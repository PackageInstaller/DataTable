---
--- Created by Eric.
--- DateTime: 2022/3/16 10:46
---

------------ import ------------
local UIEventProxy = CS.Engine.UI.UIEventProxy
local KTool = CS.Engine.Lib.KTool
local NewYearFundUtils = import("Game.UI.ActivityNewYearFund.NewYearFundUtils")
local newYearFundComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.NewYearFundComponent)
local FontStyleButton = CS.Game.Native.Common.FontStyleButton
------------ import ------------

---@class ActivityNewYearFundCell

local ActivityNewYearFundCell = Class("ActivityNewYearFundCell")
function ActivityNewYearFundCell:__init()
    self._baseId = 0
end

function ActivityNewYearFundCell:__delete()
    self._baseId = 0
end

function ActivityNewYearFundCell:Awake()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnBtnDrawReward))
end

function ActivityNewYearFundCell:Start()
    SetButtonAction(self.FontStyleButton, Bind(self, self.OnBtnDrawReward))
end

function ActivityNewYearFundCell:Refresh(id)
    self._baseId = id
    if checkNumber(self._baseId) <= 0 then
        return
    end

    self:FillSelf()
end

function ActivityNewYearFundCell:FillSelf()
    local vo = NewYearFundUtils.GetNewYearFundRewardVo(self._baseId)
    if not vo then
        return
    end

    CfUtils.FillText(self.TxtDayNumber, vo.taskNum)
    self:FillBaseReward()
    self:FillPayReward()
    CfUtils.SetActive(self.LockNode, not newYearFundComponent:GetIsPay())

    local isPay = newYearFundComponent:GetIsPay()
    local baseId = self._baseId
    local payId = CfUtils.GetStringIdGroupData(string.format("%s".."TypeDayMap", AutoIds.IdSetting6712), vo.group.."_"..vo.taskNum)

    local isDrawBase = NewYearFundUtils.IsDrawRewardById(baseId)
    local isDrawPay = NewYearFundUtils.IsDrawRewardById(payId)
    local isCanDrawBase =NewYearFundUtils.IsCanDrawBaseRewardById(baseId)
    local isCanDrawPay = NewYearFundUtils.IsCanDrawPayRewardById(payId)

    CfUtils.SetActive(self.UIFX_ActivityNewYearFundDialog101601Reward1, false)
    CfUtils.SetActive(self.UIFX_ActivityNewYearFundDialog101601Reward2, false)

    if isPay then
        if isDrawBase and isDrawPay then
            CfUtils.SetActive(self.FontStyleButton, false)
            CfUtils.SetActive(self.GetNode, false)
        else
            if isCanDrawBase or isCanDrawPay then
                CfUtils.SetActive(self.FontStyleButton, true)
                CfUtils.SetActive(self.GetNode, false)
                self.FontStyleButton.transform:GetComponent(typeof(FontStyleButton)):ResetFontStyle("B12", localize("领取"))

                CfUtils.SetActive(self.UIFX_ActivityNewYearFundDialog101601Reward2, true)
            else
                CfUtils.SetActive(self.FontStyleButton, true)
                CfUtils.SetActive(self.GetNode, false)
                self.FontStyleButton.transform:GetComponent(typeof(FontStyleButton)):ResetFontStyle("B13", localize("未达成"))
            end
        end
    else
        if isDrawBase then
            CfUtils.SetActive(self.FontStyleButton, false)
            CfUtils.SetActive(self.GetNode, true)
        else
            CfUtils.SetActive(self.GetNode, false)
            if isCanDrawBase then
                CfUtils.SetActive(self.FontStyleButton, true)
                self.FontStyleButton.transform:GetComponent(typeof(FontStyleButton)):ResetFontStyle("B12", localize("领取"))

                CfUtils.SetActive(self.UIFX_ActivityNewYearFundDialog101601Reward1, true)
            else
                CfUtils.SetActive(self.FontStyleButton, true)
                self.FontStyleButton.transform:GetComponent(typeof(FontStyleButton)):ResetFontStyle("B13", localize("未达成"))
            end
        end
    end
