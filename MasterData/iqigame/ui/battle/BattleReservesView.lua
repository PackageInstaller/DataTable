-- chunkname: @IQIGame\\UI\\Battle\\BattleReservesView.lua

local ReservesView = require("IQIGame.UI.Battle.ReservesView")
local BattleReservesView = {
	needShow = false
}

function BattleReservesView.New(view)
	local obj = Clone(BattleReservesView)

	obj:__Init(view)

	return obj
end

function BattleReservesView:__Init(view)
	self.gameObject = view

	LuaCodeInterface.BindOutlet(self.gameObject, self)

	self.reservesView = ReservesView.New(self.ReserveRolePrefab, self.ReserveRolePanel)

	function self.__OnPopupDownClickEventProxy()
		self:__UpdateReserveScrollActive()
	end

	self:__AddUIListeners()
end

function BattleReservesView:__AddUIListeners()
	self.residueMonsterBtn:GetComponent("Button").onClick:AddListener(self.__OnPopupDownClickEventProxy)
end

function BattleReservesView:__RemoveUIListeners()
	self.residueMonsterBtn:GetComponent("Button").onClick:RemoveListener(self.__OnPopupDownClickEventProxy)
end

function BattleReservesView:Dispose()
	self:__RemoveUIListeners()
	self.reservesView:Dispose()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.gameObject, self)

	self.gameObject = nil
end

function BattleReservesView:SetActive(isActive)
	isActive = isActive and self.needShow

	self.gameObject:SetActive(isActive)
end

function BattleReservesView:SetData(wave, maxWave, tubstitute)
	self.wave = wave
	self.maxWave = maxWave

	self.reservesView:ReservesInit(tubstitute)
	self:__RefreshShow(self.wave, self.maxWave, self.reservesView:GetLastCount())
end

function BattleReservesView:UpdateWave(wave, maxWave)
	self.wave = wave
	self.maxWave = maxWave

	self:__RefreshShow(self.wave, self.maxWave, self.reservesView:GetLastCount())
end

function BattleReservesView:UpdateReserves(id)
	self.reservesView:ReservesUpdate()
	self:__RefreshShow(self.wave, self.maxWave, self.reservesView:GetLastCount())
end

function BattleReservesView:__RefreshShow(wave, maxWave, monsterNum)
	if monsterNum > 0 then
		local text = BattleUIApi:GetMonsterReserveNumText(false, monsterNum)

		self:__Show(text)
	else
		self:__Hide()
	end
end

function BattleReservesView:__Hide()
	self.needShow = false

	self:SetActive(false)
end

function BattleReservesView:__Show(text)
	UGUIUtil.SetText(self.reserveText, text)

	self.needShow = true

	self:SetActive(true)
end

function BattleReservesView:__UpdateReserveScrollActive()
	self.reserveScroll:SetActive(not self.reserveScroll.activeSelf)
end

return BattleReservesView
