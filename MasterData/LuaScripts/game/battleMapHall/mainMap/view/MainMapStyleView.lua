module("battleMap.MainMapStyleView", Class.impl("lib.component.BaseContainer"))

UIRes = UrlManager:getUIPrefabPath("battleMapHall/mainMap/MainMapStyleView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mTypeList = nil
    self.mSelectType = nil
    self.mItemGoDic = {}
    self.mIsOpenDown = nil
    self.mChapterVo = nil
end

function configUI(self)
    -- 新版
    self.mTxtEasy = self:getChildGO("mTxtEasy"):GetComponent(ty.Text)
    self.mTxtDifficulty = self:getChildGO("mTxtDifficulty"):GetComponent(ty.Text)
    self.mTxtSuperDifficulty = self:getChildGO("mTxtSuperDifficulty"):GetComponent(ty.Text)
    self.mImgEasyLock = self:getChildGO("mImgEasyLock")
    self.mBtnEasy = self:getChildGO("mBtnEasy")
    self.mImgDifficultyLock = self:getChildGO("mImgDifficultyLock")
    self.mBtnDifficulty = self:getChildGO("mBtnDifficulty")
    self.mEasySelect = self:getChildGO("mEasySelect")
    self.mDifficultySelect = self:getChildGO("mDifficultySelect")
    self.mBtnSuperDifficulty = self:getChildGO("mBtnSuperDifficulty")
    self.mSuperDifficultySelect = self:getChildGO("mSuperDifficultySelect")
    self.mImgSuperDifficultyLock = self:getChildGO("mImgSuperDifficultyLock")

    self:setGuideTrans("guide_BtnDifficulty", self.mBtnDifficulty.transform)
end

function active(self)
    super.active(self)
    local chapterList = battleMap.MainMapManager:getChapterList()
    self:addOnClick(self.mBtnDifficulty, self.onClickBtnHandler, nil, battleMap.MainMapStyleType.Difficulty)
    self:addOnClick(self.mBtnEasy, self.onClickBtnHandler, nil, battleMap.MainMapStyleType.Easy)
    self:addOnClick(self.mBtnSuperDifficulty, self.onClickBtnHandler, nil, battleMap.MainMapStyleType.SuperDifficulty)
end

function deActive(self)
    super.deActive(self)
    self:updateBubble(false, self.mBtnEasy)
    self:updateBubble(false, self.mBtnDifficulty)
    self:removeOnClick(self.mBtnDifficulty, self.onClickBtnHandler)
    self:removeOnClick(self.mBtnEasy, self.onClickBtnHandler)
    self:removeOnClick(self.mBtnSuperDifficulty, self.onClickBtnHandler)
    self:recoverItemGoDic()
end

function setData(self, typeList, styleType, isOpenDown, chapterVo)
    self.mTypeList = typeList
    self.mSelectType = styleType
    self.mIsOpenDown = isOpenDown == nil and self.mIsOpenDown or isOpenDown
    self.mChapterVo = chapterVo
    self.mTxtEasy.text = _TT(71314)
    self.mTxtDifficulty.text = _TT(71315)
    self.mTxtSuperDifficulty.text = _TT(2916)
    self:updateBtnStateHandler()
    self:updateBubble(false, self.mBtnEasy)
    self:updateBubble(false, self.mBtnDifficulty)
    self:updateLockState(battleMap.MainMapStyleType.Easy)
    self:updateLockState(battleMap.MainMapStyleType.Difficulty)
    self:updateLockState(battleMap.MainMapStyleType.SuperDifficulty)
end

-- 新版
function updateBtnStateHandler(self)
    if (self.mSelectType == battleMap.MainMapStyleType.Easy) then
        self.mEasySelect:SetActive(true)
        self.mDifficultySelect:SetActive(false)
        self.mSuperDifficultySelect:SetActive(false)
    elseif (self.mSelectType == battleMap.MainMapStyleType.Difficulty) then
        self.mEasySelect:SetActive(false)
        self.mDifficultySelect:SetActive(true)
        self.mSuperDifficultySelect:SetActive(false)
    elseif (self.mSelectType == battleMap.MainMapStyleType.SuperDifficulty) then
        self.mEasySelect:SetActive(false)
        self.mDifficultySelect:SetActive(false)
        self.mSuperDifficultySelect:SetActive(true)
    end
end

function updateLockState(self, styleType)
    local isShowRed = false
    for i = 1, #battleMap.MainMapManager:getChapterList() do
        local chapterVo = battleMap.MainMapManager:getChapterList()[i]
        local progress, sum = chapterVo:getStage(styleType)
        for _, stageVo in ipairs(chapterVo:getStageVoList(styleType)) do
            if stageVo and progress >= stageVo.sort and #stageVo.stageAwardList > 0 and (table.indexof(battleMap.MainMapManager:getReceivedStageAwardList(), stageVo.stageId) == false) then
                isShowRed = true
                break
            end
        end
    end
    if (styleType == battleMap.MainMapStyleType.Easy) then
        local firstStageId = self.mChapterVo:getFirstStageId(styleType)
        local firstStageVo = battleMap.MainMapManager:getStageVo(firstStageId)
        local isActive, needPassStageId = firstStageVo:isActive()
        local needLevl = role.RoleManager:getRoleVo():getPlayerLvl() >= self.mChapterVo.m_level
        if (isActive and needLevl == true) or (self.mImgDifficultyLock.activeSelf == false) then
            self.mImgEasyLock:SetActive(false)
            self:updateBubble(isShowRed, self.mBtnEasy)
        else
            self.mImgEasyLock:SetActive(true)
        end
    elseif (styleType == battleMap.MainMapStyleType.Difficulty) then
        self.mImgDifficultyLock:SetActive(true)
        if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_SPECIAL, false) == true) then
            self.mImgDifficultyLock:SetActive(false)
            self:updateBubble(isShowRed, self.mBtnDifficulty)
        end
    elseif (styleType == battleMap.MainMapStyleType.SuperDifficulty) then
        self.mImgSuperDifficultyLock:SetActive(true)
        if (funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_SUPER_SPECIAL, false) == true) then
            self.mImgSuperDifficultyLock:SetActive(false)
            self:updateBubble(isShowRed, self.mBtnSuperDifficulty)
        end
    end
    -- 显示是否解锁的标识
