--- from: Assets/BundleResources/Prefabs/HomeGift/GiftSelectRewardDialog.prefab
---@class ActivitySelectGiftRewardsDialog
---@field Env                           	ActivitySelectGiftRewardsDialog
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field BtnRight                      	UnityEngine.UI.Button
---@field ImgIcon                       	Engine.UI.ImageAlterable
---@field Cell                          	UnityEngine.RectTransform
---@field Bg                            	UnityEngine.RectTransform
---@field GoodAnimNodes                 	UnityEngine.RectTransform
---@field BtnPurchaseGroup              	UnityEngine.RectTransform
---@field GoodsIconList                 	SuperScrollView.LoopGridView
---@field BtnCollect                    	UnityEngine.RectTransform
---@field ImgCollect                    	UnityEngine.RectTransform
---@field BtnClose                      	UnityEngine.RectTransform
---@field MaxBut                        	UnityEngine.RectTransform
---@field LeastBut                      	UnityEngine.RectTransform
---@field MinusImage                    	UnityEngine.RectTransform
---@field AddImage                      	UnityEngine.RectTransform
---@field InputFieldNumber              	TMPro.TMP_InputField

local ActivitySelectGiftRewardsDialog = Class("ActivitySelectGiftRewardsDialog")
local RectTransform = typeof(CS.UnityEngine.RectTransform)
local ImageAlterable = typeof(CS.Engine.UI.ImageAlterable)
local UISwitchImage = typeof(CS.Game.Native.Common.UISwitchImage)
local GoodsConfMgr = GoodsConfMgr:GetInstance()
local UIModule = CS.Engine.UI.UIModule
local CoWait = CS.Engine.Lib.CoWait
local util = require 'XLua.util'
local KTool = CS.Engine.Lib.KTool
function ActivitySelectGiftRewardsDialog:__init()
    self.giftId = nil  -- 礼包id
    self.giftNum = nil -- 礼包数量
    self.currentNum = 1 -- 兑换道具数量
    self.selectIndex = 0 --选择的道具索引
    self.goodsList = nil -- 道具兑换的list
end
function ActivitySelectGiftRewardsDialog:__delete()
    self.giftId = nil  -- 礼包id
    self.giftNum = nil -- 礼包数量
    self.currentNum = nil -- 兑换道具数量
    self.selectIndex = nil --选择的道具索引
    self.goodsList = nil -- 道具兑换的list
end
function ActivitySelectGiftRewardsDialog:Awake()
end
function ActivitySelectGiftRewardsDialog:MaxClick()
    if self.selectIndex == 0  then
        GameUtils.Toast(localize("请选择兑换的道具"))
        return
    end
    self.currentNum = self.giftNum
    --更新显示信息
    self.InputFieldNumber.text = tostring(self.currentNum)
end
function ActivitySelectGiftRewardsDialog:MinClick()
    if self.selectIndex == 0  then
        GameUtils.Toast(localize("请选择兑换的道具"))
        return
    end
    self.currentNum = 1
    --更新显示信息
    self.InputFieldNumber.text =tostring(self.currentNum)
end
function ActivitySelectGiftRewardsDialog:ReduceClick()
    if self.selectIndex == 0 then
        GameUtils.Toast(localize("请选择兑换的道具"))
        return
    end
    if self.currentNum == 1 then
        GameUtils.Toast(localize("已经最低数量了"))
        return
    end
    self.currentNum = self.currentNum -1
    --更新显示信息
    self.InputFieldNumber.text = tostring(self.currentNum)
end
function ActivitySelectGiftRewardsDialog:AddBtnClick()
    if self.selectIndex == 0  then
        GameUtils.Toast(localize("请选择兑换的道具"))
        return
    end
    if self.currentNum >= self.giftNum then
        GameUtils.Toast(localize("已经最大数量了"))
        return
    end
    self.currentNum = self.currentNum + 1
    --更新显示信息
    self.InputFieldNumber.text = tostring(self.currentNum)
