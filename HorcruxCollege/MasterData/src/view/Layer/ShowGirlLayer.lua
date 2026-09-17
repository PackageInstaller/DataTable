local ShowGirlLayer = class("ShowGirlLayer", function()
	return cc.Layer:create()
end)

require("view.Layer.L2dLayer")
require("view.Layer.DormL2dLayer")
require("view.Layer.BGL2dLayer")

local ShowGirlSpine = require("view.Sprite.ShowGirlSpine")
local DormGirlSpine = require("view.Sprite.DormGirlSpine")
local ShowGirlImage = require("view.Sprite.ShowGirlImage")
local DormGirlImage = require("view.Sprite.DormGirlImage")
local model_data = require("data.model_data")
local background_data = require("data.background_data")
local role_conversation_data = require("data.role_conversation_data")
local time_check_manager = require("controller.time_check_manager")
local audio_manager = require("controller.audio_manager")
local var_0_10 = 1
local var_0_11 = 2
local var_0_12 = 3
local var_0_14 = 0
local var_0_15 = 1
local var_0_16 = 2
local var_0_17 = 3
local var_0_18 = 4
local var_0_19 = 5
local var_0_20 = 320
local var_0_21 = -50
local var_0_22 = 320
local var_0_23 = -50
local var_0_24 = 426
local var_0_25 = 175
local var_0_26 = 320
local var_0_27 = -50

local function var_0_28(arg_2_0)
	if arg_2_0 ~= var_0_15 then
		return false
	end

	local var_2_0 = time_check_manager:getCurTime()

	if var_2_0 < os.time({
		hour = 0,
		month = 4,
		year = 2021,
		min = 0,
		sec = 0,
		day = 1
	}) or os.time({
		hour = 23,
		month = 4,
		year = 2021,
		min = 59,
		sec = 59,
		day = 1
	}) < var_2_0 then
		return false
	end

	return true
end

EVENT_SETTING_SHOWGIRL = {
	LIVE2D_FINISH = 1,
	IMAGE_START = 2,
	SPINE_FINISH = 5,
	LIVE2D_START = 0,
	IMAGE_FINISH = 3,
	SPINE_START = 4
}

