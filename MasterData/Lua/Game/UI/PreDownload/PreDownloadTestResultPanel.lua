-------------------------------------------------------------------------------
-- 预下载 - 测试结果面板
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-06-15 21:22:56
-------------------------------------------------------------------------------

local cs_coroutine = require 'XLua.cs_coroutine'
local XLuaUtils    = CS.Engine.Lib.XLuaUtils
---@type Engine.UI.UIRaycastBlocker
local UIRaycastBlocker = CS.Engine.UI.UIRaycastBlocker.Instance
---@type PreDownloadMgr
local PreDownloadMgr = import('Game.UI.PreDownload.PreDownloadMgr'):GetInstance()

--- from: Assets/BundleResources/Prefabs/PreDownload/PreDownloadTestResult_Canvas.prefab
---@class PreDownloadTestResultPanel
---@field Env                           	PreDownloadTestResultPanel                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field Container                     	UnityEngine.RectTransform               
---@field P2_Group                      	UnityEngine.RectTransform               
---@field P2L_TxtName                   	UnityEngine.RectTransform               
---@field P2L_CImgCatFace               	UnityEngine.RectTransform               
---@field P2L_CImgCatFace2               	UnityEngine.RectTransform               
---@field P2L_BTxtNumber                	UnityEngine.RectTransform               
---@field P2L_BImgFill                  	UnityEngine.RectTransform               
---@field P2L_GTxtNumber                	UnityEngine.RectTransform               
---@field P2L_GImgFill                  	UnityEngine.RectTransform               
---@field P2L_RTxtNumber                	UnityEngine.RectTransform               
---@field P2L_RImgFill                  	UnityEngine.RectTransform               
---@field P2L_ImgCatFace2               	UnityEngine.RectTransform               
---@field P2L_ImgCatFace                	UnityEngine.RectTransform               
---@field P2R_TxtContent                	UnityEngine.RectTransform               
---@field P2R_TxtType                   	UnityEngine.RectTransform               
---@field P2R_TxtTitle                  	UnityEngine.RectTransform               
---@field P2T_TxtName3                  	UnityEngine.RectTransform               
---@field P2T_TxtName2                  	UnityEngine.RectTransform               
---@field P2T_TxtName1                  	UnityEngine.RectTransform               
---@field P2T_RoleImg2                  	UnityEngine.RectTransform               
---@field P2T_RoleImg3                  	UnityEngine.RectTransform               
---@field P2T_RoleImg                   	UnityEngine.RectTransform               
---@field P2T_ImgInk                    	UnityEngine.RectTransform               
---@field P2T_ImgInkBg1                 	UnityEngine.RectTransform               
---@field P2T_TxtType                   	UnityEngine.RectTransform               
---@field P2T_TxtTitle                  	UnityEngine.RectTransform               
---@field P1_Group                      	UnityEngine.RectTransform               
---@field P1T_TxtName3                  	UnityEngine.RectTransform               
---@field P1T_TxtName2                  	UnityEngine.RectTransform               
---@field P1T_TxtName1                  	UnityEngine.RectTransform               
---@field P1R_ReportBtnArea             	UnityEngine.RectTransform               
---@field P1R_TxtContent                	UnityEngine.RectTransform               
---@field P1T_ImgInk                    	UnityEngine.RectTransform               
---@field P1T_TxtType                   	UnityEngine.RectTransform               
---@field P1T_TxtTitle                  	UnityEngine.RectTransform               
---@field P1T_ImgInkBg                  	UnityEngine.RectTransform               
---@field P1T_RoleImg3                  	UnityEngine.RectTransform               
---@field P1T_RoleImg2                  	UnityEngine.RectTransform               
---@field P1T_RoleImg1                  	UnityEngine.RectTransform               
local PreDownloadTestResultPanel = Class('PreDownloadTestResultPanel')

local RESULT_PANEL_TIMELINE_BLOCKER_NAME = 'RESULT_PANEL_TIMELINE_BLOCKER_NAME'


function PreDownloadTestResultPanel:__init()
    ---@type PreDownloadTestResultVo
    self.testResultConf_ = nil
end


function PreDownloadTestResultPanel:__delete()
    self.testResultConf_ = nil
end


function PreDownloadTestResultPanel:Awake()
end


