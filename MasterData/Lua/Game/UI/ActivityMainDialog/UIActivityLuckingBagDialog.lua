---
--- DateTime: 2024/1/15 16:22
---
local KTool = CS.Engine.Lib.KTool
local KCookie = CS.Engine.Lib.KCookie
local UIModule = CS.Engine.UI.UIModule
local UIEventProxy = CS.Engine.UI.UIEventProxy
local RawImageAlterable = CS.Engine.UI.RawImageAlterable
---@type ActivityUtils
local ActivityUtils = import("Game.Activity.ActivityUtils")
local FontStyleButton = CS.Game.Native.Common.FontStyleButton
local ActionUtils = import('Game.UI.FightReady.UIMainChapter.ActionUtils')
local GachapontUtils = import('Game.Gachapon.GachaponUtils')

local LimitTimePayActivityType = 122801

--- from: Assets/BundleResources/Prefabs/Activity/ActivityLuckybagEntryDialog12001201.prefab > name: ActivityLuckybagEntryDialog12001201
---@class UIActivityLuckingBagDialog
---@field Env                            UIActivityLuckingBagDialog
---@field controller                        Engine.Modules.LuaBehaviour
---@field BtnExplain                        UnityEngine.RectTransform
---@field TxtDesc                        UnityEngine.UI.Text
---@field ImgRole                        UnityEngine.RectTransform
---@field TxtTime                        TMPro.TextMeshProUGUI                   @ 右侧, 活动时间 文本
---@field BtnRoleNameNode                UnityEngine.RectTransform
---@field ImgIcon                        UnityEngine.RectTransform
---@field LoopList                        SuperScrollView.LoopListView2
---@field FX_glow2                        UnityEngine.RectTransform
---@field HaveTextDesc                    UnityEngine.RectTransform
---@field FontStyleButton                UnityEngine.RectTransform
local UIActivityLuckingBagDialog = Class('UIActivityLuckingBagDialog')
function UIActivityLuckingBagDialog:__init()
    self.activityDt = nil
    self.data = nil
    ---@type GoodsConfMgr
    self.goodsConfMgr = nil
end

function UIActivityLuckingBagDialog:__delete()
    ---@type ActivityDojo
    self.activityDt = nil
    self.data = nil
    self.goodsConfMgr = nil
end

function UIActivityLuckingBagDialog:Awake()
    ---@type GoodsConfMgr
    self.goodsConfMgr = GoodsConfMgr:GetInstance()
    SetButtonAction(self.BtnExplain, function()
        ---前往日常任务
        if self.activityDt then
            CfUtils.ShowModuleToast(checkNumber(self.activityDt.luckBagModuleId))
        end
    end)
    SetButtonAction(self.FontStyleButton, function()
        if self.activityDt and self.data then
            local haveNo = GoodsUtils.GetThingNo(self.activityDt.luckBagId)
            if haveNo <= 0 then
                local vo = self.goodsConfMgr:GetGoodsVoById(self.activityDt.luckBagId)
                GameUtils.Toast(localize('当前所需的_name_不足，不能兑换', { _name_ = vo.name }))
                return
            end
            ---开福袋的逻辑
            GameUtils.Request(Interfaces.BackpackUse, {
                goodsId = self.activityDt.luckBagId, num = haveNo
            }, function(request, response)
                if checkNumber(response.errCode) == 0 then
                    ---成功了
                    local data = checkTable(response.data)
                    local rewards = checkTable(data.rewards)
                    local t = {}
                    table.insert(t, { goodsId = self.activityDt.luckBagId, num = -haveNo })
                    GoodsUtils.DrawRewards(t, true)
                    if #rewards > 0 then
                        GoodsUtils.DrawRewards(rewards, true)
                        UIModule.OpenDialog(
                                {
                                    id = Constants.UITypeIds.UICommonRewardPop,
                                    parameters = { rewards = data.rewards }
                                }
                        )
                    end
                    ActivityUtils.UpdateActivityMainRedPointState(self.activityDt.id, -1)
                    haveNo = GoodsUtils.GetThingNo(self.activityDt.luckBagId)
                    CfUtils.FillText(self.HaveTextDesc, localize('拥有：_num_', { _num_ = haveNo }))
                    CfUtils.SetActive(self.FX_glow2, haveNo > 0)
                    CfUtils.SetActive(self.FontStyleButton.transform.parent:Find("redPoint"), haveNo > 0)
                end
            end)
        end
    end)
