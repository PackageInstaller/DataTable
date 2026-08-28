------------ import ------------
local util = require "XLua.util"
local cs_coroutine = require("XLua.cs_coroutine")
local CoWait = CS.Engine.Lib.CoWait
local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
local Yielders = CS.Engine.Lib.Yielders
local DOTween = CS.DG.Tweening.DOTween
local UIEventProxy = CS.Engine.UI.UIEventProxy
local AnnihilationUtils = import('Game.UI.FightReady.UIMainChapter.AnnihilationUtils')
------------ import ------------

------------ define ------------
------------ define ------------

--- from: Assets/BundleResources/Prefabs/UIBattling/UIBattlingRivalDialog.prefab > name: UIBattlingRivalDialog
---@class UIBattlingRivalDialog
---@field Env                           	UIBattlingRivalDialog                   
---@field controller                    	Engine.UI.UILuaDialog                   
---@field RT_ClickMask                  	UnityEngine.RectTransform               
---@field RT_GuideDesc                  	UnityEngine.RectTransform               
---@field Txt_DoubleTotalPower          	TMPro.TextMeshProUGUI                   
---@field Txt_DoublePower2              	TMPro.TextMeshProUGUI                   
---@field Txt_DoublePower1              	TMPro.TextMeshProUGUI                   
---@field Txt_DoubleName2               	UnityEngine.UI.Text                     
---@field Txt_DoubleName1               	UnityEngine.UI.Text                     
---@field Img_DoubleRoleIcon2           	Engine.UI.ImageAlterable                
---@field Img_DoubleRoleIcon1           	Engine.UI.ImageAlterable                
---@field RT_DoubleRoot                 	UnityEngine.RectTransform               
---@field RT_SingleRoot                 	UnityEngine.RectTransform               
---@field Txt_RightPower                	TMPro.TextMeshProUGUI                   
---@field Txt_LeftPower                 	TMPro.TextMeshProUGUI                   
---@field Txt_RightName                 	UnityEngine.UI.Text                     
---@field Txt_LeftName                  	UnityEngine.UI.Text                     
---@field Img_RightIcon                 	Engine.UI.ImageAlterable             
---@field Img_LeftIcon                  	Engine.UI.ImageAlterable          
---@field Animator_Root                 	UnityEngine.Animator
local UIBattlingRivalDialog = Class("UIBattlingRivalDialog")

function UIBattlingRivalDialog:__init()
    self.rivalInfo = nil
    self.LT_GuideDesc = nil
    self.waittingGuide = nil
end

function UIBattlingRivalDialog:__delete()
    self.rivalInfo = nil
    self.LT_GuideDesc = nil
    self.waittingGuide = nil
    self.controller = nil
    self = nil
end

function UIBattlingRivalDialog:Awake()
    ---@type Engine.UI.UIArgument
    local argument = self.controller.Argument
    self.rivalInfo = argument.parameters.rivalInfo
    self.waittingGuide = false
end

function UIBattlingRivalDialog:OnShow()
    xTry(function()
        UIBattlingTools.PlayAudio(UISheets.UI_Battle.ui_battle_order)
        self:ShowRival()
    end)
end

function UIBattlingRivalDialog:OnInitialize()
    xTry(function()
        self:SetHeadIconAndName(self.rivalInfo)
        self.LT_GuideDesc = GetLuaBehaviour(self.RT_GuideDesc.gameObject, "Game.UI.UIGamePlayGuide.GuideStepDesWithCharacter").Env
        UIEventProxy.Create(self.RT_ClickMask.gameObject).onPointerClick = function()
            self.waittingGuide = false
        end
    end)
end

function UIBattlingRivalDialog:OnFinalize()
    xTry(function()
        -- print("->UIBattlingRivalDialog:OnFinalize")
        
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end)
end

