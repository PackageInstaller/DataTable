--[[ 
-----------------------------------------------------
@filename       : DupEquipTabItem
@Description    : 芯片副本页签
@date           : 2021-06-03 16:32:30
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('dup.DupEquipTabItem', Class.impl(BaseReuseItem))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("dupDaily/DupEquipTabItem.prefab")


--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
end

-- 初始化
function configUI(self)
    self.mGroup = self:getChildGO("Group"):GetComponent(ty.RectTransform)
    self.mBtnNomal = self:getChildGO("Group")
    --self.mBtnNomalImg = self.mBtnNomal:GetComponent(ty.AutoRefImage)
    self.mImgSelect = self:getChildGO("mImgSelect")

   
    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mSelectTxtName = self:getChildGO("mSelectTxtName"):GetComponent(ty.Text)
    
    self.mSelectImg = self:getChildGO("mSelectImg"):GetComponent(ty.Image)
    self.mTxtOpen = self:getChildGO("mTxtOpen"):GetComponent(ty.Text)
end

--激活
function active(self)
    super.active(self)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
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
    self:addUIEvent(self.mBtnNomal, self.onNomalClick)
end


function setData(self, cusParent, cusData, cusCallBack, cusThisObject)
    self:setParentTrans(cusParent)
    self.data = cusData
    self.page = cusData.page
    self.callBack = cusCallBack
    self.thisObject = cusThisObject

    self:initBar()
end

function initBar(self)
    self.mTxtName.text = self.data.nomalLanId and _TT(self.data.nomalLanId) or self.data.nomalLan
    self.mSelectTxtName.text = self.data.nomalLanId and _TT(self.data.nomalLanId) or self.data.nomalLan
    
    self.mTxtName.color = gs.ColorUtil.GetColor(self.data.color)
    self.mSelectTxtName.color =  gs.ColorUtil.GetColor(self.data.color)
    self.mSelectImg.color =  gs.ColorUtil.GetColor(self.data.color)

    if table.nums(self.data.openList) == 7 then
        self.mTxtOpen.text = _TT(53625)
    else
        local dateStr = { _TT(53613), _TT(53614), _TT(53615), _TT(53616), _TT(53617), _TT(53618), _TT(53619) }
        local temp = ""
        for i, v in ipairs(self.data.openList) do
            temp = temp .. dateStr[v]
        end
        self.mTxtOpen.text = _TT(53620, temp)
    end

    if self:isOpenDate() then
        self.UIObject:GetComponent(ty.CanvasGroup).alpha = 1
    else
        self.UIObject:SetActive(false)
    end
    self:setSelect(false)
end

function setSelect(self, bool)
    if bool then
        self.mImgSelect:SetActive(true)
        gs.TransQuick:UIPosY(self.mGroup,-23)
    else
        self.mImgSelect:SetActive(false)
        gs.TransQuick:UIPosY(self.mGroup,-43)
    end
end

function updateRed(self, bool)
    if bool then
        RedPointManager:add(self.UITrans, nil, -80, 15)
    else
        RedPointManager:remove(self.UITrans)
    end
end

function onNomalClick(self)
    if not self:isOpenDate() then
        gs.Message.Show(_TT(4525))
        return
    end
    self.callBack(self.thisObject, self.page)
end

-- 是否开放当天
function isOpenDate(self)
    local clientTime = GameManager:getClientTime()
    local t = os.date('*t', clientTime)
    if table.nums(self.data.openList) == 7 then
        return true
    else
        for i, v in ipairs(self.data.openList) do
            if (t.wday == 1 and v == 7) or (t.wday - 1 == v) then
                return true
            end
        end
    end
    return false
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(53625):	"常驻开放"
	语言包: _TT(4525):	"未达副本开放时间"
	语言包: _TT(53619):	"日"
	语言包: _TT(53618):	"六"
	语言包: _TT(53617):	"五"
	语言包: _TT(53616):	"四"
	语言包: _TT(53615):	"三"
	语言包: _TT(53614):	"二"
	语言包: _TT(53613):	"一"
]]
