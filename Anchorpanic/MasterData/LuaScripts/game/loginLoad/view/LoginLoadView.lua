--[[ 
-----------------------------------------------------
@filename       : LoginLoadView
@Description    : 登录加载页面
@date           : 2020-08-31 16:20:26
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('loginLoad.LoginLoadView', Class.impl("lib.component.BaseContainer"))

-- 是否异步
IsAsyn = nil
--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("loginLoad/LoginLoadView.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构  
function dtor(self)
end

function initData(self)
    self.mFinishCall = nil
    self.mStartPro = 0
    self.mResPro = 0.9
    self.mScenePro = 0.1
end

-- 取父容器
function getParentTrans(self)
    return GameView.loading
end

-- 初始化
function configUI(self)
	self.mPreventClick = self:getChildGO('PreventClick')
	self.mGroupContent = self:getChildGO('GroupContent')

	self.mTxtState = self:getChildGO('TextState'):GetComponent(ty.Text)
	self.mTxtPro = self:getChildGO('TextProgress'):GetComponent(ty.Text)
	self.mImgLoginRoll = self:getChildTrans('ImgLoginRoll')
	self.mTransImgAct = self:getChildTrans('ImgAct')
    
	self.mImgProBar = self:getChildTrans('ImgProBar'):GetComponent(ty.Image)
	self.mImgProBar.fillAmount = 0
    
    self.mGroupContent:SetActive(false)
end

--激活
function active(self)
    super.active(self)
    if (not self.mActionFrameSn) then
        self.mActionFrameSn = LoopManager:addFrame(1, 0, self, self.onActionHandler)
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    if (self.mActionFrameSn) then
        LoopManager:removeFrameByIndex(self.mActionFrameSn)
        self.mActionFrameSn = nil
    end
end

function onActionHandler(self, deltaTime)
    if (not self.m_rotation) then
        self.m_rotation = 360
    else
        if (self.m_rotation <= 0) then
            self.m_rotation = 360 - 2
        else
            self.m_rotation = self.m_rotation - 4
        end
    end
    gs.TransQuick:SetRotation(self.mImgLoginRoll, 0, 0, self.m_rotation)

	if(self:checkCircleVisible())then
        self.mTransImgAct.gameObject:SetActive(true)
        gs.TransQuick:SetRotation(self.mTransImgAct, 0, 0, self.m_rotation)
	end
end

function checkCircleVisible(self)
	if(self.mTxtPro)then
		if(self.mTxtPro.text == "")then
			self.mTransImgAct.gameObject:SetActive(false)
			return false
		else
			return true
		end
	else
		return false
	end
end

function __updateProgress(self, state, cusProgress)
    local ratio = self.mStartPro + (1 - self.mStartPro) * cusProgress
    cusProgress = math.ceil(ratio * 100) / 100
    self.mTxtState.text = state
    self.mTxtPro.text = cusProgress * 100 .. "%"
	self.mImgProBar.fillAmount = cusProgress
end

function __getUiResList(self)
    local list = login.LoginManager:getPreloadConfigVo(login.PreloadType.UI):getContainResList()
    local resList = {}
    for i = 1, #list do
        table.insert(resList, list[i])
    end
    return resList
end

function __getResSceneList(self)
    local list = login.LoginManager:getPreloadConfigVo(login.PreloadType.SCENE):getContainResList()
    local resList = {}
    for i = 1, #list do
        table.insert(resList, list[i])
    end
    local cacheSceneName = StorageUtil:getString0('pre_scene_name')
    if(cacheSceneName and cacheSceneName ~= "" and table.indexof(list, cacheSceneName) == false)then
        table.insert(resList, cacheSceneName)
    end
    return resList
end

function startLoad(self, finishCall)
    self.mFinishCall = finishCall
	self.mGroupContent:SetActive(true)
    self:__loadResList()
end

function __loadResList(self)
    local tip = _TT(53)
    self:__updateProgress(tip, 0)
    web.WebController:reqReportStep(web.REPORT_STEP.PRE_LOAD_ASSETS)

    local function _updateResProgressBar(self, current, total)
        self:__updateProgress(tip, current / total * self.mResPro)
        if(current >= total)then
            -- print("预加载资源列表加载结束----------------------------------------------------" .. web.__getTime())
            web.WebController:reqReportStep(web.REPORT_STEP.PRE_LOAD_ASSETS_SUC)
            self:__localSceneList()
        end
    end
    local resList = self:__getUiResList()
    if(#resList > 0)then
        -- print("预加载资源列表加载开始----------------------------------------------------" .. web.__getTime())
        AssetLoader.PreLoadListAsyn01(resList, _updateResProgressBar, self)
    else
        _updateResProgressBar(self, 100, 100)
    end
end

function __localSceneList(self)
    web.WebController:reqReportStep(web.REPORT_STEP.PRE_LOAD_SCENE)

    local function __loadSceneFinish()
        web.WebController:reqReportStep(web.REPORT_STEP.PRE_LOAD_SCENE_SUC)
        GameManager:setIsLoadPreResComplete(true)
        if(self.mFinishCall)then
            self.mFinishCall()
            self.mFinishCall = nil
        end
    end

    local scenePathList = self:__getResSceneList()
    if(#scenePathList > 0)then
        local loadedCount = 0
        local totalCount = #scenePathList
        for i = 1, totalCount do
            local scenePath = scenePathList[i]
            local function _updateSceneLoadResult(xx, scenePath)
                loadedCount = loadedCount + 1
                self:__updateProgress(_TT(54), self.mResPro + loadedCount / totalCount * self.mScenePro)
                if(i >= totalCount and loadedCount >= totalCount)then
                    -- 销毁交由外部决定
                    -- self:destroy()
                    -- print("预加载场景加载结束----------------------------------------------------" .. web.__getTime())
                    __loadSceneFinish()
                end
            end
            -- print("预加载场景加载开始----------------------------------------------------" .. web.__getTime())
            gs.ResMgr:JustLoadAsync(scenePath, _updateSceneLoadResult, scenePath, true)
        end
    else
        __loadSceneFinish()
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(54):	"正在加载场景资源"
	语言包: _TT(53):	"正在加载列表资源"
]]