function UIBattlingRivalDialog:SetHeadIconAndName(rivalInfo)
    self:SetPlayerInfo()

    -- Boss 名字
    local monsterData = rivalInfo
    local skinId2
    local bossName
    local imgPath2
    
    if not isNull(monsterData) then
        skinId2 = monsterData.skinId
        local skinVo2 = CardConfMgr:GetCardSkinBySkinId(skinId2)
        imgPath2 = skinVo2.cardDrawing
        if BattleInfo:IsPVP() then
            bossName = UIBattlePlayerInfoMgr:GetOtherPlayerDesc().name
        else
            bossName = skinVo2.name
        end
    else
        bossName = "Boss"
    end
    self.Txt_LeftName.text = bossName
    
    -- Boss icon
    self.Img_LeftIcon:LoadSprite(imgPath2)

    -- 如果是序章，这时候玩家的名字还是代码，就不显示出来了
    local AppEngine = CS.Engine.Lib.AppEngine
    local IsOpenOp =  AppEngine.GetConfig("Engine.Dev", "IsOpenOp")
    local curOp = QuestConfMgr:GetInstance():GetCurOpId()
    if checkNumber(IsOpenOp) > 0 and curOp ~= 0 then
        KTool.SetActive(self.Txt_RightName, false)
        KTool.SetActive(self.Txt_DoubleName1, false)
        KTool.SetActive(self.Txt_DoubleName2, false)
    end
end

function UIBattlingRivalDialog:ShowRival()
    local playerPower
    local bossPower
    bossPower = checkInt(BattleInfo.initData.recommendCombatVal)
    if bossPower == 0 then
        playerPower = BattleInfo.myCamp == Constants.Camp.One and checkInt(BattleInfo.initData.playerCombatVal) or checkInt(BattleInfo.initData.enemyCombatVal)
        bossPower = BattleInfo.myCamp == Constants.Camp.One and checkInt(BattleInfo.initData.enemyCombatVal) or checkInt(BattleInfo.initData.playerCombatVal)
        if (bossPower == 0) then
            -- 机器人自己循环加
            bossPower = UIBattlingDataMgr:GetRobotCombatVal()
        end
    else
        playerPower = BattleInfo.isSimulator and 100000 or checkInt(BattleInfo.initData.playerCombatVal)
        bossPower = BattleInfo.isSimulator and 100000 or checkInt(BattleInfo.initData.recommendCombatVal)

        -- replay的时候，BattleInfo.isSimulator也是true
        if BattleViewMgr.isReplay then
            playerPower = checkInt(BattleInfo.initData.playerCombatVal)
            bossPower = checkInt(BattleInfo.initData.recommendCombatVal)
        end
    end

    local animParam, rightPowerText
    
    local questType = GoodsUtils.GetIdType(BattleInfo.initData.questId, Constants.IDArea.Quests)
    if AnnihilationUtils.QuestTypeIsAnnihilation(questType)
    and UIBattlePlayerInfoMgr:GetPlayerNum() == 2 then
        if playerPower > bossPower then
            animParam = "Win_rightTwo"
        else
            animParam = "IsOpen_win_left"
        end
        rightPowerText = self.Txt_DoubleTotalPower
    else
        if playerPower > bossPower then
            animParam = "IsOpen_win_right"
        else
            animParam = "IsOpen_win_left"
        end
        rightPowerText = self.Txt_RightPower
    end
    
    -- 设置先后手动画参数
    self.Animator_Root:SetBool(animParam, true)

    self.coRival = cs_coroutine.start(function()
        -- enter动画会自动播放，先播0.5s
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.5))
        -- 然后开始跳字
        DOTween.To(function(value)
            self.Txt_LeftPower.text = tostring(Mathf.Floor(value))
        end, 0, bossPower, 0.5)
        DOTween.To(function(value)
            rightPowerText.text = tostring(Mathf.Floor(value))
        end, 0, playerPower, 0.5)
        -- 再等1.15s到enter动画播完
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1.15))
        -- 引导
        if GamePlayGuideMgr and GamePlayGuideMgr:HasRivalGuide() then
            self:YieldAndShowGuide(1)
            self:YieldAndShowGuide(2)
        end
        -- 开始播先手动画
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1.167))
        -- 引导
        if GamePlayGuideMgr and GamePlayGuideMgr:HasRivalGuide() then
            self:YieldAndShowGuide(3)
            self:YieldAndShowGuide(4)
        end
        -- 通知战力比拼即将结束
        Events.Broadcast(Constants.EventNames.BattleBeforeRivalEnd)
        cs_coroutine.yield_return(Yielders.GetWaitForSeconds(0.5))
        -- 通知战力比拼结束
        Events.Broadcast(Constants.EventNames.BattleRivalEnd)
        -- 先手动画播完，关闭界面
        UIModule.CloseDialog(self.controller)
        self.coRival = nil
    end)