function ShowGirlLayer:create(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = ShowGirlLayer.new()

	var_3_0:init(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)

	return var_3_0
end

function ShowGirlLayer:init(arg_4_1, arg_4_2, arg_4_3, arg_4_4, arg_4_5)
	print(arg_4_1, arg_4_2)

	self._modelid = arg_4_1
	self._modelid = tostring(self._modelid)
	self._showgirltype = nil
	self._showtype = arg_4_2 or var_0_15
	self._posStat = self._showtype == var_0_15 and 1 or 0
	self._isnotlive2 = arg_4_3
	self._settinghandler = arg_4_4
	self._playl2dbeginani = arg_4_5

	if global_canshow_live2d(arg_4_1) and self._isnotlive2 ~= true then
		self:showLive2D()
	elseif global_canshow_spine(arg_4_1) then
		self:showSpine()
	else
		self:showImage()
	end

	self:updateLaiLaImg()
end

function ShowGirlLayer:update(arg_5_1, arg_5_2, arg_5_3)
	print("ShowGirlLayer update modelid：", arg_5_1)

	if self._modelid == arg_5_1 then
		return
	end

	self._modelid = arg_5_1
	self.updateCallback = arg_5_2
	self._playl2dbeginani = arg_5_3

	if var_0_28(self._showtype) then
		self:updateToActivitySpine(arg_5_1)

		return
	elseif self.isactivityspine then
		self:revertFromActivitySpine()

		return
	end

	if global_canshow_live2d(arg_5_1) then
		self:showLive2D()

		if self._showtype == var_0_15 then
			self:playSwitchShowGirlSound()
		end
	elseif global_canshow_spine(arg_5_1) then
		self:showSpine()

		if self._showtype == var_0_15 then
			self:playSwitchShowGirlSound()
		end
	else
		self:showImage()

		if self._showtype == var_0_15 then
			self:playSwitchShowGirlSound()
		end
	end

	self:updateLaiLaImg()
end

function ShowGirlLayer:updateToActivitySpine(arg_6_1)
	return
end

function ShowGirlLayer:revertFromActivitySpine()
	return
end

function ShowGirlLayer:resetShowGirlLayer()
	self.updateCallback = callback

	if self.isactivityspine then
		return
	end

	if global_canshow_live2d(self._modelid) then
		self:showLive2D()
	elseif global_canshow_spine(self._modelid) then
		self:showSpine()
	else
		self:showImage()
	end

	self:updateLaiLaImg()
end

function ShowGirlLayer:resetCurTalkConfig()
	if global_canshow_live2d(self._modelid) then
		-- block empty
	elseif global_canshow_spine(self._modelid) then
		if self:getChildByName("spine") then
			self:getChildByName("spine"):resetCurTalkConfig()
		end
	elseif self:getChildByName("roleimage") then
		self:getChildByName("roleimage"):resetCurTalkConfig()
	end
end

function ShowGirlLayer:switchPos(arg_10_1)
	if arg_10_1 == self._posStat then
		return
	end

	self._posStat = arg_10_1

	if self._showgirltype == var_0_10 then
		if self:getChildByName("l2dlayer") then
			self:getChildByName("l2dlayer"):movePlayer(1 - arg_10_1)
		end

		if self:getChildByName("BGl2dlayer") then
			self:getChildByName("BGl2dlayer"):movePlayer(1 - arg_10_1)
		end

		if self:getChildByName("frontl2dlayer") then
			self:getChildByName("frontl2dlayer"):movePlayer(1 - arg_10_1)
		end
	elseif self._showgirltype == var_0_11 then
		self:updateRoleSpinePos()
	elseif self._showgirltype == var_0_12 then
		self:updateRoleImagePos()
	end

	if var_0_28(self._showtype) and self.isactivityspine then
		if arg_10_1 == 0 and self:getChildByName("reBtn") then
			self:getChildByName("reBtn"):runAction(cc.RemoveSelf:create())

			return
		end

		local var_10_0 = ccui.Button:create("public/button/public_button_big_y.png", nil, "public/button/public_button_big_y.png", config._DEBUG and 0 or 1)

		var_10_0:setPosition(cc.p(320, 300))
		var_10_0:setName("reBtn")
		self:addChild(var_10_0, 99)

		local var_10_1 = cc.Label:createWithTTF(L_RE_SHOWGRIL, FONT_DES, 24)

		var_10_1:setColor(cc.c3b(0, 0, 0))
		var_10_1:setPosition(cc.p(var_10_0:getContentSize().width / 2, var_10_0:getContentSize().height / 2))
		var_10_0:addChild(var_10_1, 111)
		var_10_0:addTouchEventListener(function(arg_11_0, arg_11_1)
			if arg_11_1 ~= ccui.TouchEventType.ended then
				return
			end

			self:revertFromActivitySpine()
			var_10_0:runAction(cc.RemoveSelf:create())
		end)
	end
end

function ShowGirlLayer:playSwitchShowGirlSound()
	self:insertTalk(ROLE_CONVERSATION_TYPE.changeShowgilr)
end

function ShowGirlLayer:addLive2D()
	local var_13_0 = self._showtype == var_0_16 and DormL2dLayer:create() or L2dLayer:create()

	var_13_0:setName("l2dlayer")
	self:addChild(var_13_0, -1)
	var_13_0:registerSettingListener(function(arg_14_0)
		if arg_14_0 == L2DEVENT.SETTINGSTART then
			self:onLive2DSettingStart()
		elseif arg_14_0 == L2DEVENT.SETTINGFINISH then
			self:onLive2DSettingFinish()
		end
	end)
	var_13_0:addPlayer(self._posStat, self._modelid, model_data[self._modelid].live2d, false, self._playl2dbeginani)
	var_13_0:setCanStayEnabled(self._showtype ~= var_0_17)

	if self.touchTalkCallback then
		var_13_0:setTouchTalkCallback(self.touchTalkCallback)
	end
end

function ShowGirlLayer:showLive2D()
	if self:getChildByName("spine") then
		self:getChildByName("spine"):runAction(cc.RemoveSelf:create())
	end

	if self:getChildByName("roleimage") then
		self:getChildByName("roleimage"):runAction(cc.RemoveSelf:create())
	end

	self._showgirltype = var_0_10

	if self:getChildByName("BGl2dlayer") then
		self:updateBGLive2d()
	else
		self:addBGLive2D()
	end

	if self:getChildByName("l2dlayer") then
		self:updateLive2D()
	else
		self:addLive2D()
	end

	if self:getChildByName("frontl2dlayer") then
		self:updateFrontLive2d()
	else
		self:addFrontLive2D()
	end

	if self.updateCallback then
		self.updateCallback()

		self.updateCallback = nil
	end
end

function ShowGirlLayer:updateLive2D()
	self:getChildByName("l2dlayer"):addPlayer(self._posStat, self._modelid, model_data[self._modelid].live2d, false, self._playl2dbeginani)
	self:getChildByName("l2dlayer"):setCanStayEnabled(self._showtype ~= var_0_17)
end

function ShowGirlLayer:onLive2DSettingStart()
	if not self._settinghandler then
		return
	end

	local var_17_0, var_17_1 = pcall(self._settinghandler, EVENT_SETTING_SHOWGIRL.LIVE2D_START, self._modelid)

	if not var_17_0 then
		__G__TRACKBACK__(var_17_1)
	end
end

function ShowGirlLayer:onLive2DSettingFinish()
	if not self._settinghandler then
		return
	end

	local var_18_0, var_18_1 = pcall(self._settinghandler, EVENT_SETTING_SHOWGIRL.LIVE2D_FINISH, self._modelid)

	if not var_18_0 then
		__G__TRACKBACK__(var_18_1)
	end
end

function ShowGirlLayer:addBGLive2D()
	if not model_data[self._modelid].backgroundid then
		return
	end

	local var_19_0 = background_data[model_data[self._modelid].backgroundid].background_live2d

	if not background_data[model_data[self._modelid].backgroundid].background_live2d then
		return
	end

	local var_19_1 = BGL2dLayer:create()
	local var_19_2 = background_data[model_data[self._modelid].backgroundid].node_zorder or -3

	var_19_1:setName("BGl2dlayer")
	self:addChild(var_19_1, var_19_2)
	var_19_1:setTouchEnabled(false)
	var_19_1:setCanStayEnabled(false)
	var_19_1:addPlayer(self._posStat, model_data[self._modelid].backgroundid, var_19_0)
end

function ShowGirlLayer:updateBGLive2d()
	if not model_data[self._modelid].backgroundid then
		self:getChildByName("BGl2dlayer"):runAction(cc.RemoveSelf:create())

		return
	end

	local var_20_0 = background_data[model_data[self._modelid].backgroundid].background_live2d

	if not background_data[model_data[self._modelid].backgroundid].background_live2d then
		self:getChildByName("BGl2dlayer"):runAction(cc.RemoveSelf:create())

		return
	end

	self:getChildByName("BGl2dlayer"):addPlayer(self._posStat, model_data[self._modelid].backgroundid, var_20_0)
	self:getChildByName("BGl2dlayer"):setZOrder(background_data[model_data[self._modelid].backgroundid].node_zorder or -2)
end

function ShowGirlLayer:updateLaiLaImg(arg_21_1)
	if self:getChildByName("laila_img") then
		self:getChildByName("laila_img"):removeFromParent()
	end

	if self._modelid == "12970" then
		local var_21_0 = ccui.ImageView:create("mainScenebg/l2d_cloud_laila.png")

		var_21_0:setAnchorPoint(cc.p(0.5, 0.5))
		var_21_0:setPosition(cc.p(320, GameDisplay.height + 455 - GameDisplay.fix_y))
		var_21_0:setScale(3)
		var_21_0:setName("laila_img")
		self:addChild(var_21_0, 0)

		local var_21_1 = {
			rotation = var_21_0:getRotation()
		}
		local var_21_2 = require("fight.tween").new(60, var_21_1, {
			rotation = var_21_0:getRotation() + 360
		}, "linear")

		var_21_0:scheduleUpdateWithPriorityLua(function(arg_22_0)
			if var_21_2:update(arg_22_0) then
				var_21_0:setRotation(var_21_1.rotation)
				var_21_2:reset()
			else
				var_21_0:setRotation(var_21_1.rotation)
			end
		end, 0)
	elseif self._modelid == "1223110" then
		local var_21_3 = ccui.ImageView:create("mainScenebg/black1.jpg")

		var_21_3:setAnchorPoint(cc.p(0.5, 0.5))
		var_21_3:setPosition(cc.p(320, -GameDisplay.fix_y))
		var_21_3:setName("laila_img")
		self:addChild(var_21_3, -10)
	end
end

function ShowGirlLayer:addFrontLive2D()
	if not model_data[self._modelid].backgroundid then
		return
	end

	local var_23_0 = background_data[model_data[self._modelid].backgroundid].front_live2d

	if not background_data[model_data[self._modelid].backgroundid].front_live2d then
		return
	end

	local var_23_1 = L2dLayer:create()
	local var_23_2 = background_data[model_data[self._modelid].backgroundid].front_node_zorder or 5

	var_23_1:setName("frontl2dlayer")
	self:addChild(var_23_1, var_23_2)
	var_23_1:setTouchEnabled(true)
	var_23_1:setCanStayEnabled(true)
	var_23_1:addPlayer(self._posStat, 13182, var_23_0, true)
end

function ShowGirlLayer:updateFrontLive2d()
	if not model_data[self._modelid].backgroundid then
		self:getChildByName("frontl2dlayer"):runAction(cc.RemoveSelf:create())

		return
	end

	local var_24_0 = background_data[model_data[self._modelid].backgroundid].front_live2d

	if not background_data[model_data[self._modelid].backgroundid].front_live2d then
		self:getChildByName("frontl2dlayer"):runAction(cc.RemoveSelf:create())

		return
	end

	self:getChildByName("frontl2dlayer"):addPlayer(self._posStat, 13182, var_24_0, true)
	self:getChildByName("frontl2dlayer"):setZOrder(5)
end

function ShowGirlLayer:setLive2DPlayStayEnabled(arg_25_1)
	if self._showgirltype ~= var_0_10 then
		return
	end

	if not self:getChildByName("l2dlayer") then
		return
	end

	self:getChildByName("l2dlayer"):setCanStayEnabled(arg_25_1)
end

function ShowGirlLayer:showSpine()
	if self:getChildByName("l2dlayer") then
		self:getChildByName("l2dlayer"):runAction(cc.RemoveSelf:create())
	end

	if self:getChildByName("BGl2dlayer") then
		self:getChildByName("BGl2dlayer"):runAction(cc.RemoveSelf:create())
	end

	if self:getChildByName("frontl2dlayer") then
		self:getChildByName("frontl2dlayer"):runAction(cc.RemoveSelf:create())
	end

	if self:getChildByName("roleimage") then
		self:getChildByName("roleimage"):runAction(cc.RemoveSelf:create())
	end

	self._showgirltype = var_0_11

	if self:getChildByName("spine") then
		self:updateRoleSpine()
	else
		self:addRoleSpine()
	end

	if self.updateCallback then
		self.updateCallback()

		self.updateCallback = nil
	end
end

local function var_0_29(arg_27_0)
	local var_27_0, var_27_1 = arg_27_0:match("([^,]+),(.+)")

	return cc.p(checknumber(var_27_0), checknumber(var_27_1))
end

function ShowGirlLayer:addRoleSpine()
	local var_28_0

	if self._showtype == var_0_15 then
		var_28_0 = ShowGirlSpine:create(self._modelid)
	elseif self._showtype == var_0_16 then
		var_28_0 = DormGirlSpine:create(self._modelid)

		var_28_0:setPosition(var_0_20, 0)
	elseif self._showtype == var_0_17 then
		var_28_0 = ShowGirlSpine:create(self._modelid, true)

		var_28_0:setPosition(var_0_22, 0)
	elseif self._showtype == var_0_18 then
		var_28_0 = ShowGirlSpine:create(self._modelid, true)

		var_28_0:setPosition(var_0_26, 0)
	elseif self._showtype == var_0_19 then
		var_28_0 = ShowGirlSpine:create(self._modelid, nil, self._showtype)

		var_28_0:setPosition(var_0_24, var_0_25)
	end

	var_28_0:setName("spine")
	self:addChild(var_28_0)
	var_28_0:play("idle")

	if self.touchTalkCallback then
		var_28_0:setTouchTalkCallback(self.touchTalkCallback)
	end

	self:initRoleSpinePos()
end

function ShowGirlLayer:updateRoleSpine()
	self:getChildByName("spine"):reset(self._modelid)
	self:getChildByName("spine"):play("idle")
	self:initRoleSpinePos()
end

function ShowGirlLayer:initRoleSpinePos()
	local var_30_0 = self:getChildByName("spine")

	if not var_30_0 then
		return
	end

	if self._showtype == var_0_19 then
		local var_30_1 = model_data[self._modelid].database_equip_offset_x or 0
		local var_30_2 = model_data[self._modelid].database_equip_offset_y or 0

		self:getChildByName("spine"):setPosition((cc.p(var_0_24 + var_30_1, var_0_25 + var_30_2)))
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用坐标EQUIP_INIT_X, EQUIP_INIT_Y (%s,%s)", var_0_24, var_0_25), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用偏移modelData[%s].database_equip_offset_x, modelData[%s].database_equip_offset_y (%s,%s)", self._modelid, self._modelid, var_30_1, var_30_2), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用气泡偏移modelData[%s].database_talk_pos_offset or modelData[%s].talk_pos_offset (%s)", self._modelid, self._modelid, model_data[self._modelid].database_talk_pos_offset or model_data[self._modelid].talk_pos_offset or "0,0"), CONSOLE_COLOR_GREEN)
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
	elseif self._posStat == var_0_14 then
		local var_30_3 = model_data[self._modelid].spinemainmidpos and var_0_29(model_data[self._modelid].spinemainmidpos) or cc.p(320, 0)
		local var_30_4 = model_data[self._modelid].spinemainmidoffset and var_0_29(model_data[self._modelid].spinemainmidoffset) or cc.p(0, 0)

		var_30_0:setPosition(cc.p(var_30_3.x + var_30_4.x, var_30_3.y + var_30_4.y))
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用坐标modelData[%s].spinemainmidpos (%s,%s)", self._modelid, var_30_3.x, var_30_3.y), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用偏移modelData[%s].spinemainmidoffset (%s,%s)", self._modelid, var_30_4.x, var_30_4.y), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用气泡偏移modelData[%s]modelData[%s].talk_pos_offset (%s)", self._modelid, self._modelid, model_data[self._modelid].talk_pos_offset or "0,0"), CONSOLE_COLOR_GREEN)
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
	else
		local var_30_5 = model_data[self._modelid].spinemaininitpos and var_0_29(model_data[self._modelid].spinemaininitpos) or cc.p(320, 0)
		local var_30_6 = model_data[self._modelid].spinemaininitoffset and var_0_29(model_data[self._modelid].spinemaininitoffset) or cc.p(0, 0)

		var_30_0:setPosition(cc.p(var_30_5.x + var_30_6.x, var_30_5.y + var_30_6.y))
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用坐标modelData[%s].spinemaininitpos (%s,%s)", self._modelid, var_30_5.x, var_30_5.y), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用偏移modelData[%s].spinemaininitoffset (%s,%s)", self._modelid, var_30_6.x, var_30_6.y), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用气泡偏移modelData[%s]modelData[%s].talk_pos_offset (%s)", self._modelid, self._modelid, model_data[self._modelid].talk_pos_offset or "0,0"), CONSOLE_COLOR_GREEN)
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
	end
