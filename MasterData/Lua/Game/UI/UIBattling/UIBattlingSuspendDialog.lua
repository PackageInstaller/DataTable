------------ import ------------
local util = require "XLua.util"
local CoWait = CS.Engine.Lib.CoWait
local cs_coroutine = import('XLua.cs_coroutine')
local UIModule = CS.Engine.UI.UIModule
local UIBattlingCtrlMgr = import("Game.UI.UIBattling.UIBattlingCtrlMgr")
local EasyTouch = CS.HedgehogTeam.EasyTouch.EasyTouch
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie
local URPCameraController = CS.Game.Native.URP.URPCameraController
------------ import ------------

------------ define ------------
-- 互斥的页面
local mutexPageIds = {
    Constants.UITypeIds.UIBattlingDialog,
    Constants.UITypeIds.UIBattlingCharactorBattleInfoDialog,
    Constants.UITypeIds.UIBattlingBubble,
    Constants.UITypeIds.UIBattlingPVPInfoDialog,
    -- Constants.UITypeIds.UIGamePlayGuideDialog,
}
------------ define ------------

--- from: Assets/BundleResources/Prefabs/UIBattling/UIBattlingSuspendDialog.prefab > name: UIBattlingSuspendDialog
---@class UIBattlingSuspendDialog
---@field Env                           	UIBattlingSuspendDialog                 
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnSaveRecord                 	UnityEngine.RectTransform               	@ 0    
---@field BtnExit                       	UnityEngine.UI.Button                   	@ 1    
---@field BtnClose                      	UnityEngine.UI.Button                   	@ 2    
---@field BtnGuideBook                  	UnityEngine.UI.Button                   	@ 3    
---@field BtnRestart                    	UnityEngine.RectTransform               	@ 4    
local UIBattlingSuspendDialog = Class("UIBattlingSuspendDialog")

------------ LifeCycle ------------

function UIBattlingSuspendDialog:__init()
    self:CleanField()
end

function UIBattlingSuspendDialog:__delete()
    self:CleanField()
end

function UIBattlingSuspendDialog:CleanField()
    self.isAutoOrigin = nil
end

function UIBattlingSuspendDialog:Awake()
    self.controller:SetSortOrder(200)
    UIBattlingCtrlMgr:GetInstance():SetBooleanOpenDetection(false)
    self.isAutoOrigin = checkBool(UIBattleSettingMgr.isAutoBattle)
    UIBattleSettingMgr.isAutoBattle = false
end

function UIBattlingSuspendDialog:OnInitialize()
end

function UIBattlingSuspendDialog:OnFocus()
    URPCameraController.Instance:SetMainCameraActive(false)
    UIBattlingTools.SetPagesShowState(mutexPageIds, false)
end

function UIBattlingSuspendDialog:OnShow()
    xTry(function()
        self:InitListener()
    end)
end

function UIBattlingSuspendDialog:OnFinalize()
    xTry(function()
        Events.RemoveListener("ANDROID_NATIVE_BACK_ACTION", self.backEventHandler)
        URPCameraController.Instance:SetMainCameraActive(true)
        UIBattlingTools.SetPagesShowState(mutexPageIds, true)
        UIBattlingCtrlMgr:GetInstance():SetBooleanOpenDetection(true)
        -- print("->>>Action_UIBattlingSuspendDialog:OnFinalize")
        if UIBattleSettingMgr then
            UIBattleSettingMgr.isAutoBattle = self.isAutoOrigin
        end
        local battlingDialog = UIBattlingCtrlMgr:GetInstance():GetBattlingDialog()
        if UIBattleSettingMgr and checkBool(UIBattleSettingMgr.isAutoBattle) and (not isNull(battlingDialog)) then
            if checkBool(battlingDialog.booleanPlayerRoundIsStart) then
                battlingDialog:BroadcastCanUseSkillCard2Logic()
            end
        end
        KCookie.Set("IsClickUIBattlingDialogQuit", 0)
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end)
end

------------ LifeCycle ------------

