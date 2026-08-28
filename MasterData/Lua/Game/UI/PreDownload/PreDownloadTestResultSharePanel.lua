-------------------------------------------------------------------------------
-- 预下载答题结果分享内容页面
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-06-16 00:06:35
-------------------------------------------------------------------------------

---@type SDKService
local SDKService = import('Game.Entry.SDKService')

--- from: Assets/BundleResources/Prefabs/PreDownload/PredownloadShareShowDialog.prefab
---@class PreDownloadTestResultSharePanel
---@field Env                           	PreDownloadTestResultSharePanel                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
local PreDownloadTestResultSharePanel = Class('PreDownloadTestResultSharePanel')


function PreDownloadTestResultSharePanel:__init()
end


function PreDownloadTestResultSharePanel:__delete()
end


function PreDownloadTestResultSharePanel:Awake()
end


function PreDownloadTestResultSharePanel:OnInit(initArgs)
    ---@type PlayerComponent
    local playerComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.PlayerComponent) or {}
    -- CfUtils.FillText(self.nameTxt, playerComponent.playerDojo.playerName)
    -- CfUtils.FillText(self.uidText, playerComponent.playerDojo.playerId)
end


function PreDownloadTestResultSharePanel:Start()
    local codeGroupTrans = self.controller.transform:Find('Root/Container/ResultPanel/CodeGroup')
    if not isNull(codeGroupTrans) then
        local isOpenFtCommunity = SDKService:GetInstance():IsOfficialSDK()
        local isEnableCodeGroup = (isOpenFtCommunity or GameUtils.IsWindow()) and (not IS_REVIEW)  --win直接打开不分审核
        CfUtils.SetActive(codeGroupTrans, isEnableCodeGroup)
    end
end


function PreDownloadTestResultSharePanel:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return PreDownloadTestResultSharePanel
