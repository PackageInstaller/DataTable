local ActivitySkinDrawShowView = class("ActivitySkinDrawShowView", ReduxView)

function ActivitySkinDrawShowView:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinDrawShowView:Init()
	self:InitUI()
	self:AddBtnListeners()
end

function ActivitySkinDrawShowView:InitUI()
	self:BindCfgUI()

	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
end

function ActivitySkinDrawShowView:AddBtnListeners()
	return
end

function ActivitySkinDrawShowView:OnEnter()
	return
end

function ActivitySkinDrawShowView:SetData(arg_6_1, arg_6_2)
	SetActive(self.gameObject_, true)
	self:DestroySticker()

	local var_6_0 = ActivityLimitedDrawPoolCfg[arg_6_1].reward[1][1]
	local var_6_1 = ItemCfg[ActivityLimitedDrawPoolCfg[arg_6_1].reward[1][1]]

	if ActivitySkinDrawTools.GetIsSkinGift(ActivityLimitedDrawPoolCfg[arg_6_1].reward[1][1]) then
		var_6_0 = var_6_1.param[1][1]
		var_6_1 = ItemCfg[var_6_1.param[1][1]]
	end

	local var_6_2 = ActivityLimitedDrawPoolCfg[arg_6_1].reward[1][2]

	if var_6_1.type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
		self.dynamicStickerGo_ = Object.Instantiate(Asset.Load(ChatStickerCfg[var_6_1.param[1]].icon), self.dynamicTf_)

		self.typeCon_:SetSelectedState("dynamic")
	elseif var_6_1.type == ItemConst.ITEM_TYPE.HERO_SKIN then
		self.role_.sprite = pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. var_6_0)

		self.typeCon_:SetSelectedState("skin")
	else
		self.icon_.sprite = ItemTools.getItemSprite(var_6_0)

		self.typeCon_:SetSelectedState("icon")
		self.icon_:SetNativeSize()
	end

	self.name_.text = ItemTools.getItemName(var_6_0) .. "×" .. var_6_2

	self.playable_:Evaluate()

	self.playable_.time = 0

	self.playable_:Play()
end

function ActivitySkinDrawShowView:DestroySticker()
	if self.dynamicStickerGo_ then
		Object.Destroy(self.dynamicStickerGo_)

		self.dynamicStickerGo_ = nil
	end
end

function ActivitySkinDrawShowView:Hide()
	SetActive(self.gameObject_, false)
end

function ActivitySkinDrawShowView:OnExit()
	return
end

function ActivitySkinDrawShowView:Dispose()
	self:RemoveAllListeners()
	self:DestroySticker()
	self.super.Dispose(self)
end

return ActivitySkinDrawShowView