function UIBattlingSuspendDialog:InitListener()
    SetButtonAction(self.BtnGuideBook, function()
        UIModule.OpenDialog({ id = Constants.UITypeIds.UIGamePlayGuideBookDialog })
    end)
    SetButtonAction(self.BtnClose, function()
        UIModule.CloseDialog(self.controller)
    end)
    SetButtonAction(self.BtnExit, function()
        local questId = UIBattlingDataMgr:GetQuestId()
        if BattleViewMgr.isReplay then
            self:ExitSwitch()
        elseif questId == 101060 then
            GameUtils.SecondConfirm(localize("剧情关卡，不可退出"),function()end)
        elseif self:NeedCostHp() then
            local itemNum, itemName = self:GetCostItem()
            local localizeParam = {_name_ = itemName, _num_ = itemNum}
            GameUtils.SecondConfirm(localize("中途脱离战场<color=#ff7f50>_name_-_num_</color>，确定离开吗？", localizeParam),function()
                self:ExitSwitch()
            end)
        else
            self:ExitSwitch()
        end
    end)
    
    if not IsNull(self.BtnSaveRecord) then
        KTool.GetOrAddComponent(self.BtnSaveRecord.gameObject, typeof(UIEventProxy)).onPointerClick = function()
            if RecordMgr then
                local rs = RecordMgr:SaveRecord()
                CS.UnityEngine.GUIUtility.systemCopyBuffer = checkString(RecordMgr:GetRecordString())
                GameUtils.Toast(localize("战报数据已复制到粘贴版"))
            end
        end
    end

    if isNotNull(self.BtnRestart) then
        KTool.SetActive(self.BtnRestart, false)
        local questId = UIBattlingDataMgr:GetQuestId()
        local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
        if isNotNull(questVo) then
            if isNotNull(questVo.restartBattleBtn) and checkNumber(questVo.restartBattleBtn) == 1 then
                KTool.SetActive(self.BtnRestart, true)
                SetButtonAction(self.BtnRestart.gameObject, function()
                    GameUtils.RestartBattle(questId, 1)
                end)
            end
        end
    end
    
    self.backEventHandler = Events.AddListener("ANDROID_NATIVE_BACK_ACTION", Bind(self,self.OnAndroidBackAction))
end

function UIBattlingSuspendDialog:ExitSwitch()
    -- print("->>>>>>UIBattlingSuspendDialog_BtnExit", table.dump(BattleInfo))
    if BattleInfo and BattleInfo:IsOnline() then
        if BattleInfo.pvpMode == Constants.PVPMode.LadderCompetion
        or BattleInfo.pvpMode == Constants.PVPMode.Annihilation then
            self:ExitOnlineBattle()
        else  --todo 现在好友pvp暂未传入PVPMode
           self:ExitBattleFriend()
        end
    else
        self:ExitBattlePVE()
    end
end

function UIBattlingSuspendDialog:ExitOnlineBattle()
    BattleViewMgr.requestManualExit = true
    BattleViewMgr:StopView()    -- 停止战斗表现
    BattleViewMgr:SwithToUICamera() -- 把战斗相机复原到main相机的位置上
    local battleNetworkClient = BattleViewMgr.netMgr
    if not isNull(battleNetworkClient) then
        battleNetworkClient:Send(battleNetworkClient.SendPackageIds.ManualExit, {recordData = RecordMgr:GetRecordString()}, true)
    end
    -- 向服务器请求手动退出游戏，等待服务器返回退出的确认包以后再退出
    GameUtils.BeforeRequest()
end

function UIBattlingSuspendDialog:ExitBattleFriend()
    ---@type Engine.UI.UIRaycastBlocker
    local blocker = CS.Engine.UI.UIRaycastBlocker.Instance
    blocker:AddCondition("GOHomeBlocker")
    ---显示出主界面的元素再打开页面
    --Events.Broadcast(Constants.EventNames.UIMainHomeSceneFocusShowEventName, true)
    return cs_coroutine.start(function()
        local screenId = UIModule.CurrentScreen.Argument.id
        if screenId ~= Constants.UITypeIds.UISceneHome then
            UIModule.BackScreenStackIds()--当前场景不是主界面 去掉当前场景的所有ui
            UIModule.ResetStack()--重置堆栈
            GameUtils.OpenLoadingPanel({ id = Constants.UITypeIds.UISceneHome }, { { id = Constants.UITypeIds.UIHomeView } }, Constants.LoadingType.MainHome, false)
        else
            local dialogs = UIModule.CurrentScreen.dialogs
            xTry(function()
                local length = dialogs.Count
                for i = length, 1, - 1 do
                    local dialog = dialogs[i - 1]
                    if not IsNull(dialog) then
                        cs_coroutine.yield_return(UIModule.CloseDialog(dialog, true))
                    end
                end
                UIModule.ResetStack() --重置堆栈
            end)
            cs_coroutine.yield_return(UIModule.OpenDialog({ id = Constants.UITypeIds.UIHomeView }))
        end
        blocker:RemoveCondition("GOHomeBlocker")
    end)
