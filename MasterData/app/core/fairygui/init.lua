fgui = fgui or {}

import(".GComponentEx")
import(".UIPackageEx")
import(".GObjectEx")
import(".GListEx")
import(".GParallaxNodeEx")
import(".GBasicTextFieldEx")
import(".GLabelEx")
import(".GButtonEx")
import(".FActionEx")
import(".GLoaderEx")
import(".GImageEx")
import(".TransitionEx")

fgui.UIEventType = import(".UIEventType")
fgui.RelationType = import(".RelationType")

local var_0_0 = {}

function fgui:registerExtension()
	assert(self, "FairyGUI扩展不能为nil")
	assert(self.URL, "FairyGUI扩'cls.URL'不能为nil")
	fgui.register_extension(self.URL, self)
end

function fgui.register_extension(arg_2_0, arg_2_1)
	assert(arg_2_1, "FairyGUI扩展不能为nil")
	assert(arg_2_0, "FairyGUI扩'cls.URL'不能为nil")

	if arg_2_1 == nil then
		error(arg_2_0 .. "    extension is nil")

		return
	end

	if var_0_0[arg_2_0] ~= nil and var_0_0[arg_2_0] == arg_2_1 then
		return
	end

	var_0_0[arg_2_0] = arg_2_1

	function arg_2_1.createByBinder()
		if arg_2_1 and arg_2_1.new then
			return arg_2_1.create()
		else
			assert(arg_2_1, "extension is nil or extension.new is nil !!!")
		end
	end

	fgui.UIObjectFactory:setPackageItemExtension(arg_2_0, arg_2_1.createByBinder)
end

function fgui.initGameUI(arg_4_0)
	fgui.UIPackage:setStringSource("fgui_strings/fgui_language_info.xml")

	local function var_4_0(arg_5_0, arg_5_1)
		if cc.FileUtils:getInstance():isFileExist(arg_5_0 .. ".fui") then
			if arg_5_1 then
				fgui.UIPackage:addPackageCache(arg_5_0, true)
			else
				fgui.UIPackage:addPackage(arg_5_0)
			end
		end
	end

	var_4_0("ui/base/base", true)
	var_4_0("ui/base_new/base_new", true)
	var_4_0("ui/font/font")
	var_4_0("ui/text_new/text_new")
	var_4_0("ui/icon/icon")

	local var_4_1 = fgui.UIConfig:getInstance()

	var_4_1:setDefaultFont(FONT_PATH)
	var_4_1:setStrokeSize(1)
	fgui.UIConfig:registerFont(FONT_NAME, FONT_PATH)
	fgui.UIConfig:registerFont(FONT_TITLE_NAME, FONT_TITLE_PATH)
	fgui.UIConfig:registerFont(FONT_NUMBER_NAME, FONT_NUMBER_PATH)
end
