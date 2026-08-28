local cs_coroutine = import('XLua.cs_coroutine')
local Yielders = CS.Engine.Lib.Yielders
local UIEffectCapturedImage = CS.UGUI.Effects.UIEffectCapturedImage
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
---@type ActivityGachaponSkinMgr
local Mgr = import('Game.Activity.GachaponSkin.ActivityGachaponSkinMgr'):GetInstance()

local resultAnimTime = 2.5

--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinPropResultDialog.prefab > name: GachaponSkinPropResultDialog
---@class GachaponSkinPropResultDialog
---@field Env                            GachaponSkinPropResultDialog
---@field controller                        Engine.Modules.LuaBehaviour
---@field BtnClose                        UnityEngine.RectTransform                0
---@field AnimRoot                        UnityEngine.RectTransform                1
---@field Container                        UnityEngine.RectTransform                2
---@field ImgBox1                        Game.Native.Common.UISwitchImage            3
---@field ImgBox2                        Game.Native.Common.UISwitchImage            4
---@field OneGroup                        UnityEngine.RectTransform                5
---@field OneItem                        Engine.Modules.LuaBehaviour                6
---@field TenGroup                        UnityEngine.RectTransform                7
---@field TenItemRoot                    UnityEngine.RectTransform                8
---@field WhiteTwoGroup                    UnityEngine.RectTransform                9
---@field WhiteItem2                        Engine.Modules.LuaBehaviour                10
---@field TxtWhiteItem2                    UnityEngine.RectTransform                11
---@field WhiteItem3                        Engine.Modules.LuaBehaviour                12
---@field TxtWhiteItem3                    UnityEngine.RectTransform                13
---@field WhiteOneGroup                    UnityEngine.RectTransform                14
---@field WhiteItem1                        Engine.Modules.LuaBehaviour                15
local GachaponSkinPropResultDialog = Class("GachaponSkinPropResultDialog")

---@class GachaponSkinPropResultDialog.Data
---@field justShow boolean 显示奖励详情,非获得动画
---@field isBlack boolean 白盒子还是黑盒子  黑盒子为普通抽奖
---@field gachaType number 抽奖类型 1单抽 2十连抽
---@field rewards Reward[] 奖励列表
---@field extraReward LotteryExtraReward 额外奖励信息

function GachaponSkinPropResultDialog:__init()
    self.controller = nil
end

function GachaponSkinPropResultDialog:__delete()
    self.controller = nil
end

function GachaponSkinPropResultDialog:Awake()
    SetButtonAction(self.BtnClose, function()
        self:Hide()
    end)
end

function GachaponSkinPropResultDialog:OnEnable()
    local effectBg = self.controller.gameObject:GetComponent(typeof(UIEffectCapturedImage))
    effectBg:Capture()
end

function GachaponSkinPropResultDialog:RefreshData(data)
    ---@type GachaponSkinPropResultDialog.Data
    self.data = data
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function GachaponSkinPropResultDialog:Show(data)
    self.controller.gameObject:SetActive(true)
    if data then
        self:RefreshData(data)
    end
end
function GachaponSkinPropResultDialog:Hide()
    self.controller.gameObject:SetActive(false)
end

function GachaponSkinPropResultDialog:RefreshUI()
    self:Reset()

    if self.data.justShow == true then
        CfUtils.PlayAnimation(self.AnimRoot.gameObject, 'GachaponSkinPropResultDialog_Preview_Entry')
        self:RefreshWhiteBox()
    else
        cs_coroutine.start(function()
            CfUtils.PlayAnimation(self.AnimRoot.gameObject, 'GachaponSkinPropResultDialog_Entry')
            UIRaycastBlocker:AddCondition("GachaponSkinPropResultDialog")
            if self.data.isBlack == true then
                self:RefreshBlackBox()
            else
                self:RefreshWhiteBox()
            end

            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(resultAnimTime))
            self:Hide()
            UIRaycastBlocker:RemoveCondition("GachaponSkinPropResultDialog")
            CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, { rewards = self.data.rewards,forceIgnoreSort = true })
        end)
    end
