local MaskNode = class("MaskNode", function()
	return cc.Sprite:create("mainScenebg/flash.jpg")
end)

function MaskNode:create(arg_2_1)
	local var_2_0 = MaskNode.new()

	var_2_0:init(arg_2_1)

	return var_2_0
end

function MaskNode:createDreamMask()
	local var_3_0 = MaskNode.new()

	var_3_0:initDreamMask()

	return var_3_0
end

function MaskNode:init(arg_4_1)
	arg_4_1 = arg_4_1 or {}
	self._focus = arg_4_1.focus or cc.p(0.5, 0.5)
	self._range = arg_4_1.range or cc.p(0.15, 0.15)

	self:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self:initGLProgram()
end

function MaskNode:initDreamMask()
	self._focus = cc.p(0.5, 0.5)

	self:setPosition(cc.p(GameDisplay.cx, GameDisplay.cy))
	self:initDreamMaskGLProgram()
end

function MaskNode:initGLProgram()
	local var_6_0 = cc.GLProgram:createWithByteArrays("    attribute vec4 a_position;\n    attribute vec2 a_texCoord;\n    attribute vec4 a_color;  \n    \n    #ifdef GL_ES\n        varying lowp vec4 v_fragmentColor;\n        varying mediump vec2 v_texCoord;\n    #else\n        varying vec4 v_fragmentColor;\n        varying vec2 v_texCoord;\n    #endif \n    \n    void main()\n    {\n        gl_Position = CC_PMatrix * a_position; \n        v_fragmentColor = a_color;\n        v_texCoord = a_texCoord;\n    }\n    ", "    #ifdef GL_ES\n        precision mediump float;\n    #endif\n    varying vec4 v_fragmentColor;\n    varying vec2 v_texCoord;\n    \n    uniform vec2 resolution;\n    uniform vec2 focus;\n    uniform vec2 range;\n\n    void mainImage( out vec4 fragColor, in vec2 fragCoord )\n    {\n        float ratio = resolution.y/resolution.x;\n        vec2 center = vec2(focus.x, focus.y*ratio);\n        vec2 uv = v_texCoord.xy ;\n        uv.y *= ratio;\n        //使用黑色遮罩\n        vec4 tex = vec4(0., 0., 0., 1.);\n        vec2 d = uv - center;\n        //光照半径\n        vec2 s = vec2(range.x, range.y * ratio);\n        float r = dot(d, d)/dot(s,s);\n        vec4 c = tex * (1.12 - r);\n        float cl = clamp(c.a, 0.0, 1.0);\n        fragColor = c;\n        fragColor.a = 1. - cl;\n    }\n    \n    void main()\n    {\n        mainImage(gl_FragColor, gl_FragCoord.xy);\n    }\n    ")

	var_6_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_6_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_6_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_6_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_6_0):setUniformVec2("resolution", cc.p(self:getContentSize().width, self:getContentSize().height))
	cc.GLProgramState:getOrCreateWithGLProgram(var_6_0):setUniformVec2("focus", cc.p(self._focus.x, self._focus.y))
	cc.GLProgramState:getOrCreateWithGLProgram(var_6_0):setUniformVec2("range", cc.p(self._range.x, self._range.y))
	var_6_0:updateUniforms()
	self:setGLProgram(var_6_0)
end

function MaskNode:focus(arg_7_1, arg_7_2)
	local var_7_0 = self:convertToNodeSpace(cc.p(arg_7_1, arg_7_2))

	self._focus = cc.p(var_7_0.x / self:getContentSize().width, (self:getContentSize().height - var_7_0.y) / self:getContentSize().height)

	self:getGLProgramState():setUniformVec2("focus", cc.p(self._focus.x, self._focus.y))
end

function MaskNode:updteRange(arg_8_1)
	self._range = arg_8_1 or self._range

	self:getGLProgramState():setUniformVec2("range", cc.p(self._range.x, self._range.y))
end