end

function UIBattlingSuspendDialog:ExitBattlePVE()
    local questId = UIBattlingDataMgr:GetQuestId()
    local questType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    if questType ~= Constants.IDType.QuestTrainField then
        local fightPreWarMgr = FightPreWarMgr:GetInstance() --- 战前管理类
        if fightPreWarMgr then
            fightPreWarMgr.isOnBack2FightPre = true
            -- print("->MineValue_isOnBack2FightPre_OnSuspendSureClick", fightPreWarMgr.isOnBack2FightPre)
        end
    end
    local uiBattleMgr = UIBattlingCtrlMgr:GetInstance()
    local battlingDialog = uiBattleMgr:GetBattlingDialog()
    if battlingDialog then
        battlingDialog:RemoveListener()
    end
    Events.Broadcast(Constants.EventNames.UIBattlingBackToFightReady)
    if questType == Constants.IDType.QuestMaze then
        uiBattleMgr:BackToFightReadyMaze()
    elseif questType == Constants.IDType.QuestTrainField then
        local successGameOver = false
        if BattleMgr then
            xTry(function()
                BattleMgr:GameOver(true)
                local record = RecordMgr:GetNowNode().children[#RecordMgr:GetNowNode().children].data
                if record then
                    cs_coroutine.start(function()
                        RecordReader:DoGameOverRecord(record)
                        RecordReader:Reset()
                    end)
                    successGameOver = true
                end
            end)
        end
        if not successGameOver then
            uiBattleMgr:BackToFightReadyCommon()
        end
    elseif questType == Constants.IDType.Fairyland then
        local fairylandUtils = import("Game.Fairyland.FairylandUtils")
        fairylandUtils.EnterFairylandScene()
    else
        uiBattleMgr:BackToFightReadyCommon()
    end
    uiBattleMgr:SetQuestTowerAutoContinuousBattle(false)
    if not IsNull(EasyTouch) then
        EasyTouch.instance.enable = true
        EasyTouch.instance.longTapTime = 1
        EasyTouch.instance.enable2FingersGesture = true
    end
end

--- 判断关卡是否消耗体力
function UIBattlingSuspendDialog:NeedCostHp()
    local questId = BattleViewMgr.initData.questId
    local questType = GoodsUtils.GetIdType(questId, Constants.IDArea.Quests)
    local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
    if questVo then
        --如果有预先扣除的体力
        local costHpNum = checkNumber(questVo.costNumLose)
        local needCostHp = costHpNum > 0
        if needCostHp then
            if questType == Constants.IDType.QuestMain then
                local isPass = QuestConfMgr:GetInstance():IsPassQuest(questId)
                needCostHp = not isPass
            end
        end
        return needCostHp
    end
    return false
end

function UIBattlingSuspendDialog:GetCostItem()
    local questId = BattleViewMgr.initData.questId
    local questVo = QuestConfMgr:GetInstance():GetQuestVoById(questId)
    if isNotNull(questVo) then
        local costNum = checkNumber(questVo.costNumLose)
        local idGoodsCost = checkNumber(questVo.costItem)
        local goodsVo = checkTable(GoodsConfMgr:GetInstance():GetGoodsVoById(idGoodsCost))
        if isNotNull(goodsVo) then
            local goodsName = checkString(goodsVo.name)
            return costNum, goodsName
        end
    end
    return 1, localize("门票道具")
end

function UIBattlingSuspendDialog:OnAndroidBackAction()
    -- 有二级确认，关闭二级确认
    local secondConfirm = UIModule.RootCanvas.transform.parent:Find("SecondConfirmPopUp")
    if not isNull(secondConfirm) then
        ---@type UISecondConfirm
        local env = CfUtils.GetLuaScr(secondConfirm.gameObject, "Game.Behaviours.UISecondConfirm")
        if env then
            ---@type Engine.UI.UIEventProxy
            local eventProxy = KTool.GetComponent(env.BtnCancel.gameObject, typeof(UIEventProxy))
            if eventProxy.onPointerClick then
                eventProxy.onPointerClick()
            end
        end
        return
    end

    -- 没有二级确认，关闭自己
    local dialog = UIModule.CurrentScreen:LastDialog()
    if isNotNull(dialog) then
        if dialog.Argument.id == Constants.UITypeIds.UIBattlingBackToFightReadyDialog then
            UIModule.BackDialog()
        end
        return
    end
end

return UIBattlingSuspendDialog