end
function ActivitySelectGiftRewardsDialog:ChangeClick()
    if self.selectIndex == 0  then
        GameUtils.Toast(localize("请选择兑换的道具"))
        return
    end
    if self.giftNum == 0  then
        GameUtils.Toast(localize("礼包已经使用完"))
        return
    end
    local goodData = self.goodsList[self.selectIndex]
    local data = {goodsId =  self.giftId , num = self.currentNum , chooseGoodsId = goodData.goodsId}
    GameUtils.Request(Interfaces.BackpackChoose, data, function(request, responseTable)
        if responseTable and checkNumber(responseTable.errCode) == 0 then
            local rewards = clone(responseTable.data.rewards)
            if isTable(rewards) then
                rewards[#rewards+1] = { goodsId = self.giftId , num = - self.currentNum}
                GoodsUtils.DrawRewards(rewards, true)
                CS.Engine.UI.UIModule.OpenDialog({id = Constants.UITypeIds.UICommonRewardPop, parameters = {
                    rewards = clone(responseTable.data.rewards),
                    cb = function ()
                        local OptionalGiftSelectDialogControl = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.OptionalGiftSelectDialog)
                        if OptionalGiftSelectDialogControl then
                            OptionalGiftSelectDialogControl.Env:GetOptionalList()
                            local optionalGiftList = OptionalGiftSelectDialogControl.Env.optionalGiftList
                            if (not optionalGiftList) or #optionalGiftList == 0 then
                                OptionalGiftSelectDialogControl.Env:CloseClick()
                            else
                                OptionalGiftSelectDialogControl.Env:UpdateUI()
                            end
                        end
                    end
                }})
                --TODO  更新礼包界面的显示
                self.giftNum = self.giftNum - self.currentNum
                self.currentNum = 1
                self.InputFieldNumber.text = tostring(self.currentNum)
                UIModule.CloseDialog(self.controller)
            end
        end
    end, function(exception)
        GameUtils.Toast(exception.Message)
    end)
end
function ActivitySelectGiftRewardsDialog:GetComponment(trans ,  compTable)
    local object = trans:Find(compTable.path)
    if isNull(object)  then
        return
    end
    if trans.component == ImageAlterable then
        return object.gameObject:EnsureComponent(compTable.component)
    else
        return object.gameObject:GetComponent(compTable.component)
    end
end
function ActivitySelectGiftRewardsDialog:OnGetItemByIndex(listView, index)
    if index < 0 then
        return nil
    end
    index = index + 1
    local goodsData = self.goodsList[index]
    local cell = listView:NewListViewItem("Cell")
    local cellStructTable = {
        Selected = {path = "Selected" , component = RectTransform},
        ImgItem = {path = "Normal/ImgBg/ImgItem" , component = ImageAlterable},
        ImgBg = {path = "Normal/ImgBg" , component = typeof(CS.UnityEngine.UI.Image)},
        ImgItemFrame = {path = "Normal/ImgBg/ImgItemFrame" , component = UISwitchImage},
        TxtNumber = {path = "Normal/TxtNumber" , component = typeof(CS.TMPro.TextMeshProUGUI)},
        FontStyleButton = {path = "Normal/FontStyleButton" , component = typeof(CS.UnityEngine.UI.Button)},
    }
    ---@type UnityEngine.GameObject
    local gameObject = cell.gameObject
    local trans = gameObject.transform
    local goodVo = GoodsConfMgr:GetGoodsVoById(goodsData.goodsId)
    ---@type Game.Native.Common.UISwitchImage
    local ImgItemFrame = self:GetComponment(trans , cellStructTable.ImgItemFrame)
    ImgItemFrame.Status = goodVo.quality
    local TxtNumber = self:GetComponment(trans , cellStructTable.TxtNumber)
    TxtNumber.text = tostring(goodsData.goodsNum)
    local ImgItem  = self:GetComponment(trans , cellStructTable.ImgItem)
    local phoneImage = goodVo.photoPath
    if  not isNull(ImgItem) then
        ImgItem:LoadSprite(phoneImage)
    end
    local ImgBg = self:GetComponment(trans , cellStructTable.ImgBg)
    SetButtonAction(ImgBg.gameObject , function()
        local vo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsData.goodsId)
        if isTable(vo) then
            GameUtils.ShowCommonTipsBoard(ImgBg.gameObject, vo.name, vo.desc, vo.quality, vo.id)
        end
    end)
    local Selected = self:GetComponment(trans , cellStructTable.Selected)
    KTool.SetActive(Selected , self.selectIndex == index)
    ---@type UnityEngine.UI.Button
    local FontStyleButton = self:GetComponment(trans , cellStructTable.FontStyleButton)
    SetButtonAction(FontStyleButton , function()
        if self.selectIndex == index then
            local preIndex = self.selectIndex
            self.selectIndex = 0
            self:RefreshCell(preIndex)
        else
            local preIndex = self.selectIndex
            self.selectIndex = index
            self:RefreshCell(preIndex)
            self:RefreshCell(index)
        end
    end)
    return cell
