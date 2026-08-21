-- chunkname: @IQIGame\\UIExternalApi\\BuyEnergyUIApi.lua

BuyEnergyUIApi = BaseLangApi:Extend()

function BuyEnergyUIApi:GetEnergyToggleTitle(index)
	if index == 1 then
		return self:GetCfgText(1300021)
	else
		return self:GetCfgText(1300022)
	end
end

function BuyEnergyUIApi:GetUseTips(energyCount)
	return self:GetCfgText(1300019, energyCount)
end

function BuyEnergyUIApi:GetUseCurrencyTips(currencyCount, energyCount, surplusNum)
	return self:GetCfgText(1400059, currencyCount, energyCount, surplusNum)
end

function BuyEnergyUIApi:GetBuyTips(money, energyCount)
	return self:GetCfgText(1300020, money, energyCount)
end

function BuyEnergyUIApi:GetConfrimButtonText()
	return self:GetCfgText(1111105)
end

function BuyEnergyUIApi:GetCancelBtnTitle()
	return self:GetCfgText(1600038)
end

function BuyEnergyUIApi:GetExChangeBtnTitle()
	return self:GetCfgText(1400036)
end

function BuyEnergyUIApi:GetBuyCountTitle()
	return self:GetCfgText(1300023)
end

function BuyEnergyUIApi:GetCurInfoTitle()
	return self:GetCfgText(1300003)
end

function BuyEnergyUIApi:GetTimeFormat(seconds)
	if seconds <= 3600 then
		return "mm:ss"
	elseif seconds <= 86400 then
		return "hh:mm:ss"
	else
		return "dd:hh:mm"
	end
end
