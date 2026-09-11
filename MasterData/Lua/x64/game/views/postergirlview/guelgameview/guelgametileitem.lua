local GuelGameTileItem = class("GuelGameTileItem", ReduxView)

function GuelGameTileItem:Ctor(arg_1_1)
	self.gameObject_ = arg_1_1
	self.transform_ = self.gameObject_.transform

	self:BindCfgUI()
	self:AddListeners()

	self.colorControlller = self.coloritemControllerexcollection_:GetController("color")
end

function GuelGameTileItem:AddListeners()
	self:RemoveBtnListener(nil, self.imageBtn_.transform)
	self:AddBtnListener(self.imageBtn_, nil, function()
		if self.data and self.data.canclick and GuelGameManager.GetInstance().gameData.playerState == GueGameConst.GameState.playing then
			GuelGameManager.GetInstance():DoClickTile(true, self.data.index)
		end
	end)
end

function GuelGameTileItem:SetData(arg_4_1)
	self.data = arg_4_1

	if arg_4_1.color then
		self.colorControlller:SetSelectedState(arg_4_1.color)
	else
		self.colorControlller:SetSelectedState("none")
	end
end

function GuelGameTileItem:OnEnter()
	return
end

function GuelGameTileItem:ShowEffect(arg_6_1)
	self.coloritemAni_:Play("colorItem", 0, 0)
end

function GuelGameTileItem:SetPosition(arg_7_1, arg_7_2)
	if self.gameObject_ and not isNil(self.gameObject_) then
		self.gameObject_.transform.anchoredPosition = Vector3.New(arg_7_1, arg_7_2, 0)
	end
end

function GuelGameTileItem:GetPositionX()
	if self.gameObject_ and not isNil(self.gameObject_) then
		return self.gameObject_.transform.anchoredPosition.x
	end

	return 0
end

function GuelGameTileItem:OnExit()
	GuelGameTileItem.super.OnExit(self)
end

function GuelGameTileItem:Dispose()
	GuelGameTileItem.super.Dispose(self)
end

return GuelGameTileItem
