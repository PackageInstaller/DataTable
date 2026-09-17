LabLayer = class("LabLayer", function()
	return cc.Layer:create()
end)

function LabLayer.create(arg_2_0, arg_2_1)
	local var_2_0 = LabLayer.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function LabLayer:init(arg_3_1)
	self.rootlayer = ccs.GUIReader:getInstance():widgetFromJsonFile(config._DEBUG and "LabLayer.json" or "LabLayer.ExportJson")

	self:addChild(self.rootlayer)
end

function LabLayer.proccedData(arg_4_0)
	return
end

function LabLayer.createProductionsList(arg_5_0)
	return
end

function LabLayer.createUnlockSlot(arg_6_0)
	return
end

function LabLayer.createLockSlot(arg_7_0)
	return
end

function LabLayer.entranceofManufacture(arg_8_0)
	return
end

function LabLayer.bottomList(arg_9_0)
	return
end