end

function ShowGirlLayer:updateRoleSpinePos()
	if not self:getChildByName("spine") then
		return
	end

	local var_31_0 = self._modelid

	if self._showtype == var_0_19 then
		local var_31_1 = model_data[var_31_0].database_equip_offset_x or 0
		local var_31_2 = model_data[var_31_0].database_equip_offset_y or 0

		self:getChildByName("spine"):runAction(cc.MoveTo:create(0.2, (cc.p(var_0_24 + var_31_1, var_0_25 + var_31_2))))
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用坐标EQUIP_INIT_X, EQUIP_INIT_Y (%s,%s)", var_0_24, var_0_25), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用偏移modelData[%s].database_equip_offset_x, modelData[%s].database_equip_offset_y (%s,%s)", var_31_0, var_31_0, var_31_1, var_31_2), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用气泡偏移modelData[%s].database_talk_pos_offset or modelData[%s].talk_pos_offset (%s)", var_31_0, var_31_0, model_data[var_31_0].database_talk_pos_offset or model_data[var_31_0].talk_pos_offset or "0,0"), CONSOLE_COLOR_GREEN)
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
	else
		local var_31_3 = model_data[var_31_0].spinemainmidpos and var_0_29(model_data[var_31_0].spinemainmidpos) or cc.p(320, 0)
		local var_31_4 = model_data[var_31_0].spinemainmidoffset and var_0_29(model_data[var_31_0].spinemainmidoffset) or cc.p(0, 0)
		local var_31_5 = cc.p(var_31_3.x + var_31_4.x, var_31_3.y + var_31_4.y)
		local var_31_6 = model_data[var_31_0].spinemaininitpos and var_0_29(model_data[var_31_0].spinemaininitpos) or cc.p(320, 0)
		local var_31_7 = model_data[var_31_0].spinemaininitoffset and var_0_29(model_data[var_31_0].spinemaininitoffset) or cc.p(0, 0)
		local var_31_8 = cc.p(var_31_6.x + var_31_7.x, var_31_6.y + var_31_7.y)

		if self._posStat == var_0_14 then
			self:getChildByName("spine"):runAction(cc.MoveTo:create(0.5, var_31_5))
			self:getChildByName("spine"):getTalkSP():runAction(cc.MoveBy:create(0.5, cc.p(var_31_5.x - var_31_8.x, var_31_5.y - var_31_8.y)))
		else
			self:getChildByName("spine"):runAction(cc.MoveTo:create(0.5, var_31_8))
			self:getChildByName("spine"):getTalkSP():runAction(cc.MoveBy:create(0.5, cc.p(var_31_8.x - var_31_5.x, var_31_8.y - var_31_5.y)))
		end
	end
