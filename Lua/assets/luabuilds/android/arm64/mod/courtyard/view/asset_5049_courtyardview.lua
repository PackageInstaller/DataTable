local CourtYardBaseView = class("CourtYardBaseView")

function CourtYardBaseView:Ctor(arg_1_1, arg_1_2)
	self.name = arg_1_1
	self.storey = arg_1_2

	self:Init()

	return
end

function CourtYardBaseView:Init()
	self.isInit = false

	local var_2_0 = self:GetStoreyModule()
	local var_2_1

	seriesAsync({
		function(arg_3_0)
			self:LoadUI(var_2_0.__cname, function(arg_4_0)
				var_2_1 = arg_4_0

				arg_3_0()

				return
			end)

			return
		end,
		function(arg_5_0)
			self:InitObjPool(arg_5_0)

			return
		end
	}, function()
		self.storeyModule = var_2_0.New(self.storey, var_2_1)
		self.isInit = true

		return
	end)

	return
end

function CourtYardBaseView:IsInit()
	return self.isInit == true
end

function CourtYardBaseView:LoadUI(arg_8_1, arg_8_2)
	self.resName = arg_8_1

	ResourceMgr.Inst:getAssetAsync("UI/" .. self.resName, "", UnityEngine.Events.UnityAction_UnityEngine_Object(function(arg_9_0)
		local var_9_1 = Object.Instantiate(arg_9_0, self.storey:GetStyle() == CourtYardConst.STYLE_PREVIEW and pg.UIMgr.GetInstance().OverlayMain:Find("BackYardInterActionPreview(Clone)/frame/view") or pg.UIMgr.GetInstance().UIMain:Find(self.name .. "(Clone)"))

		self._go = var_9_1

		var_9_1.transform:SetSiblingIndex(1)
		setActive(var_9_1, true)

		self.poolRoot = var_9_1.transform:Find("root")

		arg_8_2(var_9_1)

		return
	end), true, true)

	return
end

function CourtYardBaseView:GetRect()
	assert(self.storeyModule)

	return self.storeyModule.rectTF
end

function CourtYardBaseView:GetStoreyModule()
	return ({
		[CourtYardConst.STYLE_INNER] = CourtYardStoreyModule,
		[CourtYardConst.STYLE_OUTSIDE] = CourtYardOutStoreyModule,
		[CourtYardConst.STYLE_FEAST] = CourtYardFeastStoreyModule,
		[CourtYardConst.STYLE_PREVIEW] = CourtYardStoreyPreviewModule
	})[self.storey:GetStyle()]
end

function CourtYardBaseView:InitObjPool(arg_12_1)
	local var_12_0 = ({
		[CourtYardConst.STYLE_INNER] = CourtYardPoolMgr,
		[CourtYardConst.STYLE_OUTSIDE] = CourtYardPoolMgr,
		[CourtYardConst.STYLE_FEAST] = CourtYardFeastPoolMgr,
		[CourtYardConst.STYLE_PREVIEW] = CourtYardPoolMgr
	})[self.storey:GetStyle()].New()

	var_12_0:Init(self.poolRoot, arg_12_1)

	self.poolMgr = var_12_0

	return
end

function CourtYardBaseView:GetCurrStorey()
	return self.storeyModule
end

function CourtYardBaseView:Dispose()
	if self.storeyModule then
		self.storeyModule:Dispose()

		self.storeyModule = nil
	end

	self.storey = nil

	self.poolMgr:Dispose()

	self.poolMgr = nil

	return
end

return CourtYardBaseView
