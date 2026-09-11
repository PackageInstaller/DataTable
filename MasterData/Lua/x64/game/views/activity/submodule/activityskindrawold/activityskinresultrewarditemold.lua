local ActivitySkinResultRewardItemOld = class("ActivitySkinResultRewardItemOld", ReduxView)

function ActivitySkinResultRewardItemOld:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function ActivitySkinResultRewardItemOld:Init()
	self:InitUI()
	self:AddUIListeners()
end

function ActivitySkinResultRewardItemOld:InitUI()
	self:BindCfgUI()

	self.typeCon_ = ControllerUtil.GetController(self.transform_, "type")
	self.switchCon_ = ControllerUtil.GetController(self.transform_, "switch")
	self.numCon_ = ControllerUtil.GetController(self.transform_, "num")
	self.commonItem_ = CommonItemView.New(self.commonItemGo_)
end

function ActivitySkinResultRewardItemOld:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		ShowPopItem(POP_ITEM, {
			self.itemID_
		})
	end)
end

function ActivitySkinResultRewardItemOld:SetData(arg_6_1, arg_6_2, arg_6_3)
	self.cfg_ = ActivityLimitedDrawPoolCfg[arg_6_1]
	self.itemID_ = self.cfg_.reward[1][1]
	self.id_ = arg_6_1
	self.num_.text = GetI18NText("X" .. self.cfg_.reward[1][2])
	self.name_.text = GetI18NText(ItemTools.getItemName(self.itemID_))

	local var_6_0 = false

	if ItemCfg[self.itemID_].type == ItemConst.ITEM_TYPE.HERO_SKIN then
		self.typeCon_:SetSelectedState("special")

		var_6_0 = true
	else
		self.typeCon_:SetSelectedState(self.cfg_.minimum_guarantee == 2 and 3 or 2)
	end

	SetActive(self.role_.gameObject, var_6_0)
	SetActive(self.icon_.gameObject, not var_6_0)

	if var_6_0 then
		self.role_.sprite = pureGetSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. self.itemID_)
	else
		self.icon_.sprite = ItemTools.getItemSprite(self.itemID_)
	end

	self.numCon_:SetSelectedState(tostring(not ActivitySkinDrawActionOld.GetIsCanReplace(arg_6_1)))

	if not arg_6_3 then
		self.switchCon_:SetSelectedState("off")
	elseif ItemCfg[self.itemID_].num_exchange_item then
		self.switchCon_:SetSelectedState("on")
		self.numCon_:SetSelectedState("false")

		local var_6_1 = clone(ItemTemplateData)

		var_6_1.id = ItemCfg[self.itemID_].num_exchange_item[1][1]
		var_6_1.number = ItemCfg[self.itemID_].num_exchange_item[1][2]

		self.commonItem_:SetData(var_6_1)
	end
end

function ActivitySkinResultRewardItemOld:OnExit()
	return
end

function ActivitySkinResultRewardItemOld:Dispose()
	self:RemoveAllListeners()
	self.commonItem_:Dispose()
	self.super.Dispose(self)
end

return ActivitySkinResultRewardItemOld
