--[[ 
-----------------------------------------------------
@filename       : ValveGameView
@Description    : 剧情游戏——阀门游戏
@date           : 2020-12-28 11:18:41
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('game.storyGame.view.ValveGameView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("storyGame/ValveGameView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    -- self:setInnerOffset(0, 0, 0, 0)
    -- self:setTxtTitle('')
    -- self:setContentBg("")
end
--析构  
function dtor(self)
end

function initData(self)
    self.lightNum = 0
    self.maxLight = 7
    self.speed = 4
end

-- 初始化
function configUI(self)
    self.mImgRota = self:getChildGO("mImgValve"):GetComponent(ty.LongPressOrClickEventTrigger)
    self.mImgValve = self:getChildTrans("mImgValve")
    self.mImgError = self:getChildGO("mImgError"):GetComponent(ty.CanvasGroup)

    for i = 1, self.maxLight do
        local img = self:getChildGO("mImgLight" .. i):GetComponent(ty.Image)
        img:SetImg(UrlManager:getCommon5Path("common_0050.png"))
    end
end

--激活
function active(self)
    super.active(self)
    self.changeValue = 0

    -- 左区域
    local function _onBeginPress()
        self:onBeginPressHandler()
    end
    self.mImgRota.onLongPress:AddListener(_onBeginPress)

    local function _onEndPress()
        self:onEndPressHandler()
    end
    self.mImgRota.onPointerUp:AddListener(_onEndPress)

end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.mImgRota.onLongPress:RemoveAllListeners()
    self.mImgRota.onPointerUp:RemoveAllListeners()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
end

function onBeginPressHandler(self)
    self.dir = -1

    self.localEluer = self.mImgValve.localEulerAngles
    self.goPos = gs.CameraMgr:WorldToScreenByUICamera(self.mImgRota.transform.position)
    self.startPos = gs.Input.mousePosition
    LoopManager:addFrame(1, 0, self, self.frameUpdate)
end

function onEndPressHandler(self)
    LoopManager:removeFrame(self, self.frameUpdate)
end

function frameUpdate(self)
    local mousePos = gs.Input.mousePosition
    local sp = self.startPos - self.goPos
    local ep = mousePos - self.goPos
    local rotateAngle = gs.Vector3.Angle(sp, ep)

    if (rotateAngle ~= 0) then
        local q = gs.Quaternion.FromToRotation(sp, ep)
        local k = q.z > 0 and 1 or -1
        self.dir = k

        if (self.dir == -1 and self.lightNum >= self.maxLight) or (self.dir == 1 and self.lightNum < 1 and math.abs(self.changeValue) <= 0) then
            LoopManager:removeFrame(self, self.frameUpdate)

            TweenFactory:canvasGroupAlphaTo(self.mImgError, 0, 0.1, 0.1, nil, function()
                TweenFactory:canvasGroupAlphaTo(self.mImgError, 0.1, 0, 0.1, nil, function()
                    TweenFactory:canvasGroupAlphaTo(self.mImgError, 0, 0.1, 0.1, nil, function()
                        TweenFactory:canvasGroupAlphaTo(self.mImgError, 0.1, 0, 0.1)
                    end)
                end)
            end)

            return
        end

        self.localEluer.z = self.localEluer.z + k * self.speed
        self.mImgValve.localEulerAngles = self.localEluer
        self.startPos = mousePos

        self.changeValue = self.changeValue + k * self.speed
    end

    if math.abs(self.changeValue) >= 360 then
        self.changeValue = 0

        if self.dir == -1 then
            self.lightNum = self.lightNum + 1
        end

        local img = self:getChildGO("mImgLight" .. self.lightNum):GetComponent(ty.Image)
        if self.dir == -1 then
            img:SetImg(UrlManager:getCommon5Path("common_0051.png"), false)
        else
            img:SetImg(UrlManager:getCommon5Path("common_0050.png"), false)
            self.lightNum = self.lightNum - 1
        end

        if self.lightNum >= self.maxLight then
            LoopManager:removeFrame(self, self.frameUpdate)
            self:setTimeout(0.5, function()
                self:close()
                UIFactory:alertMessge("完成啦，好开心啊！恭喜恭喜啊~ 你好棒棒啊~", true)
            end)
        end
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
