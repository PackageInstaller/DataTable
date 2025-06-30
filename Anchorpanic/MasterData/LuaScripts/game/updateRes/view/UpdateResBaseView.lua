module("updateRes.UpdateResBaseView", Class.impl('lib.component.BaseContainer'))

UIRes = ""

--构造函数
function ctor(self)
    super.ctor(self)
end

-- 初始化数据
function initData(self)
    super.initData(self)
    self.m_isOpen = nil
    updateRes.initLayer()
end

-- 打开窗口
function open(self)
	if self.UIObject then
		self.UITrans:SetParent(self:getParentTrans(), false)
        AudioManager:playSoundEffect(UrlManager:getUIBaseSoundPath("ui_basic_popup.prefab"))
		self:active()
	else
		self.m_isOpen = true
	end
end

-- 关闭窗口
function close(self)
	self.m_isOpen = false
	if self.UITrans then
		self.UITrans:SetParent(self:getCacheTrans(), false)
	end
	self:deActive()
end

-- 设置父容器
function getParentTrans(self)
	return ""
end

-- 设置缓存容器
function getCacheTrans(self)
	return updateRes.uiCache
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
    return self.UITrans
end

--初始化UI
function configUI(self)
	super.configUI(self)
end

-- 内部激活，请勿使用
function __active(self, args)
    self:active(args)
end

-- 内部非激活，请勿使用
function __deActive(self)
    self:deActive()
    GameDispatcher:removeAllEvent(self)
end

--激活
function active(self, args)
    super.active(self, args)
end

--非激活
function deActive(self)
    super.deActive(self)
end

-- 移除
function destroy(self)
    if (self.UIRes ~= nil and self.UIRes ~= '') then
        AssetLoader.ReleaseAsset(self.UIRes)
    end
    CS.UnityEngine.GameObject.Destroy(self.UIObject)
    self.UIObject = nil
    self.UITrans = nil

    self.m_childGos = nil
    self.m_childTrans = nil

    self:__deActive()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
