local WeaponServantHeadItem = class("WeaponServantHeadItem", ReduxView)

function WeaponServantHeadItem:OnCtor(arg_1_1, arg_1_2)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function WeaponServantHeadItem:BuildContext()
	local var_2_0 = self.gameObject_:GetComponent("ControllerExCollection")

	self.controller = {
		comps = var_2_0,
		state = {
			select = {
				False = "false",
				name = "select",
				True = "true",
				comps = var_2_0:GetController("select")
			},
			mask = {
				False = "false",
				name = "mask",
				True = "true",
				comps = var_2_0:GetController("mask")
			},
			star = {
				Star1 = "star1",
				name = "star",
				Star4 = "star4",
				Star5 = "star5",
				Star3 = "star3",
				Star2 = "star2",
				comps = var_2_0:GetController("star")
			}
		}
	}
	self.data = {
		info = {}
	}
	self.constVar = {
		isShowLock = true,
		lockImg = {
			unlocked = "com_white_icon_26",
			locked = "com_white_icon_25"
		}
	}
end

function WeaponServantHeadItem:InitContext()
	self.data.info = {}
end

function WeaponServantHeadItem:Init()
	self:BindCfgUI()

	self.roleIconImg_.immediate = true

	self:BuildContext()
	self:AddUIListener()
end

function WeaponServantHeadItem:AddUIListener()
	self:AddBtnListener(self.clickBtn_, nil, function()
		if self.data.clickCallback then
			self.data.clickCallback(self)
		end
	end)
end

function WeaponServantHeadItem:OnEnter()
	return
end

function WeaponServantHeadItem:OnExit()
	return
end

function WeaponServantHeadItem:Dispose()
	WeaponServantHeadItem.super.Dispose(self)
end

function WeaponServantHeadItem:RegistCallBack(arg_10_1)
	self.data.clickCallback = arg_10_1
end

function WeaponServantHeadItem:OnRender(arg_11_1)
	self:InitContext()

	self.data.info = arg_11_1
	self.roleIconImg_.spriteSync = "TextureConfig/WeaponServant/Icon438x238/" .. arg_11_1.id
	self.levelTxt_.text = arg_11_1.number
	self.qualityImg_.sprite = getSprite("Atlas/Hero_servantAtlas", string.format("img_servantGrade_0%d", 6 - ItemCfg[arg_11_1.id].rare))

	self:SwitchControllerState(self.controller.state.star.name, string.format("star%d", ItemCfg[arg_11_1.id].rare))

	self.servantGroupImg_.sprite = getSprite("Atlas/Item", string.format("icon_group_%d_c", WeaponServantCfg[arg_11_1.id].race))
end

function WeaponServantHeadItem:RenderEquipStatus(arg_12_1, arg_12_2)
	SetActive(self.avatarObj_, arg_12_1 or false)

	if arg_12_1 then
		self.avatarIcon_.sprite = HeroTools.GetSmallHeadSprite(arg_12_2)
	end
end

function WeaponServantHeadItem:ShowSelect(arg_13_1)
	self:SwitchControllerState(self.controller.state.select.name, (arg_13_1 or nil) and self.controller.state.select.True)
end

function WeaponServantHeadItem:ShowMask(arg_14_1)
	self:SwitchControllerState(self.controller.state.mask.name, (arg_14_1 or nil) and self.controller.state.mask.True)
end

function WeaponServantHeadItem:ShowLock(arg_15_1)
	if self.constVar.isShowLock then
		SetActive(self.lockRootObj_, arg_15_1)
	end
end

function WeaponServantHeadItem:ShowLockObj(arg_16_1)
	self.constVar.isShowLock = arg_16_1

	SetActive(self.lockRootObj_, arg_16_1 or false)
end

function WeaponServantHeadItem:ShowRecommendTag(arg_17_1)
	SetActive(self.recommendObj_, arg_17_1 or false)
end

function WeaponServantHeadItem:GetItemUid()
	if self.data.info then
		return self.data.info.uid
	end

	return 0
end

function WeaponServantHeadItem:GetIndex()
	if self.data.info then
		return self.data.info.index
	end

	return nil
end

function WeaponServantHeadItem:SwitchControllerState(arg_20_1, arg_20_2)
	if self.controller.state[arg_20_1] then
		self.controller.state[arg_20_1].comps:SetSelectedState(arg_20_2)
	end
end

return WeaponServantHeadItem
