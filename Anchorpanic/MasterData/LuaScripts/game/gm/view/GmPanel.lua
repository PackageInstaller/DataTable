--[[ 
-----------------------------------------------------
@filename       : GMPanel
@Description    : GM面板
@date           : 2022-2-22 
@Author         : lyx
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('gm.GmPanel', Class.impl(TabView))

UIRes = UrlManager:getUIPrefabPath('gm/GmPanel.prefab')
destroyTime = 0 -- 自动销毁时间-1默认
-- panelType = 2 -- 窗口类型 1 全屏 2 弹窗
panelType = -1
isBlur = 1 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(0, 0)
    self:setTxtTitle('GM')

    self:setScrollerSize(230, 500)
    self:setTabBtnPos(370, 270)
end

-- 初始化数据
function initData(self)
    super.initData(self)
end

function configUI(self)
    super.configUI(self)
end

-- 设置UI节点
function getParentTrans(self)
    return GameView.msg
end

function active(self)
    super.active(self)
end

function deActive(self)
    super.deActive(self)
end

function isHorizon(self)
    return false
end

-- 获取右侧面板数据
function getTabDatas(self)
    self.tabDataList[1] = TabData:poolGet():setData(204, 54, "GM", UrlManager:getCommon5Path("common_0172.png"), UrlManager:getCommon5Path("common_0171.png"), nil, nil, "GM", nil, nil, nil, nil, nil, true)
    self.tabDataList[2] = TabData:poolGet():setData(204, 54, "添加道具", UrlManager:getCommon5Path("common_0172.png"), UrlManager:getCommon5Path("common_0171.png"), nil, nil, "ITEM", nil, nil, nil, nil, nil, true)
    self.tabDataList[3] = TabData:poolGet():setData(204, 54, "DOWNLOAD", UrlManager:getCommon5Path("common_0172.png"), UrlManager:getCommon5Path("common_0171.png"), nil, nil, "DOWNLOAD", nil, nil, nil, nil, nil, true)
    self.tabDataList[4] = TabData:poolGet():setData(204, 54, "FIGHT", UrlManager:getCommon5Path("common_0172.png"), UrlManager:getCommon5Path("common_0171.png"), nil, nil, "FIGHT", nil, nil, nil, nil, nil, true)
    self.tabDataList[5] = TabData:poolGet():setData(204, 54, "GUIDE", UrlManager:getCommon5Path("common_0172.png"), UrlManager:getCommon5Path("common_0171.png"), nil, nil, "GUIDE", nil, nil, nil, nil, nil, true)
    self.tabDataList[6] = TabData:poolGet():setData(204, 54, "FLY_TEXT", UrlManager:getCommon5Path("common_0172.png"), UrlManager:getCommon5Path("common_0171.png"), nil, nil, "FLY_TEXT", nil, nil, nil, nil, nil, true)
    self.tabDataList[7] = TabData:poolGet():setData(204, 54, "LUA", UrlManager:getCommon5Path("common_0172.png"), UrlManager:getCommon5Path("common_0171.png"), nil, nil, "LUA", nil, nil, nil, nil, nil, true)
    self.tabDataList[8] = TabData:poolGet():setData(204, 54, "VIDEO", UrlManager:getCommon5Path("common_0172.png"), UrlManager:getCommon5Path("common_0171.png"), nil, nil, "VIDEO", nil, nil, nil, nil, nil, true)
    self.tabDataList[9] = TabData:poolGet():setData(204, 54, "DELTALIST", UrlManager:getCommon5Path("common_0172.png"), UrlManager:getCommon5Path("common_0171.png"), nil, nil, "DELTALIST", nil, nil, nil, nil, nil, true)
    return self.tabDataList
end

-- 获取对应标签的类
function getTabClass(self)
    self.tabClassDic["GM"] = gm.GmTabView
    self.tabClassDic["ITEM"] = gm.GmPropsView
    self.tabClassDic["DOWNLOAD"] = gm.DownLoadTabView
    self.tabClassDic["FIGHT"] = gm.FightTabView
    self.tabClassDic["GUIDE"] = gm.GuideTabView
    self.tabClassDic["FLY_TEXT"] = gm.FlyTextTabView
    self.tabClassDic["LUA"] = gm.LuaTabView
    self.tabClassDic["VIDEO"] = gm.VideoTabView
    self.tabClassDic["DELTALIST"] = gm.TestDeltaListTabView
    return self.tabClassDic
end

--打开窗口
function open(self)
    super.open(self)
end

function close(self)
    super.close(self)
end
 
function destroyPanel(self)
    super.destroyPanel(self)
end

return _M
  
--[[ 替换语言包自动生成，请勿修改！
]]
