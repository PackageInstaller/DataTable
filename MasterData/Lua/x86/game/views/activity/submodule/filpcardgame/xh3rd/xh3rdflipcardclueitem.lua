local XH3rdFlipCardClueItem = class("XH3rdFlipCardClueItem", ReduxView)

function XH3rdFlipCardClueItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform
	self.index = arg_1_2

	self:Init()
end

function XH3rdFlipCardClueItem:Init()
	self:InitUI()
	self:AddListeners()
end

function XH3rdFlipCardClueItem:SetData(arg_3_1, arg_3_2)
	self.clueId = arg_3_1.detail_id
	self.name = arg_3_1.name
	self.icon_path = arg_3_1.icon_path
	self.picture = arg_3_1.picture
	self.activityId = arg_3_2
	self.flipCardCfg = FlipCardCfg[self.activityId]
	self.isGetted = XH3rdFlipCardData:CheckClueIsGetted(self.clueId)
	self.isViewed = XH3rdFlipCardData:CheckClueIsViewed(self.clueId)

	manager.redPoint:bindUIandKey(self.checkBtnTrans_, string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, self.activityId, self.clueId))
	self:RefreshUI()
end

function XH3rdFlipCardClueItem:InitUI()
	self:BindCfgUI()

	self.lockController = ControllerUtil.GetController(self.transform_, "clue")
end

function XH3rdFlipCardClueItem:AddListeners()
	self:AddBtnListener(self.checkBtn_, nil, function()
		XH3rdFlipCardAction:sendViewClueRequest(self.activityId, self.clueId)
	end)
end

function XH3rdFlipCardClueItem:RefreshUI()
	self.titleText_.text = self.name

	if self.isGetted then
		self.lockController:SetSelectedState("unlock")
	else
		self.lockController:SetSelectedState("lock")
	end

	if self.picture and self.picture ~= "" and self.flipCardCfg.clue_icon_path and self.flipCardCfg.clue_icon_path ~= "" then
		self.img_.sprite = pureGetSpriteWithoutAtlas(self.flipCardCfg.clue_icon_path .. self.picture)
	end
end

function XH3rdFlipCardClueItem:Dispose()
	manager.redPoint:unbindUIandKey(self.checkBtnTrans_, string.format("%s_%s_%s_clue", RedPointConst.ACTIVITY_2_2_FLIP_CARD, self.activityId, self.clueId))
	XH3rdFlipCardClueItem.super.Dispose(self)
end

function XH3rdFlipCardClueItem:SetReveivedHandler(arg_9_1)
	self.onReceived_ = arg_9_1
end

return XH3rdFlipCardClueItem