end

function ShowGirlLayer:showImage()
	if self:getChildByName("l2dlayer") then
		self:getChildByName("l2dlayer"):runAction(cc.RemoveSelf:create())
	end

	if self:getChildByName("BGl2dlayer") then
		self:getChildByName("BGl2dlayer"):runAction(cc.RemoveSelf:create())
	end

	if self:getChildByName("frontl2dlayer") then
		self:getChildByName("frontl2dlayer"):runAction(cc.RemoveSelf:create())
	end

	if self:getChildByName("spine") then
		self:getChildByName("spine"):runAction(cc.RemoveSelf:create())
	end

	self._showgirltype = var_0_12

	if self:getChildByName("roleimage") then
		self:updateRoleImage()
	else
		self:addRoleImage()
	end

	if self.updateCallback then
		self.updateCallback()

		self.updateCallback = nil
	end
end

function ShowGirlLayer:addRoleImage()
	local var_33_0

	if self._showtype == var_0_15 then
		var_33_0 = ShowGirlImage:create(self._modelid, self._showtype)
	elseif self._showtype == var_0_16 then
		var_33_0 = DormGirlImage:create(self._modelid, self._showtype)

		var_33_0:setPosition(var_0_20, var_0_21)
	elseif self._showtype == var_0_17 then
		var_33_0 = ShowGirlImage:create(self._modelid, self._showtype)

		var_33_0:setPosition(var_0_22, var_0_23)
	elseif self._showtype == var_0_18 then
		var_33_0 = ShowGirlImage:create(self._modelid, self._showtype)

		var_33_0:setPosition(var_0_26, var_0_27)
	elseif self._showtype == var_0_19 then
		var_33_0 = ShowGirlImage:create(self._modelid, self._showtype)

		var_33_0:setPosition(var_0_24, var_0_25)
	end

	var_33_0:setAnchorPoint(cc.p(0.5, 0))
	var_33_0:setName("roleimage")
	self:addChild(var_33_0)

	if self.touchTalkCallback then
		var_33_0:setTouchTalkCallback(self.touchTalkCallback)
	end

	self:initRoleImagePos()
