--[[ 
-----------------------------------------------------
@filename       : ManualPanel
@Description    : 图鉴主界面
@date           : 2022-2-22 10:25:00->2023-3-6 10:25:00
@Author         : Zzz->Shuai
@copyright      : (LY) 2020->2023 雷焰网络
-----------------------------------------------------
]]
module("manual.ManualPanel", Class.impl(View))
UIRes = UrlManager:getUIPrefabPath("manual/ManualPanel.prefab")
destroyTime = -1 -- 自动销毁时间-1默认
panelType = 1 -- 窗口类型 1 全屏 2 弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle(_TT(70004))
    self:setBg("common_bg_020.jpg", false)
    self:setUICode(LinkCode.Manual)
end

function initData(self)
    super.initData(self)
end

-- 初始化
function configUI(self)
    super.configUI(self)
end

function initViewText(self)
    --for viewType, value in pairs(manual.getMainBtnList()) do
    --    self:updateBtnInfo()
    --end
end

function addAllUIEvent(self)
    for viewType, btnVo in pairs(manual.getMainBtnList()) do
        self:addUIEvent(self:getChildGO(btnVo.btnName), self.onClickOpenView, nil, { viewType = viewType, funcopenId = btnVo.funcopen_id })
    end
end

-- 激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({})
    GameDispatcher:addEventListener(EventName.UPDATE_MAZE_PANEL_DATA, self.onUpdateMazeDataHandler, self)
    self:updateView()
end

-- 非激活
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.UPDATE_MAZE_PANEL_DATA, self.onUpdateMazeDataHandler, self)
    MoneyManager:setMoneyTidList()
end

function onUpdateMazeDataHandler(self)
    self:updateView()
end

function updateView(self)
    for _, btnVo in pairs(manual.getMainBtnList()) do
        self:updateBtnInfo(self:getChildGO(btnVo.btnName), btnVo.progress, btnVo.funcopen_id, btnVo.nomalLan, btnVo.isNew)
    end
end

function onClickOpenView(self, args)
    if args.funcopenId == "" or funcopen.FuncOpenManager:isOpen(args.funcopenId, true) == false then
        if args.funcopenId == "" then
            gs.Message.Show(_TT(1021))
        end
        return
    end
    GameDispatcher:dispatchEvent(EventName.OPEN_MANUAL_PANEL, { type = args.viewType, subType = 1 })
end

function updateBtnInfo(self, btn, txtpro, funcopenId, name, isNew)
    local tempBtn = SimpleInsItem:create2(btn)
    tempBtn:getChildGO("mImgUnlock"):SetActive(false)
    tempBtn:getChildGO("mImgNameBg"):SetActive(true)
    tempBtn:getChildGO("mNewTans"):SetActive(isNew)
    tempBtn:getChildGO("mTxtProgress"):GetComponent(ty.Text).text = txtpro .. "%"
    tempBtn:getChildGO("mTxtUnlock"):GetComponent(ty.Text).text = _TT(25204)
    tempBtn:getGo():GetComponent(ty.AutoRefImage).alphaHitTestMinimumThreshold = 0.5
    tempBtn:getChildGO("Text"):GetComponent(ty.Text).text = name
    tempBtn:getGo():GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor("FFFFFFFF")
    tempBtn:getChildGO("Text"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("FFFFFFFF")
    tempBtn:getChildGO("mTxtProgress"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("FFFFFFFF")
    if funcopenId == "" or funcopen.FuncOpenManager:isOpen(funcopenId, false) == false then
        tempBtn:getChildGO("mImgUnlock"):SetActive(true)
        tempBtn:getChildGO("mImgNameBg"):SetActive(false)
        tempBtn:getGo():GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor("2F353Cff")
    end
    --self:setBtnLabel(btn, 1022, "角色档案")
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]