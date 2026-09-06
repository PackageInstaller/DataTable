-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/xiaonuobirthday/BirthdaywelfaresignViewExt.lua

module("logic.extensions.bonus.view.xiaonuobirthday.BirthdaywelfaresignViewExt", package.seeall)

local BirthdaywelfaresignViewExt = class("BirthdaywelfaresignViewExt", BirthdaywelfaresignView)

function BirthdaywelfaresignViewExt:onEnter()
	BirthdaywelfaresignViewExt.super.onEnter(self)
	RedPointController.instance:saveUserOnceRedPoint(RedPointModel.ID_BIRTH_SIGN_IN_TWO, true)
end

function BirthdaywelfaresignViewExt:setRoleId()
	return 14005
end

function BirthdaywelfaresignViewExt:getEffectPath()
	return "fx_ui_fuli/fx_ui_fuli_lingqu.prefab"
end

function BirthdaywelfaresignViewExt:getEffectScale()
	return 1.7
end

function BirthdaywelfaresignViewExt:getEffectPos()
	return 5, 0, 0
end

return BirthdaywelfaresignViewExt