end

function ShowGirlLayer:updateRoleImage()
	self:getChildByName("roleimage"):reset(self._modelid)
	self:initRoleImagePos()
end

function ShowGirlLayer:initRoleImagePos()
	local var_35_0 = self:getChildByName("roleimage")

	if not var_35_0 then
		return
	end

	if self._showtype == var_0_19 then
		local var_35_1 = model_data[self._modelid].database_equip_offset_x or 0
		local var_35_2 = model_data[self._modelid].database_equip_offset_y or 0

		var_35_0:setPosition((cc.p(var_0_24 + var_35_1, var_0_25 + var_35_2)))
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用坐标EQUIP_INIT_X, EQUIP_INIT_Y (%s,%s)", var_0_24, var_0_25), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用偏移modelData[%s].database_equip_offset_x, modelData[%s].database_equip_offset_y (%s,%s)", self._modelid, self._modelid, var_35_1, var_35_2), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用气泡偏移modelData[%s].database_talk_pos_offset or modelData[%s].talk_pos_offset (%s)", self._modelid, self._modelid, model_data[self._modelid].database_talk_pos_offset or model_data[self._modelid].talk_pos_offset or "0,0"), CONSOLE_COLOR_GREEN)
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
		self:getChildByName("roleimage"):setScale(model_data[self._modelid].database_equip_scale or 1)
	elseif self._posStat == 0 then
		local var_35_3 = model_data[self._modelid].mainmidpos and var_0_29(model_data[self._modelid].mainmidpos) or cc.p(320, -50)
		local var_35_4 = model_data[self._modelid].mainmidoffset and var_0_29(model_data[self._modelid].mainmidoffset) or cc.p(0, 0)

		var_35_0:setRolePosition(cc.p(var_35_3.x + var_35_4.x, var_35_3.y + var_35_4.y))
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用坐标modelData[%s].mainmidpos (%s,%s)", self._modelid, var_35_3.x, var_35_3.y), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用偏移modelData[%s].mainmidoffset (%s,%s)", self._modelid, var_35_4.x, var_35_4.y), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用气泡偏移modelData[%s]modelData[%s].talk_pos_offset (%s)", self._modelid, self._modelid, model_data[self._modelid].talk_pos_offset or "0,0"), CONSOLE_COLOR_GREEN)
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
	else
		local var_35_5 = model_data[self._modelid].maininitpos and var_0_29(model_data[self._modelid].maininitpos) or cc.p(280, -50)
		local var_35_6 = model_data[self._modelid].maininitoffset and var_0_29(model_data[self._modelid].maininitoffset) or cc.p(0, 0)

		var_35_0:setRolePosition(cc.p(var_35_5.x + var_35_6.x, var_35_5.y + var_35_6.y))
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用坐标modelData[%s].maininitpos (%s,%s)", self._modelid, var_35_5.x, var_35_5.y), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用偏移modelData[%s].maininitoffset (%s,%s)", self._modelid, var_35_6.x, var_35_6.y), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用气泡偏移modelData[%s]modelData[%s].talk_pos_offset (%s)", self._modelid, self._modelid, model_data[self._modelid].talk_pos_offset or "0,0"), CONSOLE_COLOR_GREEN)
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
	end

	if model_data[self._modelid].is_big_role_image then
		local var_35_7 = GameDisplay.width / 2
		local var_35_8 = GameDisplay.cy - var_35_0:getContentSize().height / 2 - GameDisplay.fix_y

		if model_data[self._modelid].big_role_image_offset_x then
			var_35_7 = var_35_7 + model_data[self._modelid].big_role_image_offset_x
		end

		if model_data[self._modelid].big_role_image_offset_y then
			var_35_8 = var_35_8 + model_data[self._modelid].big_role_image_offset_y
		end

		var_35_0:setPositionX(var_35_7)
		var_35_0:setPositionY(var_35_8)
	end
