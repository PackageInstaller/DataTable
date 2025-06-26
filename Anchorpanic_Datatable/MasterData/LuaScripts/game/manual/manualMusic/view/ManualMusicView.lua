--[[ 
-----------------------------------------------------
@filename       : ManualMusicView
@Description    : 图鉴-音乐
@date           : 2023-3-5 17:43:00
@Author         : Shuai
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualMusicView", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("manual/ManualMusicView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("manualMusic_bg.jpg", true, "manual")
    self:setTxtTitle("音乐")
end
-- 析构  
function dtor(self)
    super.dtor(self)
end

function initData(self)
    super.initData(self)
    self.mMusicItemList = {}
    self.mIsActionMusic = false
    self.mMusicDefaultKey = "backGroundMusic1"
    self.mCurRotation = 1
    self.mIsRightOrLeft = 0--0无状态--1左  --2 右
    self.mMainMusicPath = 0
    self.mCurMusicName = 0
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mBtnLast = self:getChildGO("mBtnLast")
    self.mBtnNext = self:getChildGO("mBtnNext")
    self.mMusicItem = self:getChildGO("mMusicItem")
    self.mImgStopMusic = self:getChildGO("mImgStopMusic")
    self.mMusicContent = self:getChildTrans("mMusicContent")
    self.mBtnActionMusic = self:getChildGO("mBtnActionMusic")
    self.mImgActionMusic = self:getChildGO("mImgActionMusic")
    --self.mToggle = self:getChildGO("mToggle"):GetComponent(ty.Toggle)
    self.mSlider = self:getChildGO("mSlider"):GetComponent(ty.Slider)
    self.mIconCD = self:getChildGO("mIconCD"):GetComponent(ty.AutoRefImage)
    self.mTxtCurTime = self:getChildGO("mTxtCurTime"):GetComponent(ty.Text)
    self.mTxtSubTime = self:getChildGO("mTxtSubTime"):GetComponent(ty.Text)
    self.mTxtMusicName = self:getChildGO("mTxtMusicName"):GetComponent(ty.Text)
    self.mGroupShowAni = self:getChildGO("mGroupShow"):GetComponent(ty.Animator)
    self.mImgShowCD = self:getChildGO("mImgShowCD"):GetComponent(ty.AutoRefImage)
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    read.ReadManager:addEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onUpdateMusicItem, self)
    --  self.mMainMusicPath = AudioManager:getMusicData()
    self.data = args
    self.curIndex = 1
    self:actionMusic()
    --local function onToggle()
    --    self:toggleChange()
    --end
    --self.mToggle.onValueChanged:AddListener(onToggle)
    self.mImgActionMusic:SetActive(false)
    self.mImgStopMusic:SetActive(true)
    self:showPanel()
    local function eventHandler(val)
        local curVal = val
        self:changeValue(string.format("%.2f", curVal))
    end
    self.mSlider.onValueChanged:AddListener(eventHandler)
end


function showPanel(self)
    for i = 1, 3 do
        local musicItem = SimpleInsItem:create(self.mMusicItem, self:getChildTrans("mItemTrans" .. i), "ManualMusicViewMusicItem")
        musicItem:addUIEvent(nil, function()
            self:click(i)
        end)
        table.insert(self.mMusicItemList, musicItem)
    end
    self:updateMusicData()
end

function next(self)
    self.curIndex = self.curIndex + 1
    self:resetTime()
    self:updateMusicData()
    self:updateEffectState()
end

function first(self)
    self.curIndex = self.curIndex - 1
    self:resetTime()
    self:updateMusicData()
    self:updateEffectState()
end

function click(self, index)
    self.curIndex = self.curIndex + index
    self:resetTime()
    self:updateMusicData()
    self:updateEffectState()
end

function updateMusicData(self, isClick)
    for i = 1, 3 do
        local oo = (self.curIndex + i) % (#manual.ManualMusicManager:getManualMusicList())
        oo = oo <= 0 and #manual.ManualMusicManager:getManualMusicList() or oo
        local vo = manual.ManualMusicManager:getManualMusicVoByMusicId(manual.ManualMusicManager:getManualMusicList()[oo].musicId)
        self.mMusicItemList[i]:setArgs(vo)
        self.mMusicItemList[i]:getChildGO("mImgIcon"):GetComponent(ty.AutoRefImage):SetImg(vo:getImgUrl(), false)
        self.mMusicItemList[i]:getChildGO("mImgNew"):SetActive(manual.ManualMusicManager:getIsNew(vo.musicId) == true)
    end
    self:onUpdateShowMusic()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    read.ReadManager:removeEventListener(read.ReadManager.UPDATE_MODULE_READ, self.onUpdateMusicItem, self)
    self.mSlider.onValueChanged:RemoveAllListeners()
    self:closeMusicListItem()
    if self.mLoopRoSn then
        self:removeTimerByIndex(self.mLoopRoSn)
        self.mLoopRoSn = nil
    end
    self.mCurMusicName = 0
    self.mSlider:DOKill()
    self.mSlider.value = 0
    -- AudioManager:playMusicById(self.mMainMusicId)
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

function addAllUIEvent(self)
    super.addAllUIEvent(self)
    self:addUIEvent(self.mBtnActionMusic, self.actionMusic)
    self:addUIEvent(self.mBtnLast, self.first)
    self:addUIEvent(self.mBtnNext, self.next)
end


function onUpdateShowMusic(self)
    self.curIndex = (self.curIndex) % (#manual.ManualMusicManager:getManualMusicList())
    self.curIndex = self.curIndex <= 0 and #manual.ManualMusicManager:getManualMusicList() or self.curIndex
    local curShowMusicVo = manual.ManualMusicManager:getManualMusicVoByMusicId(manual.ManualMusicManager:getManualMusicList()[self.curIndex].musicId)
    if curShowMusicVo then
        self.mTxtMusicName.text = curShowMusicVo:getName()
        local sprite = gs.ResMgr:Load(UrlManager:getBgPath("sDiagramUi/music_mask.png"))
        if sprite.texture then
            self.mImgShowCD.material:SetTexture("_Mask", sprite.texture)
        elseif sprite then
            self.mImgShowCD.material:SetTexture("_Mask", sprite)
        end
        self.mImgShowCD:SetImg(curShowMusicVo:getImgUrl(), false)
        self.mIconCD:SetImg(curShowMusicVo:getImgUrl(), false)
        if manual.ManualMusicManager:getIsNew(curShowMusicVo.musicId) == true then
            GameDispatcher:dispatchEvent(EventName.REQ_MODULE_READ, { type = ReadConst.MANUAL_MUSIC, id = curShowMusicVo.musicId })
        end
        self.mImgActionMusic:SetActive(self.mIsActionMusic == true)
        self.mImgStopMusic:SetActive(self.mIsActionMusic ~= true)
        --if self.mIsActionMusic ~= true then
        --    self:resetTime()
        --end 
        self:updateMusice()
        -- self.mToggle.isOn = StorageUtil:getString0(self.mMusicDefaultKey) == curShowMusicVo:getName()
    end
end

function resetTime(self)
    self.mSlider:DOKill()
    self.mSlider.value = 0
    self.mTxtCurTime.text = TimeUtil.getHMSByTime_1(0)
end

function updateMusice(self)
    local musicName = manual.ManualMusicManager:getManualMusicList()[self.curIndex]:getMusicName()
    if self.mCurMusicName ~= musicName then
        self.mCurMusicName = musicName
        AudioManager:playMusic(UrlManager:getMusicPath(musicName), true)
    end
    AudioManager:pauseMusicByFade(0)
    if self.mIsActionMusic then
        AudioManager:resumeMusicByFade(0)
    end
    self:updateMusicProgress()
end

function changeValue(self, val)
    if AudioManager:getMusicData() then
        local curTime = AudioManager:getMusicData().m_source.clip.length * val
        self.mTxtCurTime.text = TimeUtil.getHMSByTime_1(curTime)
    end
end

function updateMusicProgress(self)
    if self.mIsActionMusic then
        if AudioManager:getMusicData() then
            local curMusicDataTime = AudioManager:getMusicData().m_source.clip.length
            self.mTxtSubTime.text = TimeUtil.getHMSByTime_1(curMusicDataTime)
            self.mSlider:DOValue(1, curMusicDataTime):SetUpdate(true):SetEase(gs.DT.Ease.Linear):OnPlay(function()
                self.mSlider:DOValue(1, curMusicDataTime):SetUpdate(true):SetEase(gs.DT.Ease.Linear)
            end):OnPause(function()
            end):OnComplete(function()
                self:resetTime()
                self:updateMusicProgress()
            end)
        end
    else
        self.mSlider:DOPause()
    end
    self.mTxtSubTime.text = TimeUtil.getHMSByTime_1(AudioManager:getMusicData().m_source.clip.length)
end

function toggleChange(self)
    local vo = manual.ManualMusicManager:getManualMusicVoByMusicId(manual.ManualMusicManager:getManualMusicList()[self.curIndex].musicId)
    if self.mToggle.isOn then
        StorageUtil:saveString0(self.mMusicDefaultKey, vo:getName())
    end
end

function onUpdateMusicItem(self)
    for _, item in pairs(self.mMusicItemList) do
        item:getChildGO("mImgNew"):SetActive(manual.ManualMusicManager:getIsNew(item:getArgs().musicId) == true)
    end
end
--延迟刷新函数
function closeMusicListItem(self)
    if #self.mMusicItemList > 0 then
        for _, musicItem in ipairs(self.mMusicItemList) do
            musicItem:poolRecover()
            musicItem = nil
        end
        self.mMusicItemList = {}
    end
end

--播放音乐
function actionMusic(self)
    -- AudioManager:stopAudioSound() 
    --if AudioManager:getMusicData() == AudioManager:getMusicConfig(manual.ManualMusicManager:getCurManualMusicMusicId()) then
    --    AudioManager:resumeMusicByFade()
    --end
    if self.mIsActionMusic == true then
        self.mIsActionMusic = false
    else
        self.mIsActionMusic = true
    end
    self:onUpdateShowMusic()
    self:updateEffectState()
end

function updateEffectState(self)
    if self.mIsActionMusic then
        if not self.mLoopRoSn then
            self.mLoopRoSn = self:addTimer(0.02, 0, function()
                if self.mCurRotation > 360 then
                    self.mCurRotation = 1
                end
                gs.TransQuick:SetRotation(self:getChildTrans("mIconCD"), 0, 0, (360 - self.mCurRotation))
                self.mCurRotation = self.mCurRotation + 1
            end)
        end
        self.mGroupShowAni:SetTrigger("Enter")
    else
        if self.mLoopRoSn then
            self:removeTimerByIndex(self.mLoopRoSn)
            self.mLoopRoSn = nil
        end
        if self.mGroupShowAni:GetCurrentAnimatorStateInfo(0):IsName("ManualMusicView_CD_Enter") or self.mGroupShowAni:GetCurrentAnimatorStateInfo(0):IsName("ManualMusicView_CD_Loop") then
            self.mGroupShowAni:SetTrigger("Exit")
        end
    end
end

function onClickHandler(self, isLast)
    if isLast then
        self.mIsRightOrLeft = 1
        self:first()
    else
        self.mIsRightOrLeft = 2
        self:next()
    end
    self.mCurRotation = 1
    --AudioManager:playMusicById(manual.ManualMusicManager:getCurManualMusicMusicId())
    -- body
end

-- function updateParent(self, curMusicId)
--     local difValue = 0
--     local isOuttrans = false
--     if self.mIsRightOrLeft > 0 then
--         for index, item in ipairs(self.mMusicItemList) do
--             local curIndex = item:getArgs().curIndex
--             if self.mIsRightOrLeft == 2 then
--                 difValue = (index)
--                 if (difValue >= 4 and isOuttrans) or (difValue <= 0) then
--                     item:getTrans():SetParent(self:getChildTrans("mItemTrans" .. 5), false)
--                     item:getArgs().curIndex = 5
--                 else
--                     if difValue == 4 then
--                         isOuttrans = true
--                     end
--                     item:getTrans():SetParent(self:getChildTrans("mItemTrans" .. difValue), false)
--                     item:getArgs().curIndex = difValue
--                 end
--             elseif self.mIsRightOrLeft == 1 then
--                 difValue = index + 2
--                 if difValue > 4 and isOuttrans then
--                     difValue = 5
--                     item:getTrans():SetParent(self:getChildTrans("mItemTrans" .. 5), false)
--                     item:getArgs().curIndex = difValue
--                 else
--                     if difValue > 4 then
--                         difValue = 1
--                         isOuttrans = true
--                     end
--                     item:getTrans():SetParent(self:getChildTrans("mItemTrans" .. difValue), false)
--                     item:getArgs().curIndex = difValue
--                 end
--             end
--         end
--         self.mIsRightOrLeft = 0
--     end
-- end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]