ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleDataFunction
local BattleAirStrikeIconView = class("BattleAirStrikeIconView")

ys.Battle.BattleAirStrikeIconView = BattleAirStrikeIconView
BattleAirStrikeIconView.__name = "BattleAirStrikeIconView"
BattleAirStrikeIconView.DEFAULT_ICON_NAME = "99shijianbao"

function BattleAirStrikeIconView:Ctor(arg_1_1)
	self._iconList = {}

	self:ConfigIconSkin(arg_1_1)

	return
end

function BattleAirStrikeIconView:ConfigIconSkin(arg_2_1)
	self._iconTpl = arg_2_1
	self._iconContainer = arg_2_1.parent

	return
end

function BattleAirStrikeIconView:AppendIcon(arg_3_1, arg_3_2)
	local var_3_0 = cloneTplTo(self._iconTpl, self._iconContainer).gameObject
	local var_3_1 = var_3_0.transform:Find("FighterIcon")

	var_3_0:SetActive(true)
	self:setIconNumber(var_3_1, arg_3_2.totalNumber)
	setImageSprite(var_3_1, (var_0_0.Battle.BattleResourceManager.GetInstance():GetAircraftIcon(var_0_1.GetAircraftTmpDataFromID(arg_3_2.templateID).icon or BattleAirStrikeIconView.DEFAULT_ICON_NAME)))

	self._iconList[arg_3_1] = var_3_0

	if var_3_0:GetComponent(typeof(Animation)) then
		quickPlayAnimation(var_3_0, "anim_skinui_AFC_in")
	end

	return
end

function BattleAirStrikeIconView:RemoveIcon(arg_4_1, arg_4_2)
	local var_4_0 = self._iconList[arg_4_1]

	if not self._iconList[arg_4_1] then
		return
	end

	if arg_4_2.totalNumber <= 0 then
		local function var_4_1()
			Object.Destroy(var_4_0)

			self._iconList[arg_4_1] = nil

			return
		end

		if self._iconList[arg_4_1]:GetComponent(typeof(Animation)) then
			self._iconList[arg_4_1]:GetComponent("DftAniEvent"):SetEndEvent(function(arg_6_0)
				var_4_1()

				return
			end)
			quickPlayAnimation(self._iconList[arg_4_1], "anim_skinui_AFC_out")
		else
			var_4_1()
		end
	else
		self:setIconNumber(self._iconList[arg_4_1].transform:Find("FighterIcon"), arg_4_2.totalNumber)
	end

	return
end

function BattleAirStrikeIconView:Dispose()
	for iter_7_0, iter_7_1 in pairs(self._iconList) do
		Object.Destroy(iter_7_1)
	end

	self._iconList = nil

	return
end

function BattleAirStrikeIconView:setIconNumber(arg_8_1, arg_8_2)
	arg_8_1.transform:Find("FighterNum"):GetComponent(typeof(Text)).text = "X" .. arg_8_2

	return
end

return
