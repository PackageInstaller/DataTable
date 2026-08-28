---@class PayData
local PayData = Class("PayData")
function PayData:__init(sdkService)
    self.price = nil
    self.displayPrice = nil
    self.currencyCode = nil
    self.currencySymbol = nil
    self.productId = nil
end

function PayData:InitGoogleAndroid(priceData)
    self.price = priceData.price
    self.productId = priceData.productId 
    self.currencySymbol = priceData.currencySymbol
    self.currencyCode = priceData.currencyCode
    self.countryCode = priceData.countryCode
    self.displayPrice = priceData.displayPrice
    if self.currencyCode == "KRW" then
        self.displayPrice =  "￦" .. self.price
        priceData.currencySymbol =  "￦"
        self.currencySymbol = "￦"
    end 
end

function PayData:InitDmmAndroid(priceData)
    self.price = priceData.price
    self.productId = priceData.productId 
    self.currencySymbol = priceData.currencySymbol
    self.currencyCode = priceData.currencyCode
    self.countryCode = priceData.countryCode
    self.displayPrice = priceData.displayPrice
end

function PayData:InitOneStoreAndroid(priceData)
    self.price = priceData.price
    self.productId = priceData.productId 
    self.currencySymbol = priceData.currencySymbol
    self.currencyCode = priceData.currencyCode
    self.countryCode = priceData.countryCode
    self.displayPrice = priceData.displayPrice
    if self.currencyCode == "KRW" then
        self.displayPrice =  "￦" .. self.price
        priceData.currencySymbol =  "￦"
        self.currencySymbol = "￦"
    end     
end
function PayData:InitIos(priceData)
    self.price = priceData.price
    self.productId = priceData.productIdentifier 
    self.currencySymbol = priceData.currencySymbol
    self.currencyCode = priceData.currencyCode
    self.countryCode = priceData.countryCode
    if self.currencyCode == "TWD" then
        self.displayPrice = "NT$" .. self.price
        priceData.currencySymbol =  "NT$"
        self.currencySymbol =  "NT$"    
    elseif self.currencyCode == "KRW" then
        self.displayPrice =  "￦" .. self.price
        priceData.currencySymbol =  "￦"
        self.currencySymbol = "￦"
    else 
        self.displayPrice = self.currencySymbol .. self.price
    end
    
end
function PayData:InitQoo(priceData)
    for k, v in pairs(priceData.price) do
        if v.currency ==  "TWD" then
            self.price = checkInt(v.amount) 
            self.productId = priceData.product_id 
            self.currencySymbol = "NT$"
            self.currencyCode = "TWD"
            self.countryCode = "TW"
            self.displayPrice = "NT$" .. self.price
            break
        end
    end
    if isNull(self.price) then
        for k, v in pairs(priceData.price) do
            if v.currency ==  "USD" then
                self.price = v.amount
                self.productId = priceData.product_id 
                self.currencySymbol = "$"
                self.currencyCode = "USD"
                self.countryCode = "US"
                self.displayPrice = "$" .. self.price
                break
            end
        end
    end
end
function PayData:InitXsolla(currency , symbol,  payRow , countryCode , productId )
    self.price = payRow:Get(countryCode, false)
    self.productId = productId
    self.currencyCode = currency
    self.currencySymbol = symbol
    self.countryCode = countryCode
    self.displayPrice =  self.currencySymbol .. self.price
end

function PayData:InitNoSDK(currency , symbol, payRow ,countryCode, price)
    local configPrice = payRow:Get(countryCode, false)
    if string.isEmpty(configPrice) then
        self.price = price
    else
        self.price = configPrice
    end
    self.countryCode = countryCode
    self.currencyCode = currency
    self.currencySymbol = symbol
    self.displayPrice =  self.currencySymbol  .. self.price
end

