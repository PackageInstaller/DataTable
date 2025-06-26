module("tips.EquipInfoContrastTips", Class.impl(tips.BaseTips))

-- UI预制体名
UIRes = UrlManager:getUIPrefabPath("tips/EquipInfoContrastTips.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
isBlur = 1 -- 是否
isAdapta = 0 -- 是否开启适配刘海 0 否 1 是

function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
end

-- 初始化UI
function configUI(self)
    super.configUI(self)
    self.mNowBg = self:getChildTrans("mNowBg")

    self.mTargetBg = self:getChildTrans("mTargetBg")
    self.mBtnContrast = self:getChildGO("mBtnContrast")
end

function active(self, args)
    super.active(self, args)    
    self.mNowEquipVo = args.now 
    self.mTargetVo = args.target
    self.closeFunc = args.closeFunc

    self:updateView()
end

function addAllUIEvent(self)
    self:addUIEvent(self.mBtnContrast, self.onClickClose)
end

function updateView(self)
    if(self.mNowEquipVo) then
        if (not self.nowEquipTips) then
            self.nowEquipTips = equipBuild.EquipInfoTipsItem:poolGet()
        end
        self.nowEquipTips:setData(self.mNowEquipVo)
        self.nowEquipTips:setParent(self.mNowBg)
    else
        if self.nowEquipTips then
            self.nowEquipTips:poolRecover()
            self.nowEquipTips = nil
        end
    end

    if(self.mTargetVo) then
        if (not self.targetEquipTips) then
            self.targetEquipTips = equipBuild.EquipInfoTipsItem:poolGet()
        end
        self.targetEquipTips:setData(self.mTargetVo, true)
        self.targetEquipTips:setParent(self.mTargetBg)

        self.targetEquipTips:setContrastActive(false)
        self.targetEquipTips:setExchangeActive(true)
    else
        if self.targetEquipTips then
            self.targetEquipTips:poolRecover()
            self.targetEquipTips = nil
        end
    end
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function deActive(self)
    super.deActive(self)
    if self.nowEquipTips then
        self.nowEquipTips:poolRecover()
        self.nowEquipTips = nil
    end

    if self.targetEquipTips then
        self.targetEquipTips:poolRecover()
        self.targetEquipTips = nil
    end
end

return _M