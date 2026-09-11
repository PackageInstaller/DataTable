local AssetPendData = class("AssetPendData")

function AssetPendData:Init()
	self.expandContentList_ = {}
	self.deleteFlag_ = false
	self.deletePackageList_ = {}
	self.deleteLanguageList_ = {}
	self.deletePackageSize_ = "0.00KB"
	self.needCalcDeletePackageFlag_ = true
end

function AssetPendData:SetExpandContent(arg_2_1)
	self.expandContentList_[arg_2_1] = self.expandContentList_[arg_2_1] ~= nil and not self.expandContentList_[arg_2_1] or true
end

function AssetPendData:GetExpandContent(arg_3_1)
	if self.expandContentList_[arg_3_1] == nil then
		return false
	else
		return self.expandContentList_[arg_3_1]
	end
end

function AssetPendData:ClearExpandContent()
	self.expandContentList_ = {}
end

function AssetPendData:SetDeleteFlag(arg_5_1)
	self.deleteFlag_ = arg_5_1
end

function AssetPendData:GetDeleteFlag()
	return self.deleteFlag_
end

function AssetPendData:AddDeletePackage(arg_7_1)
	if table.keyof(self.deletePackageList_, arg_7_1) then
		return
	end

	table.insert(self.deletePackageList_, arg_7_1)

	self.needCalcDeletePackageFlag_ = true
end

function AssetPendData:RemoveDeletePackage(arg_8_1)
	table.removebyvalue(self.deletePackageList_, arg_8_1)

	self.needCalcDeletePackageFlag_ = true
end

function AssetPendData:GetDeletePackageList()
	return self.deletePackageList_
end

function AssetPendData:GetRemoveAssetPendListSize(arg_10_1, arg_10_2)
	if self.needCalcDeletePackageFlag_ ~= false then
		self.needCalcDeletePackageFlag_ = false
		self.deletePackageSize_ = manager.assetPend:GetRemoveAssetPendListSize(arg_10_1, arg_10_2)
	end

	return self.deletePackageSize_
end

function AssetPendData:ClearDeletePackageList()
	self.deletePackageList_ = {}
	self.deleteLanguageList_ = {}
	self.needCalcDeletePackageFlag_ = true
end

function AssetPendData:SetNeedRecalc()
	self.needCalcDeletePackageFlag_ = true
end

function AssetPendData:GetDeleteLanguageList()
	return self.deleteLanguageList_
end

function AssetPendData:AddDeleteLanguage(arg_14_1)
	if table.keyof(self.deleteLanguageList_, arg_14_1) then
		return
	end

	table.insert(self.deleteLanguageList_, arg_14_1)

	self.needCalcDeletePackageFlag_ = true
end

function AssetPendData:RemoveDeleteLanguage(arg_15_1)
	table.removebyvalue(self.deleteLanguageList_, arg_15_1)

	self.needCalcDeletePackageFlag_ = true
end

return AssetPendData
