-- module("formation.FormationScene", Class.impl())

-- --构造函数
-- function ctor(self)
-- end

-- function getManager(self)
-- 	return self.m_manager
-- end

-- function setManager(self, cusManager)
-- 	self.m_manager = cusManager
-- end

-- function setCallBack(self, cusCallObj, cusCallFun, ...)
--     if select("#", ...) > 0 then
--         self.m_params = {...}
--     end
--     self.m_callFun = cusCallFun
--     self.m_callObj = cusCallObj
-- end

-- function startLoad(self)
--     AssetLoader.PreLoad("FormationScene2.prefab", self.__onLoadAssetComplete, self)
-- end

-- function __onLoadAssetComplete(self)
--     self:__initData()

--     if (self.m_callFun and self.m_callObj) then
--         -- 调用外部处理
--         if self.m_params then
--             self.m_callFun(self.m_callObj, unpack(self.m_params))
--         else
--             self.m_callFun(self.m_callObj)
--         end
--     end
-- end

-- function __initData(self)
--     -- 对应预制体的名字格式
--     self.m_tileName = "Tile_{0}_{1}"
--     self.m_nodeName = "Node_{0}_{1}"
--     -- 对应C#，格子向上一面的枚举类型
--     self.m_CSharpFaceType = 0
--     -- 对应格子向上一面的默认状态纹理的索引
--     self.m_CSharpTopDefaultIndex = 13
--     -- 阵型格子场景资源名
--     self.m_sceneName = "FormationScene2.prefab"
--     -- 模型字典
--     self.m_modelDic = {}
--     -- 格子字典
--     self.m_tileDic = {}
--     -- 格子激活字典
--     self.m_tileDicAct = {}

--     -- 阵型格子网格场景资源
--     self.m_scene = gs.GOPoolMgr:Get(self.m_sceneName)
--     self.m_sceneGos, self.m_sceneTrans = GoUtil.GetChildHash(self.m_scene)

--     -- 初始化阵型格子字典
--     local formationTileCount, row, col = self:getManager():getFormationTileCount()
--     for col_x = 1, col do
--         for row_y = 1, row do
--             local tileFullName = string.substitute(self.m_tileName, col_x, row_y)
--             local tile = self.m_sceneTrans[tileFullName]
--             local tileAct = self.m_sceneTrans[tileFullName.."_s"]
--             if(not self.m_tileDic[col_x])then
--                 self.m_tileDic[col_x] = {}
--             end
--             self.m_tileDic[col_x][row_y] = tile
--             if(not self.m_tileDicAct[col_x])then
--                 self.m_tileDicAct[col_x] = {}
--             end
--             self.m_tileDicAct[col_x][row_y] = tileAct
--         end
--     end
--     self:reset()
-- end

-- function isLoadComplete(self)
--     return self.m_scene ~= nil
-- end

-- -- 是否为空格子
-- function isEmpty(self, colIndex, rowIndex)
--     return self.m_modelDic[colIndex][rowIndex] == nil
-- end

-- function setData(self, formationConfigList, formationHeroList)
--     for i = 1, #formationConfigList do
--         local pos = formationConfigList[i][1]
--         local col_x = formationConfigList[i][2][1]
--         local row_y = formationConfigList[i][2][2]
--         local tile = self.m_tileDic[col_x][row_y]
--         local tileAct = self.m_tileDicAct[col_x][row_y]
--         tileAct.gameObject:SetActive(true)

--         -- 按照配置将可以站位的格子设置默认状态
--         -- tile:SetFaceIndex(self.m_CSharpFaceType, self.m_CSharpTopDefaultIndex)
--         -- tile:SetFaceIndex(self.m_CSharpFaceType, self:getManager():getGridIndexByColAndRow(col_x, row_y))

--         -- 判断对应站位的格子上是否已有对应的英雄
--         for j = 1, #formationHeroList do
--             local formationHeroVo = formationHeroList[j]
--             if(formationHeroVo.heroPos == pos)then
--                 local nodeFullName = string.substitute(self.m_nodeName, col_x, row_y)
--                 local tileNode = self.m_sceneTrans[nodeFullName]
--                 local addModel = self:addModel(tileNode, formationHeroVo, col_x, row_y)
--                 if(not self.m_modelDic[col_x])then
--                     self.m_modelDic[col_x] = {}
--                 end
--                 self.m_modelDic[col_x][row_y] = addModel
--             end
--         end
--     end
-- end

-- function addModel(self, parent, formationHeroVo, col_x, row_y)
--     local modelPlayer = ModelPlayer:poolGet()
--     modelPlayer:setData({tid = formationHeroVo:getHeroTid(), isMonster = formationHeroVo:getIsMonster(), isEffect = false, weapon = 1, isUIAction = false, finishCall = nil}, nil, nil, 0)
--     modelPlayer:setParent(parent)
--     modelPlayer:setModelLayer("Default")
--     modelPlayer:setRotate(gs.Vector3(-5, 90, -30))
    
--     if(formationHeroVo:getHeroTid() == 1202)then
--         modelPlayer:setScale(1)
--     else
--         modelPlayer:setScale(1.2)
--     end
--     local x, y = 0, 0
--     modelPlayer:setLocalPos(x,  y, -0.8)
--     return modelPlayer
-- end

-- function destroy(self)
--     self:reset()
--     gs.GOPoolMgr:Recover(self.m_scene, self.m_sceneName)
    
--     self.m_scene = nil
--     self.m_sceneGos = nil
--     self.m_sceneTrans = nil
--     self.m_tileDic = nil
--     self.m_tileDicAct = nil
--     self.m_modelDic = nil
-- end

-- function reset(self)
--     -- 将所有格子恢复带序号纹理状态
--     for col_x, dic in pairs(self.m_tileDicAct) do
--         for row_y, tile in pairs(dic) do
--             tile.gameObject:SetActive(false)
--             -- tile:SetFaceIndex(self.m_CSharpFaceType, self:getManager():getGridIndexByColAndRow(col_x, row_y))
--             -- tile:SetFaceIndex(self.m_CSharpFaceType, self.m_CSharpTopDefaultIndex)
--         end
--     end

--     -- 回收所有模型
--     for x, dic in pairs(self.m_modelDic) do
--         for y, modelPlayer in pairs(dic) do
--             modelPlayer:poolRecover()
--             modelPlayer = nil
--         end
--     end
--     self.m_modelDic = {}
-- end

-- return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
