-- chunkname: @IQIGame\\UI\\Lottery\\LotteryMessageItemView.lua

local LotteryMessageItemView = {}
local text_RoleInfoTipsConfig = 100004
local text_ItemInfoTipsConfig = 100005
local image_RightResourceConfig = 2001
local image_LeftResourceConfig = 2002

function LotteryMessageItemView.New(go, mainView)
	local o = Clone(LotteryMessageItemView)

	o:Initialize(go, mainView)

	return o
end

function LotteryMessageItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.RectTransform = self.gameObject:GetComponent("RectTransform")
	self.rectTransform = self.gameObject:GetComponent("RectTransform")

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function LotteryMessageItemView:InitComponent()
	self.buttonClick = self.buttonClick:GetComponent("Button")
end

function LotteryMessageItemView:InitDelegate()
	function self.buttonClickDelegate()
		do return end

		self:OnButtonClickClick()
	end
end

function LotteryMessageItemView:AddListener()
	self.buttonClick.onClick:AddListener(self.buttonClickDelegate)
end

function LotteryMessageItemView:RemoveListener()
	self.buttonClick.onClick:RemoveListener(self.buttonClickDelegate)
end

function LotteryMessageItemView:OnButtonClickClick()
	self.mainView:ShowOneReward(self.Data, self.viewIndex, self.dataIndex)
end

function LotteryMessageItemView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function LotteryMessageItemView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
	self:OnClose()
end

function LotteryMessageItemView:IsShow()
	return self.gameObject.activeSelf
end

function LotteryMessageItemView:MoveY(offsetY)
	local anchorPos = self.RectTransform.anchoredPosition

	LuaUtility.SetAnchoredPositionWithRectTransform(self.RectTransform, anchorPos.x, anchorPos.y + offsetY)
end

function LotteryMessageItemView:OnClose()
	if self.effectNormalSSRObject then
		LuaUtility.SetGameObjectShow(self.effectNormalSSRObject, false)
	end

	if self.effectTriggerSSRObject then
		LuaUtility.SetGameObjectShow(self.effectTriggerSSRObject, false)
	end
end

function LotteryMessageItemView:SetSibling(index)
	self.gameObject.transform:SetSiblingIndex(index)
end

function LotteryMessageItemView:Refresh(Data, isTenStraight, viewIndex, dataIndex)
	self.Data = Data
	self.viewIndex = viewIndex
	self.dataIndex = dataIndex

	LuaUtility.SetGameObjectShow(self.normalState, false)
	LuaUtility.SetGameObjectShow(self.specialState, false)

	local cfgItemData = CfgUtil.GetItemCfgDataWithID(self.Data.itemShowPODs[1].cid)

	if cfgItemData.Quality >= 5 then
		LuaUtility.SetGameObjectShow(self.specialState, true)
		coroutine.start(function()
			coroutine.wait(LuaUtility.GetAnimationLengthWithName(self.mainView.MobileParent, isTenStraight and "Lottery_10" or "Lottery_1") + CfgUtil.publicParametersData.lotteryProgressEffectTime)
			self:PlaySSRTriggerEffect()
			self:PlaySSRNormalEffect()
		end)
	else
		LuaUtility.SetGameObjectShow(self.normalState, true)
	end

	local textType, imageType

	if CfgUtil.CheckCfgItemMainType(cfgItemData.Id, Constant.ItemType.Hero) or CfgUtil.CheckCfgItemMainAndSubType(cfgItemData.Id, Constant.ItemType.Item, Constant.ItemSubType[Constant.ItemType.Item].LifeCore) then
		textType = CfgUtil.GetCfgTipsTextWithID(text_RoleInfoTipsConfig)
		imageType = 2
	else
		textType = CfgUtil.GetCfgTipsTextWithID(text_ItemInfoTipsConfig)
		imageType = 4
	end

	local pathRight = CfgUtil.GetCfgResourceUrl(image_RightResourceConfig)
	local pathLeft = CfgUtil.GetCfgResourceUrl(image_LeftResourceConfig)

	LuaUtility.LoadImage(self, string.format(pathRight, tostring(imageType)), self.typeImg:GetComponent("Image"))
	LuaUtility.LoadImage(self, string.format(pathLeft, tostring(imageType)), self.leftTopImg:GetComponent("Image"))
	LuaUtility.SetText(self.textType, textType)
end

function LotteryMessageItemView:PlaySSRNormalEffect()
	if self.effectNormalSSRObject then
		LuaUtility.SetGameObjectShow(self.effectNormalSSRObject, true)
	else
		local effectObject = GameObject.Instantiate(self.mainView.effectSSRNormal, self.gameObject.transform)

		LuaUtility.SetGameObjectShow(effectObject, true)
		LuaUtility.SetAnchoredPositionWithRectTransform(effectObject.transform:GetComponent("RectTransform"), 0, 0)

		self.effectNormalSSRObject = effectObject
	end

	LuaUtility.PlayDoTweenWithGameObject(self.effectNormalSSRObject)
end

function LotteryMessageItemView:PlaySSRTriggerEffect()
	if self.effectTriggerSSRObject then
		LuaUtility.SetGameObjectShow(self.effectTriggerSSRObject, true)
	else
		local effectObject = GameObject.Instantiate(self.mainView.effectSSRTrigger, self.gameObject.transform)

		LuaUtility.SetGameObjectShow(effectObject, false)
		LuaUtility.SetGameObjectShow(effectObject, true)
		LuaUtility.SetAnchoredPositionWithRectTransform(effectObject.transform:GetComponent("RectTransform"), 0, 0)

		self.effectTriggerSSRObject = effectObject
	end
end

return LotteryMessageItemView
