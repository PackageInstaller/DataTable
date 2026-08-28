--
-- Author:luqucheng
-- Date: 2019-12-26 13:42:00
--
local MonoHelper = CS.Engine.Lib.MonoHelper
local ProjectileBase = Class("ProjectileBase")
local cs_coroutine = import('XLua.cs_coroutine')
--@RefType [Game.Setting.Vo.BulletVo#BulletVo]
ProjectileBase.bulletVo = nil
--@RefType: [Game.BattleView.Entity.RoleView#RoleView]
ProjectileBase.target = nil
--@RefType: [Game.BattleView.Entity.RoleView#RoleView]
ProjectileBase.attacker = nil
ProjectileBase.OnHit = nil

ProjectileBase.model = nil
ProjectileBase.aim = nil--模型为了瞄准的点,用来计算偏移
ProjectileBase.bulletObj = nil
ProjectileBase.FXId = nil
ProjectileBase.startPos = nil

ProjectileBase.needUpdate = nil

ProjectileBase.src = nil
ProjectileBase.dst = nil
ProjectileBase.time = nil
ProjectileBase.nowTime = nil

ProjectileBase.offset = nil
ProjectileBase.co = nil
ProjectileBase.isAoe = nil

function  ProjectileBase:__init( bulletVo, target, attacker, OnHit, isAoe, isRandomPos )
    self.bulletVo = bulletVo
    self.target = target
    self.attacker = attacker
    self.OnHit = OnHit
    self.dv = Vector3.New()
    self.totalOffset = Vector3.New()
    self.needUpdate = false
    self.isAoe = isAoe
    --创建子弹
    local obj = CS.UnityEngine.GameObject(tostring(bulletVo.id))
    obj.transform:SetParent(BattleViewMgr.rootNode.transform)
    local id = -1
    -- print("GetBulletObject", bulletVo.boneName, bulletVo.FX)
    --判断是模型子弹还是特效子弹
    if bulletVo:IsBoneBullet() then
        local model = attacker.gameObject:FindGameObjectByName(bulletVo.boneName)
        -- local aim = model:FindGameObjectByName("tou_hit")
        assert(model, "找不到模型子弹, boneName:"..bulletVo.boneName .. "  bullet:"..bulletVo.id)
        self.model = model
        -- self.aim = aim
        self.startPos = model.transform.position
        self.__lateUpdateHandle = Bind(self, self.LateUpdate)
        MonoHelper.AddLateUpdateListener(self.__lateUpdateHandle)
    else
        --添加特效
        id = BattleViewMgr.FXMgr:PlayFX(bulletVo.FX, obj, 1000)
        self.startPos = attacker:GetShotPosition()
    end
    self.bulletObj = obj
    self.FXId = id 

    self:SetOffsetPosition(isRandomPos)
end

function ProjectileBase:GetStartPosition( )
    local bulletVo = self.bulletVo
    local attacker = self.attacker
    --判断是模型子弹还是特效子弹
    if bulletVo:IsBoneBullet() then
        return attacker.gameObject:FindGameObjectByName(bulletVo.boneName).transform.position
    else
        return attacker:GetShotPosition()
    end 
end

function ProjectileBase:GetTargetPosition(  )
    local bulletVo = self.bulletVo
    local target = self.target
    local attacker = self.attacker

    -- if bulletVo:IsBoneBullet() then
        
    -- else
    --     return target:GetOffsetPosition(target.modelVo.bulletHitPos)
    -- end


    local offset = Quaternion.MulVec3(attacker.transform.localRotation, bulletVo.targetOffsetPos)
    if self.isAoe then
        -- offset:Add(BattleViewMgr:GetAoe(target.camp).transform.position)
        -- return BattleViewMgr:GetAoe(target.camp).transform.position
        offset:Add(BattleViewMgr:GetAoe(target.camp).transform.position)

    else
        local hitOffset = Quaternion.MulVec3(target.transform.localRotation, target.modelVo.bulletHitPos)
        offset:Add(hitOffset)
        offset:Add(target.transform.position)
    end
    
    return offset
end

function ProjectileBase:SetOffsetPosition( isRandom )
    --设置偏移点，判断是否随机
    local target = self.target
    local modelOffset = target.modelVo.bulletHitPos
    if isRandom then
        --一定范围内随机，只随机x和y轴
        --方便起见就不用圆形范围了
        local randomX = math.random() * Constants.BulletRandomOffsetEdge * 2  - Constants.BulletRandomOffsetEdge
        local randomY = math.random() * Constants.BulletRandomOffsetEdge * 2  - Constants.BulletRandomOffsetEdge
        self.offset = Vector3.New(modelOffset.x + randomX, modelOffset.y + randomY, modelOffset.z )
    else
        self.offset = modelOffset:Clone()
    end
end

function ProjectileBase:SetMove( src, dst, time )
    if self.bulletVo:IsBoneBullet() then
        self.src = src
        self.dst = dst
        self.time = time
        self.nowTime = 0
        self.needUpdate = true
    else
        self.bulletObj.transform:DOMove( dst, time )
    end
end

function ProjectileBase:ResetPosition(  )
    self.needUpdate = false
    --复位
    if self.bulletVo:IsBoneBullet() and self.model then
        self.model.transform.position = self.startPos
    end
end

function ProjectileBase:LateUpdate(  )
    --判断偏移
    if not self.needUpdate then
        if self.__lateUpdateHandle then
            MonoHelper.RemoveLateUpdateListener(self.__lateUpdateHandle)
            self.__lateUpdateHandle = nil
        end
        return
    end
    if isNull(self.model) then
        return
    end
    local dt = CS.UnityEngine.Time.deltaTime
    -- local s = self.startPos
    -- local p = self.model.transform.position
    -- local offset = Vector3.New(p.x - s.x, p.y - s.y, p.z - s.z)
    -- self.model.transform.position = Vector3.New(self.bulletObj.transform.position.x, self.model.transform.position.y, self.bulletObj.transform.position.z) --offset:Add()
    -- 
    -- self.totalOffset:Add(self.dv:Clone():Mul(dt))
    -- -- print("LateUpdate", self.dv.x, self.dv.y, self.dv.z, dt)
    -- local v = self.totalOffset:Clone():Add(self.model.transform.position)
    -- self.model.transform.position = Vector3.New(v.x, self.model.transform.position.y, v.z)

    self.nowTime = self.nowTime + dt
    if self.nowTime >= self.time then
        self.nowTime = self.time
        -- self.needUpdate = false
    end
    local offset = Vector3.Lerp(self.src, self.dst, self.nowTime / self.time )
    self.model.transform.position = Vector3.New(offset.x, self.model.transform.position.y, offset.z)

    --偏移退回位置
    -- local offset = Vector3.New()
    -- offset:Add(self.model.transform.position)
    -- self.model.transform.position = offset:Sub(self.aim.transform.position):Add(self.model.transform.position)
    -- self.model.transform.position = self.bulletObj.transform.positions
    -- self.model.transform.localPosition = self.modelLocalOffset:Clone():Add(self.model.transform.localPosition)
end

function ProjectileBase:Dipose()
    if self.isDisposed then
        return
    end

    if self.co then
        cs_coroutine.stop(self.co)
        self.co = nil
    end
    -- print("__delete")
    --判断是模型子弹还是特效子弹
    if self.bulletVo:IsBoneBullet() and self.__lateUpdateHandle then
        MonoHelper.RemoveLateUpdateListener(self.__lateUpdateHandle)
        self.__lateUpdateHandle = nil
        
    else
        BattleViewMgr.FXMgr:RemoveFX(self.FXId)
    end
    if self.bulletObj then
        CS.UnityEngine.GameObject.Destroy(self.bulletObj)
    end
    -- self.bulletObj:Destroy()
    self.model = nil
    self.bulletObj = nil
    self.FXId = nil 
    self.attacker = nil
    self.target = nil
    self.OnHit = nil
    self.bulletVo = nil
    self.isDisposed = true
end

return  ProjectileBase