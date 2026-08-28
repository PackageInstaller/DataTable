-------------------------------------------------------------------------------
-- 通用分享预览弹窗
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2022-06-04 11:43:51
-------------------------------------------------------------------------------

local cs_coroutine         = require 'XLua.cs_coroutine'
local File                 = CS.System.IO.File
local KTool                = CS.Engine.Lib.KTool
local Yielders             = CS.Engine.Lib.Yielders
local ResourceModule       = CS.Engine.Modules.ResourceModule
local RawImage             = CS.UnityEngine.UI.RawImage
local Screen               = CS.UnityEngine.Screen
local Camera               = CS.UnityEngine.Camera
local VideoPlayer          = CS.UnityEngine.Video.VideoPlayer
local VideoSource          = CS.UnityEngine.Video.VideoSource
local VideoRenderMode      = CS.UnityEngine.Video.VideoRenderMode
local VideoAudioOutputMode = CS.UnityEngine.Video.VideoAudioOutputMode
local Animator             = CS.UnityEngine.Animator
local AudioSource          = CS.UnityEngine.AudioSource
local RenderTexture        = CS.UnityEngine.RenderTexture
local RenderTextureFormat  = CS.UnityEngine.RenderTextureFormat
local PlayableDirector     = CS.UnityEngine.Playables.PlayableDirector
local ReplayCam            = CS.NatCorder.ReplayCam
local KCookie              = CS.Engine.Lib.KCookie
---@type Engine.UI.UIRaycastBlocker
local UIRaycastBlocker     = CS.Engine.UI.UIRaycastBlocker.Instance
---@type Game.Native.URP.URPCameraController
local URPCameraController  = CS.Game.Native.URP.URPCameraController.Instance
---@type SDKService
local SDKService = import('Game.Entry.SDKService')
---@type CriWareUtils
local CriWareUtils = import('Game.Entry.CriWareUtilsFix')

local RECORD_TIMELINE_BLOCKER_NAME = 'RECORD_TIMELINE_BLOCKER_NAME'

local SDKService = import('Game.Entry.SDKService'):GetInstance()
local VideoRecordState = {
    READY  = 1,
    FINISH = 2,
    CANCEL = 3,
}

-- 分享按钮名字定义
local ShareButtonNameMap = {
    Community = 'BtnCommunity',   -- 分享按钮：番糖社区
    QQGroup   = 'BtnQQGroup',     -- 分享按钮：QQ空间
    QQ        = 'BtnQQ',          -- 分享按钮：QQ
    Weixin    = 'BtnWeixin',      -- 分享按钮：微信
    WXGroup   = 'BtnWeixinGroup', -- 分享按钮：朋友圈
    Weibo     = 'BtnWeibo',       -- 分享按钮：微博
    Line      = 'BtnLine',        -- 分享按钮：Line
    Instagram = 'BtnIns',         -- 分享按钮：Instagram
    Twitter   = 'BtnTwitter',     -- 分享按钮：Twitter
    Facebook  = 'BtnFacebook',    -- 分享按钮：Facebook
    Discord   = 'BtnDiscord',     -- 分享按钮：Discord
}