end

-- 新版
function onClickBtnHandler(self, args)
    local firstStageId = self.mChapterVo:getFirstStageId(args)
    local firstStageVo = battleMap.MainMapManager:getStageVo(firstStageId)
    local isActive, needPassStageId = firstStageVo:isActive()
    if (args == battleMap.MainMapStyleType.Difficulty and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_SPECIAL, true) == false) then
        return
    elseif (args == battleMap.MainMapStyleType.SuperDifficulty and funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_SUPER_SPECIAL, true) == false) then
        return
    elseif (isActive == false and args == battleMap.MainMapStyleType.Easy and self.mImgEasyLock.activeSelf == true) then
        gs.Message.Show(_TT(53608))
        return
    end
    if (battleMap.MainMapManager:getStyle() ~= args) then
        battleMap.MainMapManager:setStyle(args)
        GameDispatcher:dispatchEvent(EventName.CHANGE_MAIN_MAP_STYLE, { styleType = battleMap.MainMapManager:getStyle(), chapterVo = self.mChapterVo })
        self:updateBtnStateHandler(args)
    end
end

-- 点击item
function onClickItemHandler(self, btnGo)
    local data = self.mItemGoDic[btnGo:GetHashCode()]
    battleMap.MainMapManager.style = data.type
    GameDispatcher:dispatchEvent(EventName.CHANGE_MAIN_MAP_STYLE, { styleType = battleMap.MainMapManager:getStyle(), chapterVo = self.mChapterVo })
    self.mIsOpenDown = false
end

function getGoUniqueName(self, goName)
    return self.__cname .. "_" .. goName
end

function updateBubble(self, isShowRed, prent)
    if isShowRed then
        RedPointManager:add(prent.transform, nil, 53, 13)
    else
        RedPointManager:remove(prent.transform)
    end
end

function __getItemGo(self, goName, type)
    local uniqueName = self:getGoUniqueName(goName)
    local go = gs.GOPoolMgr:GetOther(uniqueName)
    if (not go or gs.GoUtil.IsGoNull(go)) then
        if (self.m_childGos and self.m_childGos[goName]) then
            go = gs.GameObject.Instantiate(self.m_childGos[goName])
        end
    end
    go:SetActive(true)
    self.mItemGoDic[go:GetHashCode()] = { go = go, uniqueName = uniqueName, type = type }
    return go
end

function recoverItemGoDic(self)
    if (self.mItemGoDic) then
        for hashCode, data in pairs(self.mItemGoDic) do
            gs.GOPoolMgr:RecoverOther(data.uniqueName, data.go)
        end
    end
    self.mItemGoDic = {}
end

return _M

--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(71316):	"敬请期待"
	语言包: _TT(71315):	"特殊"
	语言包: _TT(71314):	"普通"
	语言包: _TT(71313):	"剧情模式"
]]