end

function UIBattlingRivalDialog:SetPlayerInfo()
    local questType = GoodsUtils.GetIdType(BattleInfo.initData.questId, Constants.IDArea.Quests)
    if AnnihilationUtils.QuestTypeIsAnnihilation(questType)
    and UIBattlePlayerInfoMgr:GetPlayerNum() == 2 then
        -- 双人比拼
        KTool.SetActive(self.RT_SingleRoot, false)
        KTool.SetActive(self.RT_DoubleRoot, true)

        local isInvited = BattleInfo:IsInvited()
        -- 我的角色
        local myPlayers = UIBattlingTools.PPVEGetPlayersData(1)
        local myCard = myPlayers[1]
        local mySkinId = myCard.skinId
        local mySkinVo = CardConfMgr:GetCardSkinBySkinId(mySkinId)
        local myImgPath = mySkinVo.cardDrawing
        local myName = UIBattlePlayerInfoMgr:GetMyPlayerName()
        local myPower = 0
        for i, v in ipairs(myPlayers) do
            myPower = myPower + v.combatValue
        end
        myPower = tostring(checkInt(myPower))

        -- 别人的角色
        local otherPlayers = UIBattlingTools.PPVEGetPlayersData(2)
        local otherCard = otherPlayers[1]
        local otherSkinId = otherCard.skinId
        local otherSkinVo = CardConfMgr:GetCardSkinBySkinId(otherSkinId)
        local otherImgPath = otherSkinVo.cardDrawing
        local otherName = UIBattlePlayerInfoMgr:GetOtherPlayerName()
        local otherPower = 0
        for i, v in ipairs(otherPlayers) do
            otherPower = otherPower + v.combatValue
        end
        otherPower = tostring(checkInt(otherPower))

        self.Img_DoubleRoleIcon1:LoadSprite(isInvited == 1 and myImgPath or otherImgPath)
        self.Img_DoubleRoleIcon2:LoadSprite(isInvited == 1 and otherImgPath or myImgPath)
        self.Txt_DoubleName1.text = isInvited == 1 and myName or otherName
        self.Txt_DoubleName2.text = isInvited == 1 and otherName or myName
        self.Txt_DoublePower1.text = isInvited == 1 and myPower or otherPower
        self.Txt_DoublePower2.text = isInvited == 1 and otherPower or myPower
        self.Txt_DoubleTotalPower.text = tostring(checkInt(BattleInfo.initData.playerCombatVal))
    else
        -- 单人比拼
        KTool.SetActive(self.RT_SingleRoot, true)
        KTool.SetActive(self.RT_DoubleRoot, false)
        -- 角色icon
        local characterBattleData = UIBattlingDataMgr:GetRoleDataByIndex(BattleInfo.myCamp, 1)
        local skinId = characterBattleData.skinId
        local skinVo = CardConfMgr:GetCardSkinBySkinId(skinId)
        local imgPath = skinVo.cardDrawing
        self.Img_RightIcon:LoadSprite(imgPath)

        -- 玩家名字
        self.Txt_RightName.text = UIBattlePlayerInfoMgr:GetMyPlayerName()
    end
end

function UIBattlingRivalDialog:YieldAndShowGuide(index)
    local guideData = GamePlayGuideMgr:GetRivalGuide(index)
    self.LT_GuideDesc:ShowDesc(guideData.desc, true, "", guideData.rolePos)
    self.Animator_Root.speed = 0
    KTool.SetActive(self.RT_GuideDesc, true)
    KTool.SetActive(self.RT_ClickMask, true)
    self.waittingGuide = true
    while self.waittingGuide do
        cs_coroutine.yield_return(nil)
    end
    self.Animator_Root.speed = 1
    KTool.SetActive(self.RT_GuideDesc, false)
    KTool.SetActive(self.RT_ClickMask, false)
end

return UIBattlingRivalDialog
