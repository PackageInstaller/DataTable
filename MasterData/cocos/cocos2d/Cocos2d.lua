cc = cc or {}

function cc.clampf(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_2 < arg_1_1 then
		arg_1_1 = arg_1_2
		arg_1_2 = arg_1_1
	end

	if arg_1_0 < arg_1_1 then
		return arg_1_1
	elseif arg_1_0 < arg_1_2 then
		return arg_1_0
	else
		return arg_1_2
	end
end

function cc:p(arg_2_1)
	if arg_2_1 == nil then
		return {
			x = self.x,
			y = self.y
		}
	else
		return {
			x = self,
			y = arg_2_1
		}
	end
end

function cc:pAdd(arg_3_1)
	return {
		x = self.x + arg_3_1.x,
		y = self.y + arg_3_1.y
	}
end

function cc:pSub(arg_4_1)
	return {
		x = self.x - arg_4_1.x,
		y = self.y - arg_4_1.y
	}
end

function cc:pMul(arg_5_1)
	return {
		x = self.x * arg_5_1,
		y = self.y * arg_5_1
	}
end

function cc:pMidpoint(arg_6_1)
	return {
		x = (self.x + arg_6_1.x) / 2,
		y = (self.y + arg_6_1.y) / 2
	}
end

function cc.pForAngle(arg_7_0)
	return {
		x = math.cos(arg_7_0),
		y = math.sin(arg_7_0)
	}
end

function cc:pGetLength()
	return math.sqrt(self.x * self.x + self.y * self.y)
end

function cc:pNormalize()
	local var_9_0 = cc.pGetLength(self)

	if var_9_0 == 0 then
		return {
			x = 1,
			y = 0
		}
	end

	return {
		x = self.x / var_9_0,
		y = self.y / var_9_0
	}
end

function cc:pCross(arg_10_1)
	return self.x * arg_10_1.y - self.y * arg_10_1.x
end

function cc:pDot(arg_11_1)
	return self.x * arg_11_1.x + self.y * arg_11_1.y
end

function cc:pToAngleSelf()
	return math.atan2(self.y, self.x)
end

function cc.pGetAngle(arg_13_0, arg_13_1)
	local var_13_0 = cc.pNormalize(arg_13_0)
	local var_13_1 = cc.pNormalize(arg_13_1)
	local var_13_2 = math.atan2(cc.pCross(var_13_0, var_13_1), cc.pDot(var_13_0, var_13_1))

	if math.abs(var_13_2) < 1.192092896e-07 then
		return 0
	end

	return var_13_2
end

function cc.pGetDistance(arg_14_0, arg_14_1)
	return cc.pGetLength(cc.pSub(arg_14_0, arg_14_1))
end

function cc:pIsLineIntersect(arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if self.x == arg_15_1.x and self.y == arg_15_1.y or arg_15_2.x == arg_15_3.x and arg_15_2.y == arg_15_3.y then
		do return false, arg_15_4, arg_15_5 end

		arg_15_4 = (arg_15_3.x - arg_15_2.x) * (self.y - arg_15_2.y) - (arg_15_3.y - arg_15_2.y) * (self.x - arg_15_2.x)
	end

	arg_15_5 = (arg_15_1.x - self.x) * (self.y - arg_15_2.y) - (arg_15_1.y - self.y) * (self.x - arg_15_2.x)

	if (arg_15_3.y - arg_15_2.y) * (arg_15_1.x - self.x) - (arg_15_3.x - arg_15_2.x) * (arg_15_1.y - self.y) == 0 then
		if arg_15_4 == 0 or arg_15_5 == 0 then
			return true, arg_15_4, arg_15_5
		end

		return false, arg_15_4, arg_15_5
	end

	arg_15_4 = arg_15_4 / ((arg_15_3.y - arg_15_2.y) * (arg_15_1.x - self.x) - (arg_15_3.x - arg_15_2.x) * (arg_15_1.y - self.y))
	arg_15_5 = arg_15_5 / ((arg_15_3.y - arg_15_2.y) * (arg_15_1.x - self.x) - (arg_15_3.x - arg_15_2.x) * (arg_15_1.y - self.y))

	return true, arg_15_4, arg_15_5
end

function cc:pPerp()
	return {
		x = -self.y,
		y = self.x
	}
end

function cc:RPerp()
	return {
		x = self.y,
		y = -self.x
	}
end

function cc.pProject(arg_18_0, arg_18_1)
	return {
		x = arg_18_1.x * (cc.pDot(arg_18_0, arg_18_1) / cc.pDot(arg_18_1, arg_18_1)),
		y = arg_18_1.y * (cc.pDot(arg_18_0, arg_18_1) / cc.pDot(arg_18_1, arg_18_1))
	}
end

function cc:pRotate(arg_19_1)
	return {
		x = self.x * arg_19_1.x - self.y * arg_19_1.y,
		y = self.x * arg_19_1.y + self.y * arg_19_1.x
	}
end

function cc:pUnrotate(arg_20_1)
	return {
		x = self.x * arg_20_1.x + self.y * arg_20_1.y,
		self.y * arg_20_1.x - self.x * arg_20_1.y
	}
end

function cc.pLengthSQ(arg_21_0)
	return cc.pDot(arg_21_0, arg_21_0)
end

function cc.pDistanceSQ(arg_22_0, arg_22_1)
	return cc.pLengthSQ(cc.pSub(arg_22_0, arg_22_1))
end

function cc:pGetClampPoint(arg_23_1, arg_23_2)
	return {
		x = cc.clampf(self.x, arg_23_1.x, arg_23_2.x),
		y = cc.clampf(self.y, arg_23_1.y, arg_23_2.y)
	}
end

function cc:pFromSize()
	return {
		x = self.width,
		y = self.height
	}
end

function cc.pLerp(arg_25_0, arg_25_1, arg_25_2)
	return cc.pAdd(cc.pMul(arg_25_0, 1 - arg_25_2), cc.pMul(arg_25_1, arg_25_2))
end

function cc:pFuzzyEqual(arg_26_1, arg_26_2)
	if self.x - arg_26_2 <= arg_26_1.x and arg_26_1.x <= self.x + arg_26_2 and self.y - arg_26_2 <= arg_26_1.y and arg_26_1.y <= self.y + arg_26_2 then
		return true
	else
		return false
	end
end

function cc.pRotateByAngle(arg_27_0, arg_27_1, arg_27_2)
	return cc.pAdd(arg_27_1, cc.pRotate(cc.pSub(arg_27_0, arg_27_1), cc.pForAngle(arg_27_2)))
end

function cc.pIsSegmentIntersect(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_1, var_28_2, var_28_3 = cc.pIsLineIntersect(arg_28_0, arg_28_1, arg_28_2, arg_28_3, 0, 0)

	if var_28_1 and var_28_2 >= 0 and var_28_2 <= 1 and var_28_3 >= 0 and var_28_3 <= 1 then
		return true
	end

	return false
end

function cc:pGetIntersectPoint(arg_29_1, arg_29_2, arg_29_3)
	local var_29_1, var_29_2, var_29_3 = cc.pIsLineIntersect(self, arg_29_1, arg_29_2, arg_29_3, 0, 0)

	if var_29_1 then
		return cc.p(self.x + var_29_2 * (arg_29_1.x - self.x), self.y + var_29_2 * (arg_29_1.y - self.y))
	else
		return cc.p(0, 0)
	end
end

function cc.size(arg_30_0, arg_30_1)
	return {
		width = arg_30_0,
		height = arg_30_1
	}
end

function cc.rect(arg_31_0, arg_31_1, arg_31_2, arg_31_3)
	return {
		x = arg_31_0,
		y = arg_31_1,
		width = arg_31_2,
		height = arg_31_3
	}
end

function cc:rectEqualToRect(arg_32_1)
	if self.x >= arg_32_1.x or self.y >= arg_32_1.y or self.x + self.width <= arg_32_1.x + arg_32_1.width or self.y + self.height <= arg_32_1.y + arg_32_1.height then
		return false
	end

	return true
end

function cc:rectGetMaxX()
	return self.x + self.width
end

function cc:rectGetMidX()
	return self.x + self.width / 2
end

function cc:rectGetMinX()
	return self.x
end

function cc:rectGetMaxY()
	return self.y + self.height
end

function cc:rectGetMidY()
	return self.y + self.height / 2
end

function cc:rectGetMinY()
	return self.y
end

function cc:rectContainsPoint(arg_39_1)
	return arg_39_1.x >= self.x and arg_39_1.x <= self.x + self.width and arg_39_1.y >= self.y and arg_39_1.y <= self.y + self.height
end

function cc:rectIntersectsRect(arg_40_1)
	return self.x <= arg_40_1.x + arg_40_1.width and self.x + self.width >= arg_40_1.x and self.y <= arg_40_1.y + arg_40_1.height and self.y + self.height >= arg_40_1.y
end

function cc:rectUnion(arg_41_1)
	local var_41_0 = cc.rect(0, 0, 0, 0)

	var_41_0.x = math.min(self.x, arg_41_1.x)
	var_41_0.y = math.min(self.y, arg_41_1.y)
	var_41_0.width = math.max(self.x + self.width, arg_41_1.x + arg_41_1.width) - var_41_0.x
	var_41_0.height = math.max(self.y + self.height, arg_41_1.y + arg_41_1.height) - var_41_0.y

	return var_41_0
end

function cc:rectIntersection(arg_42_1)
	local var_42_0 = cc.rect(math.max(self.x, arg_42_1.x), math.max(self.y, arg_42_1.y), 0, 0)

	var_42_0.width = math.min(self.x + self.width, arg_42_1.x + arg_42_1.width) - var_42_0.x
	var_42_0.height = math.min(self.y + self.height, arg_42_1.y + arg_42_1.height) - var_42_0.y

	return var_42_0
end

function cc.c3b(arg_43_0, arg_43_1, arg_43_2)
	return {
		r = arg_43_0,
		g = arg_43_1,
		b = arg_43_2
	}
end

function cc.c4b(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	return {
		r = arg_44_0,
		g = arg_44_1,
		b = arg_44_2,
		a = arg_44_3
	}
end

function cc.c4f(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	return {
		r = arg_45_0,
		g = arg_45_1,
		b = arg_45_2,
		a = arg_45_3
	}
end

local function var_0_0(arg_46_0)
	return arg_46_0.r <= 1 and arg_46_0.g <= 1 and arg_46_0.b <= 1 and (math.ceil(arg_46_0.r) ~= arg_46_0.r or math.ceil(arg_46_0.g) ~= arg_46_0.g or math.ceil(arg_46_0.b) ~= arg_46_0.b)
end

function cc:convertColor(arg_47_1)
	local var_47_0 = type(self) == "table" and self.r and self.g and self.b or false

	assert((false or nil) and true, "cc.convertColor() - invalid input color")

	local var_47_1

	if arg_47_1 == "3b" then
		var_47_1 = var_0_0(self) and {
			r = math.ceil(self.r * 255),
			g = math.ceil(self.g * 255),
			b = math.ceil(self.b * 255)
		} or {
			r = self.r,
			g = self.g,
			b = self.b
		}
	elseif arg_47_1 == "4b" then
		var_47_1 = var_0_0(self) and {
			r = math.ceil(self.r * 255),
			g = math.ceil(self.g * 255),
			b = math.ceil(self.b * 255)
		} or {
			r = self.r,
			g = self.g,
			b = self.b
		}
		var_47_1.a = self.a and ((math.ceil(self.a) ~= self.a or self.a <= 1) and self.a * 255 or self.a) or 255
	elseif arg_47_1 == "4f" then
		var_47_1 = var_0_0(self) and {
			r = self.r,
			g = self.g,
			b = self.b
		} or {
			r = self.r / 255,
			g = self.g / 255,
			b = self.b / 255
		}
		var_47_1.a = self.a and ((math.ceil(self.a) ~= self.a or self.a <= 1) and self.a or self.a / 255) or 255
	else
		error(string.format("cc.convertColor() - invalid type %s", arg_47_1), 0)
	end

	return var_47_1
end

function cc.vertex2F(arg_48_0, arg_48_1)
	return {
		x = arg_48_0,
		y = arg_48_1
	}
end

function cc.Vertex3F(arg_49_0, arg_49_1, arg_49_2)
	return {
		x = arg_49_0,
		y = arg_49_1,
		z = arg_49_2
	}
end

function cc.tex2F(arg_50_0, arg_50_1)
	return {
		u = arg_50_0,
		v = arg_50_1
	}
end

function cc.PointSprite(arg_51_0, arg_51_1, arg_51_2)
	return {
		pos = arg_51_0,
		color = arg_51_1,
		size = arg_51_2
	}
end

function cc.Quad2(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	return {
		tl = arg_52_0,
		tr = arg_52_1,
		bl = arg_52_2,
		br = arg_52_3
	}
end

function cc.Quad3(arg_53_0, arg_53_1, arg_53_2, arg_53_3)
	return {
		tl = arg_53_0,
		tr = arg_53_1,
		bl = arg_53_2,
		br = arg_53_3
	}
end

function cc.V2F_C4B_T2F(arg_54_0, arg_54_1, arg_54_2)
	return {
		vertices = arg_54_0,
		colors = arg_54_1,
		texCoords = arg_54_2
	}
end

function cc.V2F_C4F_T2F(arg_55_0, arg_55_1, arg_55_2)
	return {
		vertices = arg_55_0,
		colors = arg_55_1,
		texCoords = arg_55_2
	}
end

function cc.V3F_C4B_T2F(arg_56_0, arg_56_1, arg_56_2)
	return {
		vertices = arg_56_0,
		colors = arg_56_1,
		texCoords = arg_56_2
	}
end

function cc.V2F_C4B_T2F_Quad(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	return {
		bl = arg_57_0,
		br = arg_57_1,
		tl = arg_57_2,
		tr = arg_57_3
	}
end

function cc.V3F_C4B_T2F_Quad(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	return {
		tl = arg_58_0,
		bl = arg_58_1,
		tr = arg_58_2,
		br = arg_58_3
	}
end

function cc.V2F_C4F_T2F_Quad(arg_59_0, arg_59_1, arg_59_2, arg_59_3)
	return {
		bl = arg_59_0,
		br = arg_59_1,
		tl = arg_59_2,
		tr = arg_59_3
	}
end

function cc.T2F_Quad(arg_60_0, arg_60_1, arg_60_2, arg_60_3)
	return {
		bl = arg_60_0,
		br = arg_60_1,
		tl = arg_60_2,
		tr = arg_60_3
	}
end

function cc.AnimationFrameData(arg_61_0, arg_61_1, arg_61_2)
	return {
		texCoords = arg_61_0,
		delay = arg_61_1,
		size = arg_61_2
	}
end

function cc.PhysicsMaterial(arg_62_0, arg_62_1, arg_62_2)
	return {
		density = arg_62_0,
		restitution = arg_62_1,
		friction = arg_62_2
	}
end

function cc.vec3(arg_63_0, arg_63_1, arg_63_2)
	return {
		x = arg_63_0,
		y = arg_63_1,
		z = arg_63_2
	}
end

function cc.vec4(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	return {
		x = arg_64_0,
		y = arg_64_1,
		z = arg_64_2,
		w = arg_64_3
	}
end

function cc:vec3cross(arg_65_1)
	return cc.vec3(self.y * arg_65_1.z - self.z * arg_65_1.y, self.z * arg_65_1.x - self.x * arg_65_1.z, self.x * arg_65_1.y - self.y * arg_65_1.x)
end

function cc:vec3add(arg_66_1)
	return {
		x = self.x + arg_66_1.x,
		y = self.y + arg_66_1.y,
		z = self.z + arg_66_1.z
	}
end

function cc:vec3sub(arg_67_1)
	return {
		x = self.x - arg_67_1.x,
		y = self.y - arg_67_1.y,
		z = self.z - arg_67_1.z
	}
end

function cc:vec3mul(arg_68_1)
	return {
		x = self.x * arg_68_1,
		y = self.y * arg_68_1,
		z = self.z * arg_68_1
	}
end

function cc:vec3dot(arg_69_1)
	return self.x * arg_69_1.x + self.y * arg_69_1.y + self.z * arg_69_1.z
end

function cc.vec3normalize(arg_70_0)
	local var_70_0 = cc.vec3dot(arg_70_0, arg_70_0)

	if var_70_0 == 1 then
		return arg_70_0
	end

	local var_70_1 = math.sqrt(var_70_0)

	if var_70_1 < 2e-37 then
		return arg_70_0
	end

	return cc.vec3mul(arg_70_0, 1 / var_70_1)
end

function cc.quaternion(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	return {
		x = arg_71_0,
		y = arg_71_1,
		z = arg_71_2,
		w = arg_71_3
	}
end

function cc:quaternion_createFromAxisAngle(arg_72_1)
	local var_72_0 = math.sin(arg_72_1 * 0.5)
	local var_72_1 = cc.vec3normalize((cc.vec3(self.x, self.y, self.z)))
	local var_72_2 = cc.vec3(0, 0, 0)

	var_72_2.x = var_72_1.x * var_72_0
	var_72_2.y = var_72_1.y * var_72_0
	var_72_2.z = var_72_1.z * var_72_0
	var_72_2.w = math.cos(arg_72_1 * 0.5)

	return var_72_2
end

function cc.blendFunc(arg_73_0, arg_73_1)
	return {
		src = arg_73_0,
		dst = arg_73_1
	}
end

cc.mat4 = cc.mat4 or {}

function cc.mat4.new()
	local var_74_0 = {
		...
	}
	local var_74_1 = {}

	if #var_74_0 == 1 then
		assert(type(var_74_0[1]) == "table", "type of input params are wrong to new a mat4 when num of params is 1")

		for iter_74_0 = 1, 16 do
			var_74_1[iter_74_0] = var_74_0[1][iter_74_0] ~= nil and var_74_0[1][iter_74_0] or 0
		end
	elseif #var_74_0 == 16 then
		for iter_74_1 = 1, 16 do
			var_74_1[iter_74_1] = var_74_0[iter_74_1]
		end
	end

	setmetatable(var_74_1, {
		__index = cc.mat4
	})

	return var_74_1
end

function cc.mat4.getInversed(arg_75_0)
	return mat4_getInversed(arg_75_0)
end

function cc.mat4.transformVector()
	return mat4_transformVector(...)
end

function cc.mat4.multiply(arg_77_0, arg_77_1)
	return mat4_multiply(arg_77_0, arg_77_1)
end

function cc.mat4.decompose(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
	return mat4_decompose(arg_78_0, arg_78_1, arg_78_2, arg_78_3)
end

function cc.mat4.createIdentity()
	return cc.mat4.new(1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1)
end

function cc.mat4.translate(arg_80_0, arg_80_1)
	return mat4_translate(arg_80_0, arg_80_1)
end

function cc.mat4.createRotationZ(arg_81_0, arg_81_1)
	return mat4_createRotationZ(arg_81_0, arg_81_1)
end

function cc.mat4.setIdentity(arg_82_0)
	return mat4_setIdentity(arg_82_0)
end

function cc.mat4.createTranslation()
	return mat4_createTranslation(...)
end

function cc.mat4.createRotation()
	return mat4_createRotation(...)
end

function cc.ray(arg_85_0, arg_85_1)
	arg_85_1 = cc.vec3normalize(arg_85_1)

	return {
		origin = arg_85_0,
		direction = arg_85_1
	}
end

function cc.plane(arg_86_0, arg_86_1, arg_86_2)
	local var_86_0 = cc.vec3sub(arg_86_1, arg_86_0)
	local var_86_1 = cc.vec3sub(arg_86_2, arg_86_1)
	local var_86_2 = cc.vec3normalize((cc.vec3(var_86_0.y * var_86_1.z - var_86_0.z * var_86_1.y, var_86_0.z * var_86_1.x - var_86_0.x * var_86_1.z, var_86_0.x * var_86_1.y - var_86_0.y * var_86_1.x)))

	return {
		normal = var_86_2,
		dist = cc.vec3dot(var_86_2, arg_86_0)
	}
end

function cc:rayDistancePlane(arg_87_1)
	local var_87_0 = cc.vec3dot(arg_87_1.normal, self.direction)

	if var_87_0 == 0 then
		return 0
	end

	return (arg_87_1.dist - cc.vec3dot(arg_87_1.normal, self.origin)) / var_87_0
end

function cc:rayIntersectPlanePoint(arg_88_1)
	return cc.vec3add(self.origin, cc.vec3mul(self.direction, (cc.rayDistancePlane(self, arg_88_1))))
end
