
---@type ActivityGachaponSkinMgr
local Mgr = import('Game.Activity.GachaponSkin.ActivityGachaponSkinMgr'):GetInstance()


--- from: Assets/BundleResources/Prefabs/GachaponSkin/GachaponSkinPropRewardNode.prefab > name: GachaponSkinPropRewardNode
---@class GachaponSkinProgressNode
---@field Env                           	GachaponSkinProgressNode                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgBg                         	UnityEngine.RectTransform               
---@field TextProgress                  	UnityEngine.RectTransform               
---@field Item1ImgIcon2                 	UnityEngine.RectTransform               
---@field Item1ImgIcon                  	UnityEngine.RectTransform               
---@field Item1TextNumber               	UnityEngine.RectTransform               
---@field Item1ImgReceived              	UnityEngine.RectTransform               
---@field item1                         	UnityEngine.RectTransform               
---@field item2                         	UnityEngine.RectTransform               
---@field Item2ImgIcon                  	UnityEngine.RectTransform               
---@field Item2ImgIcon2                 	UnityEngine.RectTransform               
---@field Item2ImgReceived              	UnityEngine.RectTransform               
---@field Item2TextNumber               	UnityEngine.RectTransform               
---@field ImgOR                         	UnityEngine.RectTransform               
---@field RedPoint                      	UnityEngine.RectTransform               
local GachaponSkinProgressNode = Class("GachaponSkinProgressNode")

function GachaponSkinProgressNode:__init()
    self.controller = nil
end

function GachaponSkinProgressNode:__delete()
    self.controller = nil
end

function GachaponSkinProgressNode:Awake()
    --SetButtonAction(self.controller.gameObject, Bind(self, self.OnBtnSelfClick))
    SetButtonAction(self.item1,function(event)
        self:OnClickItem(1)
    end)
    SetButtonAction(self.item2,function(event)
        self:OnClickItem(2)
    end)
end

function GachaponSkinProgressNode:OnClickItem(index)
    if self.data.status == Constants.GetStatus.Can then
        self:OnBtnSelfClick()
        return
    end

    if self.data.status == Constants.GetStatus.Not then
        ---@type GachaponSkinPropResultDialog.Data
        local data = {
            justShow = true,
            isBlack = false,
            extraReward = self.data,
        }
        self.parent:ShowGachaResultDialog(data)
        return
    end
    
    local item = self:GetGroupItemData(index)
    if item then
        local goodsId = item.rewards[1].goodsId
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        if isTable(vo) then
            GameUtils.ShowCommonTipsBoard(self.controller.gameObject, vo.name, vo.desc, vo.quality, vo.id)
        end
    end
end

function GachaponSkinProgressNode:SetClickNodeCB(clickCallback)
    self.clickCallback = clickCallback
end

---@param data LotteryExtraReward
---@param index number
---@param parent GachaponSkinPropDialog
function GachaponSkinProgressNode:RefreshData(data,index,parent)
    ---@type LotteryExtraReward
    self.data = data
    self.index = index
    self.parent = parent
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function GachaponSkinProgressNode:RefreshUI()
    self:RefreshState()
    self:RefreshItem1()
    self:RefreshItem2()
end

function GachaponSkinProgressNode:RefreshState()
    if self.data.status == Constants.GetStatus.Can then
        CfUtils.PlayAnimation(self.controller.gameObject, 'UIFX_GachaponRewardNode_Available')
        CfUtils.SetActive(self.RedPoint, true)
    else
        CfUtils.PlayAnimation(self.controller.gameObject, 'UIFX_GachaponRewardNode_Default')
        CfUtils.SetActive(self.RedPoint, false)
    end

    if self.data.status == Constants.GetStatus.Has then
        CfUtils.SetUISwitchImage(self.ImgBg, 2)
    else
        CfUtils.SetUISwitchImage(self.ImgBg, 1)
    end
    CfUtils.FillText(self.TextProgress, self.data.num)
    CfUtils.SetUISwitchText(self.TextNumber, self.data.status == Constants.GetStatus.Not and 1 or 2)
    CfUtils.SetUISwitchText(self.TextProgress, self.data.status == Constants.GetStatus.Not and 1 or 2)
end

function GachaponSkinProgressNode:RefreshItem1()
    local item1 = self:GetGroupItemData(1)
    if item1 then
        --CfUtils.SetActive(self.item1.gameObject, true)
        
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(item1.rewards[1].goodsId)
        CfUtils.FillImage(self.Item1ImgIcon, goodsVo.photoPath)
        CfUtils.FillImage(self.Item1ImgIcon2, goodsVo.photoPath)
        CfUtils.FillText(self.Item1TextNumber, checkString(item1.probability).."%")

        if self.data.status == Constants.GetStatus.Has then
            CfUtils.SetActive(self.Item1ImgReceived, true)
            CfUtils.SetColorString(self.Item1ImgIcon, '#8c8c8c')
            CfUtils.SetActive(self.Item1TextNumber, false)
        else
            CfUtils.SetActive(self.Item1TextNumber, true)
            CfUtils.SetActive(self.Item1ImgReceived, false)
            CfUtils.SetColorString(self.Item1ImgIcon, '#FFFFFF')
        end
    end
end

function GachaponSkinProgressNode:RefreshItem2()
    local item2 = self:GetGroupItemData(2)
    if item2 then
        CfUtils.SetActive(self.item2.gameObject, true)
        CfUtils.SetActive(self.ImgOR, true)
        
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(item2.rewards[1].goodsId)
        CfUtils.FillImage(self.Item2ImgIcon, goodsVo.photoPath)
        CfUtils.FillImage(self.Item2ImgIcon2, goodsVo.photoPath)
        CfUtils.FillText(self.Item2TextNumber, checkString(checkString(item2.probability).."%"))

        if self.data.status == Constants.GetStatus.Has then
            CfUtils.SetActive(self.Item2ImgReceived, true)
            CfUtils.SetColorString(self.Item2ImgIcon, '#8c8c8c')
            CfUtils.SetActive(self.Item2TextNumber, false)
        else
            CfUtils.SetActive(self.Item2ImgReceived, false)
            CfUtils.SetActive(self.Item2TextNumber, true)
            CfUtils.SetColorString(self.Item2ImgIcon, '#FFFFFF')
        end
    else
        CfUtils.SetActive(self.item2.gameObject, false)
        CfUtils.SetActive(self.ImgOR, false)
    end
end

function GachaponSkinProgressNode:GetGroupItemData(index)
    if self.data.status == 2 then
        if index == 2 then
            return nil
        else
            return self.data.rewardGroup[self.data.rewardGroupIndex+1]
        end
    end
    
    return self.data.rewardGroup[index]
end

function GachaponSkinProgressNode:OnBtnSelfClick()
    if self.clickCallback then
        self.clickCallback(self.index)
    end
end

return GachaponSkinProgressNode