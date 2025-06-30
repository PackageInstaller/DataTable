--[[ 
-----------------------------------------------------
@filename       : VideoTabView
@Description    : GMLUA
@date           : 2022-2-22 
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('gm.VideoTabView', Class.impl(TabSubView))

UIRes = UrlManager:getUIPrefabPath('gm/VideoTab.prefab')

--构造函数
function ctor(self)
    super.ctor(self)
end

function configUI(self)
    super.configUI(self)
    self.mAvproPlayer = self:getChildGO("MediaPlayer"):GetComponent(ty.MediaPlayer)
    AvproUtil:init(self.mAvproPlayer)
    self.mAvproPlayer.Events:AddListener(
        function(mediaPlayer, eventType, errorCode)
            if(eventType == gs.MediaPlayerEventType.MetaDataReady)then              -- 元数据（宽度、持续时间等）可用时触发
                gs.Message.Show("元数据（宽度、持续时间等）可用时触发")
            elseif(eventType == gs.MediaPlayerEventType.ReadyToPlay)then            -- 加载视频并准备播放时触发
                gs.Message.Show("加载视频并准备播放时触发")
            elseif(eventType == gs.MediaPlayerEventType.Started)then                -- 播放开始时触发
                gs.Message.Show("播放开始时触发")
            elseif(eventType == gs.MediaPlayerEventType.FirstFrameReady)then        -- 渲染第一帧时触发
                gs.Message.Show("渲染第一帧时触发")
            elseif(eventType == gs.MediaPlayerEventType.FinishedPlaying)then        -- 非循环视频播放完毕时触发
                gs.Message.Show("非循环视频播放完毕时触发")
            elseif(eventType == gs.MediaPlayerEventType.Closing)then                -- 媒体关闭时触发
                gs.Message.Show("媒体关闭时触发")
            elseif(eventType == gs.MediaPlayerEventType.SubtitleChange)then         -- 字幕更改时触发
                gs.Message.Show("字幕更改时触发")
            elseif(eventType == gs.MediaPlayerEventType.Stalled)then                -- 当媒体停止时触发（例如，当失去与媒体流的连接时）-当前仅在Windows平台上支持
                gs.Message.Show("当媒体停止时触发（例如，当失去与媒体流的连接时）-当前仅在Windows平台上支持")
            elseif(eventType == gs.MediaPlayerEventType.Unstalled)then              -- 当媒体从暂停状态恢复时触发（例如，当重新建立丢失的连接时）
                gs.Message.Show("当媒体从暂停状态恢复时触发（例如，当重新建立丢失的连接时）")
            elseif(eventType == gs.MediaPlayerEventType.ResolutionChanged)then      -- 当视频分辨率发生变化（包括负载）时触发，适用于自适应流
                gs.Message.Show("当视频分辨率发生变化（包括负载）时触发，适用于自适应流")
            elseif(eventType == gs.MediaPlayerEventType.StartedSeeking)then         -- 搜索开始时触发
                gs.Message.Show("搜索开始时触发")
            elseif(eventType == gs.MediaPlayerEventType.FinishedSeeking)then        -- 搜索完成时触发
                gs.Message.Show("搜索完成时触发")
            elseif(eventType == gs.MediaPlayerEventType.StartedBuffering)then       -- 缓冲开始时触发
                gs.Message.Show("缓冲开始时触发")
            elseif(eventType == gs.MediaPlayerEventType.FinishedBuffering)then      -- 缓冲完成时触发
                gs.Message.Show("缓冲完成时触发")
            elseif(eventType == gs.MediaPlayerEventType.PropertiesChanged)then      -- 当任何财产（如立体声包装发生变化）时触发-必须手动触发
                gs.Message.Show("当任何财产（如立体声包装发生变化）时触发-必须手动触发")
            elseif(eventType == gs.MediaPlayerEventType.PlaylistItemChanged)then    -- 在播放列表中播放新项目时触发
                gs.Message.Show("在播放列表中播放新项目时触发")
            elseif(eventType == gs.MediaPlayerEventType.PlaylistFinished)then       -- 播放列表到达结尾时触发
                gs.Message.Show("播放列表到达结尾时触发")
            elseif(eventType == gs.MediaPlayerEventType.Error)then                  -- 发生错误时触发
                if(errorCode == gs.MediaPlayerErrorCode.None)then
                elseif(errorCode == gs.MediaPlayerErrorCode.LoadFailed)then
                    gs.Message.Show("发生错误:", errorCode)
                elseif(errorCode == gs.MediaPlayerErrorCode.DecodeFailed)then
                    gs.Message.Show("发生错误:", errorCode)
                end
            end
        end
    )
    
    self.mBtnClear = self:getChildGO('mBtnClear')
    self.mBtnClose = self:getChildGO('mBtnClose')
    self.mFileContent = self:getChildTrans('Content')
    self.mFileCustomContent = self:getChildTrans('CustomContent')
    self.mFileItem = self:getChildGO('FileItem')
end

-- 初始化数据
function initData(self)
    self.mItemList = {}
end

function active(self)
    super.active(self)
    self:addOnClick(self.mBtnClear, self.onClickClearHandler)
    self:addOnClick(self.mBtnClose, self.onClickCloseHandler)
    self:updateView()
end

function deActive(self)
    super.deActive(self)
    self:removeOnClick(self.mBtnClear)
    self:removeOnClick(self.mBtnClose)
    self:recover()
    if self.mAvproPlayer then
        self.mAvproPlayer:Stop()
        self.mAvproPlayer:CloseVideo()
        self.mAvproPlayer.Events:RemoveAllListeners()
        self.mAvproPlayer = nil
    end
end

function onClickClearHandler(self)
    if self.mAvproPlayer then
        self.mAvproPlayer:Stop()
        self.mAvproPlayer:CloseVideo()
    end
end

function onClickCloseHandler(self)
    gm.GmController.m_gmPanel:close()
end

function updateView(self)
    local codeList = {"H264", "H265", "MPEG4DivX", "MPEG4Xvid"}
    local detailList = {"%s_1080p_2M_30.mp4", "%s_1080p_3M_30.mp4", "%s_1080p_4M_30.mp4", "%s_1080p_5M_30.mp4", "%s_1080p_10M_30.mp4", "%s_1080p_20M_30.mp4", "%s_1080p_30M_30.mp4", "%s_1080p_2M_60.mp4", "%s_1080p_30M_60.mp4"}
    for i = 1, #codeList do
        for j = 1, #detailList do
            local fileName = string.format(detailList[j], codeList[i])
            local streamAssetsPath = gs.PathUtil.DataPath .. "/" .. gs.AssetSetting.ArtsDir .. "/extra/video/test/" .. fileName
            local persistentAssetsPath = gs.PathUtil.DataPath .. "/" .. gs.AssetSetting.ArtsDir .. "/extra/video/test/" .. fileName
            if (not gs.ApplicationUtil.IsEditorRun) then
                streamAssetsPath = gs.PathUtil.GetStreamingAssetsPath("extra/video/test/" .. fileName)
                persistentAssetsPath = gs.PathUtil.GetPersistentAssetsWPath("extra/video/test/" .. fileName)
            end

            local item = SimpleInsItem:create(self.mFileItem, self.mFileContent, self.__cname .. "_self.xxx")
            item:getChildGO("mBtnStream"):SetActive(true)
            item:getChildGO("mTextFileName"):GetComponent(ty.Text).text = fileName
            
            item:addUIEvent("mTextFileName", function()
                gs.Message.Show(string.split(fileName, ".")[1])
                gs.SdkManager:Copy(string.split(fileName, ".")[1])
            end)
            item:addUIEvent("mBtnStream", 
            function() 
                self:playVideo(streamAssetsPath) 
            end)
            item:addUIEvent("mBtnPersistetnt", 
            function()
                if(gs.File.Exists(persistentAssetsPath))then
                    self:playVideo(persistentAssetsPath)
                else
                    gs.FileUtil.CreateFile(streamAssetsPath, persistentAssetsPath, function() self:playVideo(persistentAssetsPath) end)
                end
            end)
            table.insert(self.mItemList, item)
        end
    end

    local customDirPath = gs.PathUtil.DataPath .. "/" .. gs.AssetSetting.ArtsDir .. "/extra/video/test/custom"
    if (not gs.ApplicationUtil.IsEditorRun) then
        customDirPath = gs.PathUtil.GetPersistentAssetsWPath("extra/video/test/custom")
    end
    local fileListStr = gs.FileUtil.GetDirFileListStr(customDirPath)
    if(fileListStr ~= "")then
        local fileList = string.split(fileListStr, "|")
        for i = 1, #fileList do
            local fileName = fileList[i]

            local item = SimpleInsItem:create(self.mFileItem, self.mFileCustomContent, self.__cname .. "_self.xxx")
            item:getChildGO("mBtnStream"):SetActive(false)
            item:getChildGO("mTextFileName"):GetComponent(ty.Text).text = fileName
            
            item:addUIEvent("mTextFileName", function()
                gs.Message.Show(string.split(fileName, ".")[1])
                gs.SdkManager:Copy(string.split(fileName, ".")[1])
            end)
            item:addUIEvent("mBtnPersistetnt", 
            function()
                self:playVideo(customDirPath .. "/" .. fileName)
            end)
            table.insert(self.mItemList, item)
        end
    end
end

function playVideo(self, path)
    if(self.mAvproPlayer)then
        self.mAvproPlayer:Stop()
        self.mAvproPlayer:CloseVideo()
        self.mAvproPlayer:OpenVideoFromFile(gs.MediaPlayer.FileLocation.AbsolutePathOrURL, path, false)
        self.mAvproPlayer:Play()
        AvproUtil:setVolume(self.mAvproPlayer, 100)
    end
end

function recover(self, key)
    for i = #self.mItemList, 1, -1 do
        self.mItemList[i]:poolRecover()
    end
    self.mItemList = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]