end

function UIActivityLuckingBagDialog:GetActivityId()
    return checkInt(self.activityDt.id)
end

function UIActivityLuckingBagDialog:RefreshBaseView()
    CfUtils.FillText(self.TxtTime, ActivityUtils.ConventActivityDurationTime(self.activityDt.startTime, self.activityDt.endTime))
    CfUtils.FillText(self.TxtDesc, string.trim(self.activityDt.detail) ~= "" and self.activityDt.detail or "TO BE CONTINUE")
    --CfUtils.FillImage(self.ImgRole, ActivityUtils.GetImageFullPath(self.activityDt.luckyBagCardSkin))
    local path = self.goodsConfMgr:GetPhotoPathById(self.activityDt.luckBagId)
    CfUtils.FillImage(self.ImgIcon, path)
    KTool.SetActive(self.BtnRoleNameNode, true)
    ---@type CommonBtnRoleNameNode
    local env = CfUtils.GetLuaScr(self.BtnRoleNameNode, "Game.UI.Common.CommonBtnRoleNameNode")
    if env then
        env:RefreshSelf(self.activityDt.luckyBagCardId, nil, function()
            KCookie.Set(Constants.UICacheDataKeys.UI_ACTIVITY_MAIN_SELECTED_ACTIVITY_ID, self.activityDt.id)
            xTry(function()
                GachapontUtils.OpenDetail(self.activityDt.luckyBagCardId, { { id = Constants.UITypeIds.UIActivityMainDialog } })
            end)
        end, false)
    end
    local haveNo = GoodsUtils.GetThingNo(self.activityDt.luckBagId)
    CfUtils.FillText(self.HaveTextDesc, localize('拥有：_num_', { _num_ = haveNo }))
    CfUtils.SetActive(self.FX_glow2, haveNo > 0)
    CfUtils.SetActive(self.FontStyleButton.transform.parent:Find("redPoint"), haveNo > 0)
end

function UIActivityLuckingBagDialog:Refresh(activityDojo)
    self.activityDt = activityDojo
    local vo = self.goodsConfMgr:GetGoodsVoById(self.activityDt.luckBagId)
    if isSet(vo, "jumpAway") then
        self.data = clone(vo.jumpAway)
    else
        self.data = {}
    end
    ---@type ActivityComponent
    local activityComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityComponent)
    if activityComponent then
        local activityData = activityComponent:GetActivityData()
        for i, v in pairs(activityData) do
            if checkNumber(v.type) == LimitTimePayActivityType and ActivityUtils.IsActivityEnabled(v) then
                table.insert(self.data, { isLimit = true, name = v.name, id = checkNumber(v.id) })
            end
        end
    end
    self:RefreshBaseView()
    self:FreshListView()
end

