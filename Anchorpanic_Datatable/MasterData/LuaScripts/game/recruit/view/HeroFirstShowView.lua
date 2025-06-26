--[[ 
-----------------------------------------------------
@filename       : HeroFirstShowView
@Description    : 首次获得战员展示
@date           : 2021-12-16 17:16:23
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.recruit.view.HeroFirstShowView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("recruit/HeroFirstShowView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0 --是否使用黑屏过渡(仅1全屏UI有效，默认开启，0关闭)
isShowBlackBg = 0 --是否显示全屏纯黑防穿帮底图

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setBg("")
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.modelPlayer = ModelScenePlayer.new()
end

--激活
function active(self, args)
    super.active(self, args)
    self.heroTid = args
    self.base_childGos["mGroupTop"]:SetActive(false)

    self:updateModelView()
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:recoverModel(true)
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
    -- self:addUIEvent(self.aa,self.onClick)
end

-- 更新模型
function updateModelView(self)
    -- 不显示模型则放在前面，显示模型则放在模型设置之后
    -- GameDispatcher:dispatchEvent(EventName.OPEN_RECRUIT_SHOW_ONE_VIEW, {tid = self.heroTid})

    local heroVo = hero.HeroManager:getHeroConfigVo(self.heroTid)
    if (heroVo) then
        if(self.isPop == 1)then
            self.modelPlayer:setModelData(heroVo.model, false, true, 1, true, MainCityConst.ROLE_MODE_OVERVIEW, "", self.m_modelClicker, true, nil)
        end
    else
        self:recoverModel(false)
    end
end

function recoverModel(self, isResetMaincity)
    self.modelPlayer:reset(isResetMaincity)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