end

function ShowGirlLayer:updateRoleImagePos()
	if not self:getChildByName("roleimage") then
		return
	end

	local var_36_0 = self._modelid

	if self._showtype == var_0_19 then
		local var_36_1 = model_data[var_36_0].database_equip_offset_x or 0
		local var_36_2 = model_data[var_36_0].database_equip_offset_y or 0
		local var_36_3 = cc.p(var_0_24 + var_36_1, var_0_25 + var_36_2)

		self:getChildByName("roleimage"):runAction(cc.MoveTo:create(0.2, var_36_3))
		self:getChildByName("roleimage"):getTalkSP():runAction(cc.MoveBy:create(0.2, cc.p(var_36_3.x - self:getChildByName("roleimage"):getPositionX(), var_36_3.y - self:getChildByName("roleimage"):getPositionY())))
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用坐标EQUIP_INIT_X, EQUIP_INIT_Y (%s,%s)", var_0_24, var_0_25), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用偏移modelData[%s].database_equip_offset_x, modelData[%s].database_equip_offset_y (%s,%s)", var_36_0, var_36_0, var_36_1, var_36_2), CONSOLE_COLOR_GREEN)
		hx_print(string.format("使用气泡偏移modelData[%s].database_talk_pos_offset or modelData[%s].talk_pos_offset (%s)", var_36_0, var_36_0, model_data[var_36_0].database_talk_pos_offset or model_data[var_36_0].talk_pos_offset or "0,0"), CONSOLE_COLOR_GREEN)
		hx_print("------------------------------------------------------------------------------", CONSOLE_COLOR_GREEN)
		self:getChildByName("roleimage"):setScale(model_data[var_36_0].database_equip_scale or 1)
	else
		local var_36_4 = model_data[var_36_0].mainmidpos and var_0_29(model_data[var_36_0].mainmidpos) or cc.p(320, -50)
		local var_36_5 = model_data[var_36_0].mainmidoffset and var_0_29(model_data[var_36_0].mainmidoffset) or cc.p(0, 0)
		local var_36_6 = cc.p(var_36_4.x + var_36_5.x, var_36_4.y + var_36_5.y)
		local var_36_7 = model_data[var_36_0].maininitpos and var_0_29(model_data[var_36_0].maininitpos) or cc.p(280, -50)
		local var_36_8 = model_data[var_36_0].maininitoffset and var_0_29(model_data[var_36_0].maininitoffset) or cc.p(0, 0)
		local var_36_9 = cc.p(var_36_7.x + var_36_8.x, var_36_7.y + var_36_8.y)

		if model_data[var_36_0].is_big_role_image then
			var_36_6.y = GameDisplay.cy - self:getChildByName("roleimage"):getContentSize().height / 2 - GameDisplay.fix_y
			var_36_9.y = GameDisplay.cy - self:getChildByName("roleimage"):getContentSize().height / 2 - GameDisplay.fix_y
			var_36_6.x = GameDisplay.width / 2
			var_36_9.x = GameDisplay.width / 2
		end

		if self._posStat == var_0_14 then
			self:getChildByName("roleimage"):runAction(cc.MoveTo:create(0.5, var_36_6))
			self:getChildByName("roleimage"):getTalkSP():runAction(cc.MoveBy:create(0.5, cc.p(var_36_6.x - var_36_9.x, var_36_6.y - var_36_9.y)))
		else
			self:getChildByName("roleimage"):runAction(cc.MoveTo:create(0.5, var_36_9))
			self:getChildByName("roleimage"):getTalkSP():runAction(cc.MoveBy:create(0.5, cc.p(var_36_9.x - var_36_6.x, var_36_9.y - var_36_6.y)))
		end
	end
