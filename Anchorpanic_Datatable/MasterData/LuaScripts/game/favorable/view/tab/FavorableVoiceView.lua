--[[ 
-----------------------------------------------------
@filename       : FavorableVoiceView
@Description    : 战员档案-cv
@date           : 2021-08-20 12:06:02
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.favorable.view.FavorableVoiceView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("favorable/tab/FavorableVoiceView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mItemList = {}
    self.mIsCN = false
end

function setMask(self)
end

-- 初始化
function configUI(self)
    self.Content = self:getChildTrans("Content")
    self.mImgCvShowBg = self:getChildGO("mImgCvShowBg")
    self.mTxtCvShow = self:getChildGO("mTxtCvShow"):GetComponent(ty.Text)
    self.mImgJp = self:getChildGO("mImgJp")
    self.mImgCN = self:getChildGO("mImgCN")
end

--激活
function active(self, args)
    super.active(self, args)
    self.mHeroId = args.heroId
    self.mHeroTid = args.heroTid
    self:updateView()
    GameDispatcher:addEventListener(EventName.HERO_FILES_SHOW_VOICE, self.showCvLines, self)
    GameDispatcher:addEventListener(EventName.CHANGE_SHOW_HERO, self.onChangeHero, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItemList()
    GameDispatcher:removeEventListener(EventName.HERO_FILES_SHOW_VOICE, self.showCvLines, self)
    GameDispatcher:removeEventListener(EventName.CHANGE_SHOW_HERO, self.onChangeHero, self)
    self.curPlayItme = nil
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mImgCN, self.onClickCN)
    self:addUIEvent(self.mImgJp, self.onClickJp)

end

function onChangeHero(self, args)
    self.mHeroId = args.heroId
    self.mHeroTid = args.heroTid
    self:updateView()
end

function onClickCN(self)
    if (not self.mIsCN) then
        self.mIsCN = true
        self.mImgCN:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0017.png"))
        self.mImgJp:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0018.png"))
    end
end

function onClickJp(self)
    if (self.mIsCN) then
        self.mIsCN = false
        self.mImgCN:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0018.png"))
        self.mImgJp:GetComponent(ty.AutoRefImage):SetImg(UrlManager:getCommon5Path("common_0017.png"))
    end
end

function updateView(self)
    self:recoverItemList()
    local list = favorable.FavorableManager:getVoiceList(self.mHeroTid)

    for i, v in ipairs(list) do
        local item = favorable.FavorableVoiceItem:poolGet()
        v.tweenId = i
        item:setData(self.Content, v, self.mHeroId, self.mHeroTid)
        item:addEventListener(item.EVENT_PLAYING, self.onPlayingHandler, self)
        table.insert(self.mItemList, item)
    end
end

function onPlayingHandler(self, args)
    local item = args.item
    if self.curPlayItme and self.curPlayItme ~= item then
        self.curPlayItme:stopPlay()
    end
    self.curPlayItme = item
end

function recoverItemList(self)
    for i, v in ipairs(self.mItemList) do
        v:poolRecover()
    end
    self.mItemList = {}
end

function showCvLines(self, args)
    if self.audioData then
        AudioManager:stopAudioSound(self.audioData)
        self.audioData = nil
    end
    if args.state then
        local cvId = args.cvId
        local cvData = AudioManager:getCVData(cvId)
        if not cvData then
            return
        end
        if (self.mIsCN) then
            --中文路径
        else
            --日语路径
        end

        if (cvData.voice == "") then
            gs.Message.Show(_TT(41617))
            return;
        end
        self.audioData = AudioManager:playCvByCVPath(UrlManager:getCVSoundPath(cvData.voice), function()
            self.mImgCvShowBg:SetActive(false)
            self.audioData = nil
            if (args.finishCall) then
                args.finishCall()
            end
            favorable.FavorableManager:setNowVoiceTime(0)
        end)
        if (self.audioData) then
            favorable.FavorableManager:setNowVoiceTime(self.audioData.m_source.clip.length)
        else
            favorable.FavorableManager:setNowVoiceTime(0)
        end
        self.mTxtCvShow.text = cvData.lines
        self.mImgCvShowBg:SetActive(true)
    else
        self.mImgCvShowBg:SetActive(false)
        if (args.finishCall) then
            args.finishCall()
        end
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]