end
function ActivitySelectGiftRewardsDialog:RefreshCell(index)
    local cellStructTable = {
        Selected = {path = "Selected" , component = RectTransform},
        ImgItem = {path = "Normal/ImgBg/ImgItem" , component = ImageAlterable},
        ImgItemFrame = {path = "Normal/ImgBg/ImgItemFrame" , component = UISwitchImage},
        TxtNumber = {path = "Normal/TxtNumber" , component = typeof(CS.TMPro.TextMeshProUGUI)},
        FontStyleButton = {path = "Normal/FontStyleButton" , component = typeof(CS.UnityEngine.UI.Button)},
    }
    local goodsData = self.goodsList[index]
    -- 获取具体的cell
    local cell = self.GoodsIconList:GetShownItemByItemIndex(index - 1)
    if isNull(cell) then
        return
    end
    ---@type UnityEngine.GameObject
    local gameObject = cell.gameObject
    local trans = gameObject.transform
    local Selected = self:GetComponment(trans , cellStructTable.Selected)
    KTool.SetActive(Selected , self.selectIndex == index)
    local TxtNumber = self:GetComponment(trans , cellStructTable.TxtNumber)
    TxtNumber.text = goodsData.goodsNum
end
function ActivitySelectGiftRewardsDialog:OnShow()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self:BindClick()
        self:UpdateUI()
    end))
    return coWait
end
function ActivitySelectGiftRewardsDialog:UpdateUI()
    local goodVo = GoodsConfMgr:GetGoodsVoById(self.giftId)
    local phoneImage = goodVo.photoPath
    self.ImgIcon:LoadSprite(phoneImage)
    self.InputFieldNumber.text = tostring(self.currentNum)
    self.GoodsIconList:InitGridView(table.count(self.goodsList) , Bind(self, self.OnGetItemByIndex))
end
function ActivitySelectGiftRewardsDialog:BindClick()
    SetButtonAction(self.BtnClose, function()
        UIModule.CloseDialog(self.controller)
    end)
    local SetButtonAction = SetButtonAction
    SetButtonAction(self.BtnRight, Bind(self, self.ChangeClick))
    SetButtonAction(self.AddImage, Bind(self, self.AddBtnClick))
    SetButtonAction(self.MinusImage, Bind(self, self.ReduceClick))
    SetButtonAction(self.LeastBut, Bind(self, self.MinClick))
    SetButtonAction(self.MaxBut, Bind(self, self.MaxClick))
    self.InputFieldNumber.onValueChanged:AddListener(function(num)
        num = checkNumber(num)
        if num <= 1 then
            self.currentNum = 1
        elseif num >= self.giftNum then
            self.currentNum = self.giftNum
        else
            self.currentNum = num
        end
    end)
end
function ActivitySelectGiftRewardsDialog:OnInitialize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        local param = self.controller.Argument.parameters
        self.giftNum = param.giftNum
        self.giftId = param.giftId
        ---@type GoodsOptionalGiftVo
        local goodVo = GoodsConfMgr:GetGoodsVoById(self.giftId)
        self.goodsList = goodVo.goodList
        for i = #self.goodsList, 1 , -1 do
            local goodsId = checkInt(self.goodsList[i].goodsId) 
            local isVail = CfUtils.isInVailId(self.goodsList[i].goodsId)
            if isVail == false then
                table.remove(self.goodsList , i)
            else 
                local zoneGoodsId = CfUtils.GetZoneIdById(goodsId)
                print("goodsId = >" , goodsId , zoneGoodsId)
                if checkInt(zoneGoodsId) ~= goodsId then
                    self.goodsList[i].goodsId = zoneGoodsId
                end
            end
        end
    end))
    return coWait
end
function ActivitySelectGiftRewardsDialog:OnFinalize()
    local coWait = CoWait.Start():Coroutine(util.cs_generator(function()
        self.controller = nil --删除lua层引用到的c#对象 否则不会产生c# gc回收到对象
        self:Delete()
        self = nil --lua层的gc需要
    end))
    return coWait
end
return ActivitySelectGiftRewardsDialog