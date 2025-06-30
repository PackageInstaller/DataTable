module("welfareOpt.pop.WelfareOptFightSupplyProView", Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("welfareOpt/pop/WelfareOptFightSupplyProView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(1114, 651)
end

--析构
function dtor(self)
end


function initData(self)
    self.m_itemList = {}
    self.m_type = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)
    self.mTxtTitle = self:getChildGO('mTxtTitle'):GetComponent(ty.Text)
    self.mTxtTips = self:getChildGO('mTxtTips'):GetComponent(ty.Text)
    self.mContent = self:getChildTrans('Content')
    self.mContentRect = self:getChildGO('Content'):GetComponent(ty.RectTransform)
end

-- 激活
function active(self, args)
    super.active(self, args)

    self.m_type = args.type

    self:setData()
end
-- 非激活
function deActive(self)
    super.deActive(self)
    self:__recyAllItem()
end

function initViewText(self)
    self.mTxtTitle.text = _TT(28011) --"招募规则"
end

function addAllUIEvent(self)
end

function __recyAllItem(self)
    if self.m_itemList then
        for i, v in pairs(self.m_itemList) do
            v:poolRecover()
        end
    end
    self.m_itemList = {}
    gs.TransQuick:UIPos(self.mContentRect, 0, 0)
end

function setData(self)
    self:__recyAllItem()
    local dic,des = welfareOpt.WelfareOptManager:getDataFightSupplyColorData(self.m_type)
    self.mTxtTips.text = _TT(des)
    local item = welfareOpt.WelfareOptFightSupplyItem:poolGet()
    item:setData(self.mContent, dic)
    table.insert(self.m_itemList, item)
    
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