end

function ShowGirlLayer:insertTalk(arg_37_1)
	if self.L2ActorSprite then
		self:showActTalk(arg_37_1)
	elseif self:getChildByName("l2dlayer") and global_canshow_live2d(self._modelid) then
		self:getChildByName("l2dlayer"):insertTalk(arg_37_1)
	elseif self:getChildByName("spine") and global_canshow_spine(self._modelid) then
		self:getChildByName("spine"):insertTalk(arg_37_1)
	elseif self:getChildByName("roleimage") and model_data[self._modelid].role_image then
		self:getChildByName("roleimage"):insertTalk(arg_37_1)
	end
end

function ShowGirlLayer:showActTalk(arg_39_1)
	currentClass = GenerateRoleConversationClass(self._modelid, arg_39_1)

	if not currentClass then
		return
	end

	if not role_conversation_data[currentClass * 100 + 1] then
		do return false end

		local var_39_0 = role_conversation_data[currentClass * 100 + 1].dec
	end

	if role_conversation_data[currentClass * 100 + 1].dec then
		local var_39_5 = self.L2ActorSprite:getChildByName("talksp")

		var_39_5:getChildByName("talklabel"):setString(role_conversation_data[currentClass * 100 + 1].dec)

		local var_39_6 = var_39_5:getChildByName("talklabel"):getContentSize().width + 100
		local var_39_7 = var_39_5:getChildByName("talklabel"):getContentSize().height + 90

		var_39_6 = var_39_6 < 348 and 348 or var_39_6
		var_39_7 = var_39_7 < 132 and 132 or var_39_7

		var_39_5:setPreferredSize(cc.size(var_39_6, var_39_7))
		var_39_5:getChildByName("talklabel"):setPosition(cc.p(20, self._talksp:getContentSize().height / 2 - 20))
		var_39_5:setPosition(cc.p(self.L2ActorSprite:getContentSize().width / 2 + 50, self.L2ActorSprite:getContentSize().height / 2 - 200))
		var_39_5:setVisible(true)
	end

	self:runAction(cc.Sequence:create(cc.DelayTime:create(3.5), cc.CallFunc:create(function()
		if self.talkCallback then
			self.talkCallback()

			self.talkCallback = nil
		end

		if var_39_0 and self.L2ActorSprite then
			self.L2ActorSprite:getChildByName("talksp"):setVisible(false)
		end
	end)))

	return res