local ShareChannelDefines = {
    [ShareButtonNameMap.Community] = {
        channel      = Constants.ShareChannel.FTCommunity,
        iosImage     = Constants.MODULE_SWITCH.FT_COMMUNITY, -- ios图片 是否支持
        androidImage = Constants.MODULE_SWITCH.FT_COMMUNITY, -- 安卓图片 是否支持
        iosVideo     = false,                                -- ios视频 是否支持
        androidVideo = false,                                -- 安卓视频 是否支持
        packageName  = nil,                                  -- 原生分享 安卓包名
        className    = nil,                                  -- 原生分享 安卓类名
        sdkVideo     = false,                                -- sdk视频 是否支持
        voTitle      = 'ftCommunityTitle',                   -- 分享信息vo 标题字段
        voDescr      = 'ftCommunityDesc',                    -- 分享信息vo 正文字段
        voLink       = 'ftCommunityLink',                    -- 分享信息vo 链接字段
        voShow       = 'ftCommunityShow',                    -- 分享信息vo 链接字段
        voGName      = nil,                                  -- 分享信息vo 超话字段
        voGSection   = nil,                                  -- 分享信息vo 板块字段
    },
    [ShareButtonNameMap.QQGroup] = {
        channel      = Constants.ShareChannel.QQSpace,
        iosImage     = true,                           -- ios图片 是否支持
        androidImage = true,                           -- 安卓图片 是否支持
        iosVideo     = false,                          -- ios视频 是否支持
        androidVideo = false,                          -- 安卓视频 是否支持
        packageName  = 'com.qzone',                    -- 原生分享 安卓包名
        className    = nil,                            -- 原生分享 安卓类名
        sdkVideo     = false,                          -- sdk视频 是否支持
        voTitle      = nil,                            -- 分享信息vo 标题字段
        voDescr      = 'qqGroupDesc',                  -- 分享信息vo 正文字段
        voLink       = 'qqGroupLink',                  -- 分享信息vo 链接字段
        voShow       = 'qqGroupShow',                  -- 分享信息vo 链接字段
        voGName      = nil,                            -- 分享信息vo 超话字段
        voGSection   = nil,                            -- 分享信息vo 板块字段
    },
    [ShareButtonNameMap.QQ] = {
        channel      = Constants.ShareChannel.QQChat,
        iosImage     = true,                          -- ios图片 是否支持
        androidImage = true,                          -- 安卓图片 是否支持
        iosVideo     = true,                          -- ios视频 是否支持
        androidVideo = true,                          -- 安卓视频 是否支持
        packageName  = 'com.tencent.mobileqq',        -- 原生分享 安卓包名
        className    = nil,                           -- 原生分享 安卓类名
        sdkVideo     = false,                         -- sdk视频 是否支持
        voTitle      = nil,                           -- 分享信息vo 标题字段
        voDescr      = 'qqDesc',                      -- 分享信息vo 正文字段
        voLink       = 'qqLink',                      -- 分享信息vo 链接字段
        voShow       = 'qqShow',                      -- 分享信息vo 链接字段
        voGName      = nil,                           -- 分享信息vo 超话字段
        voGSection   = nil,                           -- 分享信息vo 板块字段
    },
    [ShareButtonNameMap.Weixin] = {
        channel      = Constants.ShareChannel.WeChatFriend,
        iosImage     = true,                                -- ios图片 是否支持
        androidImage = true,                                -- 安卓图片 是否支持
        iosVideo     = true,                                -- ios视频 是否支持
        androidVideo = true,                                -- 安卓视频 是否支持
        packageName  = 'com.tencent.mm',                    -- 原生分享 安卓包名
        className    = nil,                                 -- 原生分享 安卓类名
        sdkVideo     = false,                               -- sdk视频 是否支持
        voTitle      = nil,                                 -- 分享信息vo 标题字段
        voDescr      = 'weixinDesc',                        -- 分享信息vo 正文字段
        voLink       = 'weixinLink',                        -- 分享信息vo 链接字段
        voShow       = 'weixinShow',                        -- 分享信息vo 链接字段
        voGName      = nil,                                 -- 分享信息vo 超话字段
        voGSection   = nil,                                 -- 分享信息vo 板块字段
    },
    [ShareButtonNameMap.WXGroup] = {
        channel      = Constants.ShareChannel.WeChatFriendCircle,
        iosImage     = true,                                      -- ios图片 是否支持
        androidImage = true,                                      -- 安卓图片 是否支持
        iosVideo     = false,                                     -- ios视频 是否支持
        androidVideo = false,                                     -- 安卓视频 是否支持
        packageName  = 'com.tencent.mm',                          -- 原生分享 安卓包名
        className    = nil,                                       -- 原生分享 安卓类名
        sdkVideo     = false,                                     -- sdk视频 是否支持
        voTitle      = nil,                                       -- 分享信息vo 标题字段
        voDescr      = 'wxGroupDesc',                             -- 分享信息vo 正文字段
        voLink       = 'wxGroupLink',                             -- 分享信息vo 链接字段
        voShow       = 'wxGroupShow',                             -- 分享信息vo 链接字段
        voGName      = nil,                                       -- 分享信息vo 超话字段
        voGSection   = nil,                                       -- 分享信息vo 板块字段
    },
    [ShareButtonNameMap.Weibo] = {
        channel      = Constants.ShareChannel.WeiBo,
        iosImage     = true,                         -- ios图片 是否支持
        androidImage = true,                         -- 安卓图片 是否支持
        iosVideo     = true,                         -- ios视频 是否支持
        androidVideo = false,                        -- 安卓视频 是否支持
        packageName  = 'com.sina.weibo',             -- 原生分享 安卓包名
        className    = nil,                          -- 原生分享 安卓类名
        sdkVideo     = false,                        -- sdk视频 是否支持
        voTitle      = nil,                          -- 分享信息vo 标题字段
        voDescr      = 'weiboDesc',                  -- 分享信息vo 正文字段
        voLink       = 'weiboLink',                  -- 分享信息vo 链接字段
        voShow       = 'weiboShow',                  -- 分享信息vo 链接字段
        voGName      = 'weiboGroupName',             -- 分享信息vo 超话字段
        voGSection   = 'weiboGroupSection',          -- 分享信息vo 板块字段
    },
    [ShareButtonNameMap.Facebook] = {
        channel      = Constants.ShareChannel.FB,
        iosImage     = true,                      -- ios图片 是否支持
        androidImage = (not SDKService:IsDmm()),  -- 安卓图片 是否支持
        iosVideo     = false,                     -- ios视频 是否支持
        androidVideo = false,                     -- 安卓视频 是否支持
        packageName  = 'com.facebook.katana',     -- 原生分享 安卓包名
        className    = nil,                       -- 原生分享 安卓类名
        sdkVideo     = false,                     -- sdk视频 是否支持
        voTitle      = nil,                       -- 分享信息vo 标题字段
        voDescr      = 'facebookDesc',            -- 分享信息vo 正文字段
        voLink       = 'facebookLink',            -- 分享信息vo 链接字段
        voShow       = 'facebookShow',            -- 分享信息vo 是否开启
        voGName      = nil,                       -- 分享信息vo 超话字段
        voGSection   = nil,                       -- 分享信息vo 板块字段
    },
    [ShareButtonNameMap.Twitter] = {
        channel      = Constants.ShareChannel.TWITTER_SHARE,
        iosImage     = true,                                 -- ios图片 是否支持
        androidImage = true,                                 -- 安卓图片 是否支持
        iosVideo     = true,                                 -- ios视频 是否支持
        androidVideo = false,                                -- 安卓视频 是否支持
        packageName  = 'com.twitter.android',                -- 原生分享 安卓包名
        className    = nil,                                  -- 原生分享 安卓类名
        sdkVideo     = false,                                -- sdk视频 是否支持
        voTitle      = nil,                                  -- 分享信息vo 标题字段
        voDescr      = 'twitterDesc',                        -- 分享信息vo 正文字段
        voLink       = 'twitterLink',                        -- 分享信息vo 链接字段
        voShow       = 'twitterShow',                        -- 分享信息vo 是否开启
        voGName      = nil,                                  -- 分享信息vo 超话字段
        voGSection   = nil,                                  -- 分享信息vo 板块字段
    },
    [ShareButtonNameMap.Instagram] = {
        channel      = Constants.ShareChannel.INS_STORY_SHARE,
        iosImage     = true,                                   -- ios图片 是否支持
        androidImage = true,                                   -- 安卓图片 是否支持
        iosVideo     = true,                                   -- ios视频 是否支持
        androidVideo = false,                                  -- 安卓视频 是否支持
        packageName  = 'com.instagram.android',                -- 原生分享 安卓包名
        className    = nil,                                    -- 原生分享 安卓类名
        sdkVideo     = false,                                  -- sdk视频 是否支持
        voTitle      = nil,                                    -- 分享信息vo 标题字段
        voDescr      = 'instagramDesc',                        -- 分享信息vo 正文字段
        voLink       = 'instagramLink',                        -- 分享信息vo 链接字段
        voShow       = 'instagramShow',                        -- 分享信息vo 是否开启
        voGName      = nil,                                    -- 分享信息vo 超话字段
        voGSection   = nil,                                    -- 分享信息vo 板块字段
    },
    [ShareButtonNameMap.Line] = {
        channel      = Constants.ShareChannel.LINE,
        iosImage     = true,                        -- ios图片 是否支持
        androidImage = (not SDKService:IsJP()) ,    -- 安卓图片 是否支持
        iosVideo     = true,                        -- ios视频 是否支持
        androidVideo = false,                       -- 安卓视频 是否支持
        packageName  = 'jp.naver.line.android',     -- 原生分享 安卓包名
        className    = nil,                         -- 原生分享 安卓类名
        sdkVideo     = false,                       -- sdk视频 是否支持
        voTitle      = nil,                         -- 分享信息vo 标题字段
        voDescr      = 'lineDesc',                  -- 分享信息vo 正文字段
        voLink       = 'lineLink',                  -- 分享信息vo 链接字段
        voShow       = 'lineShow',                  -- 分享信息vo 是否开启
        voGName      = nil,                         -- 分享信息vo 超话字段
        voGSection   = nil,                         -- 分享信息vo 板块字段
    },
    [ShareButtonNameMap.Discord] = {
        channel      = Constants.ShareChannel.DISCORD_SHARE,
        iosImage     = true,                        -- ios图片 是否支持
        androidImage = true,                        -- 安卓图片 是否支持
        iosVideo     = true,                        -- ios视频 是否支持
        androidVideo = false,                       -- 安卓视频 是否支持
        packageName  = 'com.discord',               -- 原生分享 安卓包名
        className    = nil,                         -- 原生分享 安卓类名
        sdkVideo     = false,                       -- sdk视频 是否支持
        voTitle      = nil,                         -- 分享信息vo 标题字段
        voDescr      = 'discordDesc',               -- 分享信息vo 正文字段
        voLink       = 'discordLink',               -- 分享信息vo 链接字段
        voShow       = 'discordShow',               -- 分享信息vo 是否开启
        voGName      = nil,                         -- 分享信息vo 超话字段
        voGSection   = nil,                         -- 分享信息vo 板块字段
    },
}

