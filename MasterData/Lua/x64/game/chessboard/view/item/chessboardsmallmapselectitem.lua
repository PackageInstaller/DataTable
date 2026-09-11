local ChessBoardSmallMapSelectItem = class("ChessBoardSmallMapSelectItem", ReduxView)

function ChessBoardSmallMapSelectItem:OnCtor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = arg_1_1.transform

	self:Init()
end

function ChessBoardSmallMapSelectItem:Init()
	self:InitUI()
	self:AddUIListener()
end

function ChessBoardSmallMapSelectItem:InitUI()
	self:BindCfgUI()

	self.controller_ = ControllerUtil.GetController(self.transform_, "select")
end

function ChessBoardSmallMapSelectItem:SetData(arg_4_1, arg_4_2, arg_4_3)
	self.selectType_ = arg_4_1
	self.selectID_ = arg_4_2
	self.callBack_ = arg_4_3

	self:UpdateView()
end

function ChessBoardSmallMapSelectItem:AddUIListener()
	self:AddBtnListener(self.btn_, nil, function()
		if self.callBack_ then
			self.callBack_(self.selectType_, self.selectID_)
		end
	end)
end

function ChessBoardSmallMapSelectItem:UpdateView()
	if self.selectType_ == ChessBoardConst.SMALL_MAP_TYPE.GRID then
		self.text_.text = ChessBoardHexCfg[self.selectID_].name
		self.icon_.sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", ChessBoardHexCfg[self.selectID_].small_map_icon_nobg)
	elseif self.selectType_ == ChessBoardConst.SMALL_MAP_TYPE.PLAYER then
		if self.selectID_ == 0 then
			self.text_.text = ChessBoardTools.GetChessBoardGameSetting("chessboard_small_map_hero_name")
			self.icon_.sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", ChessBoardLevelCfg[ChessBoardData:GetCurrentChessBoardMapData().mapId].chessboard_hero_small_map_icon)
		else
			self.text_.text = ChessBoardNPCPoolCfg[self.selectID_].name
			self.icon_.sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", ChessBoardNPCPoolCfg[self.selectID_].small_map_icon)
		end
	elseif self.selectType_ == ChessBoardConst.SMALL_MAP_TYPE.SPECIAL then
		for iter_7_0, iter_7_1 in pairs((ChessBoardTools.GetChessBoardGameSetting("chessboard_small_map_speciality_icon"))) do
			if iter_7_1[1] == self.selectID_ then
				self.text_.text = GetTips(iter_7_1[3])
				self.icon_.sprite = getSprite("Atlas/ChessBoardSmallMapAtlas", iter_7_1[2])

				break
			end
		end
	end
end

function ChessBoardSmallMapSelectItem:SetActive(arg_8_1)
	SetActive(self.gameObject_, arg_8_1)
end

function ChessBoardSmallMapSelectItem:SetParent(arg_9_1)
	self.transform_.parent = arg_9_1
end

function ChessBoardSmallMapSelectItem:RefreshSelect(arg_10_1, arg_10_2)
	if self.selectType_ == arg_10_1 and self.selectID_ == arg_10_2 then
		self.controller_:SetSelectedState("on")
	else
		self.controller_:SetSelectedState("off")
	end
end

function ChessBoardSmallMapSelectItem:FixScaleAndPos()
	self.transform_.localScale = Vector3(1, 1, 1)
	self.transform_.localPosition = Vector3(self.transform_.localPosition.x, self.transform_.localPosition.y, 0)
end

function ChessBoardSmallMapSelectItem:Dispose()
	Object.Destroy(self.gameObject_)

	self.callBack_ = nil

	ChessBoardSmallMapSelectItem.super.Dispose(self)
end

return ChessBoardSmallMapSelectItem