end

function ShowGirlLayer:setTalkCallback(arg_41_1)
	self.talkCallback = arg_41_1

	if self:getChildByName("l2dlayer") and global_canshow_live2d(self._modelid) then
		self:getChildByName("l2dlayer"):setTalkCallback(arg_41_1)
	elseif self:getChildByName("spine") and global_canshow_spine(self._modelid) then
		self:getChildByName("spine"):setTalkCallback(arg_41_1)
	elseif self:getChildByName("roleimage") and model_data[self._modelid].role_image then
		self:getChildByName("roleimage"):setTalkCallback(arg_41_1)
	end
end

function ShowGirlLayer:debugPosition(arg_42_1)
	if self:getChildByName("spine") then
		local var_42_0, var_42_1 = self:getChildByName("spine"):getPosition()

		self:getChildByName("spine"):setPosition(cc.p(var_42_0 + arg_42_1.x, var_42_1 + arg_42_1.y))
	elseif self:getChildByName("roleimage") then
		local var_42_2, var_42_3 = self:getChildByName("roleimage"):getPosition()

		self:getChildByName("roleimage"):setPosition(cc.p(var_42_2 + arg_42_1.x, var_42_3 + arg_42_1.y))
	end
end

function ShowGirlLayer:setTalkEnabled(arg_43_1)
	if arg_43_1 then
		if self.touchLayout then
			self.touchLayout:removeFromParent()

			self.touchLayout = nil
		end
	elseif not self.touchLayout then
		self.touchLayout = ccui.Layout:create()

		self.touchLayout:setContentSize(cc.size(640, GameDisplay.getScreenSize().height))
		self.touchLayout:setPositionY(self.touchLayout:getPositionY() - GameDisplay.fix_y)
		self.touchLayout:setTouchEnabled(true)
		self:addChild(self.touchLayout, 99)
	end
end

function ShowGirlLayer:setTalkEnabledNew(arg_44_1)
	local var_44_0 = self:getChildByName("spine")
	local var_44_1 = self:getChildByName("roleimage")
	local var_44_2 = self:getChildByName("l2dlayer")

	if arg_44_1 then
		if var_44_0 then
			var_44_0:setTouchEnabled(true)
		end

		if var_44_1 then
			var_44_1:setTouchEnabled(true)
		end

		if var_44_2 then
			var_44_2:setTouchEnabled(true)
		end
	else
		if var_44_0 then
			var_44_0:setTouchEnabled(false)
		end

		if var_44_1 then
			var_44_1:setTouchEnabled(false)
		end

		if var_44_2 then
			var_44_2:setTouchEnabled(false)
		end
	end
end

function ShowGirlLayer:setTouchTalkCallback(arg_45_1)
	self.touchTalkCallback = arg_45_1

	if self:getChildByName("l2dlayer") then
		self:getChildByName("l2dlayer"):setTouchTalkCallback(self.touchTalkCallback)
	elseif self:getChildByName("spine") then
		self:getChildByName("spine"):setTouchTalkCallback(self.touchTalkCallback)
	elseif self:getChildByName("roleimage") then
		self:getChildByName("roleimage"):setTouchTalkCallback(self.touchTalkCallback)
	end
end

function ShowGirlLayer:setSwallowTouches(arg_46_1)
	if self:getChildByName("l2dlayer") then
		self:getChildByName("l2dlayer"):setSwallowTouches(arg_46_1)
	elseif self:getChildByName("spine") then
		self:getChildByName("spine"):setSwallowTouches(arg_46_1)
	elseif self:getChildByName("roleimage") then
		self:getChildByName("roleimage"):setSwallowTouches(arg_46_1)
	end
end

return ShowGirlLayer