local ShareRecordContrast = {
    [Constants.ShareType.GACHA_RESULT_TEN]  = Constants.ShareRecordType.COMMON,
    [Constants.ShareType.GACHA_RESULT_ONE]  = Constants.ShareRecordType.COMMON,
    [Constants.ShareType.GACHA_SSR_FRAME]   = Constants.ShareRecordType.COMMON,
    [Constants.ShareType.CAT_BABY_BIRTH]    = Constants.ShareRecordType.CAT,
    [Constants.ShareType.CAT_EVOLUTION]     = Constants.ShareRecordType.CAT,
    [Constants.ShareType.CAT_INFOMATION]    = Constants.ShareRecordType.CAT,
    [Constants.ShareType.RECALL_MESSAGE]    = Constants.ShareRecordType.COMMON,
    [Constants.ShareType.PRE_DOWNLOAD_TEST] = Constants.ShareRecordType.PRE_DOWNLOAD_TEST,
    [Constants.ShareType.PRE_DOWNLOAD_CALL] = Constants.ShareRecordType.CAT,
    [Constants.ShareType.PLAYER_NEW]        = Constants.ShareRecordType.COMMON,
    [Constants.ShareType.CARD_RECEIVE]      = Constants.ShareRecordType.COMMON,
}


--- from: Assets/BundleResources/Prefabs/Common/CommonShareDialog.prefab > name: CommonShareDialog
---@class CommonSharePreviewDialog
---@field Env                           	CommonSharePreviewDialog                
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BtnGroup                      	UnityEngine.RectTransform               @ 所有按钮组
---@field ScreenBtn                     	UnityEngine.RectTransform               @ 屏幕空白点击层
---@field LoadingBgImg                  	UnityEngine.RectTransform               @ 加载背景图
---@field LoadingProgressSlider         	UnityEngine.UI.Slider                   @ 加载进度条
---@field LoadingPercentText            	UnityEngine.RectTransform               @ 加载进度文本
---@field LoadingVolumeText             	UnityEngine.RectTransform               @ 加载速度文本
---@field LodingNode                    	UnityEngine.RectTransform               @ 加载层父节点
---@field VideoNode                     	UnityEngine.RectTransform               @ 视频层父节点
---@field ImgNode                       	UnityEngine.RectTransform               @ 图片层父节点
---@field BtnLine                       	UnityEngine.RectTransform               @ 渠道按钮：line
---@field BtnIns                        	UnityEngine.RectTransform               @ 渠道按钮：instagram
---@field BtnTwitter                    	UnityEngine.RectTransform               @ 渠道按钮：twitter
---@field BtnFacebook                   	UnityEngine.RectTransform               @ 渠道按钮：facebook
---@field BtnCommunity                  	UnityEngine.RectTransform               @ 渠道按钮：番糖社区分享
---@field BtnQQGroup                    	UnityEngine.RectTransform               @ 渠道按钮：QQ空间分享
---@field BtnQQ                         	UnityEngine.RectTransform               @ 渠道按钮：QQ分享
---@field BtnWeixin                     	UnityEngine.RectTransform               @ 渠道按钮：微信分享
---@field BtnWeixinGroup                	UnityEngine.RectTransform               @ 渠道按钮：朋友圈分享
---@field BtnWeibo                      	UnityEngine.RectTransform               @ 渠道按钮：微博分享
---@field BtnLocalSave                  	UnityEngine.RectTransform               @ 本地保存按钮
---@field BottomLayer                   	UnityEngine.RectTransform               @ 底部层父节点
---@field BgFuzzy                       	UnityEngine.RectTransform               @ 背景模糊层
---@field BgImage                       	UnityEngine.RectTransform               @ 背景图片
---@field BgLayer                       	UnityEngine.RectTransform               @ 背景层父节点
---@field BtnDiscord                    	UnityEngine.RectTransform               @ 渠道按钮：discord
local CommonSharePreviewDialog = Class('CommonSharePreviewDialog')