function MaskNode:initDreamMaskGLProgram()
	local var_9_0 = cc.GLProgram:createWithByteArrays("    attribute vec4 a_position;\n    attribute vec2 a_texCoord;\n    attribute vec4 a_color;  \n    \n    #ifdef GL_ES\n        varying lowp vec4 v_fragmentColor;\n        varying mediump vec2 v_texCoord;\n    #else\n        varying vec4 v_fragmentColor;\n        varying vec2 v_texCoord;\n    #endif \n    \n    void main()\n    {\n        gl_Position = CC_PMatrix * a_position; \n        v_fragmentColor = a_color;\n        v_texCoord = a_texCoord;\n    }\n    ", "    #ifdef GL_ES\n        precision mediump float;\n    #endif\n    varying vec4 v_fragmentColor;\n    varying vec2 v_texCoord;\n    \n    uniform vec2 resolution;\n\n    // SNOISE function from: https://www.shadertoy.com/view/lsf3RH\n    float snoise(vec3 uv, float res)\n    {\n        const vec3 s = vec3(1e0, 1e2, 1e3);\n        \n        uv *= res;\n        \n        vec3 uv0 = floor(mod(uv, res))*s;\n        vec3 uv1 = floor(mod(uv+vec3(1.), res))*s;\n        \n        vec3 f = fract(uv); f = f*f*(3.0-2.0*f);\n    \n        vec4 v = vec4(uv0.x+uv0.y+uv0.z, uv1.x+uv0.y+uv0.z,\n                      uv0.x+uv1.y+uv0.z, uv1.x+uv1.y+uv0.z);\n    \n        vec4 r = fract(sin(v*1e-1)*1e3);\n        float r0 = mix(mix(r.x, r.y, f.x), mix(r.z, r.w, f.x), f.y);\n        \n        r = fract(sin((v + uv1.z - uv0.z)*1e-1)*1e3);\n        float r1 = mix(mix(r.x, r.y, f.x), mix(r.z, r.w, f.x), f.y);\n        \n        return mix(r0, r1, f.z)*2.-1.;\n    }\n\n    float noise(vec2 uv, float baseres)\n    {\n        float n = 0.0;\n        for (int i = 0; i < 4; i++)\n        {\n            float v = pow(2.0, float(i));\n            n += (1.5 / v) * snoise(vec3(uv + vec2(1.,1.) * (float(i) / 17.), 1), v * baseres);\n        }\n        \n        \n        return clamp((1.0 - n) * .5, 0., 1.) * 4.;\n    }\n\n    void mainImage( out vec4 fragColor, in vec2 fragCoord )\n    {\n        float iTime = CC_Time[1];\n    \n        float aspectRatio = resolution.y/resolution.x;\n        vec2 uv = v_texCoord;\n        uv.y *= aspectRatio;\n        \n        // Tweaking vars\n        vec4 color = vec4(0.125, 0.291, 0.323, 1.0);\n        vec4 leaving = vec4(0.925, 0.791, 0.923, 1.0);\n        float noise_sz = 7.0f;\n        float speed = 0.4;\n        vec2 center = vec2(0.5, 0.5 * aspectRatio);\n        \n        float dc = 1. - (distance(uv, center) * 1.);\n        float pdc = pow(dc, 1.75);\n        \n        vec2 dir = -normalize(uv - center) * speed;\n        \n        float phase0 = fract(iTime * 0.3 + 0.5);\n        float phase1 = fract(iTime * 0.3 + 0.0);\n        \n        vec2 uv0 = uv + phase0 * dir;\n        vec2 uv1 = uv + phase1 * dir;\n        \n        // Rotation\n        float as = pdc * sin(iTime * 0.9) * 1.2;\n        float ca = cos(as);\n        float sa = sin(as);                 \n        \n        mat2 rot;\n        rot[0] = vec2(ca, -sa);\n        rot[1] = vec2(sa, ca);\n        \n        uv0 = center + ((uv0 - center) * rot);\n        uv1 = center + ((uv1 - center) * rot);\n    \n        // Samplings\n        float tex0 = max(noise(uv0, noise_sz), noise(uv0 * 1.2, noise_sz));\n        float tex1 = max(noise(uv1, noise_sz), noise(uv1 * 1.4, noise_sz));\n        \n        float lerp = abs((0.5 - phase0) / 0.5);\n        float samplings = mix(tex0, tex1, lerp);\n        \n        vec4 c = vec4(samplings, samplings, samplings, 1.0) * mix(color, leaving, pdc) * pdc;\n        c += pow(dc, 16.0) * mix(color, leaving, pow(dc, 16.0)) * 2.3;\n        \n        float cl = clamp(max(c.r, max(c.g, c.b)), 0.0, 1.0);\n        \n        //c.rgb += texture2D(CC_Texture0, v_texCoord).rgb * cl;\n        \n        // Output to screen\n        fragColor = c;\n        fragColor.a = clamp(1. - cl, 0., 1.);\n        fragColor.a *= 0.5;\n    }\n    \n    void main()\n    {\n        mainImage(gl_FragColor, gl_FragCoord.xy);\n    }\n    ")

	var_9_0:bindAttribLocation(cc.ATTRIBUTE_NAME_POSITION, cc.VERTEX_ATTRIB_POSITION)
	var_9_0:bindAttribLocation(cc.ATTRIBUTE_NAME_COLOR, cc.VERTEX_ATTRIB_COLOR)
	var_9_0:bindAttribLocation(cc.ATTRIBUTE_NAME_TEX_COORD, cc.VERTEX_ATTRIB_FLAG_TEX_COORDS)
	var_9_0:link()
	cc.GLProgramState:getOrCreateWithGLProgram(var_9_0):setUniformVec2("resolution", cc.p(self:getContentSize().width, self:getContentSize().height))
	cc.GLProgramState:getOrCreateWithGLProgram(var_9_0):setUniformVec2("focus", cc.p(self._focus.x, self._focus.y))
	var_9_0:updateUniforms()
	self:setGLProgram(var_9_0)
end

return MaskNode