function PreDownloadTestResultPanel:Start()
    local preDownloadComp = PreDownloadMgr:GetPreDownloadComponent()
    local testResultId    = preDownloadComp:GetMmpiResultId()
    print('---->>', testResultId)
    self.testResultConf_  = CfUtils.GetCfVo(AutoIds.IdSetting3101, "PreDownloadTestResultVo", testResultId)

    self.resultPanelSwitchCB_ = Events.AddListener(Constants.EventNames.PREDOWNLOAD_TEST_RESULT_PANEL_SWITCH, function(data)
        self:SetResultPanelIndex(data.panelIndex)
    end)

    SetButtonAction(self.P1R_ReportBtnArea, function()
        Events.Broadcast(Constants.EventNames.PREDOWNLOAD_TEST_RESULT_PANEL_SWITCH, {panelIndex = 2})
    end)

    self:UpdatePanel1Info_()
    self:UpdatePanel2Info_()
end


function PreDownloadTestResultPanel:OnDestroy()
    Events.RemoveListener(Constants.EventNames.PREDOWNLOAD_TEST_RESULT_PANEL_SWITCH, self.resultPanelSwitchCB_)
    
    if self.playResultPanelAnimeCo_ ~= nil then
        UIRaycastBlocker:RemoveCondition(RESULT_PANEL_TIMELINE_BLOCKER_NAME)
        cs_coroutine.stop(self.playResultPanelAnimeCo_)
        self.playResultPanelAnimeCo_ = nil
    end

    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

function PreDownloadTestResultPanel:GetResultPanelIndex()
    return self.resultPanelIndex_
end
function PreDownloadTestResultPanel:SetResultPanelIndex(index)
    self.resultPanelIndex_ = checkInt(index)

    -- switch panel
    local isFirstPanel = self:GetResultPanelIndex() == 1

    -- play animator
    CfUtils.PlayAnimator(self.Container, isFirstPanel and 'Go' or 'Enter')

    -- reset rgb chart
    CfUtils.FillText(self.P2L_RTxtNumber, string.format('%d%%', 0))
    CfUtils.FillText(self.P2L_GTxtNumber, string.format('%d%%', 0))
    CfUtils.FillText(self.P2L_BTxtNumber, string.format('%d%%', 0))
    CfUtils.SetImageFillAmount(self.P2L_BImgFill, 0)
    CfUtils.SetImageFillAmount(self.P2L_GImgFill, 0)
    CfUtils.SetImageFillAmount(self.P2L_RImgFill, 0)

    -- tween rgb chart
    if not isFirstPanel then
        local rPercent  = checkNumber(self.testResultConf_.chart[1])
        local gPercent  = checkNumber(self.testResultConf_.chart[2])
        local bPercent  = checkNumber(self.testResultConf_.chart[3])
        local rProgress = checkInt(rPercent * 100)
        local gProgress = checkInt(gPercent * 100)
        local bProgress = checkInt(bPercent * 100)
        CfUtils.DoTween(1.2, function(value)
            CfUtils.FillText(self.P2L_RTxtNumber, string.format('%d%%', checkInt(rProgress * value)))
            CfUtils.FillText(self.P2L_GTxtNumber, string.format('%d%%', checkInt(gProgress * value)))
            CfUtils.FillText(self.P2L_BTxtNumber, string.format('%d%%', checkInt(bProgress * value)))
            CfUtils.SetImageFillAmount(self.P2L_BImgFill, bPercent * value)
            CfUtils.SetImageFillAmount(self.P2L_GImgFill, gPercent * value)
            CfUtils.SetImageFillAmount(self.P2L_RImgFill, rPercent * value)
        end)
    end

    -- block share click
    local panelAnimeTime = 0
    if isFirstPanel then
        panelAnimeTime = CfUtils.GetAnimatorTime(self.Container, 'PreDownloadTestResult_Canvas')
    else
        panelAnimeTime = panelAnimeTime + CfUtils.GetAnimatorTime(self.Container, 'PreDownloadTestResult_CanvasEnter')
        panelAnimeTime = panelAnimeTime + CfUtils.GetAnimatorTime(self.Container, 'PreDownloadTestResult_CanvasEnter2')
    end
    self.playResultPanelAnimeCo_ = cs_coroutine.start(function()
        UIRaycastBlocker:AddCondition(RESULT_PANEL_TIMELINE_BLOCKER_NAME)
        coroutine.yield(CS.UnityEngine.WaitForSeconds(panelAnimeTime))
        UIRaycastBlocker:RemoveCondition(RESULT_PANEL_TIMELINE_BLOCKER_NAME)
        self.playResultPanelAnimeCo_ = nil
    end)