function CommonSharePreviewDialog:__init()
    ---@type Constants.ShareType @ 分享类型
    self.shareType_ = nil

    ---@type ShareMessagesVo @ 分享内容表
    self.shareMsgVo_ = nil

    ---@type string @ 保存路径
    self.filePath_ = nil

    ---@type UnityEngine.Texture2D @ 分享图片纹理
    self.sahreImgTexture_ = nil
    
    ---@type table<string, table> @ 视频分享参数
    self.videoArgs_ = nil

    ---@type table<Constants.ShareChannel, table> @ 各渠道分享参数定义
    self.shareDefines_ = nil

    ---@type UnityEngine.Coroutine @ 录屏协程
    self.doRecorVideoCo_ = nil

    ---@type table<string, UnityEngine.GameObject> @ 加载过的模型map
    self.loadedGoMap_ = {}

    ---@type NatCorder.ReplayCam @ 录屏播放相机
    self.videoReplayCam_ = nil
end


function CommonSharePreviewDialog:__delete()
    self.shareType_       = nil
    self.shareMsgVo_      = nil
    self.filePath_        = nil
    self.sahreImgTexture_ = nil
    self.videoArgs_       = nil
    self.shareDefines_    = nil
    self.doRecorVideoCo_  = nil
    self.loadedGoMap_     = nil
    self.videoReplayCam_  = nil
end


function CommonSharePreviewDialog:Awake()
end


function CommonSharePreviewDialog:OnShow()
    return CoWaitDo(function()
        local animTime = CfUtils.GetAnimatorTime(self.controller, 'Ani_CommonDialogShow02')
        coroutine.yield(CS.UnityEngine.WaitForSeconds(animTime))
        URPCameraController:SetMainCameraActive(false)
    end)
end


function CommonSharePreviewDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams   = self.controller.Argument.parameters or {}
        local shareMsgArgs = initParams.shareMsgArgs
        local bgImgPath    = initParams.bgImgPath
        local isBgFuzzy    = initParams.isBgFuzzy ~= false
        local isLocalSave  = initParams.isLocalSave == true
        
        self.shareType_ = checkInt(initParams.shareType)
        
        -- get shareMsgVo
        self.shareMsgVo_ = CfUtils.GetCfVo(AutoIds.IdSetting953, "ShareMessagesVo", self.shareType_) or {}
        
        --- video args
        self.videoArgs_ = initParams.videoArgs

        -- file path
        self.filePath_ = initParams.filePath
        if self:IsShareVideo_() then
            self.filePath_ = ReplayCam.BuildPath(self.videoArgs_.videoNameId)
        end

        -- share defines
        self.shareDefines_ = {}
        for btnName, defines in pairs(ShareChannelDefines) do
            self.shareDefines_[defines.channel] = {
                channel  = defines.channel,
                title    = self.shareMsgVo_[defines.voTitle],
                descr    = self:MakeShareDesc_(self.shareMsgVo_[defines.voDescr], shareMsgArgs),
                link     = self.shareMsgVo_[defines.voLink],
                show     = self.shareMsgVo_[defines.voShow],
                gName    = self.shareMsgVo_[defines.voGName],
                gSection = self.shareMsgVo_[defines.voGSection],
            }
        end
        
        -- check bg image
        self:UpdateBgImage_(bgImgPath)

        -- update share buttons
        self:UpdateShareButtons_(isLocalSave)

        -------------------------------------------------
        -- share image
        if not self:IsShareVideo_() then
            CfUtils.SetActive(self.BtnGroup, true)
            CfUtils.SetActive(self.ImgNode, true)
            CfUtils.SetActive(self.VideoNode, false)
            CfUtils.SetActive(self.LodingNode, false)

            -- load share image
            self.sahreImgTexture_ = GameUtils.GetShareScreenTexture()
            local bgImgComp   = self.ImgNode.transform:GetComponent(typeof(RawImage))
            bgImgComp.texture = self.sahreImgTexture_
            
        -------------------------------------------------
        -- share video
        else
            CfUtils.SetActive(self.BtnGroup, false)
            CfUtils.SetActive(self.ImgNode, false)

            -- show video record / preview
            if self:IsVideoRecordSucceed_() then
                self:PreviewRecordVideo_()
            else
                self:RecordTimelineVideo_()
            end
        end
    end)
end