function UIActivityLuckingBagDialog:OnGetItemByIndex(loopListView, index)
    if index < 0 then
        return nil
    end
    local position = index + 1
    local data = self.data[position]
    if not data then
        return
    end
    local cell = loopListView:NewListViewItem("Cell")
    if not isNull(cell) then
        CfUtils.PlayAnimator(cell.transform:Find("AnimRoot"), "Go")
        if isSet(data, "isLimit") then
            local textTrans = cell.transform:Find("AnimRoot/TextDesc")
            local buttonTrans = cell.transform:Find("AnimRoot/FontStyleButton")
            CfUtils.FillText(buttonTrans.transform:Find("Text"), localize("前往"))
            CfUtils.FillText(textTrans, data.name)
            UIEventProxy.Create(buttonTrans.gameObject).onPointerClick = function()
                ---@type Engine.UI.UILuaDialog
                local dialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.UIActivityMainDialog)
                if dialog and dialog.Env then
                    dialog.Env:RefreshSelfByIndex(data.id)
                end
            end
        else
            ---@type TableML.TableFileRow
            local row = self.goodsConfMgr:GetJumpModuleRow(data)
            local moduleId = checkInt(row:Get("moduleID"))
            local textTrans = cell.transform:Find("AnimRoot/TextDesc")
            local buttonTrans = cell.transform:Find("AnimRoot/FontStyleButton")
            CfUtils.FillText(buttonTrans.transform:Find("Text"), localize("前往"))
            local functionName = parse_localizeText(row, "functionName", "")
            local extraPara = nil
            if moduleId <= 0 then
                KTool.SetActive(buttonTrans.gameObject, false)
            else
                KTool.SetActive(buttonTrans.gameObject, true)
                ---@type GoodsVo
                local goodsVo = self.goodsConfMgr:GetGoodsVoById(self.activityDt.luckBagId)
                if goodsVo.jumpParameter and #goodsVo.jumpParameter > 0 then
                    local questConfMgr = QuestConfMgr:GetInstance()
                    ---存在跳转参数的情况时需要指定关卡信息
                    local questId = goodsVo.jumpParameter[position]
                    if not isNull(questId) then
                        local questType = GoodsUtils.GetIdType(questId)
                        if questType == Constants.IDType.QuestMain then
                            ---主线
                            ---@type QuestMainVo
                            local vo = questConfMgr:GetQuestVoById(questId)
                            if isTable(vo) then
                                functionName = string.format('%s(%s)', functionName, vo.label)
                            end
                        elseif questType == Constants.IDType.QuestDaily or questType == Constants.IDType.QuestCoinsCopy or questType == Constants.IDType.QuestExpCopy or questType == Constants.IDType.QuestUpStarCopy then
                            ---副本
                            ---@type QuestDailyVo
                            local vo = questConfMgr:GetQuestVoById(questId)
                            if isTable(vo) then
                                functionName = string.format('%s(%s)', functionName, vo.label)
                            end
                        elseif questType == Constants.IDType.RestaurantRecipeGoods then
                            extraPara = goodsVo.jumpParameter
                        end
                    end
                end
                local functionID = checkNumber(row:Get("functionID"))
                local isUnlock = GameUtils.IsUnlockedBySystemTogId(functionID)
                local isCanJump = self.goodsConfMgr:CheckIsCanJump(row, false)
                --区域拿参数判断  特殊
                if functionID == Constants.SystemToggleIds.Id2001 then
                    local t = checkTable(CfUtils.Split(checkString(row:Get("parameter"))))
                    local regionId = checkNumber(t[1])
                    if regionId > 0 then
                        isUnlock = ActionUtils.IsUnlockRegionalSecondPoint(regionId)
                    end
                end

                if isUnlock and isCanJump then
                else
                    buttonTrans.transform:GetComponent(typeof(FontStyleButton)):ResetFontStyle("B14")
                end
                CfUtils.FillText(textTrans, functionName)
                UIEventProxy.Create(buttonTrans.gameObject).onPointerClick = function()
                    ---跳转按钮的事件的逻辑
                    self.goodsConfMgr:ExecuteJump(row, goodsVo, position, nil, extraPara)
                end
            end
        end
    end
    return cell
end

---FreshListView
---刷新列表信息
function UIActivityLuckingBagDialog:FreshListView()
    local len = table.count(self.data)
    if not self.LoopList.IsListViewInit then
        self.LoopList:InitListView(len, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.LoopList, len)
    end
end

function UIActivityLuckingBagDialog:OnDestroy()
    self.controller = nil--luabehaviour 中CSharp对象
    self:Delete()
end

return UIActivityLuckingBagDialog