end

function GachaponSkinPropResultDialog:RefreshBlackBox()
    --CfUtils.PlayAnimation(self.Container.gameObject, 'GachaponSkinPropResultDialog_BlackBox')
    if self.ImgBox1 and self.ImgBox2 then
        self.ImgBox1.Status = 1
        self.ImgBox2.Status = 1
    end
    if self.data.gachaType == 1 then
        CfUtils.SetActive(self.OneGroup, true)
        ---@type GoodNodeMB
        local lua = CfUtils.GetLuaScr(self.OneItem,"Game.Behaviours.GoodNodeMB")
        lua:Reload({
            goodsId = self.data.rewards[1].goodsId,
            isShowNo = true,
            text = "x" .. self.data.rewards[1].num,
        })
    else
        CfUtils.SetActive(self.TenGroup, true)
        for i = 1, 10 do
            local go = self.TenItemRoot:GetChild(i - 1)
            if go then
                ---@type GoodNodeMB
                local lua = CfUtils.GetLuaScr(go.transform:Find('GoodNode'), "Game.Behaviours.GoodNodeMB")
                lua:Reload({
                    goodsId = self.data.rewards[i].goodsId,
                    isShowNo = true,
                    text = "x" .. self.data.rewards[i].num,
                })
            end
        end
    end
end

function GachaponSkinPropResultDialog:RefreshWhiteBox()
    if self.ImgBox1 and self.ImgBox2 then
        self.ImgBox1.Status = 2
        self.ImgBox2.Status = 2
    end
    if #self.data.extraReward.rewardGroup == 2 then
        CfUtils.SetActive(self.WhiteItem3.transform.parent.parent, true)
        CfUtils.SetActive(self.WhiteItem2.transform.parent.parent, true)
        CfUtils.SetActive(self.WhiteTwoGroup, true)
        self:RefreshWhiteItem(self.WhiteItem2, self.data.extraReward.rewardGroup[1],self.TxtWhiteItem2)
        self:RefreshWhiteItem(self.WhiteItem3, self.data.extraReward.rewardGroup[2],self.TxtWhiteItem3)
    else
        CfUtils.SetActive(self.WhiteOneGroup, true)
        self:RefreshWhiteItem(self.WhiteItem1, self.data.extraReward.rewardGroup[1])
    end
    
    --动画需求:获得奖励时,在1秒后隐藏未抽到的奖励
    if self.data.extraReward.rewardGroupIndex and not self.data.justShow then
        cs_coroutine.start(function()
            cs_coroutine.yield_return(Yielders.GetWaitForSeconds(1))
            if self.data.extraReward.rewardGroupIndex == 0 then
                CfUtils.SetActive(self.WhiteItem3.transform.parent.parent, false)
            else
                CfUtils.SetActive(self.WhiteItem2.transform.parent.parent, false)
            end
        end)
    end
end

---@private
function GachaponSkinPropResultDialog:RefreshWhiteItem(whiteItem, rewardGroup, txtProbability)
    ---@type GoodNodeMB
    local lua = CfUtils.GetLuaScr(whiteItem, "Game.Behaviours.GoodNodeMB")
    lua:Reload({
        goodsId = rewardGroup.rewards[1].goodsId,
        isShowNo = true,
        text = "x" .. rewardGroup.rewards[1].num,
    })
    lua:SetClickCallback(function()
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(rewardGroup.rewards[1].goodsId)
        if isTable(vo) then
            GameUtils.ShowCommonTipsBoard(whiteItem, vo.name, vo.desc, vo.quality, vo.id)
        end
    end)
    if txtProbability then
        CfUtils.FillText(txtProbability, rewardGroup.probability .. "%")
    end
end

function GachaponSkinPropResultDialog:Reset()
    CfUtils.SetActive(self.OneGroup, false)
    CfUtils.SetActive(self.TenGroup, false)
    CfUtils.SetActive(self.WhiteTwoGroup, false)
    CfUtils.SetActive(self.WhiteOneGroup, false)
end

return GachaponSkinPropResultDialog