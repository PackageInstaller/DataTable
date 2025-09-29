-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/IAirWorkShopFlowComp.lua

module("logic.extensions.airworkshop.flow.defflow.component.IAirWorkShopFlowComp", package.seeall)

local IAirWorkShopFlowComp = class("IAirWorkShopFlowComp")

IAirWorkShopFlowComp.flow = false
IAirWorkShopFlowComp[AirWorkShopFunctionName.onInit] = false
IAirWorkShopFlowComp[AirWorkShopFunctionName.onStart] = false
IAirWorkShopFlowComp[AirWorkShopFunctionName.onResourceLoaded] = false
IAirWorkShopFlowComp[AirWorkShopFunctionName.onEnterDone] = false
IAirWorkShopFlowComp[AirWorkShopFunctionName.onClear] = false
IAirWorkShopFlowComp[AirWorkShopFunctionName.onUpdateTimeScale] = false
IAirWorkShopFlowComp[AirWorkShopFunctionName.onBeforeClear] = false

return IAirWorkShopFlowComp
