local SevenDaySkinItem_3_4 = class("SevenDaySkinItem_3_4", ReduxView)

function SevenDaySkinItem_3_4:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:Init()
end

function SevenDaySkinItem_3_4:Init()
	self:InitUI()
	self:AddUIListeners()
end

function SevenDaySkinItem_3_4:InitUI()
	self:BindCfgUI()

	self.stateCon_ = ControllerUtil.GetController(self.transform_, "receive")
end

function SevenDaySkinItem_3_4:AddUIListeners()
	self:AddBtnListener(self.btn_, nil, function()
		if self.state_ == 1 or self.isResign_ then
			if self.receiveFunc_ then
				self.receiveFunc_()
			end
		else
			ShowPopItem(POP_ITEM, self.item_)
		end
	end)
end

function SevenDaySkinItem_3_4:RefreshView(arg_6_1, arg_6_2, arg_6_3)
	self.stateCon_:SetSelectedIndex(arg_6_2)

	self.state_ = arg_6_2
	self.isResign_ = arg_6_3

	SetActive(self.redGo_, self.state_ == 1 and not self.isResign_)
	SetActive(self.resignGo_, self.isResign_)

	self.item_ = arg_6_1

	local var_6_0 = arg_6_1[1]

	self.numTxt_.text = arg_6_1[2]

	SetActive(self.numGo_, arg_6_1[2] >= 1)

	self.icon_.sprite = ItemCfg[var_6_0].type == ItemConst.ITEM_TYPE.HERO_SKIN and pureGetSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. var_6_0) or ItemTools.getItemSprite(var_6_0)
end

function SevenDaySkinItem_3_4:RegisterClickFunc(arg_7_1)
	self.receiveFunc_ = arg_7_1
end

function SevenDaySkinItem_3_4:OnExit()
	return
end

function SevenDaySkinItem_3_4:Dispose()
	self:RemoveAllListeners()
	SevenDaySkinItem_3_4.super.Dispose(self)
end

return SevenDaySkinItem_3_4
