local AshPlotPanel = class("AshPlotPanel", ReduxView)
local var_0_1 = "Widget/System/Activity_EkChuah/EkChuah_IllustratedUI/Panel/plotPanel"

function AshPlotPanel:Ctor(arg_1_1)
	self.gameObject_ = GameObject.Instantiate(Asset.Load(var_0_1))
	self.transform_ = self.gameObject_.transform
	self.transform_.parent = arg_1_1
	self.transform_.localPosition = Vector3.zero
	self.transform_.localRotation = Quaternion.identity
	self.transform_.localScale = Vector3.zero

	self:Init()
end

function AshPlotPanel:Init()
	self:BindCfgUI()

	self.plots = {
		AshPlotModule.New(self.plot1Obj_),
		AshPlotModule.New(self.plot2Obj_),
		AshPlotModule.New(self.plot3Obj_),
		(AshPlotModule.New(self.plot4Obj_))
	}
end

function AshPlotPanel:ExitPanel(arg_3_1)
	self.transform_.localScale = Vector3.zero
end

function AshPlotPanel:PlayAnim(arg_4_1)
	local var_4_0 = arg_4_1:GetCustomSceneController()

	var_4_0:SwitchToShow()
	var_4_0:PlayHeroAnim("1083ui_dynamic", "Property_Files_2", 0.2)
end

function AshPlotPanel:EnterPanel(arg_5_1)
	self.transform_.localScale = Vector3.one

	self:PlayAnim(arg_5_1)

	local var_5_0 = AshSystemData:GetMomoTalkList()
	local var_5_1 = AshSystemData:GetStoryList()

	self.plots[1]:Render(var_5_1[1], 1)
	self.plots[2]:Render(var_5_0[1], 2)
	self.plots[3]:Render(var_5_0[2], 3)
	self.plots[4]:Render(var_5_1[2], 4)
end

function AshPlotPanel:Dispose()
	for iter_6_0 = 1, 4 do
		self.plots[iter_6_0]:Dispose()
	end

	GameObject.DestroyImmediate(self.gameObject_)
	Asset.Unload(var_0_1)
	self.super.Dispose(self)
end

return AshPlotPanel
