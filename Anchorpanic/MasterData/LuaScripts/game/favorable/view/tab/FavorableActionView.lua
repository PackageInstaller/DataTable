--[[ 
-----------------------------------------------------
@filename       : FavorableActionView
@Description    : 战员档案-动作
@date           : 2021-08-20 12:06:02
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.favorable.view.FavorableActionView', Class.impl(TabSubView))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("favorable/tab/FavorableActionView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mItemList = {}
end

function setMask(self)
end

-- 初始化
function configUI(self)
    self.Content = self:getChildTrans("Content")
    self.mImgCvShowBg = self:getChildGO("mImgCvShowBg")
    self.mTxtCvShow = self:getChildGO("mTxtCvShow"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    self.mHeroId = args.heroId
    self.mHeroTid = args.heroTid
    self:updateView()
    GameDispatcher:addEventListener(EventName.CHANGE_SHOW_HERO, self.onChangeHero, self)
    GameDispatcher:addEventListener(EventName.HERO_FILES_SHOW_VOICE, self.showCvLines, self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverItemList()
    self.curPlayItme = nil
    GameDispatcher:removeEventListener(EventName.CHANGE_SHOW_HERO, self.onChangeHero, self)
    GameDispatcher:removeEventListener(EventName.HERO_FILES_SHOW_VOICE, self.showCvLines, self)
end

function onChangeHero(self, args)
    self.mHeroId = args.heroId
    self.mHeroTid = args.heroTid
    self:updateView()
end

function updateView(self)
    self:recoverItemList()
    if (self.mHeroId ~= nil) then
        self.curHeroVo = hero.HeroManager:getHeroVo(self.mHeroId)
    else
        self.curHeroVo = hero.HeroManager:getHeroConfigVo(self.mHeroTid)
    end
    local list = favorable.FavorableManager:getInteractList(self.curHeroVo:getHeroModel())
    if not list then
        list = favorable.FavorableManager:getInteractList(self.curHeroVo.showModel)
    end

    if not list then
        return
    end
    for i, v in ipairs(list) do
        local item = favorable.FavorableActionItem:poolGet()
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
            favorable.FavorableManager:setNowVoiceTime(0)
        end)
        if (self.audioData) then
            favorable.FavorableManager:setNowVoiceTime(self.audioData.m_source.clip.length)
        else
            favorable.FavorableManager:setNowVoiceTime(0)
        end
        if (args.startCall) then
            args.startCall()
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

function onDispose(self)
end


return _M

--[[ 替换语言包自动生成，请勿修改！
]]