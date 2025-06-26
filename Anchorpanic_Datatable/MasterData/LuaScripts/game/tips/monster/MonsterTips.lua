module("tips.MonsterTips", Class.impl(tips.BaseTips))

UIRes = UrlManager:getUIPrefabPath("tips/MonsterTips.prefab")

--构造函数
function ctor(self)
    super.ctor(self)
end

--析构函数
function dtor(self)
    super.dtor(self)
end

--初始化UI
function configUI(self)
    super.configUI(self)
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

-- 初始化数据
function initData(self)
    -- 回收头像格子
    if (self.m_headGrid) then
        self.m_headGrid:poolRecover()
        self.m_headGrid = nil
    end
    self.m_monsterVo = nil
    self.m_instance = nil
end

function __getInstance(self)
    if (self.m_instance == nil) then
        self.m_instance = tips.MonsterTips.new()
    else
        if (self.m_instance.isPop == 0) then
            self.m_instance:loadAsset()
        end
    end
    return self.m_instance
end

function showTips(self, cusMonsterVo)
    if (not cusMonsterVo) then
        Debug:log_warn("MonsterTips", "数据Vo为空")
        return
    end
    local instance = self:__getInstance()
    instance.m_monsterVo = cusMonsterVo
    instance:__updateView()
    instance:open()
end

function __updateView(self)
    self:__updateGrid()
end

function __updateGrid(self)
    local element_1 = self.m_childTrans["m_element_1"]
    if (not self.m_headGrid) then
        self.m_headGrid = MonsterHeadGrid:poolGet()
    end
    self.m_headGrid:setData(self.m_monsterVo)
    self.m_headGrid:setParent(element_1)
    self.m_headGrid:setClickEnable(false)
    self.m_headGrid:setName("")
    self.m_headGrid:setPosition(gs.Vector3(-130, 0, 0))

    self.m_childTrans["mTxtName"]:GetComponent(ty.Text).text = self.m_monsterVo.name
    self.m_childTrans["m_textLvl"]:GetComponent(ty.Text).text = "Lv."..self.m_monsterVo.lvl
    self.m_childTrans["m_textDes"]:GetComponent(ty.Text).text = _TT(4058, self.m_monsterVo.des)
end

function onClose(self)
    super.onClose(self)
end

-- 在资源销毁前，对需要回收的资源进行回收处理
function recover(self)
    super.recover(self)
    self:initData()
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