end


-------------------------------------------------
-- private method

function PreDownloadTestResultPanel:UpdatePanel1Info_()
    local cardImgPath = self.testResultConf_.cardId
    CfUtils.FillImage(self.P1T_RoleImg1, cardImgPath)
    CfUtils.FillImage(self.P1T_RoleImg2, cardImgPath)
    CfUtils.FillImage(self.P1T_RoleImg3, cardImgPath)
    
    CfUtils.FillText(self.P1T_TxtTitle, self.testResultConf_.title)
    CfUtils.FillText(self.P1T_TxtType, self.testResultConf_.result)
    CfUtils.FillText(self.P1R_TxtContent, self.testResultConf_.intro)
    
    local colorHex = self.testResultConf_.colour
    CfUtils.SetImageColor(self.P1T_ImgInk, XLuaUtils.HexToColor(colorHex))
    CfUtils.SetImageColor(self.P1T_ImgInkBg, XLuaUtils.HexToColor(colorHex))
    CfUtils.SetActive(self.P1T_ImgInkBg, false)  -- 这东西应该没用了

    local cardName = self.testResultConf_.cardName
    CfUtils.FillText(self.P1T_TxtName3, cardName)
    CfUtils.FillText(self.P1T_TxtName2, cardName)
    CfUtils.FillText(self.P1T_TxtName1, cardName)
end


function PreDownloadTestResultPanel:UpdatePanel2Info_()
    CfUtils.FillText(self.P2L_BTxtNumber, string.format('%d%%', 0))
    CfUtils.FillText(self.P2L_GTxtNumber, string.format('%d%%', 0))
    CfUtils.FillText(self.P2L_RTxtNumber, string.format('%d%%', 0))
    CfUtils.SetImageFillAmount(self.P2L_BImgFill, 0)
    CfUtils.SetImageFillAmount(self.P2L_GImgFill, 0)
    CfUtils.SetImageFillAmount(self.P2L_RImgFill, 0)
    
    local cardImgPath = self.testResultConf_.cardId
    CfUtils.FillImage(self.P2T_RoleImg, cardImgPath)
    CfUtils.FillImage(self.P2T_RoleImg2, cardImgPath)
    CfUtils.FillImage(self.P2T_RoleImg3, cardImgPath)
    CfUtils.FillText(self.P2T_TxtTitle, self.testResultConf_.title)
    CfUtils.FillText(self.P2T_TxtType, self.testResultConf_.result)

    local colorHex = self.testResultConf_.colour
    CfUtils.SetImageColor(self.P2T_ImgInk, XLuaUtils.HexToColor(colorHex))
    CfUtils.SetImageColor(self.P2T_ImgInkBg1, XLuaUtils.HexToColor(colorHex))
    
    local cardName = self.testResultConf_.cardName
    CfUtils.FillText(self.P2T_TxtName3, cardName)
    CfUtils.FillText(self.P2T_TxtName2, cardName)
    CfUtils.FillText(self.P2T_TxtName1, cardName)

    local faceImgPath = self.testResultConf_.catFace
    CfUtils.FillImage(self.P2L_ImgCatFace, faceImgPath)
    CfUtils.FillImage(self.P2L_ImgCatFace2, faceImgPath)
    CfUtils.FillText(self.P2L_TxtName, self.testResultConf_.catTitle)

    local headImgPath = self.testResultConf_.catHead
    CfUtils.FillImage(self.P2L_CImgCatFace, headImgPath)
    CfUtils.FillImage(self.P2L_CImgCatFace2, headImgPath)
    
    CfUtils.FillText(self.P2R_TxtTitle, self.testResultConf_.title)
    CfUtils.FillText(self.P2R_TxtType, self.testResultConf_.result)
    CfUtils.FillText(self.P2R_TxtContent, self.testResultConf_.desc)
end


return PreDownloadTestResultPanel
