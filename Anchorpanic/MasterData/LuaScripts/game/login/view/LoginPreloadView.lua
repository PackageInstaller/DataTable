module('login.LoginPreloadView', Class.impl("lib.component.BaseContainer"))

panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
destroyTime = 0 -- 自动销毁时间-1默认
-- 是否异步
IsAsyn = nil
--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("login/LoginPreloadView.prefab")

--构造函数
function ctor(self)
	gs.LifeCyclelManager.Instance:AddRegister("LoginPreloadView", self.onCSharpLifeCycleHandler, self)
    super.ctor(self)
end

function onCSharpLifeCycleHandler(self, lifeCycleName)
    if (lifeCycleName == "Start") then
        gs.LifeCyclelManager.Instance:RemoveRegister("LoginPreloadView")
        if(BoardShower:getBoardState() == BoardShower.BoardState.None)then
            BoardShower:showBoard(BoardShower:getBoardImgSource(), BoardShower:getBoardImgAudioSource(), BoardShower:getBoardVideoSource(), false, nil, 
            function()
                CS.Lylibs.Splash.Instance:CloseVisible()
            end)
        else
            CS.Lylibs.Splash.Instance:CloseVisible()
        end
    end
end

--析构
function dtor(self)
end

function initData(self)
    self.mFinishCall = nil
    -- （此处进度值和热更界面的代码加载结尾进度值保持一致，整体看起来类似只有一个进度条）
    self.mStartPro = 0.5
    self.mResPro = 0.4
    self.mScenePro = 0.1
end

-- 取父容器
function getParentTrans(self)
	return GameView.loading
end

-- 适应全面屏，刘海缩进
function setAdapta(self)
    local notchHeight = ScreenUtil:getNotchHeight()
    if notchHeight ~= nil then
        local minV = self:getAdaptaTrans().offsetMin;
        minV.x = notchHeight;
        self:getAdaptaTrans().offsetMin = minV;

        local maxV = self:getAdaptaTrans().offsetMax;
        maxV.x = -notchHeight;
        self:getAdaptaTrans().offsetMax = maxV;
    end
end

-- 刘海适配缩放节点
function getAdaptaTrans(self)
    return self.mGroupAdapt
end

-- 初始化
function configUI(self)
    self.mGroupAdapt = self:getChildTrans('GroupAdapt')
    self:getChildGO('mImgBg'):SetActive(false)
    
	self.m_txtState = self:getChildGO('TextState'):GetComponent(ty.Text)
	self.m_txtPro = self:getChildGO('TextProgress'):GetComponent(ty.Text)
	self.m_transImgAct = self:getChildTrans('ImgAct')
    
	self.m_imgProBar = self:getChildTrans('ImgProBar'):GetComponent(ty.Image)
	self.m_imgProBar.fillAmount = self.mStartPro
end

--激活
function active(self)
    super.active(self)
    self:setAdapta()
    AudioManager:stopMusic()
    if (not self.mActionSn) then
        self.mActionSn = LoopManager:addFrame(gs.Application.targetFrameRate == 30 and 1 or 2, 0, self, self.onActionHandler)
    end
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    if (self.mActionSn) then
        LoopManager:removeFrameByIndex(self.mActionSn)
        self.mActionSn = nil
    end
end

function onActionHandler(self, deltaTime)
	if(self:checkCircleVisible())then
        self.m_transImgAct.gameObject:SetActive(true)
        if (not self.m_rotation) then
            self.m_rotation = 360
        else
            if (self.m_rotation <= 0) then
                self.m_rotation = 360 - 2
            else
                self.m_rotation = self.m_rotation - 4
            end
        end
        gs.TransQuick:SetRotation(self.m_transImgAct, 0, 0, self.m_rotation)
	end
end

function checkCircleVisible(self)
	if(self.m_txtPro)then
		if(self.m_txtPro.text == "")then
			self.m_transImgAct.gameObject:SetActive(false)
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
    self.m_txtState.text = state
    self.m_txtPro.text = cusProgress * 100 .. "%"
	self.m_imgProBar.fillAmount = cusProgress
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