function CommonSharePreviewDialog:OnFinalize()
    return CoWaitDo(function()
        UIRaycastBlocker:RemoveCondition(RECORD_TIMELINE_BLOCKER_NAME)

        if not isNull(self.sahreImgTexture_) then
            CS.UnityEngine.GameObject.Destroy(self.sahreImgTexture_)
            self.sahreImgTexture_ = nil
        end

        if self.isPreviewRecordVideo_ then
            CriWareUtils.PlayRandomBGMFromCDList()
            CriWareUtils.ResetVolume(Constants.CriWareCategory.BGM)
        end

        if self.doRecorVideoCo_ ~= nil then
            cs_coroutine.stop(self.doRecorVideoCo_)
            self.doRecorVideoCo_ = nil
        end

        local bgImage = self.ImgNode.transform:GetComponent(typeof(RawImage))
        CfUtils.SafeDelete(bgImage.texture)

        if self.videoReplayCam_ ~= nil then
            self.videoReplayCam_.OnRecordFinish = nil  -- 因为stop会触发完成，所以stop前先把完成回调清掉
            self.videoReplayCam_:StopRecording()
            self.videoReplayCam_ = nil
            Events.Broadcast(Constants.EventNames.SHARE_VIDEO_RECORD_STATE, {state = VideoRecordState.CANCEL})
        end

        for objPath, loadedObj in pairs(self.loadedGoMap_ or {}) do
            CfUtils.SafeDelete(loadedObj)
        end

        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


-------------------------------------------------
-- public

function CommonSharePreviewDialog:Close()
    self.controller:Close()
end


-------------------------------------------------
-- private

---@return boolean
function CommonSharePreviewDialog:IsShareVideo_()
    return self.videoArgs_ ~= nil
end


---@param bgImgPath string
function CommonSharePreviewDialog:UpdateBgImage_(bgImgPath)
    if bgImgPath then
        CfUtils.SetActive(self.BgImage, true)
        CfUtils.FillImage(self.BgImage, bgImgPath)
        CfUtils.SetActive(self.BgFuzzy, false)
    else
        CfUtils.SetActive(self.BgImage, false)
        CfUtils.SetActive(self.BgFuzzy, true)
    end
end


---@param isLocalSave boolean
function CommonSharePreviewDialog:UpdateShareButtons_(isLocalSave)
    -- check localSave button
    CfUtils.SetActive(self.BtnLocalSave, isLocalSave)

    -- check share buttons
    if self:IsShareVideo_() then
        -- update share buttons
        for btnName, defines in pairs(ShareChannelDefines) do
            local isEnable = defines.iosVideo
            if KTool.UNITY_ANDROID() then
                isEnable = defines.androidVideo
            end
            if self[btnName] then
                local shareDefine = self.shareDefines_[defines.channel] or {}
                local isVisible   = checkInt(shareDefine.show) == 1
                CfUtils.SetActive(self[btnName], isEnable and isVisible)
            end
        end
    else
        -- update share buttons
        for btnName, defines in pairs(ShareChannelDefines) do
            local isEnable = defines.iosImage
            if KTool.UNITY_ANDROID() then
                isEnable = defines.androidImage
            end
            logs('>>>> self[btnName 1]', btnName)
            if self[btnName] then
                local shareDefine = self.shareDefines_[defines.channel] or {}
                local isVisible   = checkInt(shareDefine.show) == 1
                logs('>>>> self[btnName 2]', btnName, isEnable, isVisible)
                CfUtils.SetActive(self[btnName], isEnable and isVisible)
            end
        end
    end

    -- add listens
    SetButtonAction(self.ScreenBtn, Bind(self, self.OnClickScreenButtonHandler_))
    SetButtonAction(self.BtnLocalSave, Bind(self, self.OnClickLocalSaveHandler_))
    for btnName, defines in pairs(ShareChannelDefines) do
        if self[btnName] then
            SetButtonAction(self[btnName], Bind(self, self.OnClickToShareButtonHandler_, btnName))
        end
    end
end


---@param desc string
---@param args table
---@return string
function CommonSharePreviewDialog:MakeShareDesc_(desc, args)
    if args == nil then
        return tostring(desc)
    end
    if next(args) == nil then
        return desc
    end
    return string.fmt(tostring(desc), args)
end


--- 视频：获取录制视频名字key
---@return string
function CommonSharePreviewDialog:GetRecordedVideoNameKey_()
    return string.fmt(Constants.PlayerPrefsType.ShareRecordedVideoNameId, {_nameId_ = self.videoArgs_.videoNameId})
end


--- 视频：是否录制成功
---@return boolean
function CommonSharePreviewDialog:IsVideoRecordSucceed_()
    if self:IsShareVideo_() and File.Exists(self.filePath_) then
        local recordedVideoNameValue = CfUtils.GetLocalData(self:GetRecordedVideoNameKey_(), '0')
        return checkInt(recordedVideoNameValue) == 1
    end
    return false
end


--- 视频：更新录制进度
---@param percent number @ value range 0-1.0
function CommonSharePreviewDialog:UpdateLoadingPercent_(percent)
    local percentInt = checkInt(checkNumber(percent) * 100)
    self.LoadingProgressSlider.value = percentInt
    CfUtils.FillText(self.LoadingVolumeText, '')
    CfUtils.FillText(self.LoadingPercentText, string.format('%d%%', percentInt))
end


--- 视频：进行录制
function CommonSharePreviewDialog:RecordTimelineVideo_()
    CfUtils.SetActive(self.VideoNode, false)
    CfUtils.SetActive(self.LodingNode, true)
    self:UpdateLoadingPercent_(0)

    -- FIXME: temp
    if GameUtils.IsWindow() then
        CfUtils.SetActive(self.BtnGroup, true)
        self:UpdateLoadingPercent_(1)
        return
    end

    ---@return UnityEngine.GameObject
    local MakeLoadPrefab = function(prefabPath)
        local prefabLoader = ResourceModule.LoadBundleAsync(prefabPath, nil, true)
        while not prefabLoader.IsCompleted do
            coroutine.yield(Yielders.EndOfFrame)
        end

        local prefabIns = nil
        if not isNull(prefabLoader.ResultObject) then
            prefabIns = prefabLoader:Instantiate(false, nil, false)
            self.loadedGoMap_[prefabPath] = prefabIns
        end
        prefabLoader:Release()
        return prefabIns
    end

    self.doRecorVideoCo_ = cs_coroutine.start(function()xTry(function()
        -- append blocker
        UIRaycastBlocker:AddCondition(RECORD_TIMELINE_BLOCKER_NAME)

        -- load timeline
        local timelinePath = self.videoArgs_.timelinePath
        local timelineIns  = MakeLoadPrefab(timelinePath)

        -- get camera
        local tlCameraName  = self.videoArgs_.tlCameraName
        local tlCameraTrans = timelineIns.transform:Find(tlCameraName)
        local tlCameraGo    = tlCameraTrans.gameObject:GetComponent(typeof(Camera))
        tlCameraGo.enabled  = false
        
        ---@type UnityEngine.Playables.PlayableDirector
        local tlDirector = timelineIns:GetComponent(typeof(PlayableDirector))
        local tlInitCallback = self.videoArgs_.tlInitCallback
        if tlInitCallback then
            tlInitCallback(timelineIns, tlDirector)
        end

        -- remove blocker
        UIRaycastBlocker:RemoveCondition(RECORD_TIMELINE_BLOCKER_NAME)

        -- init timeline
        CfUtils.SetActive(timelineIns, true)
        tlDirector.time = 0

        -- update progress
        local tlPlayTime = tlDirector.duration
        local recordTime = KTool.UNITY_IOS() and (tlPlayTime * 2) or tlPlayTime
        CfUtils.DoTween(recordTime, function(value)
            self:UpdateLoadingPercent_(value)
        end)
        
        -- start recording
        ---@type NatCorder.ReplayCam
        self.videoReplayCam_ = KTool.GetOrAddComponent(tlCameraGo.gameObject, typeof(ReplayCam))
        self.videoReplayCam_.videoWidth     = math.floor(Screen.width) - math.floor(Screen.width)%2
        self.videoReplayCam_.videoHeight    = math.floor(Screen.height) - math.floor(Screen.height)%2
        self.videoReplayCam_.mCamera        = tlCameraGo
        self.videoReplayCam_.recordTime     = recordTime
        self.videoReplayCam_.videoBitRate   = 6000000
        self.videoReplayCam_.audioBitRate   = 64000
        self.videoReplayCam_.sampleRate     = 44100
        self.videoReplayCam_.channelCount   = 2
        self.videoReplayCam_.isAudioMute    = true
        self.videoReplayCam_.fileNameId     = self.videoArgs_.videoNameId
        self.videoReplayCam_.OnRecordFinish = function(fileId, file_path)
            -- delete timeline
            CfUtils.SafeDelete(timelineIns)
            -- clean recording
            self.videoReplayCam_ = nil
            -- write recorded
            CfUtils.WriteLocalData(self:GetRecordedVideoNameKey_(), 1)
            Events.Broadcast(Constants.EventNames.SHARE_VIDEO_RECORD_STATE, {state = VideoRecordState.FINISH})
            -- preview video
            self:PreviewRecordVideo_()
        end

        Events.Broadcast(Constants.EventNames.SHARE_VIDEO_RECORD_STATE, {state = VideoRecordState.READY})
        self.videoReplayCam_:StartRecording()

        -- play timeline
        tlDirector:Play()
        coroutine.yield(Yielders.GetWaitForSeconds(tlPlayTime))

        -- stop logo animator
        local logoTransform = tlCameraGo.transform:Find("Logo")
        if not isNull(logoTransform) then
            ---@type UnityEngine.Animator
            local logoAnimatorCom = logoTransform.gameObject:GetComponent(typeof(Animator))
            if not isNull(logoAnimatorCom) then
                logoAnimatorCom.enabled = false
            end
        end
    end)end)
end


--- 视频：预览录制
function CommonSharePreviewDialog:PreviewRecordVideo_()
    CfUtils.SetActive(self.VideoNode, true)
    CfUtils.SetActive(self.LodingNode, true)
    self:UpdateLoadingPercent_(1)

    -- mute bgm
    self.isPreviewRecordVideo_ = true
    CriWareUtils.SetVolume(Constants.CriWareCategory.BGM, 0)

    ---@type UnityEngine.UI.RawImage
    local videoRawImg = KTool.GetComponent(self.VideoNode.gameObject, typeof(RawImage))
    if isNull(videoRawImg.texture) then
        local renderTexture = RenderTexture(Screen.width, Screen.height, 16, RenderTextureFormat.ARGBHalf)
        videoRawImg.texture = renderTexture
    end

    ---@type UnityEngine.Video.VideoPlayer
    local videoPlayer = KTool.GetOrAddComponent(self.VideoNode.gameObject, typeof(VideoPlayer))
    videoPlayer.playOnAwake   = true
    videoPlayer.isLooping     = true
    videoPlayer.renderMode    = VideoRenderMode.RenderTexture
    videoPlayer.targetTexture = videoRawImg.texture
    videoPlayer.source        = VideoSource.Url
    videoPlayer.url           = self.filePath_

    local prepareCompletedCB = function(player)
        CfUtils.SetActive(self.BtnGroup, true)
        CfUtils.SetActive(self.LodingNode, false)
        videoPlayer:Play()
    end
    if videoPlayer.isPrepared then
        prepareCompletedCB()
    else
        ---@param player UnityEngine.Video.VideoPlayer
        videoPlayer:prepareCompleted("+", function(player)
            prepareCompletedCB()
        end)
        videoPlayer:Prepare()
    end
    
    ---@type UnityEngine.AudioSource
    -- local audioSource = KTool.GetOrAddComponent(self.VideoNode.gameObject, typeof(AudioSource))
    -- audioSource.playOnAwake     = true
    -- audioSource.loop            = true
    -- videoPlayer.audioOutputMode = VideoAudioOutputMode.AudioSource
    -- videoPlayer:SetTargetAudioSource(0, audioSource)
    -- audioSource:Play()
end


-------------------------------------------------
-- handler

function CommonSharePreviewDialog:OnClickScreenButtonHandler_()
    self:Close()
end


function CommonSharePreviewDialog:OnClickLocalSaveHandler_()
    GameUtils.Toast(localize('保存成功'))
end


---@param btnName string
function CommonSharePreviewDialog:OnClickToShareButtonHandler_(btnName)
    local channelDefine = ShareChannelDefines[btnName] or {}
    local shareChannel  = channelDefine.channel
    local isSDKVideo    = channelDefine.sdkVideo == true
    local packageName   = channelDefine.packageName
    local className     = channelDefine.className
    local shareDefine   = self.shareDefines_[shareChannel] or {}
    local shareTitle    = shareDefine.title or ''
    local shareDesc     = shareDefine.descr or ''
    local shareLink     = shareDefine.link or ''
    local groupName     = shareDefine.gName or ''
    local groupSection  = shareDefine.gSection or ''
    local filePath      = self.filePath_

    if KTool.IsMobile() then
        ------------------------------------------------- [share video]
        if self:IsShareVideo_() then
            if isSDKVideo then
                -- SDK 分享视频
                GameUtils.Toast('伟浩是全能的')
            else
                ---@type NativeShare
                local nativeShare = CS.NativeShare()
                nativeShare:SetSubject(shareTitle)
                nativeShare:SetText(shareDesc)
                nativeShare:SetUrl(shareLink)
                nativeShare:AddFile(filePath)
                if KTool.UNITY_ANDROID() then
                    nativeShare:AddTarget(packageName, className)
                end
                nativeShare:SetCallback(function(ret, target)
                    GameUtils.Toast(localize('分享成功'))
                    print('分享结果：' .. tostring(ret))
                end):Share()
            end

        ------------------------------------------------- [share image]
        else
            if shareChannel == Constants.ShareChannel.FTCommunity then
                local communityLinkShareId = 9
                ---@type CommunityJumpVo
                local jumpVo   = CfUtils.GetCfVo(AutoIds.IdSetting2510, "CommunityJumpVo", communityLinkShareId) or {}
                local userComp = GameUtils.GetEntityCompByType(ECSComponentType.Constants.UserComponent)
                local userInfo =  userComp.userInfo
                local urlData  = {
                    app_id       = userInfo.app_id,
                    uid          = userInfo.openId,
                    access_token = userInfo.access_token,
                    callback     = jumpVo.gotoUrl or ''
                }
                local encodePar = CS.UnityEngine.Networking.UnityWebRequest.EscapeURL(table.serialize(urlData))
                shareLink = string.format("%s%s", jumpVo.link or '', tostring(encodePar))
                print("shareLink ==" , shareLink)
            end

            -- sdk分享图片
            SDKService:GetInstance():Share(shareChannel, filePath, shareTitle, shareDesc, shareLink, groupName, groupSection)
        end

        self:OnShareSucceedCallback_()

    else
        print(string.fmt('<color=#CC6699>[shareType = %1] %2</color>', tostring(self.shareType_), table.serialize({
            shareId = tostring(self.shareMsgVo_.id),
            file    = filePath,
            channel = shareChannel,
            title   = shareTitle,
            descr   = shareDesc,
            link    = shareLink,
        })))
        if CS.UnityEngine.Application.isEditor then
            -- 开发测试用，所以不要翻译
            GameUtils.Toast('假装分享成功')
            -- 编辑器环境下测试用
            self:OnShareSucceedCallback_()
        else
            GameUtils.Toast(localize('请移动至手机端进行分享'))
        end
    end
end


function CommonSharePreviewDialog:OnShareSucceedCallback_()
    local rewardTypeId    = checkInt(self.shareMsgVo_.rewardTypeId)
    local rewardLeftTimes = GameUtils.GetShareRewardLeftTimes(rewardTypeId)
    if rewardLeftTimes > 0 then
        local requestData = {rewardId = rewardTypeId}
        GameUtils.Request(Interfaces.OverseaPlayerShare, requestData, function(request, response)
            if checkInt(response.errCode) == 0 then
                local responseData = checkTable(response.data)

                -- update leftTimes
                GameUtils.SetShareRewardLeftTimes(rewardTypeId, rewardLeftTimes - 1)
                Events.Broadcast(Constants.EventNames.SHARE_BUTTON_REFRESH)

                -- send shareTask
                self:ShareTaskRecord_(self.shareType_)
                
                -- draw rewards
                local rewardList = checkTable(responseData.rewards)
                GoodsUtils.DrawRewards(rewardList)
                CfUtils.DialogOpen(Constants.UITypeIds.UICommonRewardPop, {
                    rewards                 = rewardList, 
                    customSortingOrder      = CfUtils.GetAddSortingOrder(self.controller) + 1,
                    isDisableSpecialRewards = true,
                })
            end
        end)
    else
        -- send shareTask
        self:ShareTaskRecord_(self.shareType_)
    end
end


--- 分享任务记录
---@param shareType Constants.ShareType
function CommonSharePreviewDialog:ShareTaskRecord_(shareType)
    local recordType = ShareRecordContrast[checkInt(shareType)] or Constants.ShareRecordType.COMMON
    if KCookie.Get(Constants.UICacheDataKeys.IS_PRE_DOWNLOAD) == 1 then
        -- 预下载分享记录
        --GameUtils.Request(Interfaces.PreDownloadShare, {targetId = recordType}, function(request, response) end)
    else
        GameUtils.Request(Interfaces.OverseaShareTaskRecord, {type = recordType}, function(request, response) end)
    end
end


return CommonSharePreviewDialog