---@type BaseSdkUtils
local BaseSdkUtils = import("Game.Sdk.BaseSdkUtils")
---@class PayUtils :BaseSdkUtils
local PayUtils = Class("PayUtils", BaseSdkUtils)
local KTool = CS.Engine.Lib.KTool
local SDKCenter = CS.Game.Native.MobileSDK.SDKCenter
local KTool = CS.Engine.Lib.KTool
local ProxyPluginName = "PlatformProxy"
---__int
function PayUtils:__init(sdkService)
    BaseSdkUtils.__init(self , sdkService)
    self.channelProdcuts = {}
    self.noSDKPayData = {}
    self.valuePayData = {}
    self.noSDKPayCount = 0
    self.valuePayCount = 0
    self.countryCode = nil
    if self.sdkService:IsJP() and (not self.sdkService:IsDmm()) then
        self.countryCode = "JP"
    end
    self.currencyCode = nil
    self.currencySymbol = nil
    self.isDmm = self.sdkService:IsDmm()
end

function PayUtils:QueryPricesCallBack(pricesJson)
    local priceDatas = table.deserialize(pricesJson)
    local SDKService = import("Game.Entry.SDKService")
    ---@type SDKService
    local sdkService = SDKService:GetInstance()
    local key = ""
    if KTool.UNITY_IOS() then
        key = "InitIos"
    elseif sdkService:IsQoo() then
        priceDatas = priceDatas.data
        key = "InitQoo"
    elseif KTool.UNITY_ANDROID() and sdkService:IsDmm() then
        key = "InitDmmAndroid"
    elseif isNotNull(sdkService.IsOneStore) and sdkService:IsOneStore() then
        priceDatas = priceDatas.products
        key = "InitOneStoreAndroid"
    elseif KTool.UNITY_ANDROID() then
        priceDatas = priceDatas.products
        key = "InitGoogleAndroid"
    end
    for k, v in pairs(priceDatas) do
		if k ~="" then
			local oneDatas =  PayData.New()
			if sdkService:IsWindowSdk() then
				oneDatas[key](oneDatas,k,v)
			else
				oneDatas[key](oneDatas,v)
			end
            if oneDatas.productId then
                self.channelProdcuts[oneDatas.productId] = oneDatas
            end
		end
    end
    for k, v in pairs(self.channelProdcuts) do
        self.currencyCode = v.currencyCode
        self.countryCode = v.countryCode
        self.currencySymbol = v.currencySymbol 
        break
    end
    self:InitNoSdk()
end