end

function ActivityNewYearFundCell:FillBaseReward()
    local vo = NewYearFundUtils.GetNewYearFundRewardVo(self._baseId)
    local t1 = CfUtils.Split(vo.reward)
    local t2 = CfUtils.Split(vo.rewardNum)
    local t = {}
    for k, v in pairs(t1) do
        table.insert(t, {
            goodsId = checkNumber(t1[k]),
            num = checkNumber(t2[k]),
        })
    end
    local isDrawBase = NewYearFundUtils.IsDrawRewardById(self._baseId)

    for i = 1, #t do
        local go = self.RewardGroup.transform:Find("GoodNode"..i)
        if go then
            CfUtils.SetActive(go, true)
            CfUtils.RefeshGoodGo2(go, t[i].goodsId, t[i].num, nil, nil, function()
                local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(t[i].goodsId)
                GameUtils.ShowCommonTipsBoard(go, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
            end)

            CfUtils.SetActive(go.transform:Find("getimg"), isDrawBase)
        end
    end

    if self.RewardGroup.childCount > #t then
        for i = #t+ 1, self.RewardGroup.childCount do
            local go = self.RewardGroup.transform:Find("GoodNode"..i)
            if go then
                CfUtils.SetActive(go, false)
            end
        end
    end
end

function ActivityNewYearFundCell:FillPayReward()
    local vo = NewYearFundUtils.GetNewYearFundRewardVo(self._baseId)
    local payId = CfUtils.GetStringIdGroupData(string.format("%s".."TypeDayMap", AutoIds.IdSetting6712), vo.group.."_"..vo.taskNum)
    vo = NewYearFundUtils.GetNewYearFundPayRewardVo(payId)
    if not vo then
        return
    end

    local payId = CfUtils.GetStringIdGroupData(string.format("%s".."TypeDayMap", AutoIds.IdSetting6712), vo.group.."_"..vo.taskNum)
    local isDrawPay = NewYearFundUtils.IsDrawRewardById(payId)

    local t1 = CfUtils.Split(vo.reward)
    local t2 = CfUtils.Split(vo.rewardNum)
    local t = {}
    for k, v in pairs(t1) do
        table.insert(t, {
            goodsId = checkNumber(t1[k]),
            num = checkNumber(t2[k]),
        })
    end

    for i = 1, #t do
        local go = self.RewardGroup2.transform:Find("GoodNode"..i)
        if go then
            CfUtils.SetActive(go, true)
            CfUtils.RefeshGoodGo2(go, t[i].goodsId, t[i].num, nil, nil, function()
                local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(t[i].goodsId)
                GameUtils.ShowCommonTipsBoard(go, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
            end)

            CfUtils.SetActive(go.transform:Find("LockNode"), not newYearFundComponent:GetIsPay())

            CfUtils.SetActive(go.transform:Find("getimg"), isDrawPay)
        end
    end

    if self.RewardGroup2.childCount > #t then
        for i = #t+ 1, self.RewardGroup2.childCount do
            local go = self.RewardGroup2.transform:Find("GoodNode"..i)
            if go then
                CfUtils.SetActive(go, false)
            end
        end
    end
end

function ActivityNewYearFundCell:OnBtnDrawReward()
    local vo = NewYearFundUtils.GetNewYearFundRewardVo(self._baseId)

    local isCanDraw, ids, err = NewYearFundUtils.IsCanDrawRewardBuyDay(vo.group, vo.taskNum)
    if not isCanDraw then
        GameUtils.Toast(err)
        return
    end

    newYearFundComponent:ActivityNewYearFundReceiveRewardReq(ids, function()
        self:FillSelf()    
    end)
end

function ActivityNewYearFundCell:OnDestroy()
    self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
    self:Delete()
    self = nil --lua层的gc需要
end

return ActivityNewYearFundCell