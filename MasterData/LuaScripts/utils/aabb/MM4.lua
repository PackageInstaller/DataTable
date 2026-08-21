module("MM4", Class.impl())

function create(self,m00,m01,m02,m03,m10,m11,m12,m13,m20,m21,m22,m23,m30,m31,m32,m33)
    self.m00 = m00
    self.m01 = m01
    self.m02 = m02
    self.m03 = m03

    self.m10 = m10
    self.m11 = m11
    self.m12 = m12
    self.m13 = m13

    self.m20 = m20
    self.m21 = m21
    self.m22 = m22
    self.m23 = m23
    
    self.m30 = m30
    self.m31 = m31
    self.m32 = m32
    self.m33 = m33
end


return _M