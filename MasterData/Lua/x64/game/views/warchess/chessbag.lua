local ChessBag = class("ChessBag", ReduxView)

function ChessBag:UIName()
	return "Widget/System/WarChess_Battle/WarChessBag"
end

function ChessBag:UIParent()
	return manager.ui.uiMain.transform
end

function ChessBag:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBag:InitUI()
	self:BindCfgUI()

	self.scrollHelper_ = LuaList.New(handler(self, self.indexItem), self.itempanelGo_, ChessBagItem)
	self.scrollHelperKey_ = LuaList.New(handler(self, self.indexItemKey), self.itempanel_keyGo_, ChessBagKeyItem)
	self.controller_ = ControllerUtil.GetController(self.transform_, "conName")
end

function ChessBag:indexItem(arg_5_1, arg_5_2)
	arg_5_2:RefreshUI(arg_5_1, self.itemList_[arg_5_1])
end

function ChessBag:indexItemKey(arg_6_1, arg_6_2)
	arg_6_2:RefreshUI(self.itemList_[arg_6_1])
end

function ChessBag:UpdateData(arg_7_1)
	self.itemList_ = {}

	if arg_7_1 == 1 then
		for iter_7_0, iter_7_1 in pairs((WarChessData:GetItemData())) do
			if WarchessObjectCfg[iter_7_0].type ~= ChessConst.OBJECT_TYPE.ENERGY then
				self.itemList_[#self.itemList_ + 1] = {
					id = iter_7_0,
					number = iter_7_1,
					iconPath = "TextureConfig/WarChess_Battle/" .. WarchessObjectCfg[iter_7_0].icon
				}
			end
		end
	elseif arg_7_1 == 2 then
		for iter_7_2, iter_7_3 in pairs((WarChessData:GetArtifactData())) do
			if WarchessItemCfg[iter_7_2].identify_buff ~= 1 then
				table.insert(self.itemList_, {
					id = iter_7_2,
					num = iter_7_3
				})
			end
		end
	elseif arg_7_1 == 3 then
		for iter_7_4, iter_7_5 in pairs((WarChessData:GetArtifactData())) do
			if WarchessItemCfg[iter_7_4].identify_buff == 1 then
				table.insert(self.itemList_, {
					id = iter_7_4,
					num = iter_7_5
				})
			end
		end
	end

	if self.type_ ~= arg_7_1 then
		self:RecordStay(arg_7_1)
	end

	self.type_ = arg_7_1
end

function ChessBag:AddUIListener()
	self:AddToggleListener(self.toggle1Tgl_, function(arg_9_0)
		if arg_9_0 then
			self:UpdateData(1)
			self.scrollHelperKey_:StartScroll(#self.itemList_)
			self.controller_:SetSelectedState("key")
			OperationRecorder.Record("chess", "key")
		end
	end)
	self:AddToggleListener(self.toggle2Tgl_, function(arg_10_0)
		if arg_10_0 then
			self:UpdateData(2)
			self.scrollHelper_:StartScroll(#self.itemList_)
			self.controller_:SetSelectedState("artifact")
			OperationRecorder.Record("chess", "artifact")
		end
	end)
	self:AddToggleListener(self.toggle3Tgl_, function(arg_11_0)
		if arg_11_0 then
			self:UpdateData(3)
			self.scrollHelper_:StartScroll(#self.itemList_)
			self.controller_:SetSelectedState("artifact")
			OperationRecorder.Record("chess", "artifact")
		end
	end)
end

function ChessBag:OnEnter()
	if self.toggle1Tgl_.isOn then
		self:UpdateData(1)
		self.scrollHelperKey_:StartScroll(#self.itemList_)
		self.controller_:SetSelectedState("key")
	else
		self.toggle1Tgl_.isOn = true
	end

	self.state = self.params_.state

	manager.windowBar:SwitchBar({
		BACK_BAR
	})
end

function ChessBag:OnExit()
	manager.windowBar:HideBar()
	self:RecordStay(self.type_)
end

function ChessBag:Dispose()
	self.scrollHelper_:Dispose()
	self.scrollHelperKey_:Dispose()
	ChessBag.super.Dispose(self)
end

function ChessBag:RecordStay(arg_15_1)
	local var_15_0 = self:GetStayTime()

	if var_15_0 == 0 then
		return
	end

	local var_15_1 = 0

	if arg_15_1 == 1 then
		var_15_1 = 30205
	elseif arg_15_1 == 2 then
		var_15_1 = 30204
	end

	OperationRecorder.RecordStayView("STAY_VIEW_CHESS_BAG", var_15_0, var_15_1)
	self:UpdateLastOpenTime()
end

return ChessBag