function PayUtils:LoadProducts(channelProductIds)
    if type(channelProductIds) ~= "table"  then
        return
    end
    if #channelProductIds == 0 then
        return
    end
    if self.sdkService:IsCommonSDK() then
        local application = CS.UnityEngine.Application
        local packName = application.identifier
        local channels = {}
        for i = #channelProductIds , 1, -1 do
            local productId = channelProductIds[i]
            if checkInt(productId) == 0 then
                channels[#channels+1] = tostring(channelProductIds[i])
            end
        end
        -- 如果没有档位 直接return 不进行查询
        if #channels == 0 then
            return
        end
        if KTool.UNITY_IOS() then 
            if #channels > 0 then
                SDKCenter.InvokePlugin(ProxyPluginName, "loadProducts", table.serialize(channels))    
            end
        elseif self.sdkService:IsXosllaSDK() or (self.sdkService:IsDmm() and (not KTool.UNITY_ANDROID())) then
                self:InitChannelProductsXsolla()
                self:InitNoSdk()
        elseif KTool.UNITY_ANDROID()  then
            SDKCenter.InvokePlugin(ProxyPluginName, "queryProducts", table.serialize(channels)) 
        end    
    else 
        self:InitNoSdk()
    end
end

function PayUtils:InitNoSdk()
    local countryCode  = "US"
    if isNull(self.countryCode) then
        local I18NModule = CS.Engine.I18N.I18NModule
        local splits = string.split(I18NModule.Lang , "_") 
        countryCode = splits[2]
    else 
        countryCode = self.countryCode 
    end  
    local tableFile1 = SettingMgr:GetInstance():Get(AutoIds.IdSetting605)
    local tableFile2 = SettingMgr:GetInstance():Get(AutoIds.IdSetting606)
    local isHave = tableFile2:HasPrimaryKey(countryCode)
    local countryRow
    if not isHave then
        countryCode = "US"
    end
    countryRow = tableFile2:FindByPrimaryKey(countryCode)
    self.countryCode = countryCode
    self.currencyCode = countryRow:Get("CurrencyCode")
    if self.countryCode == "KR" then
        self.currencySymbol = "￦"
    elseif self.countryCode == "GB" then
        self.currencySymbol = "£"
    elseif self.countryCode == "PL" then
        self.currencySymbol = "zł"    
    elseif self.countryCode == "TR" then
        self.currencySymbol = "₺"     
    elseif self.countryCode == "CZ" then
        self.currencySymbol = "Kč" 
    elseif self.countryCode == "TH" then
        self.currencySymbol = "฿" 
    elseif self.countryCode == "SG" then
        self.currencySymbol = "$" 
    elseif self.countryCode == "MY" then
        self.currencySymbol = "RM" 
    elseif self.countryCode == "PH" then
        self.currencySymbol = "₱" 
    elseif self.countryCode == "MM" then
        self.currencySymbol = "Ks" 
    elseif self.countryCode == "LA" then
        self.currencySymbol = "₭" 
    elseif self.countryCode == "KH" then
        self.currencySymbol = "៛" 
    elseif self.countryCode == "BN" then
        self.currencySymbol = "$" 
    elseif self.sdkService:IsDmm() then
        self.currencySymbol = "PT" 
    else     
        self.currencySymbol = countryRow:Get("CurrencySymbol")    
    end
    
    for k, v in pairs(tableFile1) do
        local oneDatas =  PayData.New()
        local payRow = v
        local price = payRow:Get("WindowsPrice")
        oneDatas:InitNoSDK(self.currencyCode , self.currencySymbol, payRow , countryCode, price)
        self.noSDKPayData[tostring(price)] = oneDatas 
    end
    self.noSDKPayCount = table.count(self.noSDKPayData)
end

function PayUtils:InitChannelProductsXsolla()
    --   ---@type RechargeGearVo[]
    --   local RechargeGearVos = CfUtils.GetWholeVo(AutoIds.IdSetting607,"RechargeGearVo")
    --   local tableFile1 = SettingMgr:GetInstance():Get(AutoIds.IdSetting605)
    --   local tableFile2 = SettingMgr:GetInstance():Get(AutoIds.IdSetting606)
    --   ---@type UserComponent 
    --   local  userComponent= GameUtils.GetEntityCompByType(ECSComponentType.Constants.UserComponent)
    --   local countryCode  = userComponent.userInfo.countryCode
    --   local isHave = tableFile2:HasPrimaryKey(countryCode)
    --   local countryRow
    --   if not isHave then
    --       countryCode = "US"
    --   end
    --   countryRow = tableFile2:FindByPrimaryKey(countryCode)
    --   self.countryCode = countryCode
    --   self.currencyCode = countryRow:Get("CurrencyCode")
    --   self.currencySymbol = countryRow:Get("CurrencySymbol")
    --   for k, v in pairs(RechargeGearVos) do
    --       if  isNotNull(v.xsollaWindows) then
    --           local oneDatas =  PayData.New()
    --           local payRow = tableFile1:FindByPrimaryKey(v.WindowsPrice)
    --           oneDatas:InitXsolla(self.currencyCode , self.currencySymbol, payRow , countryCode ,v.xsollaWindows)
    --           self.channelProdcuts[v.xsollaWindows] = oneDatas 
    --       end
    --   end
end

function PayUtils:GetUSDPriceByChannelProductId(channelProductId)
    -- local RechargeGearVos = CfUtils.GetWholeVo(AutoIds.IdSetting607,"RechargeGearVo")
    local price =  string.match(channelProductId, "(%d+)$")
    -- for k, v in pairs(RechargeGearVos) do
    --     if  v[key] == channelProductId then
    --         price = checkInt(v.WindowsPrice) 
    --     end
    -- end
    if checkInt(price) > 0 then
        local tableFile1 = SettingMgr:GetInstance():Get(AutoIds.IdSetting605)
        local onePrice =  checkInt(price/100)
        local isHave =  tableFile1:HasPrimaryKey(tostring(onePrice))
        if isHave then
            local payRow = tableFile1:FindByPrimaryKey( tostring(onePrice))
            price =  payRow:Get("US")
        end
    end
    return tonumber(price) 
end

function PayUtils:GetUSDPriceByWindowsPriceId(price)
    if checkInt(price) == 0 then
        return 0
    end
    local tableFile1 = SettingMgr:GetInstance():Get(AutoIds.IdSetting605)
    local onePrice =  checkInt(price)
    local isHave =  tableFile1:HasPrimaryKey(tostring(price))
    if isHave then
        local payRow = tableFile1:FindByPrimaryKey( tostring(onePrice))
        price =  payRow:Get("US")
    end
    return tonumber(price) 
end
function PayUtils:GetDisplayPrice(price,channelProductId)
    price = tostring(price)
    ---@type PayUtils
    local oneData = nil
    if self.sdkService:IsCommonSDK() and isNotNull(channelProductId) and string.len(channelProductId) > 0 then
        oneData = self.channelProdcuts[channelProductId]
    end
    if isNotNull(oneData)  then
        return oneData.displayPrice
    end

    if self.noSDKPayCount == 0 then
        self:InitNoSdk()
    end
    -- if channelProductId and checkInt(channelProductId) == 0  and  string.len(channelProductId) > 0 then
    --     local onePrice =  string.match(channelProductId, "(%d+)$")
    --     if checkInt(onePrice) > 0 then
    --         price  = checkInt(onePrice/100) 
    --     end
    -- end

    local oneData =  self.noSDKPayData[tostring(price)]
    if isNotNull(oneData) then
        return oneData.displayPrice
    else     
        print(" price error: " , debug.traceback())
        return  price
    end
end

function PayUtils:GetPayData(price  , channelProductId)
    price = tostring(price)
    local oneData = nil
    if self.sdkService:IsCommonSDK() and isNotNull(channelProductId) and string.len(channelProductId) > 0 then
        oneData = self.channelProdcuts[channelProductId]
    end
    if isNotNull(oneData)  then
        return oneData
    end
    if self.noSDKPayCount == 0  then
        self.noSDKPayCount  = self:InitNoSdk()
    end
    -- if channelProductId and checkInt(channelProductId) == 0 and  string.len(channelProductId) > 0 then
    --     local onePrice =  string.match(channelProductId, "(%d+)$")
    --     if checkInt(onePrice) > 0 then
    --         price  = checkInt(onePrice/100)
    --     end
    -- end
    local oneData =  self.noSDKPayData[tostring(price)]
    if isNotNull(oneData) then
        return oneData
    end
end
function PayUtils:GetValueDisplayPrice(price)
    if self.valuePayCount == 0 then
        local SettingModule = CS.Engine.Modules.SettingModule
        local countryCode  = "US"
        if isNull(self.countryCode) then
            local I18NModule = CS.Engine.I18N.I18NModule
            local splits = string.split(I18NModule.Lang , "_") 
            countryCode = splits[2]
        else 
            countryCode = self.countryCode 
        end  
        local tableFile1 = SettingMgr:GetInstance():Get(AutoIds.IdSetting6201)
        local tableFile2 = SettingMgr:GetInstance():Get(AutoIds.IdSetting606)
        local isHave = tableFile2:HasPrimaryKey(countryCode)
        local countryRow
        if not isHave then
            countryCode = "US"
        end
        countryRow = tableFile2:FindByPrimaryKey(countryCode)
        self.countryCode = countryCode
        self.currencyCode = countryRow:Get("CurrencyCode")
        self.currencySymbol = countryRow:Get("CurrencySymbol")
        if self.countryCode == "KR" then
            self.currencySymbol = "￦"
        elseif self.isDmm then
            self.currencySymbol = "PT"
        else              
            self.currencySymbol = countryRow:Get("CurrencySymbol")    
        end
        for k, v in pairs(tableFile1) do
            local oneDatas =  PayData.New()
            local payRow = v
            local configPrice = payRow:Get("value")
            oneDatas:InitNoSDK(self.currencyCode , self.currencySymbol, payRow , countryCode, configPrice)
            self.valuePayData[tostring(configPrice)] = oneDatas
        end
    end
    local oneData =  self.valuePayData[tostring(price)]
    if isNotNull(oneData) then
        return oneData.displayPrice
    end
    return price
end

function PayUtils:GetValuePrice(price)
    if self.valuePayCount == 0 then
        local SettingModule = CS.Engine.Modules.SettingModule
        local countryCode  = "US"
        if isNull(self.countryCode) then
            local I18NModule = CS.Engine.I18N.I18NModule
            local splits = string.split(I18NModule.Lang , "_") 
            countryCode = splits[2]
        else 
            countryCode = self.countryCode 
        end  
        local tableFile1 = SettingMgr:GetInstance():Get(AutoIds.IdSetting6201)
        local tableFile2 = SettingMgr:GetInstance():Get(AutoIds.IdSetting606)
        local isHave = tableFile2:HasPrimaryKey(countryCode)
        local countryRow
        if not isHave then
            countryCode = "US"
        end
        countryRow = tableFile2:FindByPrimaryKey(countryCode)
        self.countryCode = countryCode
        self.currencyCode = countryRow:Get("CurrencyCode")
        self.currencySymbol = countryRow:Get("CurrencySymbol")
        for k, v in pairs(tableFile1) do
            local oneDatas =  PayData.New()
            local payRow = v 
            oneDatas:InitNoSDK(self.currencyCode , self.currencySymbol, payRow , countryCode)
            local price = payRow:Get("value")
            self.valuePayData[tostring(price)] = oneDatas 
        end

    end
    local oneData =  self.valuePayData[tostring(price)]
    if isNotNull(oneData) then
        return oneData.price
    end
    return price
end

function PayUtils:GetWindowsXoslloa(price)
    price = tostring(price)
    local tableFile1 = SettingMgr:GetInstance():Get(AutoIds.IdSetting605)
    local tableFile2 = SettingMgr:GetInstance():Get(AutoIds.IdSetting606)
    local currencyTable = {}
    if tableFile1:HasPrimaryKey(price) then
        local row = tableFile1:FindByPrimaryKey(price , false)
        for k,v in pairs(row.HeaderInfos) do
            if k ~= "WindowsPrice" then
                local price = row:Get(k)
                local country = k 
                if tableFile2:HasPrimaryKey(country) then
                    local twoRow = tableFile2:FindByPrimaryKey(country,false)
                    local currencyCode  = twoRow:Get("CurrencyCode")
                    currencyTable[country] = {
                        price = price , 
                        code = currencyCode
                    }
                end
            end
        end    
        if currencyTable then
           if currencyTable["US"] then
                currencyTable["default"]  = clone(currencyTable["US"])
           end 
        end 
    end
    return currencyTable 
end

function PayUtils:GetCurrerySymbol()
    ---@type SDKService
    local sdkService = self.sdkService
    if sdkService:IsDmm() then
        return "PT"
    else
        if not self.currencySymbol then
            self:InitNoSdk()    
        end
        return self.currencySymbol or "$"
    end

end

function PayUtils:GetPrice(price,channelProductId)
    ---@type PayUtils
    local oneData = nil
    if self.sdkService:IsCommonSDK() and isNotNull(channelProductId) and string.len(channelProductId) > 0 then
        oneData = self.channelProdcuts[channelProductId]
    end
    if isNotNull(oneData)  then
        return oneData.price 
    end
    if self.noSDKPayCount == 0  then
        self.noSDKPayCount  = self:InitNoSdk()
    end
    -- if channelProductId and checkInt(channelProductId) == 0 and  string.len(channelProductId) > 0 then
    --     local onePrice =  string.match(channelProductId, "(%d+)$")
    --     if checkInt(onePrice) > 0 then
    --         price  = checkInt(onePrice/100)
    --     end
    -- end
    local oneData =  self.noSDKPayData[tostring(price)]
    if isNotNull(oneData) then
        return oneData.price
    else     
        print(" price error: " , debug.traceback())
        return  price
    end
end

function PayUtils:__delete()
    BaseSdkUtils.__delete(self)
    self.channelProdcuts = nil
    self.countryCode = nil
    self.currencySymbol = nil
    self.currencyCode = nil
    self.noSDKPayData = nil
    self.noSDKPayCount = nil
    self.valuePayCount = nil
    self.valuePayData = nil
    self.isDmm = nil
end

return PayUtils