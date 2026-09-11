return {
	Play324081001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324081001
		arg_1_1.duration_ = 5.47

		local var_1_0 = {
			zh = 4.46666666666667,
			ja = 5.46666666666667
		}
		local var_1_1 = manager.audio:GetLocalizationFlag()

		if var_1_0[var_1_1] ~= nil then
			arg_1_1.duration_ = var_1_0[var_1_1]
		end

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324081002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.J27f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J27f")
				var_4_0.name = "J27f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.J27f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.J27f

				arg_1_1.bgs_.J27f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "J27f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			local var_4_9 = "1070ui_story"

			if arg_1_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1070ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1070ui_story == nil then
				arg_1_1.var_.characterEffect1070ui_story = var_4_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_14 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 and not isNil(var_4_13) then
				if arg_1_1.var_.characterEffect1070ui_story and not isNil(var_4_13) then
					arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and not isNil(var_4_13) and arg_1_1.var_.characterEffect1070ui_story then
				arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_18 = 1.86666666666667
			local var_4_19 = 0.25

			if 1.86666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_21 = arg_1_1:GetWordFromCfg(324081001)
				local var_4_22 = arg_1_1:FormatText(var_4_21.content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 10 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 10)

				if (10 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_22) / 10)) > 0 and var_4_19 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_18 = var_4_18 + 0.3

					if var_4_24 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081001", "story_v_out_324081.awb") ~= 0 then
					local var_4_25 = manager.audio:GetVoiceLength("story_v_out_324081", "324081001", "story_v_out_324081.awb") / 1000

					if var_4_25 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_18
					end

					if var_4_21.prefab_name ~= "" and arg_1_1.actors_[var_4_21.prefab_name] ~= nil then
						local var_4_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_21.prefab_name].transform, "story_v_out_324081", "324081001", "story_v_out_324081.awb")

						arg_1_1:RecordAudio("324081001", var_4_26)
						arg_1_1:RecordAudio("324081001", var_4_26)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324081", "324081001", "story_v_out_324081.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324081", "324081001", "story_v_out_324081.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_27 = var_4_18 + 0.3
			local var_4_28 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_27 + var_4_28 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_27) / var_4_28

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_27 + var_4_28 and arg_1_1.time_ < var_4_27 + var_4_28 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play324081002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 324081002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play324081003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["1070ui_story"]) and arg_7_1.var_.characterEffect1070ui_story == nil then
				arg_7_1.var_.characterEffect1070ui_story = arg_7_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.200000002980232

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["1070ui_story"]) then
				if arg_7_1.var_.characterEffect1070ui_story and not isNil(arg_7_1.actors_["1070ui_story"]) then
					arg_7_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_0)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["1070ui_story"]) and arg_7_1.var_.characterEffect1070ui_story then
				arg_7_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_10_1 = 0
			local var_10_2 = 1.625

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_1 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_3 = arg_7_1:FormatText(arg_7_1:GetWordFromCfg(324081002).content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_5 = 65 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 65)

				if (65 <= 0 and var_10_2 or var_10_2 * (utf8.len(var_10_3) / 65)) > 0 and var_10_2 < var_10_5 then
					arg_7_1.talkMaxDuration = var_10_5

					if var_10_5 + var_10_1 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_5 + var_10_1
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_6 = math.max(var_10_2, arg_7_1.talkMaxDuration)

			if var_10_1 <= arg_7_1.time_ and arg_7_1.time_ < var_10_1 + var_10_6 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_1) / var_10_6

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_1 + var_10_6 and arg_7_1.time_ < var_10_1 + var_10_6 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {}

		arg_7_1:InitPlayNodeList()
	end,
	Play324081003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 324081003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play324081004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 1.15

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_1 = arg_11_1:FormatText(arg_11_1:GetWordFromCfg(324081003).content)

				arg_11_1.text_.text = var_14_1

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_3 = 46 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 46)

				if (46 <= 0 and var_14_0 or var_14_0 * (utf8.len(var_14_1) / 46)) > 0 and var_14_0 < var_14_3 then
					arg_11_1.talkMaxDuration = var_14_3

					if var_14_3 + 0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_3 + 0
					end
				end

				arg_11_1.text_.text = var_14_1
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_4 = math.max(var_14_0, arg_11_1.talkMaxDuration)

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - 0) / var_14_4

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play324081004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 324081004
		arg_15_1.duration_ = 3.47

		local var_15_0 = {
			zh = 2.133,
			ja = 3.466
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play324081005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1070ui_story = arg_15_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).z)
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles = arg_15_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_15_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1070ui_story"].transform.position).z)
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1070ui_story"].transform.localEulerAngles = arg_15_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_18_1 = arg_15_1.actors_["1070ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect1070ui_story == nil then
				arg_15_1.var_.characterEffect1070ui_story = var_18_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_2 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_2 and not isNil(var_18_1) then
				if arg_15_1.var_.characterEffect1070ui_story and not isNil(var_18_1) then
					arg_15_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_2 and arg_15_1.time_ < 0 + var_18_2 + arg_18_0 and not isNil(var_18_1) and arg_15_1.var_.characterEffect1070ui_story then
				arg_15_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_18_4 = 0
			local var_18_5 = 0.2

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_4 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_6 = arg_15_1:GetWordFromCfg(324081004)
				local var_18_7 = arg_15_1:FormatText(var_18_6.content)

				arg_15_1.text_.text = var_18_7

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_9 = 8 <= 0 and var_18_5 or var_18_5 * (utf8.len(var_18_7) / 8)

				if (8 <= 0 and var_18_5 or var_18_5 * (utf8.len(var_18_7) / 8)) > 0 and var_18_5 < var_18_9 then
					arg_15_1.talkMaxDuration = var_18_9

					if var_18_9 + var_18_4 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_9 + var_18_4
					end
				end

				arg_15_1.text_.text = var_18_7
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081004", "story_v_out_324081.awb") ~= 0 then
					local var_18_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081004", "story_v_out_324081.awb") / 1000

					if var_18_10 + var_18_4 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_10 + var_18_4
					end

					if var_18_6.prefab_name ~= "" and arg_15_1.actors_[var_18_6.prefab_name] ~= nil then
						local var_18_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_6.prefab_name].transform, "story_v_out_324081", "324081004", "story_v_out_324081.awb")

						arg_15_1:RecordAudio("324081004", var_18_11)
						arg_15_1:RecordAudio("324081004", var_18_11)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_324081", "324081004", "story_v_out_324081.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_324081", "324081004", "story_v_out_324081.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_12 = math.max(var_18_5, arg_15_1.talkMaxDuration)

			if var_18_4 <= arg_15_1.time_ and arg_15_1.time_ < var_18_4 + var_18_12 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_4) / var_18_12

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_4 + var_18_12 and arg_15_1.time_ < var_18_4 + var_18_12 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play324081005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 324081005
		arg_19_1.duration_ = 2.9

		local var_19_0 = {
			zh = 2.4,
			ja = 2.9
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play324081006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			if 0.1 < arg_19_1.time_ and arg_19_1.time_ <= 0.1 + arg_22_0 then
				arg_19_1:AudioAction("play", "effect", "se_story_141", "se_story_141_sword_wing01", "")
			end

			local var_22_1 = 0
			local var_22_2 = 0.225

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_1 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_3 = arg_19_1:GetWordFromCfg(324081005)
				local var_22_4 = arg_19_1:FormatText(var_22_3.content)

				arg_19_1.text_.text = var_22_4

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_6 = 9 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_4) / 9)

				if (9 <= 0 and var_22_2 or var_22_2 * (utf8.len(var_22_4) / 9)) > 0 and var_22_2 < var_22_6 then
					arg_19_1.talkMaxDuration = var_22_6

					if var_22_6 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_6 + var_22_1
					end
				end

				arg_19_1.text_.text = var_22_4
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081005", "story_v_out_324081.awb") ~= 0 then
					local var_22_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081005", "story_v_out_324081.awb") / 1000

					if var_22_7 + var_22_1 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_1
					end

					if var_22_3.prefab_name ~= "" and arg_19_1.actors_[var_22_3.prefab_name] ~= nil then
						local var_22_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_3.prefab_name].transform, "story_v_out_324081", "324081005", "story_v_out_324081.awb")

						arg_19_1:RecordAudio("324081005", var_22_8)
						arg_19_1:RecordAudio("324081005", var_22_8)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_324081", "324081005", "story_v_out_324081.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_324081", "324081005", "story_v_out_324081.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_9 = math.max(var_22_2, arg_19_1.talkMaxDuration)

			if var_22_1 <= arg_19_1.time_ and arg_19_1.time_ < var_22_1 + var_22_9 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_1) / var_22_9

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_1 + var_22_9 and arg_19_1.time_ < var_22_1 + var_22_9 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play324081006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 324081006
		arg_23_1.duration_ = 6.4

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play324081007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_9000

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1070ui_story = arg_23_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_26_0 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 then
				arg_23_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_0)
				arg_23_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1070ui_story"].transform.position).z)
				arg_23_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1070ui_story"].transform.localEulerAngles = arg_23_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 then
				arg_23_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_23_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_23_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_23_1.actors_["1070ui_story"].transform.position).z)
				arg_23_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_23_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_23_1.actors_["1070ui_story"].transform.localEulerAngles = arg_23_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_26_1 = arg_23_1.actors_["1070ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1070ui_story == nil then
				arg_23_1.var_.characterEffect1070ui_story = var_26_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.200000002980232

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 and not isNil(var_26_1) then
				if arg_23_1.var_.characterEffect1070ui_story and not isNil(var_26_1) then
					arg_23_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_2)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1070ui_story then
				arg_23_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				local var_26_3 = arg_23_1.var_.effect323

				if not arg_23_1.var_.effect323 then
					var_26_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_qiliu_in_keep"), manager.ui.mainCamera.transform)
					var_26_3.name = "323"
					arg_23_1.var_.effect323 = var_26_3
				else
					var_26_3.transform:SetParent(var_26_9000)
				end

				var_26_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_26_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_26_5 = arg_23_1.bgs_.J27f.transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPosJ27f = var_26_5.localPosition
			end

			local var_26_6 = 1.79166666666667

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_6 then
				var_26_5.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPosJ27f, Vector3.New(0, 1, 10), (arg_23_1.time_ - 0) / var_26_6)
			end

			if arg_23_1.time_ >= 0 + var_26_6 and arg_23_1.time_ < 0 + var_26_6 + arg_26_0 then
				var_26_5.localPosition = Vector3.New(0, 1, 10)
			end

			if 0.1 < arg_23_1.time_ and arg_23_1.time_ <= 0.1 + arg_26_0 then
				arg_23_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_wind_parachuting", "")
			end

			if arg_23_1.frameCnt_ <= 1 then
				arg_23_1.dialog_:SetActive(false)
			end

			local var_26_8 = 1.4
			local var_26_9 = 0.7

			if 1.4 < arg_23_1.time_ and arg_23_1.time_ <= var_26_8 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				arg_23_1.dialog_:SetActive(true)

				arg_23_1.dialogCg_.alpha = 0

				local var_26_10 = LeanTween.value(arg_23_1.dialog_, 0, 1, 0.3)

				var_26_10:setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
					arg_23_1.dialogCg_.alpha = arg_27_0
				end))
				var_26_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_23_1.dialog_)
					var_26_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_23_1.duration_ = arg_23_1.duration_ + 0.3

				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_11 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(324081006).content)

				arg_23_1.text_.text = var_26_11

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_13 = 28 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 28)

				if (28 <= 0 and var_26_9 or var_26_9 * (utf8.len(var_26_11) / 28)) > 0 and var_26_9 < var_26_13 then
					arg_23_1.talkMaxDuration = var_26_13
					var_26_8 = var_26_8 + 0.3

					if var_26_13 + var_26_8 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_13 + var_26_8
					end
				end

				arg_23_1.text_.text = var_26_11
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_14 = var_26_8 + 0.3
			local var_26_15 = math.max(var_26_9, arg_23_1.talkMaxDuration)

			if var_26_8 + 0.3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_14 + var_26_15 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_14) / var_26_15

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_14 + var_26_15 and arg_23_1.time_ < var_26_14 + var_26_15 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "J27f",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.79166666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = true,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 7.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play324081007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 324081007
		arg_29_1.duration_ = 3.73

		local var_29_0 = {
			zh = 3.43333333333333,
			ja = 3.73333333333333
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play324081008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if arg_29_1.bgs_.STblack == nil then
				local var_32_0 = Object.Instantiate(arg_29_1.paintGo_)

				var_32_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_32_0.name = "STblack"
				var_32_0.transform.parent = arg_29_1.stage_.transform
				var_32_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.bgs_.STblack = var_32_0
			end

			if 1.2 < arg_29_1.time_ and arg_29_1.time_ <= 1.2 + arg_32_0 then
				local var_32_1 = arg_29_1.bgs_.STblack

				arg_29_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_2 = var_32_1:GetComponent("SpriteRenderer")

				if var_32_2 and var_32_2.sprite then
					local var_32_3 = 2 * (var_32_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_1.transform.localScale = Vector3.New(var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, var_32_3 / var_32_2.sprite.bounds.size.y < var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x and var_32_3 * manager.ui.mainCameraCom_.aspect / var_32_2.sprite.bounds.size.x or var_32_3 / var_32_2.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "STblack" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_4 = 1.2

			if 1.2 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.allBtn_.enabled = false
			end

			if arg_29_1.time_ >= var_32_4 + 0.3 and arg_29_1.time_ < var_32_4 + 0.3 + arg_32_0 then
				arg_29_1.allBtn_.enabled = true
			end

			local var_32_5 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_5 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_6 = 1.2

			if var_32_5 <= arg_29_1.time_ and arg_29_1.time_ < var_32_5 + var_32_6 then
				local var_32_7 = Color.New(0, 0, 0)

				var_32_7.a = Mathf.Lerp(0, 1, (arg_29_1.time_ - var_32_5) / var_32_6)
				arg_29_1.mask_.color = var_32_7
			end

			if arg_29_1.time_ >= var_32_5 + var_32_6 and arg_29_1.time_ < var_32_5 + var_32_6 + arg_32_0 then
				local var_32_8 = Color.New(0, 0, 0)

				var_32_8.a = 1
				arg_29_1.mask_.color = var_32_8
			end

			local var_32_9 = 1.20000000298023

			if 1.20000000298023 < arg_29_1.time_ and arg_29_1.time_ <= var_32_9 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_10 = 2

			if var_32_9 <= arg_29_1.time_ and arg_29_1.time_ < var_32_9 + var_32_10 then
				local var_32_11 = Color.New(0, 0, 0)

				var_32_11.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_9) / var_32_10)
				arg_29_1.mask_.color = var_32_11
			end

			if arg_29_1.time_ >= var_32_9 + var_32_10 and arg_29_1.time_ < var_32_9 + var_32_10 + arg_32_0 then
				local var_32_12 = Color.New(0, 0, 0)

				arg_29_1.mask_.enabled = false
				var_32_12.a = 0
				arg_29_1.mask_.color = var_32_12
			end

			local var_32_13 = arg_29_1.actors_["1070ui_story"]

			if 1.2 < arg_29_1.time_ and arg_29_1.time_ <= 1.2 + arg_32_0 and not isNil(var_32_13) and arg_29_1.var_.characterEffect1070ui_story == nil then
				arg_29_1.var_.characterEffect1070ui_story = var_32_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_14 = 0.200000002980232

			if 1.2 <= arg_29_1.time_ and arg_29_1.time_ < 1.2 + var_32_14 and not isNil(var_32_13) then
				if arg_29_1.var_.characterEffect1070ui_story and not isNil(var_32_13) then
					arg_29_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 1.2 + var_32_14 and arg_29_1.time_ < 1.2 + var_32_14 + arg_32_0 and not isNil(var_32_13) and arg_29_1.var_.characterEffect1070ui_story then
				arg_29_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 1.2 < arg_29_1.time_ and arg_29_1.time_ <= 1.2 + arg_32_0 then
				if arg_29_1.var_.effect323 then
					Object.Destroy(arg_29_1.var_.effect323)

					arg_29_1.var_.effect323 = nil
				end
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_17 = 2.43333333333333
			local var_32_18 = 0.05

			if 2.43333333333333 < arg_29_1.time_ and arg_29_1.time_ <= var_32_17 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_19 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_19:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_20 = arg_29_1:GetWordFromCfg(324081007)
				local var_32_21 = arg_29_1:FormatText(var_32_20.content)

				arg_29_1.text_.text = var_32_21

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_23 = 2 <= 0 and var_32_18 or var_32_18 * (utf8.len(var_32_21) / 2)

				if (2 <= 0 and var_32_18 or var_32_18 * (utf8.len(var_32_21) / 2)) > 0 and var_32_18 < var_32_23 then
					arg_29_1.talkMaxDuration = var_32_23
					var_32_17 = var_32_17 + 0.3

					if var_32_23 + var_32_17 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_23 + var_32_17
					end
				end

				arg_29_1.text_.text = var_32_21
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081007", "story_v_out_324081.awb") ~= 0 then
					local var_32_24 = manager.audio:GetVoiceLength("story_v_out_324081", "324081007", "story_v_out_324081.awb") / 1000

					if var_32_24 + var_32_17 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_24 + var_32_17
					end

					if var_32_20.prefab_name ~= "" and arg_29_1.actors_[var_32_20.prefab_name] ~= nil then
						local var_32_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_20.prefab_name].transform, "story_v_out_324081", "324081007", "story_v_out_324081.awb")

						arg_29_1:RecordAudio("324081007", var_32_25)
						arg_29_1:RecordAudio("324081007", var_32_25)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_324081", "324081007", "story_v_out_324081.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_324081", "324081007", "story_v_out_324081.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_26 = var_32_17 + 0.3
			local var_32_27 = math.max(var_32_18, arg_29_1.talkMaxDuration)

			if var_32_17 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_26 + var_32_27 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_26) / var_32_27

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_26 + var_32_27 and arg_29_1.time_ < var_32_26 + var_32_27 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play324081008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 324081008
		arg_35_1.duration_ = 1

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play324081009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0.05

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:GetWordFromCfg(324081008)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.text_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_4 = 2 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 2)

				if (2 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_2) / 2)) > 0 and var_38_0 < var_38_4 then
					arg_35_1.talkMaxDuration = var_38_4

					if var_38_4 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_4 + 0
					end
				end

				arg_35_1.text_.text = var_38_2
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081008", "story_v_out_324081.awb") ~= 0 then
					local var_38_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081008", "story_v_out_324081.awb") / 1000

					if var_38_5 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + 0
					end

					if var_38_1.prefab_name ~= "" and arg_35_1.actors_[var_38_1.prefab_name] ~= nil then
						local var_38_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_1.prefab_name].transform, "story_v_out_324081", "324081008", "story_v_out_324081.awb")

						arg_35_1:RecordAudio("324081008", var_38_6)
						arg_35_1:RecordAudio("324081008", var_38_6)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_324081", "324081008", "story_v_out_324081.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_324081", "324081008", "story_v_out_324081.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_7 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_7 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_7

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_7 and arg_35_1.time_ < 0 + var_38_7 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play324081009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 324081009
		arg_39_1.duration_ = 2.3

		local var_39_0 = {
			zh = 1.166,
			ja = 2.3
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play324081010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0.1 < arg_39_1.time_ and arg_39_1.time_ <= 0.1 + arg_42_0 then
				arg_39_1:AudioAction("play", "effect", "se_story_150", "se_story_150_fall_down", "")
			end

			local var_42_1 = 0
			local var_42_2 = 0.1

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_1 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_3 = arg_39_1:GetWordFromCfg(324081009)
				local var_42_4 = arg_39_1:FormatText(var_42_3.content)

				arg_39_1.text_.text = var_42_4

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_6 = 4 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_4) / 4)

				if (4 <= 0 and var_42_2 or var_42_2 * (utf8.len(var_42_4) / 4)) > 0 and var_42_2 < var_42_6 then
					arg_39_1.talkMaxDuration = var_42_6

					if var_42_6 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_6 + var_42_1
					end
				end

				arg_39_1.text_.text = var_42_4
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081009", "story_v_out_324081.awb") ~= 0 then
					local var_42_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081009", "story_v_out_324081.awb") / 1000

					if var_42_7 + var_42_1 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_1
					end

					if var_42_3.prefab_name ~= "" and arg_39_1.actors_[var_42_3.prefab_name] ~= nil then
						local var_42_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_3.prefab_name].transform, "story_v_out_324081", "324081009", "story_v_out_324081.awb")

						arg_39_1:RecordAudio("324081009", var_42_8)
						arg_39_1:RecordAudio("324081009", var_42_8)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_324081", "324081009", "story_v_out_324081.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_324081", "324081009", "story_v_out_324081.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_9 = math.max(var_42_2, arg_39_1.talkMaxDuration)

			if var_42_1 <= arg_39_1.time_ and arg_39_1.time_ < var_42_1 + var_42_9 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_1) / var_42_9

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_1 + var_42_9 and arg_39_1.time_ < var_42_1 + var_42_9 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play324081010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 324081010
		arg_43_1.duration_ = 1.93

		local var_43_0 = {
			zh = 1.933,
			ja = 1.466
		}
		local var_43_1 = manager.audio:GetLocalizationFlag()

		if var_43_0[var_43_1] ~= nil then
			arg_43_1.duration_ = var_43_0[var_43_1]
		end

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play324081011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["10171ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10171ui_story"))) then
				local var_46_0 = Object.Instantiate(Asset.Load("Char/" .. "10171ui_story"), arg_43_1.stage_.transform)

				var_46_0.name = "10171ui_story"
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["10171ui_story"] = var_46_0

				local var_46_1 = var_46_0:GetComponentInChildren(typeof(CharacterEffect))

				var_46_1.enabled = true

				local var_46_2 = GameObjectTools.GetOrAddComponent(var_46_0, typeof(DynamicBoneHelper))

				if var_46_2 then
					var_46_2:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_1.transform, false)

				arg_43_1.var_["10171ui_story" .. "Animator"] = var_46_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_["10171ui_story" .. "Animator"].applyRootMotion = true
				arg_43_1.var_["10171ui_story" .. "LipSync"] = var_46_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_3 = arg_43_1.actors_["10171ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_3) and arg_43_1.var_.characterEffect10171ui_story == nil then
				arg_43_1.var_.characterEffect10171ui_story = var_46_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_4 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 and not isNil(var_46_3) then
				if arg_43_1.var_.characterEffect10171ui_story and not isNil(var_46_3) then
					arg_43_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 and not isNil(var_46_3) and arg_43_1.var_.characterEffect10171ui_story then
				arg_43_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_46_6 = arg_43_1.actors_["1070ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_6) and arg_43_1.var_.characterEffect1070ui_story == nil then
				arg_43_1.var_.characterEffect1070ui_story = var_46_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_7 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_7 and not isNil(var_46_6) then
				if arg_43_1.var_.characterEffect1070ui_story and not isNil(var_46_6) then
					arg_43_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_7)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_7 and arg_43_1.time_ < 0 + var_46_7 + arg_46_0 and not isNil(var_46_6) and arg_43_1.var_.characterEffect1070ui_story then
				arg_43_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_46_8 = 0
			local var_46_9 = 0.1

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_8 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_10 = arg_43_1:GetWordFromCfg(324081010)
				local var_46_11 = arg_43_1:FormatText(var_46_10.content)

				arg_43_1.text_.text = var_46_11

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_13 = 4 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 4)

				if (4 <= 0 and var_46_9 or var_46_9 * (utf8.len(var_46_11) / 4)) > 0 and var_46_9 < var_46_13 then
					arg_43_1.talkMaxDuration = var_46_13

					if var_46_13 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_13 + var_46_8
					end
				end

				arg_43_1.text_.text = var_46_11
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081010", "story_v_out_324081.awb") ~= 0 then
					local var_46_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081010", "story_v_out_324081.awb") / 1000

					if var_46_14 + var_46_8 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_14 + var_46_8
					end

					if var_46_10.prefab_name ~= "" and arg_43_1.actors_[var_46_10.prefab_name] ~= nil then
						local var_46_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_10.prefab_name].transform, "story_v_out_324081", "324081010", "story_v_out_324081.awb")

						arg_43_1:RecordAudio("324081010", var_46_15)
						arg_43_1:RecordAudio("324081010", var_46_15)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_324081", "324081010", "story_v_out_324081.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_324081", "324081010", "story_v_out_324081.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_16 = math.max(var_46_9, arg_43_1.talkMaxDuration)

			if var_46_8 <= arg_43_1.time_ and arg_43_1.time_ < var_46_8 + var_46_16 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_8) / var_46_16

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_8 + var_46_16 and arg_43_1.time_ < var_46_8 + var_46_16 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play324081011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 324081011
		arg_47_1.duration_ = 7

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play324081012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.bgs_.J22f == nil then
				local var_50_0 = Object.Instantiate(arg_47_1.paintGo_)

				var_50_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J22f")
				var_50_0.name = "J22f"
				var_50_0.transform.parent = arg_47_1.stage_.transform
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.bgs_.J22f = var_50_0
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				local var_50_1 = arg_47_1.bgs_.J22f

				arg_47_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_50_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_50_2 = var_50_1:GetComponent("SpriteRenderer")

				if var_50_2 and var_50_2.sprite then
					local var_50_3 = 2 * (var_50_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_50_1.transform.localScale = Vector3.New(var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, var_50_3 / var_50_2.sprite.bounds.size.y < var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x and var_50_3 * manager.ui.mainCameraCom_.aspect / var_50_2.sprite.bounds.size.x or var_50_3 / var_50_2.sprite.bounds.size.y, 0)
				end

				for iter_50_0, iter_50_1 in pairs(arg_47_1.bgs_) do
					if iter_50_0 ~= "J22f" then
						iter_50_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_50_4 = 0

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.allBtn_.enabled = false
			end

			if arg_47_1.time_ >= var_50_4 + 0.3 and arg_47_1.time_ < var_50_4 + 0.3 + arg_50_0 then
				arg_47_1.allBtn_.enabled = true
			end

			local var_50_5 = 0

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 then
				arg_47_1.mask_.enabled = true
				arg_47_1.mask_.raycastTarget = true

				arg_47_1:SetGaussion(false)
			end

			local var_50_6 = 2

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_6 then
				local var_50_7 = Color.New(0, 0, 0)

				var_50_7.a = Mathf.Lerp(1, 0, (arg_47_1.time_ - var_50_5) / var_50_6)
				arg_47_1.mask_.color = var_50_7
			end

			if arg_47_1.time_ >= var_50_5 + var_50_6 and arg_47_1.time_ < var_50_5 + var_50_6 + arg_50_0 then
				local var_50_8 = Color.New(0, 0, 0)

				arg_47_1.mask_.enabled = false
				var_50_8.a = 0
				arg_47_1.mask_.color = var_50_8
			end

			local var_50_9 = arg_47_1.actors_["10171ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect10171ui_story == nil then
				arg_47_1.var_.characterEffect10171ui_story = var_50_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_10 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_10 and not isNil(var_50_9) then
				if arg_47_1.var_.characterEffect10171ui_story and not isNil(var_50_9) then
					arg_47_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_10)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_10 and arg_47_1.time_ < 0 + var_50_10 + arg_50_0 and not isNil(var_50_9) and arg_47_1.var_.characterEffect10171ui_story then
				arg_47_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_47_1.time_ and arg_47_1.time_ <= 1.2 + arg_50_0 then
				arg_47_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_lost_city", "")
			end

			if 0.1 < arg_47_1.time_ and arg_47_1.time_ <= 0.1 + arg_50_0 then
				arg_47_1:AudioAction("stop", "effect", "se_story_1310", "se_story_1310_amb_winter_loop", "")
			end

			if 1 < arg_47_1.time_ and arg_47_1.time_ <= 1 + arg_50_0 then
				arg_47_1:AudioAction("play", "music", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown.awb")

				local var_50_15 = manager.audio:GetAudioName("bgm_activity_2_0_story_oldtown", "bgm_activity_2_0_story_oldtown")

				if "" ~= "" then
					if arg_47_1.bgmTxt_.text ~= var_50_15 and arg_47_1.bgmTxt_.text ~= "" then
						if arg_47_1.bgmTxt2_.text ~= "" then
							arg_47_1.bgmTxt_.text = arg_47_1.bgmTxt2_.text
						end

						arg_47_1.bgmTxt2_.text = var_50_15

						arg_47_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_47_1.bgmTxt_.text = var_50_15
						arg_47_1.bgmTxt2_.text = var_50_15
					end

					if arg_47_1.bgmTimer then
						arg_47_1.bgmTimer:Stop()

						arg_47_1.bgmTimer = nil
					end

					if arg_47_1.settingData.show_music_name == 1 then
						arg_47_1.musicController:SetSelectedState("show")
						arg_47_1.musicAnimator_:Play("open", 0, 0)

						if arg_47_1.settingData.music_time ~= 0 then
							arg_47_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_47_1.settingData.music_time), function()
								if arg_47_1 == nil or isNil(arg_47_1.bgmTxt_) then
									return
								end

								arg_47_1.musicController:SetSelectedState("hide")
								arg_47_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_47_1.frameCnt_ <= 1 then
				arg_47_1.dialog_:SetActive(false)
			end

			local var_50_16 = 2
			local var_50_17 = 1.675

			if 2 < arg_47_1.time_ and arg_47_1.time_ <= var_50_16 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				arg_47_1.dialog_:SetActive(true)

				arg_47_1.dialogCg_.alpha = 0

				local var_50_18 = LeanTween.value(arg_47_1.dialog_, 0, 1, 0.3)

				var_50_18:setOnUpdate(LuaHelper.FloatAction(function(arg_52_0)
					arg_47_1.dialogCg_.alpha = arg_52_0
				end))
				var_50_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_47_1.dialog_)
					var_50_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_47_1.duration_ = arg_47_1.duration_ + 0.3

				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_19 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(324081011).content)

				arg_47_1.text_.text = var_50_19

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_21 = 67 <= 0 and var_50_17 or var_50_17 * (utf8.len(var_50_19) / 67)

				if (67 <= 0 and var_50_17 or var_50_17 * (utf8.len(var_50_19) / 67)) > 0 and var_50_17 < var_50_21 then
					arg_47_1.talkMaxDuration = var_50_21
					var_50_16 = var_50_16 + 0.3

					if var_50_21 + var_50_16 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_21 + var_50_16
					end
				end

				arg_47_1.text_.text = var_50_19
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_22 = var_50_16 + 0.3
			local var_50_23 = math.max(var_50_17, arg_47_1.talkMaxDuration)

			if var_50_16 + 0.3 <= arg_47_1.time_ and arg_47_1.time_ < var_50_22 + var_50_23 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_22) / var_50_23

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_22 + var_50_23 and arg_47_1.time_ < var_50_22 + var_50_23 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play324081012 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 324081012
		arg_54_1.duration_ = 5.6

		local var_54_0 = {
			zh = 4.7,
			ja = 5.6
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play324081013(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.var_.moveOldPos1070ui_story = arg_54_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_57_0 = 0.001

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 then
				arg_54_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_54_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_54_1.time_ - 0) / var_57_0)
				arg_54_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1070ui_story"].transform.position).z)
				arg_54_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1070ui_story"].transform.localEulerAngles = arg_54_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 then
				arg_54_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_54_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_54_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_54_1.actors_["1070ui_story"].transform.position).z)
				arg_54_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_54_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_54_1.actors_["1070ui_story"].transform.localEulerAngles = arg_54_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_57_1 = arg_54_1.actors_["1070ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1070ui_story == nil then
				arg_54_1.var_.characterEffect1070ui_story = var_57_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_2 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_2 and not isNil(var_57_1) then
				if arg_54_1.var_.characterEffect1070ui_story and not isNil(var_57_1) then
					arg_54_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_2 and arg_54_1.time_ < 0 + var_57_2 + arg_57_0 and not isNil(var_57_1) and arg_54_1.var_.characterEffect1070ui_story then
				arg_54_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_57_4 = 0
			local var_57_5 = 0.475

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_6 = arg_54_1:GetWordFromCfg(324081012)
				local var_57_7 = arg_54_1:FormatText(var_57_6.content)

				arg_54_1.text_.text = var_57_7

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_9 = 19 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 19)

				if (19 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 19)) > 0 and var_57_5 < var_57_9 then
					arg_54_1.talkMaxDuration = var_57_9

					if var_57_9 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_7
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081012", "story_v_out_324081.awb") ~= 0 then
					local var_57_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081012", "story_v_out_324081.awb") / 1000

					if var_57_10 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_4
					end

					if var_57_6.prefab_name ~= "" and arg_54_1.actors_[var_57_6.prefab_name] ~= nil then
						local var_57_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_6.prefab_name].transform, "story_v_out_324081", "324081012", "story_v_out_324081.awb")

						arg_54_1:RecordAudio("324081012", var_57_11)
						arg_54_1:RecordAudio("324081012", var_57_11)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_324081", "324081012", "story_v_out_324081.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_324081", "324081012", "story_v_out_324081.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_12 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_12 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_12

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_12 and arg_54_1.time_ < var_57_4 + var_57_12 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_54_1:InitPlayNodeList()
	end,
	Play324081013 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324081013
		arg_58_1.duration_ = 4.2

		local var_58_0 = {
			zh = 3.633,
			ja = 4.2
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324081014(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["10171ui_story"]) and arg_58_1.var_.characterEffect10171ui_story == nil then
				arg_58_1.var_.characterEffect10171ui_story = arg_58_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["10171ui_story"]) then
				if arg_58_1.var_.characterEffect10171ui_story and not isNil(arg_58_1.actors_["10171ui_story"]) then
					arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["10171ui_story"]) and arg_58_1.var_.characterEffect10171ui_story then
				arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_61_2 = arg_58_1.actors_["1070ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1070ui_story == nil then
				arg_58_1.var_.characterEffect1070ui_story = var_61_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_3 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.characterEffect1070ui_story and not isNil(var_61_2) then
					arg_58_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_3)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1070ui_story then
				arg_58_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_61_4 = arg_58_1.actors_["10171ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10171ui_story = var_61_4.localPosition

				local var_61_5 = GameObjectTools.GetOrAddComponent(var_61_4.gameObject, typeof(DynamicBoneHelper))

				if var_61_5 then
					var_61_5:EnableDynamicBone(false)
				end
			end

			local var_61_6 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_6 then
				var_61_4.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_58_1.time_ - 0) / var_61_6)
				var_61_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_4.position).x, (manager.ui.mainCamera.transform.position - var_61_4.position).y, (manager.ui.mainCamera.transform.position - var_61_4.position).z)
				var_61_4.localEulerAngles.z = 0
				var_61_4.localEulerAngles.x = 0
				var_61_4.localEulerAngles = var_61_4.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_6 and arg_58_1.time_ < 0 + var_61_6 + arg_61_0 then
				var_61_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_61_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_4.position).x, (manager.ui.mainCamera.transform.position - var_61_4.position).y, (manager.ui.mainCamera.transform.position - var_61_4.position).z)
				var_61_4.localEulerAngles.z = 0
				var_61_4.localEulerAngles.x = 0
				var_61_4.localEulerAngles = var_61_4.localEulerAngles

				local var_61_7 = GameObjectTools.GetOrAddComponent(var_61_4.gameObject, typeof(DynamicBoneHelper))

				if var_61_7 then
					var_61_7:EnableDynamicBone(true)
				end
			end

			local var_61_8 = arg_58_1.actors_["10171ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.characterEffect10171ui_story == nil then
				arg_58_1.var_.characterEffect10171ui_story = var_61_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_9 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_9 and not isNil(var_61_8) then
				if arg_58_1.var_.characterEffect10171ui_story and not isNil(var_61_8) then
					arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_9 and arg_58_1.time_ < 0 + var_61_9 + arg_61_0 and not isNil(var_61_8) and arg_58_1.var_.characterEffect10171ui_story then
				arg_58_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_61_11 = arg_58_1.actors_["1070ui_story"].transform

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1070ui_story = var_61_11.localPosition
			end

			local var_61_12 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_12 then
				var_61_11.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_58_1.time_ - 0) / var_61_12)
				var_61_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_11.position).x, (manager.ui.mainCamera.transform.position - var_61_11.position).y, (manager.ui.mainCamera.transform.position - var_61_11.position).z)
				var_61_11.localEulerAngles.z = 0
				var_61_11.localEulerAngles.x = 0
				var_61_11.localEulerAngles = var_61_11.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_12 and arg_58_1.time_ < 0 + var_61_12 + arg_61_0 then
				var_61_11.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_61_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_61_11.position).x, (manager.ui.mainCamera.transform.position - var_61_11.position).y, (manager.ui.mainCamera.transform.position - var_61_11.position).z)
				var_61_11.localEulerAngles.z = 0
				var_61_11.localEulerAngles.x = 0
				var_61_11.localEulerAngles = var_61_11.localEulerAngles
			end

			local var_61_13 = 0
			local var_61_14 = 0.525

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_13 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_15 = arg_58_1:GetWordFromCfg(324081013)
				local var_61_16 = arg_58_1:FormatText(var_61_15.content)

				arg_58_1.text_.text = var_61_16

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_18 = 21 <= 0 and var_61_14 or var_61_14 * (utf8.len(var_61_16) / 21)

				if (21 <= 0 and var_61_14 or var_61_14 * (utf8.len(var_61_16) / 21)) > 0 and var_61_14 < var_61_18 then
					arg_58_1.talkMaxDuration = var_61_18

					if var_61_18 + var_61_13 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_18 + var_61_13
					end
				end

				arg_58_1.text_.text = var_61_16
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081013", "story_v_out_324081.awb") ~= 0 then
					local var_61_19 = manager.audio:GetVoiceLength("story_v_out_324081", "324081013", "story_v_out_324081.awb") / 1000

					if var_61_19 + var_61_13 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_19 + var_61_13
					end

					if var_61_15.prefab_name ~= "" and arg_58_1.actors_[var_61_15.prefab_name] ~= nil then
						local var_61_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_15.prefab_name].transform, "story_v_out_324081", "324081013", "story_v_out_324081.awb")

						arg_58_1:RecordAudio("324081013", var_61_20)
						arg_58_1:RecordAudio("324081013", var_61_20)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_324081", "324081013", "story_v_out_324081.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_324081", "324081013", "story_v_out_324081.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_21 = math.max(var_61_14, arg_58_1.talkMaxDuration)

			if var_61_13 <= arg_58_1.time_ and arg_58_1.time_ < var_61_13 + var_61_21 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_13) / var_61_21

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_13 + var_61_21 and arg_58_1.time_ < var_61_13 + var_61_21 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play324081014 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324081014
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play324081015(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1070ui_story = arg_62_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_65_0 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 then
				arg_62_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_0)
				arg_62_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1070ui_story"].transform.position).z)
				arg_62_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1070ui_story"].transform.localEulerAngles = arg_62_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 then
				arg_62_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_62_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_62_1.actors_["1070ui_story"].transform.position).z)
				arg_62_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_62_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_62_1.actors_["1070ui_story"].transform.localEulerAngles = arg_62_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_65_1 = arg_62_1.actors_["10171ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect10171ui_story == nil then
				arg_62_1.var_.characterEffect10171ui_story = var_65_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_2 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_2 and not isNil(var_65_1) then
				if arg_62_1.var_.characterEffect10171ui_story and not isNil(var_65_1) then
					arg_62_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_62_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_2)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_2 and arg_62_1.time_ < 0 + var_65_2 + arg_65_0 and not isNil(var_65_1) and arg_62_1.var_.characterEffect10171ui_story then
				arg_62_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_62_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_65_3 = arg_62_1.actors_["10171ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos10171ui_story = var_65_3.localPosition

				local var_65_4 = GameObjectTools.GetOrAddComponent(var_65_3.gameObject, typeof(DynamicBoneHelper))

				if var_65_4 then
					var_65_4:EnableDynamicBone(false)
				end
			end

			local var_65_5 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_5 then
				var_65_3.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_62_1.time_ - 0) / var_65_5)
				var_65_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_3.position).x, (manager.ui.mainCamera.transform.position - var_65_3.position).y, (manager.ui.mainCamera.transform.position - var_65_3.position).z)
				var_65_3.localEulerAngles.z = 0
				var_65_3.localEulerAngles.x = 0
				var_65_3.localEulerAngles = var_65_3.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_5 and arg_62_1.time_ < 0 + var_65_5 + arg_65_0 then
				var_65_3.localPosition = Vector3.New(0, 100, 0)
				var_65_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_3.position).x, (manager.ui.mainCamera.transform.position - var_65_3.position).y, (manager.ui.mainCamera.transform.position - var_65_3.position).z)
				var_65_3.localEulerAngles.z = 0
				var_65_3.localEulerAngles.x = 0
				var_65_3.localEulerAngles = var_65_3.localEulerAngles

				local var_65_6 = GameObjectTools.GetOrAddComponent(var_65_3.gameObject, typeof(DynamicBoneHelper))

				if var_65_6 then
					var_65_6:EnableDynamicBone(true)
				end
			end

			local var_65_7 = 0
			local var_65_8 = 0.925

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_7 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_9 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(324081014).content)

				arg_62_1.text_.text = var_65_9

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_11 = 37 <= 0 and var_65_8 or var_65_8 * (utf8.len(var_65_9) / 37)

				if (37 <= 0 and var_65_8 or var_65_8 * (utf8.len(var_65_9) / 37)) > 0 and var_65_8 < var_65_11 then
					arg_62_1.talkMaxDuration = var_65_11

					if var_65_11 + var_65_7 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_11 + var_65_7
					end
				end

				arg_62_1.text_.text = var_65_9
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_12 = math.max(var_65_8, arg_62_1.talkMaxDuration)

			if var_65_7 <= arg_62_1.time_ and arg_62_1.time_ < var_65_7 + var_65_12 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_7) / var_65_12

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_7 + var_65_12 and arg_62_1.time_ < var_65_7 + var_65_12 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play324081015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 324081015
		arg_66_1.duration_ = 3.97

		local var_66_0 = {
			zh = 3.7,
			ja = 3.966
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play324081016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos10171ui_story = arg_66_1.actors_["10171ui_story"].transform.localPosition

				local var_69_0 = GameObjectTools.GetOrAddComponent(arg_66_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_69_0 then
					var_69_0:EnableDynamicBone(false)
				end
			end

			local var_69_1 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_1 then
				arg_66_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_66_1.time_ - 0) / var_69_1)
				arg_66_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10171ui_story"].transform.position).z)
				arg_66_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["10171ui_story"].transform.localEulerAngles = arg_66_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_1 and arg_66_1.time_ < 0 + var_69_1 + arg_69_0 then
				arg_66_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_66_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_66_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_66_1.actors_["10171ui_story"].transform.position).z)
				arg_66_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_66_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_66_1.actors_["10171ui_story"].transform.localEulerAngles = arg_66_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_69_2 = GameObjectTools.GetOrAddComponent(arg_66_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(true)
				end
			end

			local var_69_3 = arg_66_1.actors_["10171ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.characterEffect10171ui_story == nil then
				arg_66_1.var_.characterEffect10171ui_story = var_69_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_4 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 and not isNil(var_69_3) then
				if arg_66_1.var_.characterEffect10171ui_story and not isNil(var_69_3) then
					arg_66_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.characterEffect10171ui_story then
				arg_66_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_2")
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_69_6 = 0
			local var_69_7 = 0.4

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_8 = arg_66_1:GetWordFromCfg(324081015)
				local var_69_9 = arg_66_1:FormatText(var_69_8.content)

				arg_66_1.text_.text = var_69_9

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 16 <= 0 and var_69_7 or var_69_7 * (utf8.len(var_69_9) / 16)

				if (16 <= 0 and var_69_7 or var_69_7 * (utf8.len(var_69_9) / 16)) > 0 and var_69_7 < var_69_11 then
					arg_66_1.talkMaxDuration = var_69_11

					if var_69_11 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_11 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_9
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081015", "story_v_out_324081.awb") ~= 0 then
					local var_69_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081015", "story_v_out_324081.awb") / 1000

					if var_69_12 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_12 + var_69_6
					end

					if var_69_8.prefab_name ~= "" and arg_66_1.actors_[var_69_8.prefab_name] ~= nil then
						local var_69_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_8.prefab_name].transform, "story_v_out_324081", "324081015", "story_v_out_324081.awb")

						arg_66_1:RecordAudio("324081015", var_69_13)
						arg_66_1:RecordAudio("324081015", var_69_13)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_324081", "324081015", "story_v_out_324081.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_324081", "324081015", "story_v_out_324081.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_14 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_14 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_14

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_14 and arg_66_1.time_ < var_69_6 + var_69_14 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play324081016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 324081016
		arg_70_1.duration_ = 9.63

		local var_70_0 = {
			zh = 7.3,
			ja = 9.633
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play324081017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1070ui_story = arg_70_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_73_0 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 then
				arg_70_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_70_1.time_ - 0) / var_73_0)
				arg_70_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).z)
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles = arg_70_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 then
				arg_70_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_70_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_70_1.actors_["1070ui_story"].transform.position).z)
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_70_1.actors_["1070ui_story"].transform.localEulerAngles = arg_70_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_73_1 = arg_70_1.actors_["1070ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_1) and arg_70_1.var_.characterEffect1070ui_story == nil then
				arg_70_1.var_.characterEffect1070ui_story = var_73_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_2 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_2 and not isNil(var_73_1) then
				if arg_70_1.var_.characterEffect1070ui_story and not isNil(var_73_1) then
					arg_70_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_2 and arg_70_1.time_ < 0 + var_73_2 + arg_73_0 and not isNil(var_73_1) and arg_70_1.var_.characterEffect1070ui_story then
				arg_70_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_73_4 = arg_70_1.actors_["10171ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect10171ui_story == nil then
				arg_70_1.var_.characterEffect10171ui_story = var_73_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_5 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_5 and not isNil(var_73_4) then
				if arg_70_1.var_.characterEffect10171ui_story and not isNil(var_73_4) then
					arg_70_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_70_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_5)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_5 and arg_70_1.time_ < 0 + var_73_5 + arg_73_0 and not isNil(var_73_4) and arg_70_1.var_.characterEffect10171ui_story then
				arg_70_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_70_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_73_6 = 0
			local var_73_7 = 0.85

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_8 = arg_70_1:GetWordFromCfg(324081016)
				local var_73_9 = arg_70_1:FormatText(var_73_8.content)

				arg_70_1.text_.text = var_73_9

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 34 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 34)

				if (34 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 34)) > 0 and var_73_7 < var_73_11 then
					arg_70_1.talkMaxDuration = var_73_11

					if var_73_11 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_9
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081016", "story_v_out_324081.awb") ~= 0 then
					local var_73_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081016", "story_v_out_324081.awb") / 1000

					if var_73_12 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_6
					end

					if var_73_8.prefab_name ~= "" and arg_70_1.actors_[var_73_8.prefab_name] ~= nil then
						local var_73_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_8.prefab_name].transform, "story_v_out_324081", "324081016", "story_v_out_324081.awb")

						arg_70_1:RecordAudio("324081016", var_73_13)
						arg_70_1:RecordAudio("324081016", var_73_13)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_324081", "324081016", "story_v_out_324081.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_324081", "324081016", "story_v_out_324081.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play324081017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 324081017
		arg_74_1.duration_ = 5.5

		local var_74_0 = {
			zh = 3.933,
			ja = 5.5
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play324081018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["10171ui_story"]) and arg_74_1.var_.characterEffect10171ui_story == nil then
				arg_74_1.var_.characterEffect10171ui_story = arg_74_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["10171ui_story"]) then
				if arg_74_1.var_.characterEffect10171ui_story and not isNil(arg_74_1.actors_["10171ui_story"]) then
					arg_74_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["10171ui_story"]) and arg_74_1.var_.characterEffect10171ui_story then
				arg_74_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_77_2 = arg_74_1.actors_["1070ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect1070ui_story == nil then
				arg_74_1.var_.characterEffect1070ui_story = var_77_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_3 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_3 and not isNil(var_77_2) then
				if arg_74_1.var_.characterEffect1070ui_story and not isNil(var_77_2) then
					arg_74_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_3)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_3 and arg_74_1.time_ < 0 + var_77_3 + arg_77_0 and not isNil(var_77_2) and arg_74_1.var_.characterEffect1070ui_story then
				arg_74_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_77_4 = 0
			local var_77_5 = 0.45

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_6 = arg_74_1:GetWordFromCfg(324081017)
				local var_77_7 = arg_74_1:FormatText(var_77_6.content)

				arg_74_1.text_.text = var_77_7

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 18 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 18)

				if (18 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 18)) > 0 and var_77_5 < var_77_9 then
					arg_74_1.talkMaxDuration = var_77_9

					if var_77_9 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_7
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081017", "story_v_out_324081.awb") ~= 0 then
					local var_77_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081017", "story_v_out_324081.awb") / 1000

					if var_77_10 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_4
					end

					if var_77_6.prefab_name ~= "" and arg_74_1.actors_[var_77_6.prefab_name] ~= nil then
						local var_77_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_6.prefab_name].transform, "story_v_out_324081", "324081017", "story_v_out_324081.awb")

						arg_74_1:RecordAudio("324081017", var_77_11)
						arg_74_1:RecordAudio("324081017", var_77_11)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_324081", "324081017", "story_v_out_324081.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_324081", "324081017", "story_v_out_324081.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_12 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_12 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_12

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_12 and arg_74_1.time_ < var_77_4 + var_77_12 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play324081018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324081018
		arg_78_1.duration_ = 7.1

		local var_78_0 = {
			zh = 7.1,
			ja = 7.066
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play324081019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1070ui_story"]) and arg_78_1.var_.characterEffect1070ui_story == nil then
				arg_78_1.var_.characterEffect1070ui_story = arg_78_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1070ui_story"]) then
				if arg_78_1.var_.characterEffect1070ui_story and not isNil(arg_78_1.actors_["1070ui_story"]) then
					arg_78_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1070ui_story"]) and arg_78_1.var_.characterEffect1070ui_story then
				arg_78_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_81_2 = arg_78_1.actors_["10171ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect10171ui_story == nil then
				arg_78_1.var_.characterEffect10171ui_story = var_81_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_3 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 and not isNil(var_81_2) then
				if arg_78_1.var_.characterEffect10171ui_story and not isNil(var_81_2) then
					arg_78_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_78_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_3)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 and not isNil(var_81_2) and arg_78_1.var_.characterEffect10171ui_story then
				arg_78_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_78_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_81_4 = 0
			local var_81_5 = 0.725

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_6 = arg_78_1:GetWordFromCfg(324081018)
				local var_81_7 = arg_78_1:FormatText(var_81_6.content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 29 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 29)

				if (29 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_7) / 29)) > 0 and var_81_5 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081018", "story_v_out_324081.awb") ~= 0 then
					local var_81_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081018", "story_v_out_324081.awb") / 1000

					if var_81_10 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_10 + var_81_4
					end

					if var_81_6.prefab_name ~= "" and arg_78_1.actors_[var_81_6.prefab_name] ~= nil then
						local var_81_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_6.prefab_name].transform, "story_v_out_324081", "324081018", "story_v_out_324081.awb")

						arg_78_1:RecordAudio("324081018", var_81_11)
						arg_78_1:RecordAudio("324081018", var_81_11)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_324081", "324081018", "story_v_out_324081.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_324081", "324081018", "story_v_out_324081.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_12 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_12 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_12

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_12 and arg_78_1.time_ < var_81_4 + var_81_12 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play324081019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324081019
		arg_82_1.duration_ = 4.2

		local var_82_0 = {
			zh = 2.933,
			ja = 4.2
		}
		local var_82_1 = manager.audio:GetLocalizationFlag()

		if var_82_0[var_82_1] ~= nil then
			arg_82_1.duration_ = var_82_0[var_82_1]
		end

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play324081020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["10171ui_story"]) and arg_82_1.var_.characterEffect10171ui_story == nil then
				arg_82_1.var_.characterEffect10171ui_story = arg_82_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["10171ui_story"]) then
				if arg_82_1.var_.characterEffect10171ui_story and not isNil(arg_82_1.actors_["10171ui_story"]) then
					arg_82_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["10171ui_story"]) and arg_82_1.var_.characterEffect10171ui_story then
				arg_82_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_85_2 = arg_82_1.actors_["1070ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1070ui_story == nil then
				arg_82_1.var_.characterEffect1070ui_story = var_85_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_3 = 0.200000002980232

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 and not isNil(var_85_2) then
				if arg_82_1.var_.characterEffect1070ui_story and not isNil(var_85_2) then
					arg_82_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_82_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_3)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.characterEffect1070ui_story then
				arg_82_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_82_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_85_4 = 0
			local var_85_5 = 0.375

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_4 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_6 = arg_82_1:GetWordFromCfg(324081019)
				local var_85_7 = arg_82_1:FormatText(var_85_6.content)

				arg_82_1.text_.text = var_85_7

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_9 = 15 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 15)

				if (15 <= 0 and var_85_5 or var_85_5 * (utf8.len(var_85_7) / 15)) > 0 and var_85_5 < var_85_9 then
					arg_82_1.talkMaxDuration = var_85_9

					if var_85_9 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_9 + var_85_4
					end
				end

				arg_82_1.text_.text = var_85_7
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081019", "story_v_out_324081.awb") ~= 0 then
					local var_85_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081019", "story_v_out_324081.awb") / 1000

					if var_85_10 + var_85_4 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_10 + var_85_4
					end

					if var_85_6.prefab_name ~= "" and arg_82_1.actors_[var_85_6.prefab_name] ~= nil then
						local var_85_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_6.prefab_name].transform, "story_v_out_324081", "324081019", "story_v_out_324081.awb")

						arg_82_1:RecordAudio("324081019", var_85_11)
						arg_82_1:RecordAudio("324081019", var_85_11)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_324081", "324081019", "story_v_out_324081.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_324081", "324081019", "story_v_out_324081.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_12 = math.max(var_85_5, arg_82_1.talkMaxDuration)

			if var_85_4 <= arg_82_1.time_ and arg_82_1.time_ < var_85_4 + var_85_12 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_4) / var_85_12

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_4 + var_85_12 and arg_82_1.time_ < var_85_4 + var_85_12 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play324081020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324081020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play324081021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1070ui_story = arg_86_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_0)
				arg_86_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1070ui_story"].transform.position).z)
				arg_86_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1070ui_story"].transform.localEulerAngles = arg_86_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_86_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_86_1.actors_["1070ui_story"].transform.position).z)
				arg_86_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_86_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_86_1.actors_["1070ui_story"].transform.localEulerAngles = arg_86_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_89_1 = arg_86_1.actors_["10171ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos10171ui_story = var_89_1.localPosition

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_1.gameObject, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end
			end

			local var_89_3 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 then
				var_89_1.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_86_1.time_ - 0) / var_89_3)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 then
				var_89_1.localPosition = Vector3.New(0, 100, 0)
				var_89_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_1.position).x, (manager.ui.mainCamera.transform.position - var_89_1.position).y, (manager.ui.mainCamera.transform.position - var_89_1.position).z)
				var_89_1.localEulerAngles.z = 0
				var_89_1.localEulerAngles.x = 0
				var_89_1.localEulerAngles = var_89_1.localEulerAngles

				local var_89_4 = GameObjectTools.GetOrAddComponent(var_89_1.gameObject, typeof(DynamicBoneHelper))

				if var_89_4 then
					var_89_4:EnableDynamicBone(true)
				end
			end

			local var_89_5 = arg_86_1.actors_["10171ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect10171ui_story == nil then
				arg_86_1.var_.characterEffect10171ui_story = var_89_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_6 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_6 and not isNil(var_89_5) then
				if arg_86_1.var_.characterEffect10171ui_story and not isNil(var_89_5) then
					arg_86_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_6)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_6 and arg_86_1.time_ < 0 + var_89_6 + arg_89_0 and not isNil(var_89_5) and arg_86_1.var_.characterEffect10171ui_story then
				arg_86_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_89_7 = 0
			local var_89_8 = 1.075

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_7 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, false)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_9 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(324081020).content)

				arg_86_1.text_.text = var_89_9

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 43 <= 0 and var_89_8 or var_89_8 * (utf8.len(var_89_9) / 43)

				if (43 <= 0 and var_89_8 or var_89_8 * (utf8.len(var_89_9) / 43)) > 0 and var_89_8 < var_89_11 then
					arg_86_1.talkMaxDuration = var_89_11

					if var_89_11 + var_89_7 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_7
					end
				end

				arg_86_1.text_.text = var_89_9
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_8, arg_86_1.talkMaxDuration)

			if var_89_7 <= arg_86_1.time_ and arg_86_1.time_ < var_89_7 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_7) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_7 + var_89_12 and arg_86_1.time_ < var_89_7 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play324081021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324081021
		arg_90_1.duration_ = 8.23

		local var_90_0 = {
			zh = 8.233,
			ja = 7.9
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play324081022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10171ui_story = arg_90_1.actors_["10171ui_story"].transform.localPosition

				local var_93_0 = GameObjectTools.GetOrAddComponent(arg_90_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_93_0 then
					var_93_0:EnableDynamicBone(false)
				end
			end

			local var_93_1 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_1 then
				arg_90_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_90_1.time_ - 0) / var_93_1)
				arg_90_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10171ui_story"].transform.position).z)
				arg_90_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["10171ui_story"].transform.localEulerAngles = arg_90_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_1 and arg_90_1.time_ < 0 + var_93_1 + arg_93_0 then
				arg_90_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_90_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10171ui_story"].transform.position).z)
				arg_90_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["10171ui_story"].transform.localEulerAngles = arg_90_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_93_2 = GameObjectTools.GetOrAddComponent(arg_90_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(true)
				end
			end

			local var_93_3 = arg_90_1.actors_["10171ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_3) and arg_90_1.var_.characterEffect10171ui_story == nil then
				arg_90_1.var_.characterEffect10171ui_story = var_93_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_4 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 and not isNil(var_93_3) then
				if arg_90_1.var_.characterEffect10171ui_story and not isNil(var_93_3) then
					arg_90_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 and not isNil(var_93_3) and arg_90_1.var_.characterEffect10171ui_story then
				arg_90_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_93_6 = 0
			local var_93_7 = 0.9

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_8 = arg_90_1:GetWordFromCfg(324081021)
				local var_93_9 = arg_90_1:FormatText(var_93_8.content)

				arg_90_1.text_.text = var_93_9

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 36 <= 0 and var_93_7 or var_93_7 * (utf8.len(var_93_9) / 36)

				if (36 <= 0 and var_93_7 or var_93_7 * (utf8.len(var_93_9) / 36)) > 0 and var_93_7 < var_93_11 then
					arg_90_1.talkMaxDuration = var_93_11

					if var_93_11 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_11 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_9
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081021", "story_v_out_324081.awb") ~= 0 then
					local var_93_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081021", "story_v_out_324081.awb") / 1000

					if var_93_12 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_12 + var_93_6
					end

					if var_93_8.prefab_name ~= "" and arg_90_1.actors_[var_93_8.prefab_name] ~= nil then
						local var_93_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_8.prefab_name].transform, "story_v_out_324081", "324081021", "story_v_out_324081.awb")

						arg_90_1:RecordAudio("324081021", var_93_13)
						arg_90_1:RecordAudio("324081021", var_93_13)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_324081", "324081021", "story_v_out_324081.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_324081", "324081021", "story_v_out_324081.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_14 and arg_90_1.time_ < var_93_6 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play324081022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324081022
		arg_94_1.duration_ = 10

		local var_94_0 = {
			zh = 10,
			ja = 8.9
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play324081023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 1.275

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:GetWordFromCfg(324081022)
				local var_97_2 = arg_94_1:FormatText(var_97_1.content)

				arg_94_1.text_.text = var_97_2

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_4 = 51 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 51)

				if (51 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_2) / 51)) > 0 and var_97_0 < var_97_4 then
					arg_94_1.talkMaxDuration = var_97_4

					if var_97_4 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_4 + 0
					end
				end

				arg_94_1.text_.text = var_97_2
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081022", "story_v_out_324081.awb") ~= 0 then
					local var_97_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081022", "story_v_out_324081.awb") / 1000

					if var_97_5 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_5 + 0
					end

					if var_97_1.prefab_name ~= "" and arg_94_1.actors_[var_97_1.prefab_name] ~= nil then
						local var_97_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_1.prefab_name].transform, "story_v_out_324081", "324081022", "story_v_out_324081.awb")

						arg_94_1:RecordAudio("324081022", var_97_6)
						arg_94_1:RecordAudio("324081022", var_97_6)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_324081", "324081022", "story_v_out_324081.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_324081", "324081022", "story_v_out_324081.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_7 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_7

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play324081023 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324081023
		arg_98_1.duration_ = 9.3

		local var_98_0 = {
			zh = 9.3,
			ja = 9.2
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play324081024(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_101_0 = 0
			local var_101_1 = 1.125

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_2 = arg_98_1:GetWordFromCfg(324081023)
				local var_101_3 = arg_98_1:FormatText(var_101_2.content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 45 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 45)

				if (45 <= 0 and var_101_1 or var_101_1 * (utf8.len(var_101_3) / 45)) > 0 and var_101_1 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_0
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081023", "story_v_out_324081.awb") ~= 0 then
					local var_101_6 = manager.audio:GetVoiceLength("story_v_out_324081", "324081023", "story_v_out_324081.awb") / 1000

					if var_101_6 + var_101_0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_6 + var_101_0
					end

					if var_101_2.prefab_name ~= "" and arg_98_1.actors_[var_101_2.prefab_name] ~= nil then
						local var_101_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_2.prefab_name].transform, "story_v_out_324081", "324081023", "story_v_out_324081.awb")

						arg_98_1:RecordAudio("324081023", var_101_7)
						arg_98_1:RecordAudio("324081023", var_101_7)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_324081", "324081023", "story_v_out_324081.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_324081", "324081023", "story_v_out_324081.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_8 = math.max(var_101_1, arg_98_1.talkMaxDuration)

			if var_101_0 <= arg_98_1.time_ and arg_98_1.time_ < var_101_0 + var_101_8 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_0) / var_101_8

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_0 + var_101_8 and arg_98_1.time_ < var_101_0 + var_101_8 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play324081024 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324081024
		arg_102_1.duration_ = 8.13

		local var_102_0 = {
			zh = 8.133,
			ja = 7.266
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play324081025(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1070ui_story"]) and arg_102_1.var_.characterEffect1070ui_story == nil then
				arg_102_1.var_.characterEffect1070ui_story = arg_102_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1070ui_story"]) then
				if arg_102_1.var_.characterEffect1070ui_story and not isNil(arg_102_1.actors_["1070ui_story"]) then
					arg_102_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1070ui_story"]) and arg_102_1.var_.characterEffect1070ui_story then
				arg_102_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_105_2 = arg_102_1.actors_["10171ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect10171ui_story == nil then
				arg_102_1.var_.characterEffect10171ui_story = var_105_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.characterEffect10171ui_story and not isNil(var_105_2) then
					arg_102_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_3)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect10171ui_story then
				arg_102_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_105_4 = arg_102_1.actors_["10171ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos10171ui_story = var_105_4.localPosition

				local var_105_5 = GameObjectTools.GetOrAddComponent(var_105_4.gameObject, typeof(DynamicBoneHelper))

				if var_105_5 then
					var_105_5:EnableDynamicBone(false)
				end
			end

			local var_105_6 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_6 then
				var_105_4.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_102_1.time_ - 0) / var_105_6)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_6 and arg_102_1.time_ < 0 + var_105_6 + arg_105_0 then
				var_105_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_105_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_4.position).x, (manager.ui.mainCamera.transform.position - var_105_4.position).y, (manager.ui.mainCamera.transform.position - var_105_4.position).z)
				var_105_4.localEulerAngles.z = 0
				var_105_4.localEulerAngles.x = 0
				var_105_4.localEulerAngles = var_105_4.localEulerAngles

				local var_105_7 = GameObjectTools.GetOrAddComponent(var_105_4.gameObject, typeof(DynamicBoneHelper))

				if var_105_7 then
					var_105_7:EnableDynamicBone(true)
				end
			end

			local var_105_8 = arg_102_1.actors_["1070ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos1070ui_story = var_105_8.localPosition
			end

			local var_105_9 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_9 then
				var_105_8.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_102_1.time_ - 0) / var_105_9)
				var_105_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_8.position).x, (manager.ui.mainCamera.transform.position - var_105_8.position).y, (manager.ui.mainCamera.transform.position - var_105_8.position).z)
				var_105_8.localEulerAngles.z = 0
				var_105_8.localEulerAngles.x = 0
				var_105_8.localEulerAngles = var_105_8.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_9 and arg_102_1.time_ < 0 + var_105_9 + arg_105_0 then
				var_105_8.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_105_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_8.position).x, (manager.ui.mainCamera.transform.position - var_105_8.position).y, (manager.ui.mainCamera.transform.position - var_105_8.position).z)
				var_105_8.localEulerAngles.z = 0
				var_105_8.localEulerAngles.x = 0
				var_105_8.localEulerAngles = var_105_8.localEulerAngles
			end

			local var_105_10 = 0
			local var_105_11 = 0.975

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_10 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_12 = arg_102_1:GetWordFromCfg(324081024)
				local var_105_13 = arg_102_1:FormatText(var_105_12.content)

				arg_102_1.text_.text = var_105_13

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_15 = 39 <= 0 and var_105_11 or var_105_11 * (utf8.len(var_105_13) / 39)

				if (39 <= 0 and var_105_11 or var_105_11 * (utf8.len(var_105_13) / 39)) > 0 and var_105_11 < var_105_15 then
					arg_102_1.talkMaxDuration = var_105_15

					if var_105_15 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_15 + var_105_10
					end
				end

				arg_102_1.text_.text = var_105_13
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081024", "story_v_out_324081.awb") ~= 0 then
					local var_105_16 = manager.audio:GetVoiceLength("story_v_out_324081", "324081024", "story_v_out_324081.awb") / 1000

					if var_105_16 + var_105_10 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_16 + var_105_10
					end

					if var_105_12.prefab_name ~= "" and arg_102_1.actors_[var_105_12.prefab_name] ~= nil then
						local var_105_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_12.prefab_name].transform, "story_v_out_324081", "324081024", "story_v_out_324081.awb")

						arg_102_1:RecordAudio("324081024", var_105_17)
						arg_102_1:RecordAudio("324081024", var_105_17)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_324081", "324081024", "story_v_out_324081.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_324081", "324081024", "story_v_out_324081.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_18 = math.max(var_105_11, arg_102_1.talkMaxDuration)

			if var_105_10 <= arg_102_1.time_ and arg_102_1.time_ < var_105_10 + var_105_18 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_10) / var_105_18

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_10 + var_105_18 and arg_102_1.time_ < var_105_10 + var_105_18 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play324081025 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324081025
		arg_106_1.duration_ = 3.63

		local var_106_0 = {
			zh = 2.5,
			ja = 3.633
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play324081026(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["10171ui_story"]) and arg_106_1.var_.characterEffect10171ui_story == nil then
				arg_106_1.var_.characterEffect10171ui_story = arg_106_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["10171ui_story"]) then
				if arg_106_1.var_.characterEffect10171ui_story and not isNil(arg_106_1.actors_["10171ui_story"]) then
					arg_106_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["10171ui_story"]) and arg_106_1.var_.characterEffect10171ui_story then
				arg_106_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_109_2 = arg_106_1.actors_["1070ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect1070ui_story == nil then
				arg_106_1.var_.characterEffect1070ui_story = var_109_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_3 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.characterEffect1070ui_story and not isNil(var_109_2) then
					arg_106_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_3)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect1070ui_story then
				arg_106_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_109_4 = 0
			local var_109_5 = 0.325

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(324081025)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 13 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 13)

				if (13 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 13)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081025", "story_v_out_324081.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081025", "story_v_out_324081.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_out_324081", "324081025", "story_v_out_324081.awb")

						arg_106_1:RecordAudio("324081025", var_109_11)
						arg_106_1:RecordAudio("324081025", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_324081", "324081025", "story_v_out_324081.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_324081", "324081025", "story_v_out_324081.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_12 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_12 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_12

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_12 and arg_106_1.time_ < var_109_4 + var_109_12 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play324081026 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324081026
		arg_110_1.duration_ = 4.6

		local var_110_0 = {
			zh = 3.2,
			ja = 4.6
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play324081027(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["1070ui_story"]) and arg_110_1.var_.characterEffect1070ui_story == nil then
				arg_110_1.var_.characterEffect1070ui_story = arg_110_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["1070ui_story"]) then
				if arg_110_1.var_.characterEffect1070ui_story and not isNil(arg_110_1.actors_["1070ui_story"]) then
					arg_110_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["1070ui_story"]) and arg_110_1.var_.characterEffect1070ui_story then
				arg_110_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_113_2 = arg_110_1.actors_["10171ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect10171ui_story == nil then
				arg_110_1.var_.characterEffect10171ui_story = var_113_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_3 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_3 and not isNil(var_113_2) then
				if arg_110_1.var_.characterEffect10171ui_story and not isNil(var_113_2) then
					arg_110_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_110_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_3)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_3 and arg_110_1.time_ < 0 + var_113_3 + arg_113_0 and not isNil(var_113_2) and arg_110_1.var_.characterEffect10171ui_story then
				arg_110_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_110_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_113_4 = 0
			local var_113_5 = 0.3

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_4 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_6 = arg_110_1:GetWordFromCfg(324081026)
				local var_113_7 = arg_110_1:FormatText(var_113_6.content)

				arg_110_1.text_.text = var_113_7

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_9 = 12 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 12)

				if (12 <= 0 and var_113_5 or var_113_5 * (utf8.len(var_113_7) / 12)) > 0 and var_113_5 < var_113_9 then
					arg_110_1.talkMaxDuration = var_113_9

					if var_113_9 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_9 + var_113_4
					end
				end

				arg_110_1.text_.text = var_113_7
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081026", "story_v_out_324081.awb") ~= 0 then
					local var_113_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081026", "story_v_out_324081.awb") / 1000

					if var_113_10 + var_113_4 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_10 + var_113_4
					end

					if var_113_6.prefab_name ~= "" and arg_110_1.actors_[var_113_6.prefab_name] ~= nil then
						local var_113_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_6.prefab_name].transform, "story_v_out_324081", "324081026", "story_v_out_324081.awb")

						arg_110_1:RecordAudio("324081026", var_113_11)
						arg_110_1:RecordAudio("324081026", var_113_11)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_324081", "324081026", "story_v_out_324081.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_324081", "324081026", "story_v_out_324081.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_12 = math.max(var_113_5, arg_110_1.talkMaxDuration)

			if var_113_4 <= arg_110_1.time_ and arg_110_1.time_ < var_113_4 + var_113_12 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_4) / var_113_12

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_4 + var_113_12 and arg_110_1.time_ < var_113_4 + var_113_12 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play324081027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 324081027
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play324081028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos1070ui_story = arg_114_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_117_0 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 then
				arg_114_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_0)
				arg_114_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1070ui_story"].transform.position).z)
				arg_114_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1070ui_story"].transform.localEulerAngles = arg_114_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 then
				arg_114_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_114_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_114_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_114_1.actors_["1070ui_story"].transform.position).z)
				arg_114_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_114_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_114_1.actors_["1070ui_story"].transform.localEulerAngles = arg_114_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_117_1 = arg_114_1.actors_["10171ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos10171ui_story = var_117_1.localPosition

				local var_117_2 = GameObjectTools.GetOrAddComponent(var_117_1.gameObject, typeof(DynamicBoneHelper))

				if var_117_2 then
					var_117_2:EnableDynamicBone(false)
				end
			end

			local var_117_3 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_3 then
				var_117_1.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_3)
				var_117_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_1.position).x, (manager.ui.mainCamera.transform.position - var_117_1.position).y, (manager.ui.mainCamera.transform.position - var_117_1.position).z)
				var_117_1.localEulerAngles.z = 0
				var_117_1.localEulerAngles.x = 0
				var_117_1.localEulerAngles = var_117_1.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_3 and arg_114_1.time_ < 0 + var_117_3 + arg_117_0 then
				var_117_1.localPosition = Vector3.New(0, 100, 0)
				var_117_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_1.position).x, (manager.ui.mainCamera.transform.position - var_117_1.position).y, (manager.ui.mainCamera.transform.position - var_117_1.position).z)
				var_117_1.localEulerAngles.z = 0
				var_117_1.localEulerAngles.x = 0
				var_117_1.localEulerAngles = var_117_1.localEulerAngles

				local var_117_4 = GameObjectTools.GetOrAddComponent(var_117_1.gameObject, typeof(DynamicBoneHelper))

				if var_117_4 then
					var_117_4:EnableDynamicBone(true)
				end
			end

			local var_117_5 = arg_114_1.actors_["1070ui_story"]

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.characterEffect1070ui_story == nil then
				arg_114_1.var_.characterEffect1070ui_story = var_117_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_6 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_6 and not isNil(var_117_5) then
				if arg_114_1.var_.characterEffect1070ui_story and not isNil(var_117_5) then
					arg_114_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_6)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_6 and arg_114_1.time_ < 0 + var_117_6 + arg_117_0 and not isNil(var_117_5) and arg_114_1.var_.characterEffect1070ui_story then
				arg_114_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_117_7 = 0
			local var_117_8 = 1.7

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_7 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_9 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(324081027).content)

				arg_114_1.text_.text = var_117_9

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_11 = 68 <= 0 and var_117_8 or var_117_8 * (utf8.len(var_117_9) / 68)

				if (68 <= 0 and var_117_8 or var_117_8 * (utf8.len(var_117_9) / 68)) > 0 and var_117_8 < var_117_11 then
					arg_114_1.talkMaxDuration = var_117_11

					if var_117_11 + var_117_7 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_11 + var_117_7
					end
				end

				arg_114_1.text_.text = var_117_9
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_12 = math.max(var_117_8, arg_114_1.talkMaxDuration)

			if var_117_7 <= arg_114_1.time_ and arg_114_1.time_ < var_117_7 + var_117_12 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_7) / var_117_12

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_7 + var_117_12 and arg_114_1.time_ < var_117_7 + var_117_12 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play324081028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 324081028
		arg_118_1.duration_ = 1.27

		local var_118_0 = {
			zh = 1.2,
			ja = 1.266
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play324081029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos1070ui_story = arg_118_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_121_0 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 then
				arg_118_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_118_1.time_ - 0) / var_121_0)
				arg_118_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1070ui_story"].transform.position).z)
				arg_118_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1070ui_story"].transform.localEulerAngles = arg_118_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 then
				arg_118_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_118_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_118_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_118_1.actors_["1070ui_story"].transform.position).z)
				arg_118_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_118_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_118_1.actors_["1070ui_story"].transform.localEulerAngles = arg_118_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_121_1 = arg_118_1.actors_["1070ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1070ui_story == nil then
				arg_118_1.var_.characterEffect1070ui_story = var_121_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_2 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_2 and not isNil(var_121_1) then
				if arg_118_1.var_.characterEffect1070ui_story and not isNil(var_121_1) then
					arg_118_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_2 and arg_118_1.time_ < 0 + var_121_2 + arg_121_0 and not isNil(var_121_1) and arg_118_1.var_.characterEffect1070ui_story then
				arg_118_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_121_4 = 0
			local var_121_5 = 0.1

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_6 = arg_118_1:GetWordFromCfg(324081028)
				local var_121_7 = arg_118_1:FormatText(var_121_6.content)

				arg_118_1.text_.text = var_121_7

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_9 = 4 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 4)

				if (4 <= 0 and var_121_5 or var_121_5 * (utf8.len(var_121_7) / 4)) > 0 and var_121_5 < var_121_9 then
					arg_118_1.talkMaxDuration = var_121_9

					if var_121_9 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_9 + var_121_4
					end
				end

				arg_118_1.text_.text = var_121_7
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081028", "story_v_out_324081.awb") ~= 0 then
					local var_121_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081028", "story_v_out_324081.awb") / 1000

					if var_121_10 + var_121_4 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_10 + var_121_4
					end

					if var_121_6.prefab_name ~= "" and arg_118_1.actors_[var_121_6.prefab_name] ~= nil then
						local var_121_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_6.prefab_name].transform, "story_v_out_324081", "324081028", "story_v_out_324081.awb")

						arg_118_1:RecordAudio("324081028", var_121_11)
						arg_118_1:RecordAudio("324081028", var_121_11)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_324081", "324081028", "story_v_out_324081.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_324081", "324081028", "story_v_out_324081.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = math.max(var_121_5, arg_118_1.talkMaxDuration)

			if var_121_4 <= arg_118_1.time_ and arg_118_1.time_ < var_121_4 + var_121_12 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_4) / var_121_12

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_4 + var_121_12 and arg_118_1.time_ < var_121_4 + var_121_12 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play324081029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 324081029
		arg_122_1.duration_ = 2.37

		local var_122_0 = {
			zh = 1.999999999999,
			ja = 2.366
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play324081030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos10171ui_story = arg_122_1.actors_["10171ui_story"].transform.localPosition

				local var_125_0 = GameObjectTools.GetOrAddComponent(arg_122_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_125_0 then
					var_125_0:EnableDynamicBone(false)
				end
			end

			local var_125_1 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_1 then
				arg_122_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_122_1.time_ - 0) / var_125_1)
				arg_122_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10171ui_story"].transform.position).z)
				arg_122_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["10171ui_story"].transform.localEulerAngles = arg_122_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_1 and arg_122_1.time_ < 0 + var_125_1 + arg_125_0 then
				arg_122_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_122_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_122_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_122_1.actors_["10171ui_story"].transform.position).z)
				arg_122_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_122_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_122_1.actors_["10171ui_story"].transform.localEulerAngles = arg_122_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_125_2 = GameObjectTools.GetOrAddComponent(arg_122_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_125_2 then
					var_125_2:EnableDynamicBone(true)
				end
			end

			local var_125_3 = arg_122_1.actors_["10171ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_3) and arg_122_1.var_.characterEffect10171ui_story == nil then
				arg_122_1.var_.characterEffect10171ui_story = var_125_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_4 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 and not isNil(var_125_3) then
				if arg_122_1.var_.characterEffect10171ui_story and not isNil(var_125_3) then
					arg_122_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 and not isNil(var_125_3) and arg_122_1.var_.characterEffect10171ui_story then
				arg_122_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_125_6 = arg_122_1.actors_["1070ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_6) and arg_122_1.var_.characterEffect1070ui_story == nil then
				arg_122_1.var_.characterEffect1070ui_story = var_125_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_7 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 and not isNil(var_125_6) then
				if arg_122_1.var_.characterEffect1070ui_story and not isNil(var_125_6) then
					arg_122_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_122_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_7)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 and not isNil(var_125_6) and arg_122_1.var_.characterEffect1070ui_story then
				arg_122_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_122_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_125_8 = 0
			local var_125_9 = 0.15

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_10 = arg_122_1:GetWordFromCfg(324081029)
				local var_125_11 = arg_122_1:FormatText(var_125_10.content)

				arg_122_1.text_.text = var_125_11

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 6 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 6)

				if (6 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 6)) > 0 and var_125_9 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_8
					end
				end

				arg_122_1.text_.text = var_125_11
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081029", "story_v_out_324081.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081029", "story_v_out_324081.awb") / 1000

					if var_125_14 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_8
					end

					if var_125_10.prefab_name ~= "" and arg_122_1.actors_[var_125_10.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_10.prefab_name].transform, "story_v_out_324081", "324081029", "story_v_out_324081.awb")

						arg_122_1:RecordAudio("324081029", var_125_15)
						arg_122_1:RecordAudio("324081029", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_324081", "324081029", "story_v_out_324081.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_324081", "324081029", "story_v_out_324081.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_9, arg_122_1.talkMaxDuration)

			if var_125_8 <= arg_122_1.time_ and arg_122_1.time_ < var_125_8 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_8) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_8 + var_125_16 and arg_122_1.time_ < var_125_8 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play324081030 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 324081030
		arg_126_1.duration_ = 6.07

		local var_126_0 = {
			zh = 6.06633333333333,
			ja = 5.86633333333333
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play324081031(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if arg_126_1.bgs_.J22g == nil then
				local var_129_0 = Object.Instantiate(arg_126_1.paintGo_)

				var_129_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J22g")
				var_129_0.name = "J22g"
				var_129_0.transform.parent = arg_126_1.stage_.transform
				var_129_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_126_1.bgs_.J22g = var_129_0
			end

			if 1.56666666666667 < arg_126_1.time_ and arg_126_1.time_ <= 1.56666666666667 + arg_129_0 then
				local var_129_1 = arg_126_1.bgs_.J22g

				arg_126_1.bgs_.J22g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_129_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_129_2 = var_129_1:GetComponent("SpriteRenderer")

				if var_129_2 and var_129_2.sprite then
					local var_129_3 = 2 * (var_129_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_129_1.transform.localScale = Vector3.New(var_129_3 / var_129_2.sprite.bounds.size.y < var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x and var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x or var_129_3 / var_129_2.sprite.bounds.size.y, var_129_3 / var_129_2.sprite.bounds.size.y < var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x and var_129_3 * manager.ui.mainCameraCom_.aspect / var_129_2.sprite.bounds.size.x or var_129_3 / var_129_2.sprite.bounds.size.y, 0)
				end

				for iter_129_0, iter_129_1 in pairs(arg_126_1.bgs_) do
					if iter_129_0 ~= "J22g" then
						iter_129_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_129_4 = 1.56666666666667

			if 1.56666666666667 < arg_126_1.time_ and arg_126_1.time_ <= var_129_4 + arg_129_0 then
				arg_126_1.allBtn_.enabled = false
			end

			if arg_126_1.time_ >= var_129_4 + 0.3 and arg_126_1.time_ < var_129_4 + 0.3 + arg_129_0 then
				arg_126_1.allBtn_.enabled = true
			end

			local var_129_5 = 0

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_5 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_6 = 1.56666666666667

			if var_129_5 <= arg_126_1.time_ and arg_126_1.time_ < var_129_5 + var_129_6 then
				local var_129_7 = Color.New(0, 0, 0)

				var_129_7.a = Mathf.Lerp(0, 1, (arg_126_1.time_ - var_129_5) / var_129_6)
				arg_126_1.mask_.color = var_129_7
			end

			if arg_126_1.time_ >= var_129_5 + var_129_6 and arg_126_1.time_ < var_129_5 + var_129_6 + arg_129_0 then
				local var_129_8 = Color.New(0, 0, 0)

				var_129_8.a = 1
				arg_126_1.mask_.color = var_129_8
			end

			local var_129_9 = 1.56666666666667

			if 1.56666666666667 < arg_126_1.time_ and arg_126_1.time_ <= var_129_9 + arg_129_0 then
				arg_126_1.mask_.enabled = true
				arg_126_1.mask_.raycastTarget = true

				arg_126_1:SetGaussion(false)
			end

			local var_129_10 = 2

			if var_129_9 <= arg_126_1.time_ and arg_126_1.time_ < var_129_9 + var_129_10 then
				local var_129_11 = Color.New(0, 0, 0)

				var_129_11.a = Mathf.Lerp(1, 0, (arg_126_1.time_ - var_129_9) / var_129_10)
				arg_126_1.mask_.color = var_129_11
			end

			if arg_126_1.time_ >= var_129_9 + var_129_10 and arg_126_1.time_ < var_129_9 + var_129_10 + arg_129_0 then
				local var_129_12 = Color.New(0, 0, 0)

				arg_126_1.mask_.enabled = false
				var_129_12.a = 0
				arg_126_1.mask_.color = var_129_12
			end

			local var_129_13 = arg_126_1.actors_["10171ui_story"]

			if 1.56666666666667 < arg_126_1.time_ and arg_126_1.time_ <= 1.56666666666667 + arg_129_0 and not isNil(var_129_13) and arg_126_1.var_.characterEffect10171ui_story == nil then
				arg_126_1.var_.characterEffect10171ui_story = var_129_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_14 = 0.200000002980232

			if 1.56666666666667 <= arg_126_1.time_ and arg_126_1.time_ < 1.56666666666667 + var_129_14 and not isNil(var_129_13) then
				if arg_126_1.var_.characterEffect10171ui_story and not isNil(var_129_13) then
					arg_126_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_126_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 1.56666666666667) / var_129_14)
				end
			end

			if arg_126_1.time_ >= 1.56666666666667 + var_129_14 and arg_126_1.time_ < 1.56666666666667 + var_129_14 + arg_129_0 and not isNil(var_129_13) and arg_126_1.var_.characterEffect10171ui_story then
				arg_126_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_126_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_129_15 = arg_126_1.actors_["10171ui_story"].transform

			if 1.56666666666667 < arg_126_1.time_ and arg_126_1.time_ <= 1.56666666666667 + arg_129_0 then
				arg_126_1.var_.moveOldPos10171ui_story = var_129_15.localPosition

				local var_129_16 = GameObjectTools.GetOrAddComponent(var_129_15.gameObject, typeof(DynamicBoneHelper))

				if var_129_16 then
					var_129_16:EnableDynamicBone(false)
				end
			end

			local var_129_17 = 0.001

			if 1.56666666666667 <= arg_126_1.time_ and arg_126_1.time_ < 1.56666666666667 + var_129_17 then
				var_129_15.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 1.56666666666667) / var_129_17)
				var_129_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_15.position).x, (manager.ui.mainCamera.transform.position - var_129_15.position).y, (manager.ui.mainCamera.transform.position - var_129_15.position).z)
				var_129_15.localEulerAngles.z = 0
				var_129_15.localEulerAngles.x = 0
				var_129_15.localEulerAngles = var_129_15.localEulerAngles
			end

			if arg_126_1.time_ >= 1.56666666666667 + var_129_17 and arg_126_1.time_ < 1.56666666666667 + var_129_17 + arg_129_0 then
				var_129_15.localPosition = Vector3.New(0, 100, 0)
				var_129_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_15.position).x, (manager.ui.mainCamera.transform.position - var_129_15.position).y, (manager.ui.mainCamera.transform.position - var_129_15.position).z)
				var_129_15.localEulerAngles.z = 0
				var_129_15.localEulerAngles.x = 0
				var_129_15.localEulerAngles = var_129_15.localEulerAngles

				local var_129_18 = GameObjectTools.GetOrAddComponent(var_129_15.gameObject, typeof(DynamicBoneHelper))

				if var_129_18 then
					var_129_18:EnableDynamicBone(true)
				end
			end

			local var_129_19 = arg_126_1.actors_["1070ui_story"].transform

			if 1.56666666666667 < arg_126_1.time_ and arg_126_1.time_ <= 1.56666666666667 + arg_129_0 then
				arg_126_1.var_.moveOldPos1070ui_story = var_129_19.localPosition
			end

			local var_129_20 = 0.001

			if 1.56666666666667 <= arg_126_1.time_ and arg_126_1.time_ < 1.56666666666667 + var_129_20 then
				var_129_19.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 1.56666666666667) / var_129_20)
				var_129_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_19.position).x, (manager.ui.mainCamera.transform.position - var_129_19.position).y, (manager.ui.mainCamera.transform.position - var_129_19.position).z)
				var_129_19.localEulerAngles.z = 0
				var_129_19.localEulerAngles.x = 0
				var_129_19.localEulerAngles = var_129_19.localEulerAngles
			end

			if arg_126_1.time_ >= 1.56666666666667 + var_129_20 and arg_126_1.time_ < 1.56666666666667 + var_129_20 + arg_129_0 then
				var_129_19.localPosition = Vector3.New(0, 100, 0)
				var_129_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_19.position).x, (manager.ui.mainCamera.transform.position - var_129_19.position).y, (manager.ui.mainCamera.transform.position - var_129_19.position).z)
				var_129_19.localEulerAngles.z = 0
				var_129_19.localEulerAngles.x = 0
				var_129_19.localEulerAngles = var_129_19.localEulerAngles
			end

			if 1.2 < arg_126_1.time_ and arg_126_1.time_ <= 1.2 + arg_129_0 then
				arg_126_1:AudioAction("play", "effect", "se_story_145", "se_story_145_amb_construction", "")
			end

			if 0.1 < arg_126_1.time_ and arg_126_1.time_ <= 0.1 + arg_129_0 then
				arg_126_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_lost_city", "")
			end

			if arg_126_1.frameCnt_ <= 1 then
				arg_126_1.dialog_:SetActive(false)
			end

			local var_129_23 = 3.13333333333333
			local var_129_24 = 0.225

			if 3.13333333333333 < arg_126_1.time_ and arg_126_1.time_ <= var_129_23 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0

				arg_126_1.dialog_:SetActive(true)

				arg_126_1.dialogCg_.alpha = 0

				local var_129_25 = LeanTween.value(arg_126_1.dialog_, 0, 1, 0.3)

				var_129_25:setOnUpdate(LuaHelper.FloatAction(function(arg_130_0)
					arg_126_1.dialogCg_.alpha = arg_130_0
				end))
				var_129_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_126_1.dialog_)
					var_129_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_126_1.duration_ = arg_126_1.duration_ + 0.3

				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_26 = arg_126_1:GetWordFromCfg(324081030)
				local var_129_27 = arg_126_1:FormatText(var_129_26.content)

				arg_126_1.text_.text = var_129_27

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_29 = 9 <= 0 and var_129_24 or var_129_24 * (utf8.len(var_129_27) / 9)

				if (9 <= 0 and var_129_24 or var_129_24 * (utf8.len(var_129_27) / 9)) > 0 and var_129_24 < var_129_29 then
					arg_126_1.talkMaxDuration = var_129_29
					var_129_23 = var_129_23 + 0.3

					if var_129_29 + var_129_23 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_29 + var_129_23
					end
				end

				arg_126_1.text_.text = var_129_27
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081030", "story_v_out_324081.awb") ~= 0 then
					local var_129_30 = manager.audio:GetVoiceLength("story_v_out_324081", "324081030", "story_v_out_324081.awb") / 1000

					if var_129_30 + var_129_23 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_30 + var_129_23
					end

					if var_129_26.prefab_name ~= "" and arg_126_1.actors_[var_129_26.prefab_name] ~= nil then
						local var_129_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_26.prefab_name].transform, "story_v_out_324081", "324081030", "story_v_out_324081.awb")

						arg_126_1:RecordAudio("324081030", var_129_31)
						arg_126_1:RecordAudio("324081030", var_129_31)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_324081", "324081030", "story_v_out_324081.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_324081", "324081030", "story_v_out_324081.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_32 = var_129_23 + 0.3
			local var_129_33 = math.max(var_129_24, arg_126_1.talkMaxDuration)

			if var_129_23 + 0.3 <= arg_126_1.time_ and arg_126_1.time_ < var_129_32 + var_129_33 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_32) / var_129_33

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_32 + var_129_33 and arg_126_1.time_ < var_129_32 + var_129_33 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.56666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play324081031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324081031
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play324081032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos1070ui_story = arg_132_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_135_0 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 then
				arg_132_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_0)
				arg_132_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1070ui_story"].transform.position).z)
				arg_132_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1070ui_story"].transform.localEulerAngles = arg_132_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 then
				arg_132_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_132_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_132_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_132_1.actors_["1070ui_story"].transform.position).z)
				arg_132_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_132_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_132_1.actors_["1070ui_story"].transform.localEulerAngles = arg_132_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_135_1 = arg_132_1.actors_["10171ui_story"].transform

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.var_.moveOldPos10171ui_story = var_135_1.localPosition

				local var_135_2 = GameObjectTools.GetOrAddComponent(var_135_1.gameObject, typeof(DynamicBoneHelper))

				if var_135_2 then
					var_135_2:EnableDynamicBone(false)
				end
			end

			local var_135_3 = 0.001

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 then
				var_135_1.localPosition = Vector3.Lerp(arg_132_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_132_1.time_ - 0) / var_135_3)
				var_135_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_1.position).x, (manager.ui.mainCamera.transform.position - var_135_1.position).y, (manager.ui.mainCamera.transform.position - var_135_1.position).z)
				var_135_1.localEulerAngles.z = 0
				var_135_1.localEulerAngles.x = 0
				var_135_1.localEulerAngles = var_135_1.localEulerAngles
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 then
				var_135_1.localPosition = Vector3.New(0, 100, 0)
				var_135_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_135_1.position).x, (manager.ui.mainCamera.transform.position - var_135_1.position).y, (manager.ui.mainCamera.transform.position - var_135_1.position).z)
				var_135_1.localEulerAngles.z = 0
				var_135_1.localEulerAngles.x = 0
				var_135_1.localEulerAngles = var_135_1.localEulerAngles

				local var_135_4 = GameObjectTools.GetOrAddComponent(var_135_1.gameObject, typeof(DynamicBoneHelper))

				if var_135_4 then
					var_135_4:EnableDynamicBone(true)
				end
			end

			if 0.6 < arg_132_1.time_ and arg_132_1.time_ <= 0.6 + arg_135_0 then
				arg_132_1:AudioAction("play", "effect", "se_story_140", "se_story_140_footstep_run01", "")
			end

			local var_135_6 = 0
			local var_135_7 = 1.2

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_6 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_8 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(324081031).content)

				arg_132_1.text_.text = var_135_8

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_10 = 48 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_8) / 48)

				if (48 <= 0 and var_135_7 or var_135_7 * (utf8.len(var_135_8) / 48)) > 0 and var_135_7 < var_135_10 then
					arg_132_1.talkMaxDuration = var_135_10

					if var_135_10 + var_135_6 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_6
					end
				end

				arg_132_1.text_.text = var_135_8
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_11 = math.max(var_135_7, arg_132_1.talkMaxDuration)

			if var_135_6 <= arg_132_1.time_ and arg_132_1.time_ < var_135_6 + var_135_11 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_6) / var_135_11

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_6 + var_135_11 and arg_132_1.time_ < var_135_6 + var_135_11 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_132_1:InitPlayNodeList()
	end,
	Play324081032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324081032
		arg_136_1.duration_ = 3.9

		local var_136_0 = {
			zh = 2.933,
			ja = 3.9
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play324081033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.325

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_1 = arg_136_1:GetWordFromCfg(324081032)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 13 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 13)

				if (13 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 13)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081032", "story_v_out_324081.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081032", "story_v_out_324081.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_324081", "324081032", "story_v_out_324081.awb")

						arg_136_1:RecordAudio("324081032", var_139_6)
						arg_136_1:RecordAudio("324081032", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_324081", "324081032", "story_v_out_324081.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_324081", "324081032", "story_v_out_324081.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_7 = math.max(var_139_0, arg_136_1.talkMaxDuration)

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_7 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - 0) / var_139_7

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= 0 + var_139_7 and arg_136_1.time_ < 0 + var_139_7 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play324081033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324081033
		arg_140_1.duration_ = 3.7

		local var_140_0 = {
			zh = 3.166,
			ja = 3.7
		}
		local var_140_1 = manager.audio:GetLocalizationFlag()

		if var_140_0[var_140_1] ~= nil then
			arg_140_1.duration_ = var_140_0[var_140_1]
		end

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play324081034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.425

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[1452].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_bossma")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_1 = arg_140_1:GetWordFromCfg(324081033)
				local var_143_2 = arg_140_1:FormatText(var_143_1.content)

				arg_140_1.text_.text = var_143_2

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 17 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 17)

				if (17 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 17)) > 0 and var_143_0 < var_143_4 then
					arg_140_1.talkMaxDuration = var_143_4

					if var_143_4 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_4 + 0
					end
				end

				arg_140_1.text_.text = var_143_2
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081033", "story_v_out_324081.awb") ~= 0 then
					local var_143_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081033", "story_v_out_324081.awb") / 1000

					if var_143_5 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + 0
					end

					if var_143_1.prefab_name ~= "" and arg_140_1.actors_[var_143_1.prefab_name] ~= nil then
						local var_143_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_1.prefab_name].transform, "story_v_out_324081", "324081033", "story_v_out_324081.awb")

						arg_140_1:RecordAudio("324081033", var_143_6)
						arg_140_1:RecordAudio("324081033", var_143_6)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_324081", "324081033", "story_v_out_324081.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_324081", "324081033", "story_v_out_324081.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play324081034 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 324081034
		arg_144_1.duration_ = 4.23

		local var_144_0 = {
			zh = 3.3,
			ja = 4.233
		}
		local var_144_1 = manager.audio:GetLocalizationFlag()

		if var_144_0[var_144_1] ~= nil then
			arg_144_1.duration_ = var_144_0[var_144_1]
		end

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play324081035(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.375

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:GetWordFromCfg(324081034)
				local var_147_2 = arg_144_1:FormatText(var_147_1.content)

				arg_144_1.text_.text = var_147_2

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_4 = 15 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 15)

				if (15 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_2) / 15)) > 0 and var_147_0 < var_147_4 then
					arg_144_1.talkMaxDuration = var_147_4

					if var_147_4 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_4 + 0
					end
				end

				arg_144_1.text_.text = var_147_2
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081034", "story_v_out_324081.awb") ~= 0 then
					local var_147_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081034", "story_v_out_324081.awb") / 1000

					if var_147_5 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + 0
					end

					if var_147_1.prefab_name ~= "" and arg_144_1.actors_[var_147_1.prefab_name] ~= nil then
						local var_147_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_1.prefab_name].transform, "story_v_out_324081", "324081034", "story_v_out_324081.awb")

						arg_144_1:RecordAudio("324081034", var_147_6)
						arg_144_1:RecordAudio("324081034", var_147_6)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_324081", "324081034", "story_v_out_324081.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_324081", "324081034", "story_v_out_324081.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_7 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_7 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_7

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_7 and arg_144_1.time_ < 0 + var_147_7 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play324081035 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 324081035
		arg_148_1.duration_ = 8

		local var_148_0 = {
			zh = 6.4,
			ja = 8
		}
		local var_148_1 = manager.audio:GetLocalizationFlag()

		if var_148_0[var_148_1] ~= nil then
			arg_148_1.duration_ = var_148_0[var_148_1]
		end

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play324081036(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.7

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_1 = arg_148_1:GetWordFromCfg(324081035)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 28 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 28)

				if (28 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 28)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081035", "story_v_out_324081.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081035", "story_v_out_324081.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_324081", "324081035", "story_v_out_324081.awb")

						arg_148_1:RecordAudio("324081035", var_151_6)
						arg_148_1:RecordAudio("324081035", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_324081", "324081035", "story_v_out_324081.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_324081", "324081035", "story_v_out_324081.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play324081036 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 324081036
		arg_152_1.duration_ = 6.1

		local var_152_0 = {
			zh = 5.4,
			ja = 6.1
		}
		local var_152_1 = manager.audio:GetLocalizationFlag()

		if var_152_0[var_152_1] ~= nil then
			arg_152_1.duration_ = var_152_0[var_152_1]
		end

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play324081037(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.65

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_1 = arg_152_1:GetWordFromCfg(324081036)
				local var_155_2 = arg_152_1:FormatText(var_155_1.content)

				arg_152_1.text_.text = var_155_2

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_4 = 26 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 26)

				if (26 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_2) / 26)) > 0 and var_155_0 < var_155_4 then
					arg_152_1.talkMaxDuration = var_155_4

					if var_155_4 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_4 + 0
					end
				end

				arg_152_1.text_.text = var_155_2
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081036", "story_v_out_324081.awb") ~= 0 then
					local var_155_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081036", "story_v_out_324081.awb") / 1000

					if var_155_5 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + 0
					end

					if var_155_1.prefab_name ~= "" and arg_152_1.actors_[var_155_1.prefab_name] ~= nil then
						local var_155_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_1.prefab_name].transform, "story_v_out_324081", "324081036", "story_v_out_324081.awb")

						arg_152_1:RecordAudio("324081036", var_155_6)
						arg_152_1:RecordAudio("324081036", var_155_6)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_324081", "324081036", "story_v_out_324081.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_324081", "324081036", "story_v_out_324081.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_7 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_7

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play324081037 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 324081037
		arg_156_1.duration_ = 5.63

		local var_156_0 = {
			zh = 4.3,
			ja = 5.633
		}
		local var_156_1 = manager.audio:GetLocalizationFlag()

		if var_156_0[var_156_1] ~= nil then
			arg_156_1.duration_ = var_156_0[var_156_1]
		end

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play324081038(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.575

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, true)
				arg_156_1.iconController_:SetSelectedState("hero")

				arg_156_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_156_1.callingController_:SetSelectedState("normal")

				arg_156_1.keyicon_.color = Color.New(1, 1, 1)
				arg_156_1.icon_.color = Color.New(1, 1, 1)

				local var_159_1 = arg_156_1:GetWordFromCfg(324081037)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 23 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 23)

				if (23 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 23)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081037", "story_v_out_324081.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081037", "story_v_out_324081.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_324081", "324081037", "story_v_out_324081.awb")

						arg_156_1:RecordAudio("324081037", var_159_6)
						arg_156_1:RecordAudio("324081037", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_324081", "324081037", "story_v_out_324081.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_324081", "324081037", "story_v_out_324081.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_7 = math.max(var_159_0, arg_156_1.talkMaxDuration)

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_7 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - 0) / var_159_7

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= 0 + var_159_7 and arg_156_1.time_ < 0 + var_159_7 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play324081038 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 324081038
		arg_160_1.duration_ = 7.6

		local var_160_0 = {
			zh = 5.633,
			ja = 7.6
		}
		local var_160_1 = manager.audio:GetLocalizationFlag()

		if var_160_0[var_160_1] ~= nil then
			arg_160_1.duration_ = var_160_0[var_160_1]
		end

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play324081039(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.725

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_1 = arg_160_1:GetWordFromCfg(324081038)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 29 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 29)

				if (29 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 29)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081038", "story_v_out_324081.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081038", "story_v_out_324081.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_324081", "324081038", "story_v_out_324081.awb")

						arg_160_1:RecordAudio("324081038", var_163_6)
						arg_160_1:RecordAudio("324081038", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_324081", "324081038", "story_v_out_324081.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_324081", "324081038", "story_v_out_324081.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_0, arg_160_1.talkMaxDuration)

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - 0) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= 0 + var_163_7 and arg_160_1.time_ < 0 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play324081039 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 324081039
		arg_164_1.duration_ = 3.1

		local var_164_0 = {
			zh = 2.6,
			ja = 3.1
		}
		local var_164_1 = manager.audio:GetLocalizationFlag()

		if var_164_0[var_164_1] ~= nil then
			arg_164_1.duration_ = var_164_0[var_164_1]
		end

		SetActive(arg_164_1.tipsGo_, false)

		function arg_164_1.onSingleLineFinish_()
			arg_164_1.onSingleLineUpdate_ = nil
			arg_164_1.onSingleLineFinish_ = nil
			arg_164_1.state_ = "waiting"
		end

		function arg_164_1.playNext_(arg_166_0)
			if arg_166_0 == 1 then
				arg_164_0:Play324081040(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.3

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_1 = arg_164_1:GetWordFromCfg(324081039)
				local var_167_2 = arg_164_1:FormatText(var_167_1.content)

				arg_164_1.text_.text = var_167_2

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 12 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 12)

				if (12 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 12)) > 0 and var_167_0 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end

				arg_164_1.text_.text = var_167_2
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081039", "story_v_out_324081.awb") ~= 0 then
					local var_167_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081039", "story_v_out_324081.awb") / 1000

					if var_167_5 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + 0
					end

					if var_167_1.prefab_name ~= "" and arg_164_1.actors_[var_167_1.prefab_name] ~= nil then
						local var_167_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_1.prefab_name].transform, "story_v_out_324081", "324081039", "story_v_out_324081.awb")

						arg_164_1:RecordAudio("324081039", var_167_6)
						arg_164_1:RecordAudio("324081039", var_167_6)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_324081", "324081039", "story_v_out_324081.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_324081", "324081039", "story_v_out_324081.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_7 = math.max(var_167_0, arg_164_1.talkMaxDuration)

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_7 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - 0) / var_167_7

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= 0 + var_167_7 and arg_164_1.time_ < 0 + var_167_7 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play324081040 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 324081040
		arg_168_1.duration_ = 3.97

		local var_168_0 = {
			zh = 2.666,
			ja = 3.966
		}
		local var_168_1 = manager.audio:GetLocalizationFlag()

		if var_168_0[var_168_1] ~= nil then
			arg_168_1.duration_ = var_168_0[var_168_1]
		end

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play324081041(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.175

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, true)
				arg_168_1.iconController_:SetSelectedState("hero")

				arg_168_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_168_1.callingController_:SetSelectedState("normal")

				arg_168_1.keyicon_.color = Color.New(1, 1, 1)
				arg_168_1.icon_.color = Color.New(1, 1, 1)

				local var_171_1 = arg_168_1:GetWordFromCfg(324081040)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 7 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 7)

				if (7 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 7)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081040", "story_v_out_324081.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081040", "story_v_out_324081.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_out_324081", "324081040", "story_v_out_324081.awb")

						arg_168_1:RecordAudio("324081040", var_171_6)
						arg_168_1:RecordAudio("324081040", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_324081", "324081040", "story_v_out_324081.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_324081", "324081040", "story_v_out_324081.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_7 = math.max(var_171_0, arg_168_1.talkMaxDuration)

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_7 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - 0) / var_171_7

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= 0 + var_171_7 and arg_168_1.time_ < 0 + var_171_7 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play324081041 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324081041
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324081042(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			local var_175_0 = 1.225

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_1 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(324081041).content)

				arg_172_1.text_.text = var_175_1

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_3 = 49 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 49)

				if (49 <= 0 and var_175_0 or var_175_0 * (utf8.len(var_175_1) / 49)) > 0 and var_175_0 < var_175_3 then
					arg_172_1.talkMaxDuration = var_175_3

					if var_175_3 + 0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_3 + 0
					end
				end

				arg_172_1.text_.text = var_175_1
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_4 = math.max(var_175_0, arg_172_1.talkMaxDuration)

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_4 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - 0) / var_175_4

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= 0 + var_175_4 and arg_172_1.time_ < 0 + var_175_4 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play324081042 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 324081042
		arg_176_1.duration_ = 2

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play324081043(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos10171ui_story = arg_176_1.actors_["10171ui_story"].transform.localPosition

				local var_179_0 = GameObjectTools.GetOrAddComponent(arg_176_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_179_0 then
					var_179_0:EnableDynamicBone(false)
				end
			end

			local var_179_1 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_1 then
				arg_176_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_176_1.time_ - 0) / var_179_1)
				arg_176_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10171ui_story"].transform.position).z)
				arg_176_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["10171ui_story"].transform.localEulerAngles = arg_176_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_1 and arg_176_1.time_ < 0 + var_179_1 + arg_179_0 then
				arg_176_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_176_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["10171ui_story"].transform.position).z)
				arg_176_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["10171ui_story"].transform.localEulerAngles = arg_176_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_179_2 = GameObjectTools.GetOrAddComponent(arg_176_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_179_2 then
					var_179_2:EnableDynamicBone(true)
				end
			end

			local var_179_3 = arg_176_1.actors_["10171ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_3) and arg_176_1.var_.characterEffect10171ui_story == nil then
				arg_176_1.var_.characterEffect10171ui_story = var_179_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_4 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_4 and not isNil(var_179_3) then
				if arg_176_1.var_.characterEffect10171ui_story and not isNil(var_179_3) then
					arg_176_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_4 and arg_176_1.time_ < 0 + var_179_4 + arg_179_0 and not isNil(var_179_3) and arg_176_1.var_.characterEffect10171ui_story then
				arg_176_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action28_1")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_179_6 = 0
			local var_179_7 = 0.075

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_6 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_8 = arg_176_1:GetWordFromCfg(324081042)
				local var_179_9 = arg_176_1:FormatText(var_179_8.content)

				arg_176_1.text_.text = var_179_9

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_11 = 3 <= 0 and var_179_7 or var_179_7 * (utf8.len(var_179_9) / 3)

				if (3 <= 0 and var_179_7 or var_179_7 * (utf8.len(var_179_9) / 3)) > 0 and var_179_7 < var_179_11 then
					arg_176_1.talkMaxDuration = var_179_11

					if var_179_11 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_11 + var_179_6
					end
				end

				arg_176_1.text_.text = var_179_9
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081042", "story_v_out_324081.awb") ~= 0 then
					local var_179_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081042", "story_v_out_324081.awb") / 1000

					if var_179_12 + var_179_6 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_12 + var_179_6
					end

					if var_179_8.prefab_name ~= "" and arg_176_1.actors_[var_179_8.prefab_name] ~= nil then
						local var_179_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_8.prefab_name].transform, "story_v_out_324081", "324081042", "story_v_out_324081.awb")

						arg_176_1:RecordAudio("324081042", var_179_13)
						arg_176_1:RecordAudio("324081042", var_179_13)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_324081", "324081042", "story_v_out_324081.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_324081", "324081042", "story_v_out_324081.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_14 = math.max(var_179_7, arg_176_1.talkMaxDuration)

			if var_179_6 <= arg_176_1.time_ and arg_176_1.time_ < var_179_6 + var_179_14 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_6) / var_179_14

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_6 + var_179_14 and arg_176_1.time_ < var_179_6 + var_179_14 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play324081043 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 324081043
		arg_180_1.duration_ = 2.73

		local var_180_0 = {
			zh = 2.5,
			ja = 2.733
		}
		local var_180_1 = manager.audio:GetLocalizationFlag()

		if var_180_0[var_180_1] ~= nil then
			arg_180_1.duration_ = var_180_0[var_180_1]
		end

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play324081044(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["10171ui_story"]) and arg_180_1.var_.characterEffect10171ui_story == nil then
				arg_180_1.var_.characterEffect10171ui_story = arg_180_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_0 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_0 and not isNil(arg_180_1.actors_["10171ui_story"]) then
				if arg_180_1.var_.characterEffect10171ui_story and not isNil(arg_180_1.actors_["10171ui_story"]) then
					arg_180_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_180_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 0) / var_183_0)
				end
			end

			if arg_180_1.time_ >= 0 + var_183_0 and arg_180_1.time_ < 0 + var_183_0 + arg_183_0 and not isNil(arg_180_1.actors_["10171ui_story"]) and arg_180_1.var_.characterEffect10171ui_story then
				arg_180_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_180_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_183_1 = 0
			local var_183_2 = 0.225

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_1 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_3 = arg_180_1:GetWordFromCfg(324081043)
				local var_183_4 = arg_180_1:FormatText(var_183_3.content)

				arg_180_1.text_.text = var_183_4

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_6 = 9 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_4) / 9)

				if (9 <= 0 and var_183_2 or var_183_2 * (utf8.len(var_183_4) / 9)) > 0 and var_183_2 < var_183_6 then
					arg_180_1.talkMaxDuration = var_183_6

					if var_183_6 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_6 + var_183_1
					end
				end

				arg_180_1.text_.text = var_183_4
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081043", "story_v_out_324081.awb") ~= 0 then
					local var_183_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081043", "story_v_out_324081.awb") / 1000

					if var_183_7 + var_183_1 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_7 + var_183_1
					end

					if var_183_3.prefab_name ~= "" and arg_180_1.actors_[var_183_3.prefab_name] ~= nil then
						local var_183_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_3.prefab_name].transform, "story_v_out_324081", "324081043", "story_v_out_324081.awb")

						arg_180_1:RecordAudio("324081043", var_183_8)
						arg_180_1:RecordAudio("324081043", var_183_8)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_324081", "324081043", "story_v_out_324081.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_324081", "324081043", "story_v_out_324081.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_9 = math.max(var_183_2, arg_180_1.talkMaxDuration)

			if var_183_1 <= arg_180_1.time_ and arg_180_1.time_ < var_183_1 + var_183_9 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_1) / var_183_9

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_1 + var_183_9 and arg_180_1.time_ < var_183_1 + var_183_9 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play324081044 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 324081044
		arg_184_1.duration_ = 2.93

		local var_184_0 = {
			zh = 2.466,
			ja = 2.933
		}
		local var_184_1 = manager.audio:GetLocalizationFlag()

		if var_184_0[var_184_1] ~= nil then
			arg_184_1.duration_ = var_184_0[var_184_1]
		end

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play324081045(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["10171ui_story"]) and arg_184_1.var_.characterEffect10171ui_story == nil then
				arg_184_1.var_.characterEffect10171ui_story = arg_184_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["10171ui_story"]) then
				if arg_184_1.var_.characterEffect10171ui_story and not isNil(arg_184_1.actors_["10171ui_story"]) then
					arg_184_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["10171ui_story"]) and arg_184_1.var_.characterEffect10171ui_story then
				arg_184_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171actionlink/10171action42829")
			end

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 then
				arg_184_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanR", "EmotionTimelineAnimator")
			end

			local var_187_2 = 0
			local var_187_3 = 0.3

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_2 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_4 = arg_184_1:GetWordFromCfg(324081044)
				local var_187_5 = arg_184_1:FormatText(var_187_4.content)

				arg_184_1.text_.text = var_187_5

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_7 = 12 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 12)

				if (12 <= 0 and var_187_3 or var_187_3 * (utf8.len(var_187_5) / 12)) > 0 and var_187_3 < var_187_7 then
					arg_184_1.talkMaxDuration = var_187_7

					if var_187_7 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_7 + var_187_2
					end
				end

				arg_184_1.text_.text = var_187_5
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081044", "story_v_out_324081.awb") ~= 0 then
					local var_187_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081044", "story_v_out_324081.awb") / 1000

					if var_187_8 + var_187_2 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_2
					end

					if var_187_4.prefab_name ~= "" and arg_184_1.actors_[var_187_4.prefab_name] ~= nil then
						local var_187_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_4.prefab_name].transform, "story_v_out_324081", "324081044", "story_v_out_324081.awb")

						arg_184_1:RecordAudio("324081044", var_187_9)
						arg_184_1:RecordAudio("324081044", var_187_9)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_324081", "324081044", "story_v_out_324081.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_324081", "324081044", "story_v_out_324081.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_10 = math.max(var_187_3, arg_184_1.talkMaxDuration)

			if var_187_2 <= arg_184_1.time_ and arg_184_1.time_ < var_187_2 + var_187_10 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_2) / var_187_10

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_2 + var_187_10 and arg_184_1.time_ < var_187_2 + var_187_10 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play324081045 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 324081045
		arg_188_1.duration_ = 9.03

		local var_188_0 = {
			zh = 4.966,
			ja = 9.033
		}
		local var_188_1 = manager.audio:GetLocalizationFlag()

		if var_188_0[var_188_1] ~= nil then
			arg_188_1.duration_ = var_188_0[var_188_1]
		end

		SetActive(arg_188_1.tipsGo_, false)

		function arg_188_1.onSingleLineFinish_()
			arg_188_1.onSingleLineUpdate_ = nil
			arg_188_1.onSingleLineFinish_ = nil
			arg_188_1.state_ = "waiting"
		end

		function arg_188_1.playNext_(arg_190_0)
			if arg_190_0 == 1 then
				arg_188_0:Play324081046(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["10171ui_story"]) and arg_188_1.var_.characterEffect10171ui_story == nil then
				arg_188_1.var_.characterEffect10171ui_story = arg_188_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["10171ui_story"]) then
				if arg_188_1.var_.characterEffect10171ui_story and not isNil(arg_188_1.actors_["10171ui_story"]) then
					arg_188_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_188_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_188_1.time_ - 0) / var_191_0)
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["10171ui_story"]) and arg_188_1.var_.characterEffect10171ui_story then
				arg_188_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_188_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_191_1 = 0
			local var_191_2 = 0.475

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_1 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_3 = arg_188_1:GetWordFromCfg(324081045)
				local var_191_4 = arg_188_1:FormatText(var_191_3.content)

				arg_188_1.text_.text = var_191_4

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_6 = 19 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_4) / 19)

				if (19 <= 0 and var_191_2 or var_191_2 * (utf8.len(var_191_4) / 19)) > 0 and var_191_2 < var_191_6 then
					arg_188_1.talkMaxDuration = var_191_6

					if var_191_6 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_6 + var_191_1
					end
				end

				arg_188_1.text_.text = var_191_4
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081045", "story_v_out_324081.awb") ~= 0 then
					local var_191_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081045", "story_v_out_324081.awb") / 1000

					if var_191_7 + var_191_1 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_1
					end

					if var_191_3.prefab_name ~= "" and arg_188_1.actors_[var_191_3.prefab_name] ~= nil then
						local var_191_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_3.prefab_name].transform, "story_v_out_324081", "324081045", "story_v_out_324081.awb")

						arg_188_1:RecordAudio("324081045", var_191_8)
						arg_188_1:RecordAudio("324081045", var_191_8)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_324081", "324081045", "story_v_out_324081.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_324081", "324081045", "story_v_out_324081.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_9 = math.max(var_191_2, arg_188_1.talkMaxDuration)

			if var_191_1 <= arg_188_1.time_ and arg_188_1.time_ < var_191_1 + var_191_9 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_1) / var_191_9

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_1 + var_191_9 and arg_188_1.time_ < var_191_1 + var_191_9 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play324081046 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 324081046
		arg_192_1.duration_ = 5

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play324081047(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos10171ui_story = arg_192_1.actors_["10171ui_story"].transform.localPosition

				local var_195_0 = GameObjectTools.GetOrAddComponent(arg_192_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_195_0 then
					var_195_0:EnableDynamicBone(false)
				end
			end

			local var_195_1 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_1 then
				arg_192_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_192_1.time_ - 0) / var_195_1)
				arg_192_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10171ui_story"].transform.position).z)
				arg_192_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["10171ui_story"].transform.localEulerAngles = arg_192_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_1 and arg_192_1.time_ < 0 + var_195_1 + arg_195_0 then
				arg_192_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_192_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["10171ui_story"].transform.position).z)
				arg_192_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["10171ui_story"].transform.localEulerAngles = arg_192_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_195_2 = GameObjectTools.GetOrAddComponent(arg_192_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_195_2 then
					var_195_2:EnableDynamicBone(true)
				end
			end

			local var_195_3 = 0
			local var_195_4 = 0.575

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_3 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_5 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(324081046).content)

				arg_192_1.text_.text = var_195_5

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_7 = 23 <= 0 and var_195_4 or var_195_4 * (utf8.len(var_195_5) / 23)

				if (23 <= 0 and var_195_4 or var_195_4 * (utf8.len(var_195_5) / 23)) > 0 and var_195_4 < var_195_7 then
					arg_192_1.talkMaxDuration = var_195_7

					if var_195_7 + var_195_3 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_7 + var_195_3
					end
				end

				arg_192_1.text_.text = var_195_5
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_8 = math.max(var_195_4, arg_192_1.talkMaxDuration)

			if var_195_3 <= arg_192_1.time_ and arg_192_1.time_ < var_195_3 + var_195_8 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_3) / var_195_8

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_3 + var_195_8 and arg_192_1.time_ < var_195_3 + var_195_8 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play324081047 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 324081047
		arg_196_1.duration_ = 6.33

		local var_196_0 = {
			zh = 5.933,
			ja = 6.333
		}
		local var_196_1 = manager.audio:GetLocalizationFlag()

		if var_196_0[var_196_1] ~= nil then
			arg_196_1.duration_ = var_196_0[var_196_1]
		end

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play324081048(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			local var_199_0 = 0.5

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, true)
				arg_196_1.iconController_:SetSelectedState("hero")

				arg_196_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_196_1.callingController_:SetSelectedState("normal")

				arg_196_1.keyicon_.color = Color.New(1, 1, 1)
				arg_196_1.icon_.color = Color.New(1, 1, 1)

				local var_199_1 = arg_196_1:GetWordFromCfg(324081047)
				local var_199_2 = arg_196_1:FormatText(var_199_1.content)

				arg_196_1.text_.text = var_199_2

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_4 = 20 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 20)

				if (20 <= 0 and var_199_0 or var_199_0 * (utf8.len(var_199_2) / 20)) > 0 and var_199_0 < var_199_4 then
					arg_196_1.talkMaxDuration = var_199_4

					if var_199_4 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_4 + 0
					end
				end

				arg_196_1.text_.text = var_199_2
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081047", "story_v_out_324081.awb") ~= 0 then
					local var_199_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081047", "story_v_out_324081.awb") / 1000

					if var_199_5 + 0 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_5 + 0
					end

					if var_199_1.prefab_name ~= "" and arg_196_1.actors_[var_199_1.prefab_name] ~= nil then
						local var_199_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_1.prefab_name].transform, "story_v_out_324081", "324081047", "story_v_out_324081.awb")

						arg_196_1:RecordAudio("324081047", var_199_6)
						arg_196_1:RecordAudio("324081047", var_199_6)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_324081", "324081047", "story_v_out_324081.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_324081", "324081047", "story_v_out_324081.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_0, arg_196_1.talkMaxDuration)

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - 0) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= 0 + var_199_7 and arg_196_1.time_ < 0 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play324081048 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324081048
		arg_200_1.duration_ = 8.17

		local var_200_0 = {
			zh = 7.766,
			ja = 8.166
		}
		local var_200_1 = manager.audio:GetLocalizationFlag()

		if var_200_0[var_200_1] ~= nil then
			arg_200_1.duration_ = var_200_0[var_200_1]
		end

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play324081049(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.var_.moveOldPos1070ui_story = arg_200_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_203_0 = 0.001

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 then
				arg_200_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_200_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_200_1.time_ - 0) / var_203_0)
				arg_200_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1070ui_story"].transform.position).z)
				arg_200_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["1070ui_story"].transform.localEulerAngles = arg_200_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 then
				arg_200_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_200_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_200_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_200_1.actors_["1070ui_story"].transform.position).z)
				arg_200_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_200_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_200_1.actors_["1070ui_story"].transform.localEulerAngles = arg_200_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_203_1 = arg_200_1.actors_["1070ui_story"]

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(var_203_1) and arg_200_1.var_.characterEffect1070ui_story == nil then
				arg_200_1.var_.characterEffect1070ui_story = var_203_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_2 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_2 and not isNil(var_203_1) then
				if arg_200_1.var_.characterEffect1070ui_story and not isNil(var_203_1) then
					arg_200_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_200_1.time_ >= 0 + var_203_2 and arg_200_1.time_ < 0 + var_203_2 + arg_203_0 and not isNil(var_203_1) and arg_200_1.var_.characterEffect1070ui_story then
				arg_200_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_203_4 = 0
			local var_203_5 = 0.9

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_4 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_6 = arg_200_1:GetWordFromCfg(324081048)
				local var_203_7 = arg_200_1:FormatText(var_203_6.content)

				arg_200_1.text_.text = var_203_7

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_9 = 36 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 36)

				if (36 <= 0 and var_203_5 or var_203_5 * (utf8.len(var_203_7) / 36)) > 0 and var_203_5 < var_203_9 then
					arg_200_1.talkMaxDuration = var_203_9

					if var_203_9 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_9 + var_203_4
					end
				end

				arg_200_1.text_.text = var_203_7
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081048", "story_v_out_324081.awb") ~= 0 then
					local var_203_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081048", "story_v_out_324081.awb") / 1000

					if var_203_10 + var_203_4 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_10 + var_203_4
					end

					if var_203_6.prefab_name ~= "" and arg_200_1.actors_[var_203_6.prefab_name] ~= nil then
						local var_203_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_200_1.actors_[var_203_6.prefab_name].transform, "story_v_out_324081", "324081048", "story_v_out_324081.awb")

						arg_200_1:RecordAudio("324081048", var_203_11)
						arg_200_1:RecordAudio("324081048", var_203_11)
					else
						arg_200_1:AudioAction("play", "voice", "story_v_out_324081", "324081048", "story_v_out_324081.awb")
					end

					arg_200_1:RecordHistoryTalkVoice("story_v_out_324081", "324081048", "story_v_out_324081.awb")
				end

				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_12 = math.max(var_203_5, arg_200_1.talkMaxDuration)

			if var_203_4 <= arg_200_1.time_ and arg_200_1.time_ < var_203_4 + var_203_12 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_4) / var_203_12

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_4 + var_203_12 and arg_200_1.time_ < var_203_4 + var_203_12 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_200_1:InitPlayNodeList()
	end,
	Play324081049 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 324081049
		arg_204_1.duration_ = 7.6

		local var_204_0 = {
			zh = 7.6,
			ja = 5.833
		}
		local var_204_1 = manager.audio:GetLocalizationFlag()

		if var_204_0[var_204_1] ~= nil then
			arg_204_1.duration_ = var_204_0[var_204_1]
		end

		SetActive(arg_204_1.tipsGo_, false)

		function arg_204_1.onSingleLineFinish_()
			arg_204_1.onSingleLineUpdate_ = nil
			arg_204_1.onSingleLineFinish_ = nil
			arg_204_1.state_ = "waiting"
		end

		function arg_204_1.playNext_(arg_206_0)
			if arg_206_0 == 1 then
				arg_204_0:Play324081050(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1070ui_story"]) and arg_204_1.var_.characterEffect1070ui_story == nil then
				arg_204_1.var_.characterEffect1070ui_story = arg_204_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1070ui_story"]) then
				if arg_204_1.var_.characterEffect1070ui_story and not isNil(arg_204_1.actors_["1070ui_story"]) then
					arg_204_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_204_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_204_1.time_ - 0) / var_207_0)
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1070ui_story"]) and arg_204_1.var_.characterEffect1070ui_story then
				arg_204_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_204_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_207_1 = 0
			local var_207_2 = 0.725

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_1 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, true)
				arg_204_1.iconController_:SetSelectedState("hero")

				arg_204_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_204_1.callingController_:SetSelectedState("normal")

				arg_204_1.keyicon_.color = Color.New(1, 1, 1)
				arg_204_1.icon_.color = Color.New(1, 1, 1)

				local var_207_3 = arg_204_1:GetWordFromCfg(324081049)
				local var_207_4 = arg_204_1:FormatText(var_207_3.content)

				arg_204_1.text_.text = var_207_4

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_6 = 29 <= 0 and var_207_2 or var_207_2 * (utf8.len(var_207_4) / 29)

				if (29 <= 0 and var_207_2 or var_207_2 * (utf8.len(var_207_4) / 29)) > 0 and var_207_2 < var_207_6 then
					arg_204_1.talkMaxDuration = var_207_6

					if var_207_6 + var_207_1 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_6 + var_207_1
					end
				end

				arg_204_1.text_.text = var_207_4
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081049", "story_v_out_324081.awb") ~= 0 then
					local var_207_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081049", "story_v_out_324081.awb") / 1000

					if var_207_7 + var_207_1 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_1
					end

					if var_207_3.prefab_name ~= "" and arg_204_1.actors_[var_207_3.prefab_name] ~= nil then
						local var_207_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_3.prefab_name].transform, "story_v_out_324081", "324081049", "story_v_out_324081.awb")

						arg_204_1:RecordAudio("324081049", var_207_8)
						arg_204_1:RecordAudio("324081049", var_207_8)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_324081", "324081049", "story_v_out_324081.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_324081", "324081049", "story_v_out_324081.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_9 = math.max(var_207_2, arg_204_1.talkMaxDuration)

			if var_207_1 <= arg_204_1.time_ and arg_204_1.time_ < var_207_1 + var_207_9 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_1) / var_207_9

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_1 + var_207_9 and arg_204_1.time_ < var_207_1 + var_207_9 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play324081050 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 324081050
		arg_208_1.duration_ = 8.3

		local var_208_0 = {
			zh = 7.8,
			ja = 8.3
		}
		local var_208_1 = manager.audio:GetLocalizationFlag()

		if var_208_0[var_208_1] ~= nil then
			arg_208_1.duration_ = var_208_0[var_208_1]
		end

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play324081051(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			local var_211_0 = 0.85

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_1 = arg_208_1:GetWordFromCfg(324081050)
				local var_211_2 = arg_208_1:FormatText(var_211_1.content)

				arg_208_1.text_.text = var_211_2

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_4 = 34 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 34)

				if (34 <= 0 and var_211_0 or var_211_0 * (utf8.len(var_211_2) / 34)) > 0 and var_211_0 < var_211_4 then
					arg_208_1.talkMaxDuration = var_211_4

					if var_211_4 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_4 + 0
					end
				end

				arg_208_1.text_.text = var_211_2
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081050", "story_v_out_324081.awb") ~= 0 then
					local var_211_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081050", "story_v_out_324081.awb") / 1000

					if var_211_5 + 0 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + 0
					end

					if var_211_1.prefab_name ~= "" and arg_208_1.actors_[var_211_1.prefab_name] ~= nil then
						local var_211_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_1.prefab_name].transform, "story_v_out_324081", "324081050", "story_v_out_324081.awb")

						arg_208_1:RecordAudio("324081050", var_211_6)
						arg_208_1:RecordAudio("324081050", var_211_6)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_324081", "324081050", "story_v_out_324081.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_324081", "324081050", "story_v_out_324081.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_7 = math.max(var_211_0, arg_208_1.talkMaxDuration)

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - 0) / var_211_7

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play324081051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 324081051
		arg_212_1.duration_ = 4.2

		local var_212_0 = {
			zh = 3.233,
			ja = 4.2
		}
		local var_212_1 = manager.audio:GetLocalizationFlag()

		if var_212_0[var_212_1] ~= nil then
			arg_212_1.duration_ = var_212_0[var_212_1]
		end

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play324081052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1070ui_story = arg_212_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_215_0 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_0 then
				arg_212_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_0)
				arg_212_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1070ui_story"].transform.position).z)
				arg_212_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1070ui_story"].transform.localEulerAngles = arg_212_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_0 and arg_212_1.time_ < 0 + var_215_0 + arg_215_0 then
				arg_212_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_212_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1070ui_story"].transform.position).z)
				arg_212_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1070ui_story"].transform.localEulerAngles = arg_212_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_215_1 = arg_212_1.actors_["10171ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos10171ui_story = var_215_1.localPosition

				local var_215_2 = GameObjectTools.GetOrAddComponent(var_215_1.gameObject, typeof(DynamicBoneHelper))

				if var_215_2 then
					var_215_2:EnableDynamicBone(false)
				end
			end

			local var_215_3 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_3 then
				var_215_1.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_212_1.time_ - 0) / var_215_3)
				var_215_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_1.position).x, (manager.ui.mainCamera.transform.position - var_215_1.position).y, (manager.ui.mainCamera.transform.position - var_215_1.position).z)
				var_215_1.localEulerAngles.z = 0
				var_215_1.localEulerAngles.x = 0
				var_215_1.localEulerAngles = var_215_1.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_3 and arg_212_1.time_ < 0 + var_215_3 + arg_215_0 then
				var_215_1.localPosition = Vector3.New(0, -0.95, -6.05)
				var_215_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_1.position).x, (manager.ui.mainCamera.transform.position - var_215_1.position).y, (manager.ui.mainCamera.transform.position - var_215_1.position).z)
				var_215_1.localEulerAngles.z = 0
				var_215_1.localEulerAngles.x = 0
				var_215_1.localEulerAngles = var_215_1.localEulerAngles

				local var_215_4 = GameObjectTools.GetOrAddComponent(var_215_1.gameObject, typeof(DynamicBoneHelper))

				if var_215_4 then
					var_215_4:EnableDynamicBone(true)
				end
			end

			local var_215_5 = arg_212_1.actors_["10171ui_story"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_5) and arg_212_1.var_.characterEffect10171ui_story == nil then
				arg_212_1.var_.characterEffect10171ui_story = var_215_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_215_6 = 0.200000002980232

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_6 and not isNil(var_215_5) then
				if arg_212_1.var_.characterEffect10171ui_story and not isNil(var_215_5) then
					arg_212_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_212_1.time_ >= 0 + var_215_6 and arg_212_1.time_ < 0 + var_215_6 + arg_215_0 and not isNil(var_215_5) and arg_212_1.var_.characterEffect10171ui_story then
				arg_212_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action29_2")
			end

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_215_8 = 0
			local var_215_9 = 0.375

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_8 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_10 = arg_212_1:GetWordFromCfg(324081051)
				local var_215_11 = arg_212_1:FormatText(var_215_10.content)

				arg_212_1.text_.text = var_215_11

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_13 = 15 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 15)

				if (15 <= 0 and var_215_9 or var_215_9 * (utf8.len(var_215_11) / 15)) > 0 and var_215_9 < var_215_13 then
					arg_212_1.talkMaxDuration = var_215_13

					if var_215_13 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_13 + var_215_8
					end
				end

				arg_212_1.text_.text = var_215_11
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081051", "story_v_out_324081.awb") ~= 0 then
					local var_215_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081051", "story_v_out_324081.awb") / 1000

					if var_215_14 + var_215_8 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_14 + var_215_8
					end

					if var_215_10.prefab_name ~= "" and arg_212_1.actors_[var_215_10.prefab_name] ~= nil then
						local var_215_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_10.prefab_name].transform, "story_v_out_324081", "324081051", "story_v_out_324081.awb")

						arg_212_1:RecordAudio("324081051", var_215_15)
						arg_212_1:RecordAudio("324081051", var_215_15)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_324081", "324081051", "story_v_out_324081.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_324081", "324081051", "story_v_out_324081.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_16 = math.max(var_215_9, arg_212_1.talkMaxDuration)

			if var_215_8 <= arg_212_1.time_ and arg_212_1.time_ < var_215_8 + var_215_16 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_8) / var_215_16

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_8 + var_215_16 and arg_212_1.time_ < var_215_8 + var_215_16 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play324081052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 324081052
		arg_216_1.duration_ = 13.07

		local var_216_0 = {
			zh = 7.933,
			ja = 13.066
		}
		local var_216_1 = manager.audio:GetLocalizationFlag()

		if var_216_0[var_216_1] ~= nil then
			arg_216_1.duration_ = var_216_0[var_216_1]
		end

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play324081053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(arg_216_1.actors_["1070ui_story"]) and arg_216_1.var_.characterEffect1070ui_story == nil then
				arg_216_1.var_.characterEffect1070ui_story = arg_216_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_0 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_0 and not isNil(arg_216_1.actors_["1070ui_story"]) then
				if arg_216_1.var_.characterEffect1070ui_story and not isNil(arg_216_1.actors_["1070ui_story"]) then
					arg_216_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_216_1.time_ >= 0 + var_219_0 and arg_216_1.time_ < 0 + var_219_0 + arg_219_0 and not isNil(arg_216_1.actors_["1070ui_story"]) and arg_216_1.var_.characterEffect1070ui_story then
				arg_216_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_219_2 = arg_216_1.actors_["10171ui_story"]

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.characterEffect10171ui_story == nil then
				arg_216_1.var_.characterEffect10171ui_story = var_219_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_219_3 = 0.200000002980232

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_3 and not isNil(var_219_2) then
				if arg_216_1.var_.characterEffect10171ui_story and not isNil(var_219_2) then
					arg_216_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_216_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_216_1.time_ - 0) / var_219_3)
				end
			end

			if arg_216_1.time_ >= 0 + var_219_3 and arg_216_1.time_ < 0 + var_219_3 + arg_219_0 and not isNil(var_219_2) and arg_216_1.var_.characterEffect10171ui_story then
				arg_216_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_216_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_219_4 = arg_216_1.actors_["10171ui_story"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos10171ui_story = var_219_4.localPosition

				local var_219_5 = GameObjectTools.GetOrAddComponent(var_219_4.gameObject, typeof(DynamicBoneHelper))

				if var_219_5 then
					var_219_5:EnableDynamicBone(false)
				end
			end

			local var_219_6 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_6 then
				var_219_4.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos10171ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_216_1.time_ - 0) / var_219_6)
				var_219_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_4.position).x, (manager.ui.mainCamera.transform.position - var_219_4.position).y, (manager.ui.mainCamera.transform.position - var_219_4.position).z)
				var_219_4.localEulerAngles.z = 0
				var_219_4.localEulerAngles.x = 0
				var_219_4.localEulerAngles = var_219_4.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_6 and arg_216_1.time_ < 0 + var_219_6 + arg_219_0 then
				var_219_4.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_219_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_4.position).x, (manager.ui.mainCamera.transform.position - var_219_4.position).y, (manager.ui.mainCamera.transform.position - var_219_4.position).z)
				var_219_4.localEulerAngles.z = 0
				var_219_4.localEulerAngles.x = 0
				var_219_4.localEulerAngles = var_219_4.localEulerAngles

				local var_219_7 = GameObjectTools.GetOrAddComponent(var_219_4.gameObject, typeof(DynamicBoneHelper))

				if var_219_7 then
					var_219_7:EnableDynamicBone(true)
				end
			end

			local var_219_8 = arg_216_1.actors_["1070ui_story"].transform

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.var_.moveOldPos1070ui_story = var_219_8.localPosition
			end

			local var_219_9 = 0.001

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_9 then
				var_219_8.localPosition = Vector3.Lerp(arg_216_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_216_1.time_ - 0) / var_219_9)
				var_219_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_8.position).x, (manager.ui.mainCamera.transform.position - var_219_8.position).y, (manager.ui.mainCamera.transform.position - var_219_8.position).z)
				var_219_8.localEulerAngles.z = 0
				var_219_8.localEulerAngles.x = 0
				var_219_8.localEulerAngles = var_219_8.localEulerAngles
			end

			if arg_216_1.time_ >= 0 + var_219_9 and arg_216_1.time_ < 0 + var_219_9 + arg_219_0 then
				var_219_8.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_219_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_219_8.position).x, (manager.ui.mainCamera.transform.position - var_219_8.position).y, (manager.ui.mainCamera.transform.position - var_219_8.position).z)
				var_219_8.localEulerAngles.z = 0
				var_219_8.localEulerAngles.x = 0
				var_219_8.localEulerAngles = var_219_8.localEulerAngles
			end

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_219_10 = 0
			local var_219_11 = 1

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= var_219_10 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_12 = arg_216_1:GetWordFromCfg(324081052)
				local var_219_13 = arg_216_1:FormatText(var_219_12.content)

				arg_216_1.text_.text = var_219_13

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_15 = 40 <= 0 and var_219_11 or var_219_11 * (utf8.len(var_219_13) / 40)

				if (40 <= 0 and var_219_11 or var_219_11 * (utf8.len(var_219_13) / 40)) > 0 and var_219_11 < var_219_15 then
					arg_216_1.talkMaxDuration = var_219_15

					if var_219_15 + var_219_10 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_15 + var_219_10
					end
				end

				arg_216_1.text_.text = var_219_13
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081052", "story_v_out_324081.awb") ~= 0 then
					local var_219_16 = manager.audio:GetVoiceLength("story_v_out_324081", "324081052", "story_v_out_324081.awb") / 1000

					if var_219_16 + var_219_10 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_16 + var_219_10
					end

					if var_219_12.prefab_name ~= "" and arg_216_1.actors_[var_219_12.prefab_name] ~= nil then
						local var_219_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_12.prefab_name].transform, "story_v_out_324081", "324081052", "story_v_out_324081.awb")

						arg_216_1:RecordAudio("324081052", var_219_17)
						arg_216_1:RecordAudio("324081052", var_219_17)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_324081", "324081052", "story_v_out_324081.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_324081", "324081052", "story_v_out_324081.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_18 = math.max(var_219_11, arg_216_1.talkMaxDuration)

			if var_219_10 <= arg_216_1.time_ and arg_216_1.time_ < var_219_10 + var_219_18 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - var_219_10) / var_219_18

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= var_219_10 + var_219_18 and arg_216_1.time_ < var_219_10 + var_219_18 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_216_1:InitPlayNodeList()
	end,
	Play324081053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 324081053
		arg_220_1.duration_ = 5

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play324081054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1070ui_story = arg_220_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_223_0 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				arg_220_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_220_1.time_ - 0) / var_223_0)
				arg_220_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).z)
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles = arg_220_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				arg_220_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_220_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1070ui_story"].transform.position).z)
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1070ui_story"].transform.localEulerAngles = arg_220_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_223_1 = arg_220_1.actors_["10171ui_story"].transform

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos10171ui_story = var_223_1.localPosition

				local var_223_2 = GameObjectTools.GetOrAddComponent(var_223_1.gameObject, typeof(DynamicBoneHelper))

				if var_223_2 then
					var_223_2:EnableDynamicBone(false)
				end
			end

			local var_223_3 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_3 then
				var_223_1.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_220_1.time_ - 0) / var_223_3)
				var_223_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_1.position).x, (manager.ui.mainCamera.transform.position - var_223_1.position).y, (manager.ui.mainCamera.transform.position - var_223_1.position).z)
				var_223_1.localEulerAngles.z = 0
				var_223_1.localEulerAngles.x = 0
				var_223_1.localEulerAngles = var_223_1.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_3 and arg_220_1.time_ < 0 + var_223_3 + arg_223_0 then
				var_223_1.localPosition = Vector3.New(0, 100, 0)
				var_223_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_223_1.position).x, (manager.ui.mainCamera.transform.position - var_223_1.position).y, (manager.ui.mainCamera.transform.position - var_223_1.position).z)
				var_223_1.localEulerAngles.z = 0
				var_223_1.localEulerAngles.x = 0
				var_223_1.localEulerAngles = var_223_1.localEulerAngles

				local var_223_4 = GameObjectTools.GetOrAddComponent(var_223_1.gameObject, typeof(DynamicBoneHelper))

				if var_223_4 then
					var_223_4:EnableDynamicBone(true)
				end
			end

			local var_223_5 = arg_220_1.actors_["1070ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_5) and arg_220_1.var_.characterEffect1070ui_story == nil then
				arg_220_1.var_.characterEffect1070ui_story = var_223_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_6 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_6 and not isNil(var_223_5) then
				if arg_220_1.var_.characterEffect1070ui_story and not isNil(var_223_5) then
					arg_220_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_220_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_220_1.time_ - 0) / var_223_6)
				end
			end

			if arg_220_1.time_ >= 0 + var_223_6 and arg_220_1.time_ < 0 + var_223_6 + arg_223_0 and not isNil(var_223_5) and arg_220_1.var_.characterEffect1070ui_story then
				arg_220_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_220_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_223_7 = 0
			local var_223_8 = 1.625

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_7 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, false)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_9 = arg_220_1:FormatText(arg_220_1:GetWordFromCfg(324081053).content)

				arg_220_1.text_.text = var_223_9

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 65 <= 0 and var_223_8 or var_223_8 * (utf8.len(var_223_9) / 65)

				if (65 <= 0 and var_223_8 or var_223_8 * (utf8.len(var_223_9) / 65)) > 0 and var_223_8 < var_223_11 then
					arg_220_1.talkMaxDuration = var_223_11

					if var_223_11 + var_223_7 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_11 + var_223_7
					end
				end

				arg_220_1.text_.text = var_223_9
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)
				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_12 = math.max(var_223_8, arg_220_1.talkMaxDuration)

			if var_223_7 <= arg_220_1.time_ and arg_220_1.time_ < var_223_7 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_7) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_7 + var_223_12 and arg_220_1.time_ < var_223_7 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play324081054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 324081054
		arg_224_1.duration_ = 17.93

		local var_224_0 = {
			zh = 17.933,
			ja = 14.7
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play324081055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			local var_227_0 = 1.625

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_1 = arg_224_1:GetWordFromCfg(324081054)
				local var_227_2 = arg_224_1:FormatText(var_227_1.content)

				arg_224_1.text_.text = var_227_2

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_4 = 65 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 65)

				if (65 <= 0 and var_227_0 or var_227_0 * (utf8.len(var_227_2) / 65)) > 0 and var_227_0 < var_227_4 then
					arg_224_1.talkMaxDuration = var_227_4

					if var_227_4 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_4 + 0
					end
				end

				arg_224_1.text_.text = var_227_2
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081054", "story_v_out_324081.awb") ~= 0 then
					local var_227_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081054", "story_v_out_324081.awb") / 1000

					if var_227_5 + 0 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + 0
					end

					if var_227_1.prefab_name ~= "" and arg_224_1.actors_[var_227_1.prefab_name] ~= nil then
						local var_227_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_1.prefab_name].transform, "story_v_out_324081", "324081054", "story_v_out_324081.awb")

						arg_224_1:RecordAudio("324081054", var_227_6)
						arg_224_1:RecordAudio("324081054", var_227_6)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_324081", "324081054", "story_v_out_324081.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_324081", "324081054", "story_v_out_324081.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_7 = math.max(var_227_0, arg_224_1.talkMaxDuration)

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_7 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - 0) / var_227_7

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= 0 + var_227_7 and arg_224_1.time_ < 0 + var_227_7 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play324081055 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 324081055
		arg_228_1.duration_ = 5.9

		local var_228_0 = {
			zh = 3.333,
			ja = 5.9
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play324081056(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.var_.moveOldPos1070ui_story = arg_228_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_231_0 = 0.001

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_0 then
				arg_228_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_228_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_228_1.time_ - 0) / var_231_0)
				arg_228_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1070ui_story"].transform.position).z)
				arg_228_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1070ui_story"].transform.localEulerAngles = arg_228_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_228_1.time_ >= 0 + var_231_0 and arg_228_1.time_ < 0 + var_231_0 + arg_231_0 then
				arg_228_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_228_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_228_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_228_1.actors_["1070ui_story"].transform.position).z)
				arg_228_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_228_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_228_1.actors_["1070ui_story"].transform.localEulerAngles = arg_228_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_231_1 = arg_228_1.actors_["1070ui_story"]

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1070ui_story == nil then
				arg_228_1.var_.characterEffect1070ui_story = var_231_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_231_2 = 0.200000002980232

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_2 and not isNil(var_231_1) then
				if arg_228_1.var_.characterEffect1070ui_story and not isNil(var_231_1) then
					arg_228_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_228_1.time_ >= 0 + var_231_2 and arg_228_1.time_ < 0 + var_231_2 + arg_231_0 and not isNil(var_231_1) and arg_228_1.var_.characterEffect1070ui_story then
				arg_228_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_231_4 = 0
			local var_231_5 = 0.4

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= var_231_4 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_6 = arg_228_1:GetWordFromCfg(324081055)
				local var_231_7 = arg_228_1:FormatText(var_231_6.content)

				arg_228_1.text_.text = var_231_7

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_9 = 16 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 16)

				if (16 <= 0 and var_231_5 or var_231_5 * (utf8.len(var_231_7) / 16)) > 0 and var_231_5 < var_231_9 then
					arg_228_1.talkMaxDuration = var_231_9

					if var_231_9 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_9 + var_231_4
					end
				end

				arg_228_1.text_.text = var_231_7
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081055", "story_v_out_324081.awb") ~= 0 then
					local var_231_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081055", "story_v_out_324081.awb") / 1000

					if var_231_10 + var_231_4 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_10 + var_231_4
					end

					if var_231_6.prefab_name ~= "" and arg_228_1.actors_[var_231_6.prefab_name] ~= nil then
						local var_231_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_6.prefab_name].transform, "story_v_out_324081", "324081055", "story_v_out_324081.awb")

						arg_228_1:RecordAudio("324081055", var_231_11)
						arg_228_1:RecordAudio("324081055", var_231_11)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_324081", "324081055", "story_v_out_324081.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_324081", "324081055", "story_v_out_324081.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_12 = math.max(var_231_5, arg_228_1.talkMaxDuration)

			if var_231_4 <= arg_228_1.time_ and arg_228_1.time_ < var_231_4 + var_231_12 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - var_231_4) / var_231_12

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= var_231_4 + var_231_12 and arg_228_1.time_ < var_231_4 + var_231_12 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_228_1:InitPlayNodeList()
	end,
	Play324081056 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 324081056
		arg_232_1.duration_ = 11.67

		local var_232_0 = {
			zh = 9.6,
			ja = 11.666
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play324081057(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 and not isNil(arg_232_1.actors_["1070ui_story"]) and arg_232_1.var_.characterEffect1070ui_story == nil then
				arg_232_1.var_.characterEffect1070ui_story = arg_232_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_235_0 = 0.200000002980232

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_0 and not isNil(arg_232_1.actors_["1070ui_story"]) then
				if arg_232_1.var_.characterEffect1070ui_story and not isNil(arg_232_1.actors_["1070ui_story"]) then
					arg_232_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_232_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_232_1.time_ - 0) / var_235_0)
				end
			end

			if arg_232_1.time_ >= 0 + var_235_0 and arg_232_1.time_ < 0 + var_235_0 + arg_235_0 and not isNil(arg_232_1.actors_["1070ui_story"]) and arg_232_1.var_.characterEffect1070ui_story then
				arg_232_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_232_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_235_1 = 0
			local var_235_2 = 0.975

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= var_235_1 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, true)
				arg_232_1.iconController_:SetSelectedState("hero")

				arg_232_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_232_1.callingController_:SetSelectedState("normal")

				arg_232_1.keyicon_.color = Color.New(1, 1, 1)
				arg_232_1.icon_.color = Color.New(1, 1, 1)

				local var_235_3 = arg_232_1:GetWordFromCfg(324081056)
				local var_235_4 = arg_232_1:FormatText(var_235_3.content)

				arg_232_1.text_.text = var_235_4

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_6 = 39 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_4) / 39)

				if (39 <= 0 and var_235_2 or var_235_2 * (utf8.len(var_235_4) / 39)) > 0 and var_235_2 < var_235_6 then
					arg_232_1.talkMaxDuration = var_235_6

					if var_235_6 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_6 + var_235_1
					end
				end

				arg_232_1.text_.text = var_235_4
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081056", "story_v_out_324081.awb") ~= 0 then
					local var_235_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081056", "story_v_out_324081.awb") / 1000

					if var_235_7 + var_235_1 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_7 + var_235_1
					end

					if var_235_3.prefab_name ~= "" and arg_232_1.actors_[var_235_3.prefab_name] ~= nil then
						local var_235_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_3.prefab_name].transform, "story_v_out_324081", "324081056", "story_v_out_324081.awb")

						arg_232_1:RecordAudio("324081056", var_235_8)
						arg_232_1:RecordAudio("324081056", var_235_8)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_324081", "324081056", "story_v_out_324081.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_324081", "324081056", "story_v_out_324081.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_9 = math.max(var_235_2, arg_232_1.talkMaxDuration)

			if var_235_1 <= arg_232_1.time_ and arg_232_1.time_ < var_235_1 + var_235_9 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - var_235_1) / var_235_9

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= var_235_1 + var_235_9 and arg_232_1.time_ < var_235_1 + var_235_9 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play324081057 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 324081057
		arg_236_1.duration_ = 10.5

		local var_236_0 = {
			zh = 7.733,
			ja = 10.5
		}
		local var_236_1 = manager.audio:GetLocalizationFlag()

		if var_236_0[var_236_1] ~= nil then
			arg_236_1.duration_ = var_236_0[var_236_1]
		end

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play324081058(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.8

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_1 = arg_236_1:GetWordFromCfg(324081057)
				local var_239_2 = arg_236_1:FormatText(var_239_1.content)

				arg_236_1.text_.text = var_239_2

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_4 = 32 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 32)

				if (32 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_2) / 32)) > 0 and var_239_0 < var_239_4 then
					arg_236_1.talkMaxDuration = var_239_4

					if var_239_4 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_4 + 0
					end
				end

				arg_236_1.text_.text = var_239_2
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081057", "story_v_out_324081.awb") ~= 0 then
					local var_239_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081057", "story_v_out_324081.awb") / 1000

					if var_239_5 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_5 + 0
					end

					if var_239_1.prefab_name ~= "" and arg_236_1.actors_[var_239_1.prefab_name] ~= nil then
						local var_239_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_236_1.actors_[var_239_1.prefab_name].transform, "story_v_out_324081", "324081057", "story_v_out_324081.awb")

						arg_236_1:RecordAudio("324081057", var_239_6)
						arg_236_1:RecordAudio("324081057", var_239_6)
					else
						arg_236_1:AudioAction("play", "voice", "story_v_out_324081", "324081057", "story_v_out_324081.awb")
					end

					arg_236_1:RecordHistoryTalkVoice("story_v_out_324081", "324081057", "story_v_out_324081.awb")
				end

				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_7 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_7 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_7

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_7 and arg_236_1.time_ < 0 + var_239_7 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play324081058 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324081058
		arg_240_1.duration_ = 9.27

		local var_240_0 = {
			zh = 6.366,
			ja = 9.266
		}
		local var_240_1 = manager.audio:GetLocalizationFlag()

		if var_240_0[var_240_1] ~= nil then
			arg_240_1.duration_ = var_240_0[var_240_1]
		end

		SetActive(arg_240_1.tipsGo_, false)

		function arg_240_1.onSingleLineFinish_()
			arg_240_1.onSingleLineUpdate_ = nil
			arg_240_1.onSingleLineFinish_ = nil
			arg_240_1.state_ = "waiting"
		end

		function arg_240_1.playNext_(arg_242_0)
			if arg_242_0 == 1 then
				arg_240_0:Play324081059(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos1070ui_story = arg_240_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_243_0 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 then
				arg_240_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_240_1.time_ - 0) / var_243_0)
				arg_240_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).z)
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles = arg_240_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 then
				arg_240_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_240_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_240_1.actors_["1070ui_story"].transform.position).z)
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_240_1.actors_["1070ui_story"].transform.localEulerAngles = arg_240_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_243_1 = arg_240_1.actors_["10171ui_story"].transform

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10171ui_story = var_243_1.localPosition

				local var_243_2 = GameObjectTools.GetOrAddComponent(var_243_1.gameObject, typeof(DynamicBoneHelper))

				if var_243_2 then
					var_243_2:EnableDynamicBone(false)
				end
			end

			local var_243_3 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_3 then
				var_243_1.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_240_1.time_ - 0) / var_243_3)
				var_243_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_1.position).x, (manager.ui.mainCamera.transform.position - var_243_1.position).y, (manager.ui.mainCamera.transform.position - var_243_1.position).z)
				var_243_1.localEulerAngles.z = 0
				var_243_1.localEulerAngles.x = 0
				var_243_1.localEulerAngles = var_243_1.localEulerAngles
			end

			if arg_240_1.time_ >= 0 + var_243_3 and arg_240_1.time_ < 0 + var_243_3 + arg_243_0 then
				var_243_1.localPosition = Vector3.New(0, -0.95, -6.05)
				var_243_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_243_1.position).x, (manager.ui.mainCamera.transform.position - var_243_1.position).y, (manager.ui.mainCamera.transform.position - var_243_1.position).z)
				var_243_1.localEulerAngles.z = 0
				var_243_1.localEulerAngles.x = 0
				var_243_1.localEulerAngles = var_243_1.localEulerAngles

				local var_243_4 = GameObjectTools.GetOrAddComponent(var_243_1.gameObject, typeof(DynamicBoneHelper))

				if var_243_4 then
					var_243_4:EnableDynamicBone(true)
				end
			end

			local var_243_5 = arg_240_1.actors_["10171ui_story"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_5) and arg_240_1.var_.characterEffect10171ui_story == nil then
				arg_240_1.var_.characterEffect10171ui_story = var_243_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_6 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_6 and not isNil(var_243_5) then
				if arg_240_1.var_.characterEffect10171ui_story and not isNil(var_243_5) then
					arg_240_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_6 and arg_240_1.time_ < 0 + var_243_6 + arg_243_0 and not isNil(var_243_5) and arg_240_1.var_.characterEffect10171ui_story then
				arg_240_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action30_1")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_243_8 = 0
			local var_243_9 = 0.75

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_8 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_10 = arg_240_1:GetWordFromCfg(324081058)
				local var_243_11 = arg_240_1:FormatText(var_243_10.content)

				arg_240_1.text_.text = var_243_11

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_13 = 30 <= 0 and var_243_9 or var_243_9 * (utf8.len(var_243_11) / 30)

				if (30 <= 0 and var_243_9 or var_243_9 * (utf8.len(var_243_11) / 30)) > 0 and var_243_9 < var_243_13 then
					arg_240_1.talkMaxDuration = var_243_13

					if var_243_13 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_8
					end
				end

				arg_240_1.text_.text = var_243_11
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081058", "story_v_out_324081.awb") ~= 0 then
					local var_243_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081058", "story_v_out_324081.awb") / 1000

					if var_243_14 + var_243_8 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_14 + var_243_8
					end

					if var_243_10.prefab_name ~= "" and arg_240_1.actors_[var_243_10.prefab_name] ~= nil then
						local var_243_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_10.prefab_name].transform, "story_v_out_324081", "324081058", "story_v_out_324081.awb")

						arg_240_1:RecordAudio("324081058", var_243_15)
						arg_240_1:RecordAudio("324081058", var_243_15)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_324081", "324081058", "story_v_out_324081.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_324081", "324081058", "story_v_out_324081.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_16 = math.max(var_243_9, arg_240_1.talkMaxDuration)

			if var_243_8 <= arg_240_1.time_ and arg_240_1.time_ < var_243_8 + var_243_16 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_8) / var_243_16

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_8 + var_243_16 and arg_240_1.time_ < var_243_8 + var_243_16 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play324081059 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324081059
		arg_244_1.duration_ = 8.9

		local var_244_0 = {
			zh = 8.9,
			ja = 8.733
		}
		local var_244_1 = manager.audio:GetLocalizationFlag()

		if var_244_0[var_244_1] ~= nil then
			arg_244_1.duration_ = var_244_0[var_244_1]
		end

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play324081060(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["10171ui_story"]) and arg_244_1.var_.characterEffect10171ui_story == nil then
				arg_244_1.var_.characterEffect10171ui_story = arg_244_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["10171ui_story"]) then
				if arg_244_1.var_.characterEffect10171ui_story and not isNil(arg_244_1.actors_["10171ui_story"]) then
					arg_244_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_244_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_0)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["10171ui_story"]) and arg_244_1.var_.characterEffect10171ui_story then
				arg_244_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_244_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_247_1 = 0
			local var_247_2 = 0.9

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:GetWordFromCfg(324081059)
				local var_247_4 = arg_244_1:FormatText(var_247_3.content)

				arg_244_1.text_.text = var_247_4

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_6 = 36 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_4) / 36)

				if (36 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_4) / 36)) > 0 and var_247_2 < var_247_6 then
					arg_244_1.talkMaxDuration = var_247_6

					if var_247_6 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_6 + var_247_1
					end
				end

				arg_244_1.text_.text = var_247_4
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081059", "story_v_out_324081.awb") ~= 0 then
					local var_247_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081059", "story_v_out_324081.awb") / 1000

					if var_247_7 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_7 + var_247_1
					end

					if var_247_3.prefab_name ~= "" and arg_244_1.actors_[var_247_3.prefab_name] ~= nil then
						local var_247_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_3.prefab_name].transform, "story_v_out_324081", "324081059", "story_v_out_324081.awb")

						arg_244_1:RecordAudio("324081059", var_247_8)
						arg_244_1:RecordAudio("324081059", var_247_8)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_324081", "324081059", "story_v_out_324081.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_324081", "324081059", "story_v_out_324081.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_9 = math.max(var_247_2, arg_244_1.talkMaxDuration)

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_9 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_1) / var_247_9

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_1 + var_247_9 and arg_244_1.time_ < var_247_1 + var_247_9 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play324081060 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324081060
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play324081061(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1070ui_story = arg_248_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_251_0 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_0 then
				arg_248_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_0)
				arg_248_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).z)
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles = arg_248_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_0 and arg_248_1.time_ < 0 + var_251_0 + arg_251_0 then
				arg_248_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_248_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["1070ui_story"].transform.position).z)
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["1070ui_story"].transform.localEulerAngles = arg_248_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_251_1 = arg_248_1.actors_["10171ui_story"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos10171ui_story = var_251_1.localPosition

				local var_251_2 = GameObjectTools.GetOrAddComponent(var_251_1.gameObject, typeof(DynamicBoneHelper))

				if var_251_2 then
					var_251_2:EnableDynamicBone(false)
				end
			end

			local var_251_3 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_3 then
				var_251_1.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_3)
				var_251_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_1.position).x, (manager.ui.mainCamera.transform.position - var_251_1.position).y, (manager.ui.mainCamera.transform.position - var_251_1.position).z)
				var_251_1.localEulerAngles.z = 0
				var_251_1.localEulerAngles.x = 0
				var_251_1.localEulerAngles = var_251_1.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_3 and arg_248_1.time_ < 0 + var_251_3 + arg_251_0 then
				var_251_1.localPosition = Vector3.New(0, 100, 0)
				var_251_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_1.position).x, (manager.ui.mainCamera.transform.position - var_251_1.position).y, (manager.ui.mainCamera.transform.position - var_251_1.position).z)
				var_251_1.localEulerAngles.z = 0
				var_251_1.localEulerAngles.x = 0
				var_251_1.localEulerAngles = var_251_1.localEulerAngles

				local var_251_4 = GameObjectTools.GetOrAddComponent(var_251_1.gameObject, typeof(DynamicBoneHelper))

				if var_251_4 then
					var_251_4:EnableDynamicBone(true)
				end
			end

			local var_251_5 = 0
			local var_251_6 = 1.15

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_5 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_7 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(324081060).content)

				arg_248_1.text_.text = var_251_7

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_9 = 46 <= 0 and var_251_6 or var_251_6 * (utf8.len(var_251_7) / 46)

				if (46 <= 0 and var_251_6 or var_251_6 * (utf8.len(var_251_7) / 46)) > 0 and var_251_6 < var_251_9 then
					arg_248_1.talkMaxDuration = var_251_9

					if var_251_9 + var_251_5 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_9 + var_251_5
					end
				end

				arg_248_1.text_.text = var_251_7
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_10 = math.max(var_251_6, arg_248_1.talkMaxDuration)

			if var_251_5 <= arg_248_1.time_ and arg_248_1.time_ < var_251_5 + var_251_10 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_5) / var_251_10

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_5 + var_251_10 and arg_248_1.time_ < var_251_5 + var_251_10 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play324081061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324081061
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324081062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_0 = 1.325

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_1 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(324081061).content)

				arg_252_1.text_.text = var_255_1

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_3 = 53 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 53)

				if (53 <= 0 and var_255_0 or var_255_0 * (utf8.len(var_255_1) / 53)) > 0 and var_255_0 < var_255_3 then
					arg_252_1.talkMaxDuration = var_255_3

					if var_255_3 + 0 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_3 + 0
					end
				end

				arg_252_1.text_.text = var_255_1
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_4 = math.max(var_255_0, arg_252_1.talkMaxDuration)

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - 0) / var_255_4

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play324081062 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 324081062
		arg_256_1.duration_ = 5

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play324081063(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 1.45 < arg_256_1.time_ and arg_256_1.time_ <= 1.45 + arg_259_0 then
				arg_256_1:AudioAction("play", "effect", "se_story_side_1148", "se_story_1148_applause", "")
			end

			local var_259_1 = 0
			local var_259_2 = 1.675

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_1 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, false)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_3 = arg_256_1:FormatText(arg_256_1:GetWordFromCfg(324081062).content)

				arg_256_1.text_.text = var_259_3

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_5 = 67 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 67)

				if (67 <= 0 and var_259_2 or var_259_2 * (utf8.len(var_259_3) / 67)) > 0 and var_259_2 < var_259_5 then
					arg_256_1.talkMaxDuration = var_259_5

					if var_259_5 + var_259_1 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + var_259_1
					end
				end

				arg_256_1.text_.text = var_259_3
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)
				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_6 = math.max(var_259_2, arg_256_1.talkMaxDuration)

			if var_259_1 <= arg_256_1.time_ and arg_256_1.time_ < var_259_1 + var_259_6 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_1) / var_259_6

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_1 + var_259_6 and arg_256_1.time_ < var_259_1 + var_259_6 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play324081063 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 324081063
		arg_260_1.duration_ = 3

		local var_260_0 = {
			zh = 2.9,
			ja = 3
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play324081064(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 0.25

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, true)
				arg_260_1.iconController_:SetSelectedState("hero")

				arg_260_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_260_1.callingController_:SetSelectedState("normal")

				arg_260_1.keyicon_.color = Color.New(1, 1, 1)
				arg_260_1.icon_.color = Color.New(1, 1, 1)

				local var_263_1 = arg_260_1:GetWordFromCfg(324081063)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 10 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 10)

				if (10 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 10)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081063", "story_v_out_324081.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081063", "story_v_out_324081.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_324081", "324081063", "story_v_out_324081.awb")

						arg_260_1:RecordAudio("324081063", var_263_6)
						arg_260_1:RecordAudio("324081063", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_324081", "324081063", "story_v_out_324081.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_324081", "324081063", "story_v_out_324081.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play324081064 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 324081064
		arg_264_1.duration_ = 4.23

		local var_264_0 = {
			zh = 3.433,
			ja = 4.233
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play324081065(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.var_.moveOldPos10171ui_story = arg_264_1.actors_["10171ui_story"].transform.localPosition

				local var_267_0 = GameObjectTools.GetOrAddComponent(arg_264_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_267_0 then
					var_267_0:EnableDynamicBone(false)
				end
			end

			local var_267_1 = 0.001

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_1 then
				arg_264_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_264_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_264_1.time_ - 0) / var_267_1)
				arg_264_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["10171ui_story"].transform.position).z)
				arg_264_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["10171ui_story"].transform.localEulerAngles = arg_264_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_264_1.time_ >= 0 + var_267_1 and arg_264_1.time_ < 0 + var_267_1 + arg_267_0 then
				arg_264_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_264_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_264_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_264_1.actors_["10171ui_story"].transform.position).z)
				arg_264_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_264_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_264_1.actors_["10171ui_story"].transform.localEulerAngles = arg_264_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_267_2 = GameObjectTools.GetOrAddComponent(arg_264_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_267_2 then
					var_267_2:EnableDynamicBone(true)
				end
			end

			local var_267_3 = arg_264_1.actors_["10171ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect10171ui_story == nil then
				arg_264_1.var_.characterEffect10171ui_story = var_267_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_4 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_4 and not isNil(var_267_3) then
				if arg_264_1.var_.characterEffect10171ui_story and not isNil(var_267_3) then
					arg_264_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_4 and arg_264_1.time_ < 0 + var_267_4 + arg_267_0 and not isNil(var_267_3) and arg_264_1.var_.characterEffect10171ui_story then
				arg_264_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171actionlink/10171action43027")
			end

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_267_6 = 0
			local var_267_7 = 0.35

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_6 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_8 = arg_264_1:GetWordFromCfg(324081064)
				local var_267_9 = arg_264_1:FormatText(var_267_8.content)

				arg_264_1.text_.text = var_267_9

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_11 = 14 <= 0 and var_267_7 or var_267_7 * (utf8.len(var_267_9) / 14)

				if (14 <= 0 and var_267_7 or var_267_7 * (utf8.len(var_267_9) / 14)) > 0 and var_267_7 < var_267_11 then
					arg_264_1.talkMaxDuration = var_267_11

					if var_267_11 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_11 + var_267_6
					end
				end

				arg_264_1.text_.text = var_267_9
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081064", "story_v_out_324081.awb") ~= 0 then
					local var_267_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081064", "story_v_out_324081.awb") / 1000

					if var_267_12 + var_267_6 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_12 + var_267_6
					end

					if var_267_8.prefab_name ~= "" and arg_264_1.actors_[var_267_8.prefab_name] ~= nil then
						local var_267_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_8.prefab_name].transform, "story_v_out_324081", "324081064", "story_v_out_324081.awb")

						arg_264_1:RecordAudio("324081064", var_267_13)
						arg_264_1:RecordAudio("324081064", var_267_13)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_324081", "324081064", "story_v_out_324081.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_324081", "324081064", "story_v_out_324081.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_14 = math.max(var_267_7, arg_264_1.talkMaxDuration)

			if var_267_6 <= arg_264_1.time_ and arg_264_1.time_ < var_267_6 + var_267_14 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_6) / var_267_14

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_6 + var_267_14 and arg_264_1.time_ < var_267_6 + var_267_14 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_264_1:InitPlayNodeList()
	end,
	Play324081065 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 324081065
		arg_268_1.duration_ = 8.07

		local var_268_0 = {
			zh = 7.766,
			ja = 8.066
		}
		local var_268_1 = manager.audio:GetLocalizationFlag()

		if var_268_0[var_268_1] ~= nil then
			arg_268_1.duration_ = var_268_0[var_268_1]
		end

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play324081066(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["10171ui_story"]) and arg_268_1.var_.characterEffect10171ui_story == nil then
				arg_268_1.var_.characterEffect10171ui_story = arg_268_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["10171ui_story"]) then
				if arg_268_1.var_.characterEffect10171ui_story and not isNil(arg_268_1.actors_["10171ui_story"]) then
					arg_268_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_268_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_0)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["10171ui_story"]) and arg_268_1.var_.characterEffect10171ui_story then
				arg_268_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_268_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_271_1 = 0
			local var_271_2 = 0.675

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:GetWordFromCfg(324081065)
				local var_271_4 = arg_268_1:FormatText(var_271_3.content)

				arg_268_1.text_.text = var_271_4

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_6 = 27 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_4) / 27)

				if (27 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_4) / 27)) > 0 and var_271_2 < var_271_6 then
					arg_268_1.talkMaxDuration = var_271_6

					if var_271_6 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_6 + var_271_1
					end
				end

				arg_268_1.text_.text = var_271_4
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081065", "story_v_out_324081.awb") ~= 0 then
					local var_271_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081065", "story_v_out_324081.awb") / 1000

					if var_271_7 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_7 + var_271_1
					end

					if var_271_3.prefab_name ~= "" and arg_268_1.actors_[var_271_3.prefab_name] ~= nil then
						local var_271_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_268_1.actors_[var_271_3.prefab_name].transform, "story_v_out_324081", "324081065", "story_v_out_324081.awb")

						arg_268_1:RecordAudio("324081065", var_271_8)
						arg_268_1:RecordAudio("324081065", var_271_8)
					else
						arg_268_1:AudioAction("play", "voice", "story_v_out_324081", "324081065", "story_v_out_324081.awb")
					end

					arg_268_1:RecordHistoryTalkVoice("story_v_out_324081", "324081065", "story_v_out_324081.awb")
				end

				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_9 = math.max(var_271_2, arg_268_1.talkMaxDuration)

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_9 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_1) / var_271_9

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_1 + var_271_9 and arg_268_1.time_ < var_271_1 + var_271_9 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play324081066 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 324081066
		arg_272_1.duration_ = 10.03

		local var_272_0 = {
			zh = 8.333,
			ja = 10.033
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play324081067(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.8

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, true)
				arg_272_1.iconController_:SetSelectedState("hero")

				arg_272_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_272_1.callingController_:SetSelectedState("normal")

				arg_272_1.keyicon_.color = Color.New(1, 1, 1)
				arg_272_1.icon_.color = Color.New(1, 1, 1)

				local var_275_1 = arg_272_1:GetWordFromCfg(324081066)
				local var_275_2 = arg_272_1:FormatText(var_275_1.content)

				arg_272_1.text_.text = var_275_2

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_4 = 32 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 32)

				if (32 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_2) / 32)) > 0 and var_275_0 < var_275_4 then
					arg_272_1.talkMaxDuration = var_275_4

					if var_275_4 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_4 + 0
					end
				end

				arg_272_1.text_.text = var_275_2
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081066", "story_v_out_324081.awb") ~= 0 then
					local var_275_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081066", "story_v_out_324081.awb") / 1000

					if var_275_5 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_5 + 0
					end

					if var_275_1.prefab_name ~= "" and arg_272_1.actors_[var_275_1.prefab_name] ~= nil then
						local var_275_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_1.prefab_name].transform, "story_v_out_324081", "324081066", "story_v_out_324081.awb")

						arg_272_1:RecordAudio("324081066", var_275_6)
						arg_272_1:RecordAudio("324081066", var_275_6)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_324081", "324081066", "story_v_out_324081.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_324081", "324081066", "story_v_out_324081.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_7 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_7 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_7

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_7 and arg_272_1.time_ < 0 + var_275_7 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play324081067 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 324081067
		arg_276_1.duration_ = 3.93

		local var_276_0 = {
			zh = 2.3,
			ja = 3.933
		}
		local var_276_1 = manager.audio:GetLocalizationFlag()

		if var_276_0[var_276_1] ~= nil then
			arg_276_1.duration_ = var_276_0[var_276_1]
		end

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play324081068(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.var_.moveOldPos1070ui_story = arg_276_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_279_0 = 0.001

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 then
				arg_276_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_276_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_276_1.time_ - 0) / var_279_0)
				arg_276_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1070ui_story"].transform.position).z)
				arg_276_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1070ui_story"].transform.localEulerAngles = arg_276_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 then
				arg_276_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_276_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_276_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_276_1.actors_["1070ui_story"].transform.position).z)
				arg_276_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_276_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_276_1.actors_["1070ui_story"].transform.localEulerAngles = arg_276_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_279_1 = arg_276_1.actors_["1070ui_story"]

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(var_279_1) and arg_276_1.var_.characterEffect1070ui_story == nil then
				arg_276_1.var_.characterEffect1070ui_story = var_279_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_2 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_2 and not isNil(var_279_1) then
				if arg_276_1.var_.characterEffect1070ui_story and not isNil(var_279_1) then
					arg_276_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_276_1.time_ >= 0 + var_279_2 and arg_276_1.time_ < 0 + var_279_2 + arg_279_0 and not isNil(var_279_1) and arg_276_1.var_.characterEffect1070ui_story then
				arg_276_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_279_4 = 0
			local var_279_5 = 0.275

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_4 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_6 = arg_276_1:GetWordFromCfg(324081067)
				local var_279_7 = arg_276_1:FormatText(var_279_6.content)

				arg_276_1.text_.text = var_279_7

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_9 = 11 <= 0 and var_279_5 or var_279_5 * (utf8.len(var_279_7) / 11)

				if (11 <= 0 and var_279_5 or var_279_5 * (utf8.len(var_279_7) / 11)) > 0 and var_279_5 < var_279_9 then
					arg_276_1.talkMaxDuration = var_279_9

					if var_279_9 + var_279_4 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_9 + var_279_4
					end
				end

				arg_276_1.text_.text = var_279_7
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081067", "story_v_out_324081.awb") ~= 0 then
					local var_279_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081067", "story_v_out_324081.awb") / 1000

					if var_279_10 + var_279_4 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_10 + var_279_4
					end

					if var_279_6.prefab_name ~= "" and arg_276_1.actors_[var_279_6.prefab_name] ~= nil then
						local var_279_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_276_1.actors_[var_279_6.prefab_name].transform, "story_v_out_324081", "324081067", "story_v_out_324081.awb")

						arg_276_1:RecordAudio("324081067", var_279_11)
						arg_276_1:RecordAudio("324081067", var_279_11)
					else
						arg_276_1:AudioAction("play", "voice", "story_v_out_324081", "324081067", "story_v_out_324081.awb")
					end

					arg_276_1:RecordHistoryTalkVoice("story_v_out_324081", "324081067", "story_v_out_324081.awb")
				end

				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_12 = math.max(var_279_5, arg_276_1.talkMaxDuration)

			if var_279_4 <= arg_276_1.time_ and arg_276_1.time_ < var_279_4 + var_279_12 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_4) / var_279_12

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_4 + var_279_12 and arg_276_1.time_ < var_279_4 + var_279_12 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_276_1:InitPlayNodeList()
	end,
	Play324081068 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 324081068
		arg_280_1.duration_ = 12.93

		local var_280_0 = {
			zh = 12.933,
			ja = 12.5
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play324081069(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(arg_280_1.actors_["1070ui_story"]) and arg_280_1.var_.characterEffect1070ui_story == nil then
				arg_280_1.var_.characterEffect1070ui_story = arg_280_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_283_0 = 0.200000002980232

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_0 and not isNil(arg_280_1.actors_["1070ui_story"]) then
				if arg_280_1.var_.characterEffect1070ui_story and not isNil(arg_280_1.actors_["1070ui_story"]) then
					arg_280_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_280_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_280_1.time_ - 0) / var_283_0)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_0 and arg_280_1.time_ < 0 + var_283_0 + arg_283_0 and not isNil(arg_280_1.actors_["1070ui_story"]) and arg_280_1.var_.characterEffect1070ui_story then
				arg_280_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_280_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_283_1 = 0
			local var_283_2 = 1

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_1 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, true)
				arg_280_1.iconController_:SetSelectedState("hero")

				arg_280_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_280_1.callingController_:SetSelectedState("normal")

				arg_280_1.keyicon_.color = Color.New(1, 1, 1)
				arg_280_1.icon_.color = Color.New(1, 1, 1)

				local var_283_3 = arg_280_1:GetWordFromCfg(324081068)
				local var_283_4 = arg_280_1:FormatText(var_283_3.content)

				arg_280_1.text_.text = var_283_4

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_6 = 40 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 40)

				if (40 <= 0 and var_283_2 or var_283_2 * (utf8.len(var_283_4) / 40)) > 0 and var_283_2 < var_283_6 then
					arg_280_1.talkMaxDuration = var_283_6

					if var_283_6 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_6 + var_283_1
					end
				end

				arg_280_1.text_.text = var_283_4
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081068", "story_v_out_324081.awb") ~= 0 then
					local var_283_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081068", "story_v_out_324081.awb") / 1000

					if var_283_7 + var_283_1 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_7 + var_283_1
					end

					if var_283_3.prefab_name ~= "" and arg_280_1.actors_[var_283_3.prefab_name] ~= nil then
						local var_283_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_3.prefab_name].transform, "story_v_out_324081", "324081068", "story_v_out_324081.awb")

						arg_280_1:RecordAudio("324081068", var_283_8)
						arg_280_1:RecordAudio("324081068", var_283_8)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_324081", "324081068", "story_v_out_324081.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_324081", "324081068", "story_v_out_324081.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_9 = math.max(var_283_2, arg_280_1.talkMaxDuration)

			if var_283_1 <= arg_280_1.time_ and arg_280_1.time_ < var_283_1 + var_283_9 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_1) / var_283_9

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_1 + var_283_9 and arg_280_1.time_ < var_283_1 + var_283_9 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {}

		arg_280_1:InitPlayNodeList()
	end,
	Play324081069 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 324081069
		arg_284_1.duration_ = 2.47

		local var_284_0 = {
			zh = 2.466,
			ja = 2.433
		}
		local var_284_1 = manager.audio:GetLocalizationFlag()

		if var_284_0[var_284_1] ~= nil then
			arg_284_1.duration_ = var_284_0[var_284_1]
		end

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play324081070(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			local var_287_0 = 0.175

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, true)

				arg_284_1.leftNameTxt_.text = arg_284_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_284_1.leftNameTxt_.transform)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1.leftNameTxt_.text)
				SetActive(arg_284_1.iconTrs_.gameObject, true)
				arg_284_1.iconController_:SetSelectedState("hero")

				arg_284_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_284_1.callingController_:SetSelectedState("normal")

				arg_284_1.keyicon_.color = Color.New(1, 1, 1)
				arg_284_1.icon_.color = Color.New(1, 1, 1)

				local var_287_1 = arg_284_1:GetWordFromCfg(324081069)
				local var_287_2 = arg_284_1:FormatText(var_287_1.content)

				arg_284_1.text_.text = var_287_2

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_4 = 7 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 7)

				if (7 <= 0 and var_287_0 or var_287_0 * (utf8.len(var_287_2) / 7)) > 0 and var_287_0 < var_287_4 then
					arg_284_1.talkMaxDuration = var_287_4

					if var_287_4 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_4 + 0
					end
				end

				arg_284_1.text_.text = var_287_2
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081069", "story_v_out_324081.awb") ~= 0 then
					local var_287_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081069", "story_v_out_324081.awb") / 1000

					if var_287_5 + 0 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_5 + 0
					end

					if var_287_1.prefab_name ~= "" and arg_284_1.actors_[var_287_1.prefab_name] ~= nil then
						local var_287_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_284_1.actors_[var_287_1.prefab_name].transform, "story_v_out_324081", "324081069", "story_v_out_324081.awb")

						arg_284_1:RecordAudio("324081069", var_287_6)
						arg_284_1:RecordAudio("324081069", var_287_6)
					else
						arg_284_1:AudioAction("play", "voice", "story_v_out_324081", "324081069", "story_v_out_324081.awb")
					end

					arg_284_1:RecordHistoryTalkVoice("story_v_out_324081", "324081069", "story_v_out_324081.awb")
				end

				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_7 = math.max(var_287_0, arg_284_1.talkMaxDuration)

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_7 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - 0) / var_287_7

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= 0 + var_287_7 and arg_284_1.time_ < 0 + var_287_7 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {}

		arg_284_1:InitPlayNodeList()
	end,
	Play324081070 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 324081070
		arg_288_1.duration_ = 4

		local var_288_0 = {
			zh = 4,
			ja = 2.866
		}
		local var_288_1 = manager.audio:GetLocalizationFlag()

		if var_288_0[var_288_1] ~= nil then
			arg_288_1.duration_ = var_288_0[var_288_1]
		end

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play324081071(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos1070ui_story = arg_288_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_291_0 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_0 then
				arg_288_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_288_1.time_ - 0) / var_291_0)
				arg_288_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).z)
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles = arg_288_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_0 and arg_288_1.time_ < 0 + var_291_0 + arg_291_0 then
				arg_288_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_288_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_288_1.actors_["1070ui_story"].transform.position).z)
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_288_1.actors_["1070ui_story"].transform.localEulerAngles = arg_288_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_291_1 = arg_288_1.actors_["10171ui_story"].transform

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.var_.moveOldPos10171ui_story = var_291_1.localPosition

				local var_291_2 = GameObjectTools.GetOrAddComponent(var_291_1.gameObject, typeof(DynamicBoneHelper))

				if var_291_2 then
					var_291_2:EnableDynamicBone(false)
				end
			end

			local var_291_3 = 0.001

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_3 then
				var_291_1.localPosition = Vector3.Lerp(arg_288_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_288_1.time_ - 0) / var_291_3)
				var_291_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_1.position).x, (manager.ui.mainCamera.transform.position - var_291_1.position).y, (manager.ui.mainCamera.transform.position - var_291_1.position).z)
				var_291_1.localEulerAngles.z = 0
				var_291_1.localEulerAngles.x = 0
				var_291_1.localEulerAngles = var_291_1.localEulerAngles
			end

			if arg_288_1.time_ >= 0 + var_291_3 and arg_288_1.time_ < 0 + var_291_3 + arg_291_0 then
				var_291_1.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_291_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_291_1.position).x, (manager.ui.mainCamera.transform.position - var_291_1.position).y, (manager.ui.mainCamera.transform.position - var_291_1.position).z)
				var_291_1.localEulerAngles.z = 0
				var_291_1.localEulerAngles.x = 0
				var_291_1.localEulerAngles = var_291_1.localEulerAngles

				local var_291_4 = GameObjectTools.GetOrAddComponent(var_291_1.gameObject, typeof(DynamicBoneHelper))

				if var_291_4 then
					var_291_4:EnableDynamicBone(true)
				end
			end

			local var_291_5 = arg_288_1.actors_["10171ui_story"]

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 and not isNil(var_291_5) and arg_288_1.var_.characterEffect10171ui_story == nil then
				arg_288_1.var_.characterEffect10171ui_story = var_291_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_291_6 = 0.200000002980232

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_6 and not isNil(var_291_5) then
				if arg_288_1.var_.characterEffect10171ui_story and not isNil(var_291_5) then
					arg_288_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_288_1.time_ >= 0 + var_291_6 and arg_288_1.time_ < 0 + var_291_6 + arg_291_0 and not isNil(var_291_5) and arg_288_1.var_.characterEffect10171ui_story then
				arg_288_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_2")
			end

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_291_8 = 0
			local var_291_9 = 0.275

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= var_291_8 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, true)

				arg_288_1.leftNameTxt_.text = arg_288_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_288_1.leftNameTxt_.transform)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1.leftNameTxt_.text)
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_10 = arg_288_1:GetWordFromCfg(324081070)
				local var_291_11 = arg_288_1:FormatText(var_291_10.content)

				arg_288_1.text_.text = var_291_11

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_13 = 11 <= 0 and var_291_9 or var_291_9 * (utf8.len(var_291_11) / 11)

				if (11 <= 0 and var_291_9 or var_291_9 * (utf8.len(var_291_11) / 11)) > 0 and var_291_9 < var_291_13 then
					arg_288_1.talkMaxDuration = var_291_13

					if var_291_13 + var_291_8 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_13 + var_291_8
					end
				end

				arg_288_1.text_.text = var_291_11
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081070", "story_v_out_324081.awb") ~= 0 then
					local var_291_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081070", "story_v_out_324081.awb") / 1000

					if var_291_14 + var_291_8 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_14 + var_291_8
					end

					if var_291_10.prefab_name ~= "" and arg_288_1.actors_[var_291_10.prefab_name] ~= nil then
						local var_291_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_288_1.actors_[var_291_10.prefab_name].transform, "story_v_out_324081", "324081070", "story_v_out_324081.awb")

						arg_288_1:RecordAudio("324081070", var_291_15)
						arg_288_1:RecordAudio("324081070", var_291_15)
					else
						arg_288_1:AudioAction("play", "voice", "story_v_out_324081", "324081070", "story_v_out_324081.awb")
					end

					arg_288_1:RecordHistoryTalkVoice("story_v_out_324081", "324081070", "story_v_out_324081.awb")
				end

				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_16 = math.max(var_291_9, arg_288_1.talkMaxDuration)

			if var_291_8 <= arg_288_1.time_ and arg_288_1.time_ < var_291_8 + var_291_16 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - var_291_8) / var_291_16

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= var_291_8 + var_291_16 and arg_288_1.time_ < var_291_8 + var_291_16 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_288_1:InitPlayNodeList()
	end,
	Play324081071 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 324081071
		arg_292_1.duration_ = 3.97

		local var_292_0 = {
			zh = 2.333,
			ja = 3.966
		}
		local var_292_1 = manager.audio:GetLocalizationFlag()

		if var_292_0[var_292_1] ~= nil then
			arg_292_1.duration_ = var_292_0[var_292_1]
		end

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play324081072(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(arg_292_1.actors_["1070ui_story"]) and arg_292_1.var_.characterEffect1070ui_story == nil then
				arg_292_1.var_.characterEffect1070ui_story = arg_292_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_0 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_0 and not isNil(arg_292_1.actors_["1070ui_story"]) then
				if arg_292_1.var_.characterEffect1070ui_story and not isNil(arg_292_1.actors_["1070ui_story"]) then
					arg_292_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_292_1.time_ >= 0 + var_295_0 and arg_292_1.time_ < 0 + var_295_0 + arg_295_0 and not isNil(arg_292_1.actors_["1070ui_story"]) and arg_292_1.var_.characterEffect1070ui_story then
				arg_292_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_295_2 = arg_292_1.actors_["10171ui_story"]

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.characterEffect10171ui_story == nil then
				arg_292_1.var_.characterEffect10171ui_story = var_295_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_295_3 = 0.200000002980232

			if 0 <= arg_292_1.time_ and arg_292_1.time_ < 0 + var_295_3 and not isNil(var_295_2) then
				if arg_292_1.var_.characterEffect10171ui_story and not isNil(var_295_2) then
					arg_292_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_292_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_292_1.time_ - 0) / var_295_3)
				end
			end

			if arg_292_1.time_ >= 0 + var_295_3 and arg_292_1.time_ < 0 + var_295_3 + arg_295_0 and not isNil(var_295_2) and arg_292_1.var_.characterEffect10171ui_story then
				arg_292_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_292_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= 0 + arg_295_0 then
				arg_292_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva", "EmotionTimelineAnimator")
			end

			local var_295_4 = 0
			local var_295_5 = 0.225

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0
				arg_292_1.dialogCg_.alpha = 1

				arg_292_1.dialog_:SetActive(true)
				SetActive(arg_292_1.leftNameGo_, true)

				arg_292_1.leftNameTxt_.text = arg_292_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_292_1.leftNameTxt_.transform)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1.leftNameTxt_.text)
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_6 = arg_292_1:GetWordFromCfg(324081071)
				local var_295_7 = arg_292_1:FormatText(var_295_6.content)

				arg_292_1.text_.text = var_295_7

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_9 = 9 <= 0 and var_295_5 or var_295_5 * (utf8.len(var_295_7) / 9)

				if (9 <= 0 and var_295_5 or var_295_5 * (utf8.len(var_295_7) / 9)) > 0 and var_295_5 < var_295_9 then
					arg_292_1.talkMaxDuration = var_295_9

					if var_295_9 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_9 + var_295_4
					end
				end

				arg_292_1.text_.text = var_295_7
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081071", "story_v_out_324081.awb") ~= 0 then
					local var_295_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081071", "story_v_out_324081.awb") / 1000

					if var_295_10 + var_295_4 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_10 + var_295_4
					end

					if var_295_6.prefab_name ~= "" and arg_292_1.actors_[var_295_6.prefab_name] ~= nil then
						local var_295_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_292_1.actors_[var_295_6.prefab_name].transform, "story_v_out_324081", "324081071", "story_v_out_324081.awb")

						arg_292_1:RecordAudio("324081071", var_295_11)
						arg_292_1:RecordAudio("324081071", var_295_11)
					else
						arg_292_1:AudioAction("play", "voice", "story_v_out_324081", "324081071", "story_v_out_324081.awb")
					end

					arg_292_1:RecordHistoryTalkVoice("story_v_out_324081", "324081071", "story_v_out_324081.awb")
				end

				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_12 = math.max(var_295_5, arg_292_1.talkMaxDuration)

			if var_295_4 <= arg_292_1.time_ and arg_292_1.time_ < var_295_4 + var_295_12 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_4) / var_295_12

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_4 + var_295_12 and arg_292_1.time_ < var_295_4 + var_295_12 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play324081072 = function(arg_296_0, arg_296_1)
		arg_296_1.time_ = 0
		arg_296_1.frameCnt_ = 0
		arg_296_1.state_ = "playing"
		arg_296_1.curTalkId_ = 324081072
		arg_296_1.duration_ = 9.6

		local var_296_0 = {
			zh = 9.566,
			ja = 9.6
		}
		local var_296_1 = manager.audio:GetLocalizationFlag()

		if var_296_0[var_296_1] ~= nil then
			arg_296_1.duration_ = var_296_0[var_296_1]
		end

		SetActive(arg_296_1.tipsGo_, false)

		function arg_296_1.onSingleLineFinish_()
			arg_296_1.onSingleLineUpdate_ = nil
			arg_296_1.onSingleLineFinish_ = nil
			arg_296_1.state_ = "waiting"
		end

		function arg_296_1.playNext_(arg_298_0)
			if arg_298_0 == 1 then
				arg_296_0:Play324081073(arg_296_1)
			end
		end

		function arg_296_1.onSingleLineUpdate_(arg_299_0)
			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(arg_296_1.actors_["10171ui_story"]) and arg_296_1.var_.characterEffect10171ui_story == nil then
				arg_296_1.var_.characterEffect10171ui_story = arg_296_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_0 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_0 and not isNil(arg_296_1.actors_["10171ui_story"]) then
				if arg_296_1.var_.characterEffect10171ui_story and not isNil(arg_296_1.actors_["10171ui_story"]) then
					arg_296_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_296_1.time_ >= 0 + var_299_0 and arg_296_1.time_ < 0 + var_299_0 + arg_299_0 and not isNil(arg_296_1.actors_["10171ui_story"]) and arg_296_1.var_.characterEffect10171ui_story then
				arg_296_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_299_2 = arg_296_1.actors_["1070ui_story"]

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= 0 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.characterEffect1070ui_story == nil then
				arg_296_1.var_.characterEffect1070ui_story = var_299_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_299_3 = 0.200000002980232

			if 0 <= arg_296_1.time_ and arg_296_1.time_ < 0 + var_299_3 and not isNil(var_299_2) then
				if arg_296_1.var_.characterEffect1070ui_story and not isNil(var_299_2) then
					arg_296_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_296_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_296_1.time_ - 0) / var_299_3)
				end
			end

			if arg_296_1.time_ >= 0 + var_299_3 and arg_296_1.time_ < 0 + var_299_3 + arg_299_0 and not isNil(var_299_2) and arg_296_1.var_.characterEffect1070ui_story then
				arg_296_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_296_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_299_4 = 0
			local var_299_5 = 1.15

			if 0 < arg_296_1.time_ and arg_296_1.time_ <= var_299_4 + arg_299_0 then
				arg_296_1.talkMaxDuration = 0
				arg_296_1.dialogCg_.alpha = 1

				arg_296_1.dialog_:SetActive(true)
				SetActive(arg_296_1.leftNameGo_, true)

				arg_296_1.leftNameTxt_.text = arg_296_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_296_1.leftNameTxt_.transform)

				arg_296_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_296_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_296_1:RecordName(arg_296_1.leftNameTxt_.text)
				SetActive(arg_296_1.iconTrs_.gameObject, false)
				arg_296_1.callingController_:SetSelectedState("normal")

				local var_299_6 = arg_296_1:GetWordFromCfg(324081072)
				local var_299_7 = arg_296_1:FormatText(var_299_6.content)

				arg_296_1.text_.text = var_299_7

				LuaForUtil.ClearLinePrefixSymbol(arg_296_1.text_)

				local var_299_9 = 46 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 46)

				if (46 <= 0 and var_299_5 or var_299_5 * (utf8.len(var_299_7) / 46)) > 0 and var_299_5 < var_299_9 then
					arg_296_1.talkMaxDuration = var_299_9

					if var_299_9 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_9 + var_299_4
					end
				end

				arg_296_1.text_.text = var_299_7
				arg_296_1.typewritter.percent = 0

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081072", "story_v_out_324081.awb") ~= 0 then
					local var_299_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081072", "story_v_out_324081.awb") / 1000

					if var_299_10 + var_299_4 > arg_296_1.duration_ then
						arg_296_1.duration_ = var_299_10 + var_299_4
					end

					if var_299_6.prefab_name ~= "" and arg_296_1.actors_[var_299_6.prefab_name] ~= nil then
						local var_299_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_296_1.actors_[var_299_6.prefab_name].transform, "story_v_out_324081", "324081072", "story_v_out_324081.awb")

						arg_296_1:RecordAudio("324081072", var_299_11)
						arg_296_1:RecordAudio("324081072", var_299_11)
					else
						arg_296_1:AudioAction("play", "voice", "story_v_out_324081", "324081072", "story_v_out_324081.awb")
					end

					arg_296_1:RecordHistoryTalkVoice("story_v_out_324081", "324081072", "story_v_out_324081.awb")
				end

				arg_296_1:RecordContent(arg_296_1.text_.text)
			end

			local var_299_12 = math.max(var_299_5, arg_296_1.talkMaxDuration)

			if var_299_4 <= arg_296_1.time_ and arg_296_1.time_ < var_299_4 + var_299_12 then
				arg_296_1.typewritter.percent = (arg_296_1.time_ - var_299_4) / var_299_12

				arg_296_1.typewritter:SetDirty()
			end

			if arg_296_1.time_ >= var_299_4 + var_299_12 and arg_296_1.time_ < var_299_4 + var_299_12 + arg_299_0 then
				arg_296_1.typewritter.percent = 1

				arg_296_1.typewritter:SetDirty()
				arg_296_1:ShowNextGo(true)
			end
		end

		arg_296_1.nodeConfigList_ = {}

		arg_296_1:InitPlayNodeList()
	end,
	Play324081073 = function(arg_300_0, arg_300_1)
		arg_300_1.time_ = 0
		arg_300_1.frameCnt_ = 0
		arg_300_1.state_ = "playing"
		arg_300_1.curTalkId_ = 324081073
		arg_300_1.duration_ = 1.2

		local var_300_0 = {
			zh = 1.2,
			ja = 0.999999999999
		}
		local var_300_1 = manager.audio:GetLocalizationFlag()

		if var_300_0[var_300_1] ~= nil then
			arg_300_1.duration_ = var_300_0[var_300_1]
		end

		SetActive(arg_300_1.tipsGo_, false)

		function arg_300_1.onSingleLineFinish_()
			arg_300_1.onSingleLineUpdate_ = nil
			arg_300_1.onSingleLineFinish_ = nil
			arg_300_1.state_ = "waiting"
		end

		function arg_300_1.playNext_(arg_302_0)
			if arg_302_0 == 1 then
				arg_300_0:Play324081074(arg_300_1)
			end
		end

		function arg_300_1.onSingleLineUpdate_(arg_303_0)
			if 0 < arg_300_1.time_ and arg_300_1.time_ <= 0 + arg_303_0 and not isNil(arg_300_1.actors_["10171ui_story"]) and arg_300_1.var_.characterEffect10171ui_story == nil then
				arg_300_1.var_.characterEffect10171ui_story = arg_300_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_303_0 = 0.200000002980232

			if 0 <= arg_300_1.time_ and arg_300_1.time_ < 0 + var_303_0 and not isNil(arg_300_1.actors_["10171ui_story"]) then
				if arg_300_1.var_.characterEffect10171ui_story and not isNil(arg_300_1.actors_["10171ui_story"]) then
					arg_300_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_300_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_300_1.time_ - 0) / var_303_0)
				end
			end

			if arg_300_1.time_ >= 0 + var_303_0 and arg_300_1.time_ < 0 + var_303_0 + arg_303_0 and not isNil(arg_300_1.actors_["10171ui_story"]) and arg_300_1.var_.characterEffect10171ui_story then
				arg_300_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_300_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_303_1 = 0
			local var_303_2 = 0.075

			if 0 < arg_300_1.time_ and arg_300_1.time_ <= var_303_1 + arg_303_0 then
				arg_300_1.talkMaxDuration = 0
				arg_300_1.dialogCg_.alpha = 1

				arg_300_1.dialog_:SetActive(true)
				SetActive(arg_300_1.leftNameGo_, true)

				arg_300_1.leftNameTxt_.text = arg_300_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_300_1.leftNameTxt_.transform)

				arg_300_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_300_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_300_1:RecordName(arg_300_1.leftNameTxt_.text)
				SetActive(arg_300_1.iconTrs_.gameObject, true)
				arg_300_1.iconController_:SetSelectedState("hero")

				arg_300_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_300_1.callingController_:SetSelectedState("normal")

				arg_300_1.keyicon_.color = Color.New(1, 1, 1)
				arg_300_1.icon_.color = Color.New(1, 1, 1)

				local var_303_3 = arg_300_1:GetWordFromCfg(324081073)
				local var_303_4 = arg_300_1:FormatText(var_303_3.content)

				arg_300_1.text_.text = var_303_4

				LuaForUtil.ClearLinePrefixSymbol(arg_300_1.text_)

				local var_303_6 = 3 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_4) / 3)

				if (3 <= 0 and var_303_2 or var_303_2 * (utf8.len(var_303_4) / 3)) > 0 and var_303_2 < var_303_6 then
					arg_300_1.talkMaxDuration = var_303_6

					if var_303_6 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_6 + var_303_1
					end
				end

				arg_300_1.text_.text = var_303_4
				arg_300_1.typewritter.percent = 0

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081073", "story_v_out_324081.awb") ~= 0 then
					local var_303_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081073", "story_v_out_324081.awb") / 1000

					if var_303_7 + var_303_1 > arg_300_1.duration_ then
						arg_300_1.duration_ = var_303_7 + var_303_1
					end

					if var_303_3.prefab_name ~= "" and arg_300_1.actors_[var_303_3.prefab_name] ~= nil then
						local var_303_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_300_1.actors_[var_303_3.prefab_name].transform, "story_v_out_324081", "324081073", "story_v_out_324081.awb")

						arg_300_1:RecordAudio("324081073", var_303_8)
						arg_300_1:RecordAudio("324081073", var_303_8)
					else
						arg_300_1:AudioAction("play", "voice", "story_v_out_324081", "324081073", "story_v_out_324081.awb")
					end

					arg_300_1:RecordHistoryTalkVoice("story_v_out_324081", "324081073", "story_v_out_324081.awb")
				end

				arg_300_1:RecordContent(arg_300_1.text_.text)
			end

			local var_303_9 = math.max(var_303_2, arg_300_1.talkMaxDuration)

			if var_303_1 <= arg_300_1.time_ and arg_300_1.time_ < var_303_1 + var_303_9 then
				arg_300_1.typewritter.percent = (arg_300_1.time_ - var_303_1) / var_303_9

				arg_300_1.typewritter:SetDirty()
			end

			if arg_300_1.time_ >= var_303_1 + var_303_9 and arg_300_1.time_ < var_303_1 + var_303_9 + arg_303_0 then
				arg_300_1.typewritter.percent = 1

				arg_300_1.typewritter:SetDirty()
				arg_300_1:ShowNextGo(true)
			end
		end

		arg_300_1.nodeConfigList_ = {}

		arg_300_1:InitPlayNodeList()
	end,
	Play324081074 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 324081074
		arg_304_1.duration_ = 12.93

		local var_304_0 = {
			zh = 12.933,
			ja = 12.366
		}
		local var_304_1 = manager.audio:GetLocalizationFlag()

		if var_304_0[var_304_1] ~= nil then
			arg_304_1.duration_ = var_304_0[var_304_1]
		end

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play324081075(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_0 = 1.2

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0
				arg_304_1.dialogCg_.alpha = 1

				arg_304_1.dialog_:SetActive(true)
				SetActive(arg_304_1.leftNameGo_, true)

				arg_304_1.leftNameTxt_.text = arg_304_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_304_1.leftNameTxt_.transform)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1.leftNameTxt_.text)
				SetActive(arg_304_1.iconTrs_.gameObject, true)
				arg_304_1.iconController_:SetSelectedState("hero")

				arg_304_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_304_1.callingController_:SetSelectedState("normal")

				arg_304_1.keyicon_.color = Color.New(1, 1, 1)
				arg_304_1.icon_.color = Color.New(1, 1, 1)

				local var_307_1 = arg_304_1:GetWordFromCfg(324081074)
				local var_307_2 = arg_304_1:FormatText(var_307_1.content)

				arg_304_1.text_.text = var_307_2

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_4 = 48 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 48)

				if (48 <= 0 and var_307_0 or var_307_0 * (utf8.len(var_307_2) / 48)) > 0 and var_307_0 < var_307_4 then
					arg_304_1.talkMaxDuration = var_307_4

					if var_307_4 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_4 + 0
					end
				end

				arg_304_1.text_.text = var_307_2
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081074", "story_v_out_324081.awb") ~= 0 then
					local var_307_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081074", "story_v_out_324081.awb") / 1000

					if var_307_5 + 0 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_5 + 0
					end

					if var_307_1.prefab_name ~= "" and arg_304_1.actors_[var_307_1.prefab_name] ~= nil then
						local var_307_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_304_1.actors_[var_307_1.prefab_name].transform, "story_v_out_324081", "324081074", "story_v_out_324081.awb")

						arg_304_1:RecordAudio("324081074", var_307_6)
						arg_304_1:RecordAudio("324081074", var_307_6)
					else
						arg_304_1:AudioAction("play", "voice", "story_v_out_324081", "324081074", "story_v_out_324081.awb")
					end

					arg_304_1:RecordHistoryTalkVoice("story_v_out_324081", "324081074", "story_v_out_324081.awb")
				end

				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_7 = math.max(var_307_0, arg_304_1.talkMaxDuration)

			if 0 <= arg_304_1.time_ and arg_304_1.time_ < 0 + var_307_7 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - 0) / var_307_7

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= 0 + var_307_7 and arg_304_1.time_ < 0 + var_307_7 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play324081075 = function(arg_308_0, arg_308_1)
		arg_308_1.time_ = 0
		arg_308_1.frameCnt_ = 0
		arg_308_1.state_ = "playing"
		arg_308_1.curTalkId_ = 324081075
		arg_308_1.duration_ = 5

		SetActive(arg_308_1.tipsGo_, false)

		function arg_308_1.onSingleLineFinish_()
			arg_308_1.onSingleLineUpdate_ = nil
			arg_308_1.onSingleLineFinish_ = nil
			arg_308_1.state_ = "waiting"
		end

		function arg_308_1.playNext_(arg_310_0)
			if arg_310_0 == 1 then
				arg_308_0:Play324081076(arg_308_1)
			end
		end

		function arg_308_1.onSingleLineUpdate_(arg_311_0)
			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos1070ui_story = arg_308_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_311_0 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_0 then
				arg_308_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_0)
				arg_308_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1070ui_story"].transform.position).z)
				arg_308_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1070ui_story"].transform.localEulerAngles = arg_308_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_0 and arg_308_1.time_ < 0 + var_311_0 + arg_311_0 then
				arg_308_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_308_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_308_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_308_1.actors_["1070ui_story"].transform.position).z)
				arg_308_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_308_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_308_1.actors_["1070ui_story"].transform.localEulerAngles = arg_308_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_311_1 = arg_308_1.actors_["10171ui_story"].transform

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= 0 + arg_311_0 then
				arg_308_1.var_.moveOldPos10171ui_story = var_311_1.localPosition

				local var_311_2 = GameObjectTools.GetOrAddComponent(var_311_1.gameObject, typeof(DynamicBoneHelper))

				if var_311_2 then
					var_311_2:EnableDynamicBone(false)
				end
			end

			local var_311_3 = 0.001

			if 0 <= arg_308_1.time_ and arg_308_1.time_ < 0 + var_311_3 then
				var_311_1.localPosition = Vector3.Lerp(arg_308_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_308_1.time_ - 0) / var_311_3)
				var_311_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_1.position).x, (manager.ui.mainCamera.transform.position - var_311_1.position).y, (manager.ui.mainCamera.transform.position - var_311_1.position).z)
				var_311_1.localEulerAngles.z = 0
				var_311_1.localEulerAngles.x = 0
				var_311_1.localEulerAngles = var_311_1.localEulerAngles
			end

			if arg_308_1.time_ >= 0 + var_311_3 and arg_308_1.time_ < 0 + var_311_3 + arg_311_0 then
				var_311_1.localPosition = Vector3.New(0, 100, 0)
				var_311_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_311_1.position).x, (manager.ui.mainCamera.transform.position - var_311_1.position).y, (manager.ui.mainCamera.transform.position - var_311_1.position).z)
				var_311_1.localEulerAngles.z = 0
				var_311_1.localEulerAngles.x = 0
				var_311_1.localEulerAngles = var_311_1.localEulerAngles

				local var_311_4 = GameObjectTools.GetOrAddComponent(var_311_1.gameObject, typeof(DynamicBoneHelper))

				if var_311_4 then
					var_311_4:EnableDynamicBone(true)
				end
			end

			if 1.5 < arg_308_1.time_ and arg_308_1.time_ <= 1.5 + arg_311_0 then
				arg_308_1:AudioAction("play", "effect", "se_story_side_1034", "se_story_side_1034_car_door", "")
			end

			local var_311_6 = 0
			local var_311_7 = 1.625

			if 0 < arg_308_1.time_ and arg_308_1.time_ <= var_311_6 + arg_311_0 then
				arg_308_1.talkMaxDuration = 0
				arg_308_1.dialogCg_.alpha = 1

				arg_308_1.dialog_:SetActive(true)
				SetActive(arg_308_1.leftNameGo_, false)

				arg_308_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_308_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_308_1:RecordName(arg_308_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_308_1.iconTrs_.gameObject, false)
				arg_308_1.callingController_:SetSelectedState("normal")

				local var_311_8 = arg_308_1:FormatText(arg_308_1:GetWordFromCfg(324081075).content)

				arg_308_1.text_.text = var_311_8

				LuaForUtil.ClearLinePrefixSymbol(arg_308_1.text_)

				local var_311_10 = 65 <= 0 and var_311_7 or var_311_7 * (utf8.len(var_311_8) / 65)

				if (65 <= 0 and var_311_7 or var_311_7 * (utf8.len(var_311_8) / 65)) > 0 and var_311_7 < var_311_10 then
					arg_308_1.talkMaxDuration = var_311_10

					if var_311_10 + var_311_6 > arg_308_1.duration_ then
						arg_308_1.duration_ = var_311_10 + var_311_6
					end
				end

				arg_308_1.text_.text = var_311_8
				arg_308_1.typewritter.percent = 0

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(false)
				arg_308_1:RecordContent(arg_308_1.text_.text)
			end

			local var_311_11 = math.max(var_311_7, arg_308_1.talkMaxDuration)

			if var_311_6 <= arg_308_1.time_ and arg_308_1.time_ < var_311_6 + var_311_11 then
				arg_308_1.typewritter.percent = (arg_308_1.time_ - var_311_6) / var_311_11

				arg_308_1.typewritter:SetDirty()
			end

			if arg_308_1.time_ >= var_311_6 + var_311_11 and arg_308_1.time_ < var_311_6 + var_311_11 + arg_311_0 then
				arg_308_1.typewritter.percent = 1

				arg_308_1.typewritter:SetDirty()
				arg_308_1:ShowNextGo(true)
			end
		end

		arg_308_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_308_1:InitPlayNodeList()
	end,
	Play324081076 = function(arg_312_0, arg_312_1)
		arg_312_1.time_ = 0
		arg_312_1.frameCnt_ = 0
		arg_312_1.state_ = "playing"
		arg_312_1.curTalkId_ = 324081076
		arg_312_1.duration_ = 4.33

		local var_312_0 = {
			zh = 4.333,
			ja = 2.766
		}
		local var_312_1 = manager.audio:GetLocalizationFlag()

		if var_312_0[var_312_1] ~= nil then
			arg_312_1.duration_ = var_312_0[var_312_1]
		end

		SetActive(arg_312_1.tipsGo_, false)

		function arg_312_1.onSingleLineFinish_()
			arg_312_1.onSingleLineUpdate_ = nil
			arg_312_1.onSingleLineFinish_ = nil
			arg_312_1.state_ = "waiting"
		end

		function arg_312_1.playNext_(arg_314_0)
			if arg_314_0 == 1 then
				arg_312_0:Play324081077(arg_312_1)
			end
		end

		function arg_312_1.onSingleLineUpdate_(arg_315_0)
			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1.var_.moveOldPos10171ui_story = arg_312_1.actors_["10171ui_story"].transform.localPosition

				local var_315_0 = GameObjectTools.GetOrAddComponent(arg_312_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_315_0 then
					var_315_0:EnableDynamicBone(false)
				end
			end

			local var_315_1 = 0.001

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_1 then
				arg_312_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_312_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_312_1.time_ - 0) / var_315_1)
				arg_312_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10171ui_story"].transform.position).z)
				arg_312_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["10171ui_story"].transform.localEulerAngles = arg_312_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_312_1.time_ >= 0 + var_315_1 and arg_312_1.time_ < 0 + var_315_1 + arg_315_0 then
				arg_312_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_312_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_312_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_312_1.actors_["10171ui_story"].transform.position).z)
				arg_312_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_312_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_312_1.actors_["10171ui_story"].transform.localEulerAngles = arg_312_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_315_2 = GameObjectTools.GetOrAddComponent(arg_312_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_315_2 then
					var_315_2:EnableDynamicBone(true)
				end
			end

			local var_315_3 = arg_312_1.actors_["10171ui_story"]

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 and not isNil(var_315_3) and arg_312_1.var_.characterEffect10171ui_story == nil then
				arg_312_1.var_.characterEffect10171ui_story = var_315_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_315_4 = 0.200000002980232

			if 0 <= arg_312_1.time_ and arg_312_1.time_ < 0 + var_315_4 and not isNil(var_315_3) then
				if arg_312_1.var_.characterEffect10171ui_story and not isNil(var_315_3) then
					arg_312_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_312_1.time_ >= 0 + var_315_4 and arg_312_1.time_ < 0 + var_315_4 + arg_315_0 and not isNil(var_315_3) and arg_312_1.var_.characterEffect10171ui_story then
				arg_312_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_1")
			end

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= 0 + arg_315_0 then
				arg_312_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_315_6 = 0
			local var_315_7 = 0.3

			if 0 < arg_312_1.time_ and arg_312_1.time_ <= var_315_6 + arg_315_0 then
				arg_312_1.talkMaxDuration = 0
				arg_312_1.dialogCg_.alpha = 1

				arg_312_1.dialog_:SetActive(true)
				SetActive(arg_312_1.leftNameGo_, true)

				arg_312_1.leftNameTxt_.text = arg_312_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_312_1.leftNameTxt_.transform)

				arg_312_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_312_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_312_1:RecordName(arg_312_1.leftNameTxt_.text)
				SetActive(arg_312_1.iconTrs_.gameObject, false)
				arg_312_1.callingController_:SetSelectedState("normal")

				local var_315_8 = arg_312_1:GetWordFromCfg(324081076)
				local var_315_9 = arg_312_1:FormatText(var_315_8.content)

				arg_312_1.text_.text = var_315_9

				LuaForUtil.ClearLinePrefixSymbol(arg_312_1.text_)

				local var_315_11 = 12 <= 0 and var_315_7 or var_315_7 * (utf8.len(var_315_9) / 12)

				if (12 <= 0 and var_315_7 or var_315_7 * (utf8.len(var_315_9) / 12)) > 0 and var_315_7 < var_315_11 then
					arg_312_1.talkMaxDuration = var_315_11

					if var_315_11 + var_315_6 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_11 + var_315_6
					end
				end

				arg_312_1.text_.text = var_315_9
				arg_312_1.typewritter.percent = 0

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081076", "story_v_out_324081.awb") ~= 0 then
					local var_315_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081076", "story_v_out_324081.awb") / 1000

					if var_315_12 + var_315_6 > arg_312_1.duration_ then
						arg_312_1.duration_ = var_315_12 + var_315_6
					end

					if var_315_8.prefab_name ~= "" and arg_312_1.actors_[var_315_8.prefab_name] ~= nil then
						local var_315_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_312_1.actors_[var_315_8.prefab_name].transform, "story_v_out_324081", "324081076", "story_v_out_324081.awb")

						arg_312_1:RecordAudio("324081076", var_315_13)
						arg_312_1:RecordAudio("324081076", var_315_13)
					else
						arg_312_1:AudioAction("play", "voice", "story_v_out_324081", "324081076", "story_v_out_324081.awb")
					end

					arg_312_1:RecordHistoryTalkVoice("story_v_out_324081", "324081076", "story_v_out_324081.awb")
				end

				arg_312_1:RecordContent(arg_312_1.text_.text)
			end

			local var_315_14 = math.max(var_315_7, arg_312_1.talkMaxDuration)

			if var_315_6 <= arg_312_1.time_ and arg_312_1.time_ < var_315_6 + var_315_14 then
				arg_312_1.typewritter.percent = (arg_312_1.time_ - var_315_6) / var_315_14

				arg_312_1.typewritter:SetDirty()
			end

			if arg_312_1.time_ >= var_315_6 + var_315_14 and arg_312_1.time_ < var_315_6 + var_315_14 + arg_315_0 then
				arg_312_1.typewritter.percent = 1

				arg_312_1.typewritter:SetDirty()
				arg_312_1:ShowNextGo(true)
			end
		end

		arg_312_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_312_1:InitPlayNodeList()
	end,
	Play324081077 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 324081077
		arg_316_1.duration_ = 7.27

		local var_316_0 = {
			zh = 5.366,
			ja = 7.266
		}
		local var_316_1 = manager.audio:GetLocalizationFlag()

		if var_316_0[var_316_1] ~= nil then
			arg_316_1.duration_ = var_316_0[var_316_1]
		end

		SetActive(arg_316_1.tipsGo_, false)

		function arg_316_1.onSingleLineFinish_()
			arg_316_1.onSingleLineUpdate_ = nil
			arg_316_1.onSingleLineFinish_ = nil
			arg_316_1.state_ = "waiting"
		end

		function arg_316_1.playNext_(arg_318_0)
			if arg_318_0 == 1 then
				arg_316_0:Play324081078(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 and not isNil(arg_316_1.actors_["10171ui_story"]) and arg_316_1.var_.characterEffect10171ui_story == nil then
				arg_316_1.var_.characterEffect10171ui_story = arg_316_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_319_0 = 0.200000002980232

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_0 and not isNil(arg_316_1.actors_["10171ui_story"]) then
				if arg_316_1.var_.characterEffect10171ui_story and not isNil(arg_316_1.actors_["10171ui_story"]) then
					arg_316_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_316_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_316_1.time_ - 0) / var_319_0)
				end
			end

			if arg_316_1.time_ >= 0 + var_319_0 and arg_316_1.time_ < 0 + var_319_0 + arg_319_0 and not isNil(arg_316_1.actors_["10171ui_story"]) and arg_316_1.var_.characterEffect10171ui_story then
				arg_316_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_316_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_319_1 = 0
			local var_319_2 = 0.525

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= var_319_1 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[1448].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10168")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_3 = arg_316_1:GetWordFromCfg(324081077)
				local var_319_4 = arg_316_1:FormatText(var_319_3.content)

				arg_316_1.text_.text = var_319_4

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_6 = 21 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_4) / 21)

				if (21 <= 0 and var_319_2 or var_319_2 * (utf8.len(var_319_4) / 21)) > 0 and var_319_2 < var_319_6 then
					arg_316_1.talkMaxDuration = var_319_6

					if var_319_6 + var_319_1 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_6 + var_319_1
					end
				end

				arg_316_1.text_.text = var_319_4
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081077", "story_v_out_324081.awb") ~= 0 then
					local var_319_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081077", "story_v_out_324081.awb") / 1000

					if var_319_7 + var_319_1 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_7 + var_319_1
					end

					if var_319_3.prefab_name ~= "" and arg_316_1.actors_[var_319_3.prefab_name] ~= nil then
						local var_319_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_3.prefab_name].transform, "story_v_out_324081", "324081077", "story_v_out_324081.awb")

						arg_316_1:RecordAudio("324081077", var_319_8)
						arg_316_1:RecordAudio("324081077", var_319_8)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_324081", "324081077", "story_v_out_324081.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_324081", "324081077", "story_v_out_324081.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_9 = math.max(var_319_2, arg_316_1.talkMaxDuration)

			if var_319_1 <= arg_316_1.time_ and arg_316_1.time_ < var_319_1 + var_319_9 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - var_319_1) / var_319_9

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= var_319_1 + var_319_9 and arg_316_1.time_ < var_319_1 + var_319_9 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play324081078 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 324081078
		arg_320_1.duration_ = 5

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play324081079(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				arg_320_1.var_.moveOldPos10171ui_story = arg_320_1.actors_["10171ui_story"].transform.localPosition

				local var_323_0 = GameObjectTools.GetOrAddComponent(arg_320_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_323_0 then
					var_323_0:EnableDynamicBone(false)
				end
			end

			local var_323_1 = 0.001

			if 0 <= arg_320_1.time_ and arg_320_1.time_ < 0 + var_323_1 then
				arg_320_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_320_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_320_1.time_ - 0) / var_323_1)
				arg_320_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["10171ui_story"].transform.position).z)
				arg_320_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["10171ui_story"].transform.localEulerAngles = arg_320_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_320_1.time_ >= 0 + var_323_1 and arg_320_1.time_ < 0 + var_323_1 + arg_323_0 then
				arg_320_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_320_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_320_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_320_1.actors_["10171ui_story"].transform.position).z)
				arg_320_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_320_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_320_1.actors_["10171ui_story"].transform.localEulerAngles = arg_320_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_323_2 = GameObjectTools.GetOrAddComponent(arg_320_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_323_2 then
					var_323_2:EnableDynamicBone(true)
				end
			end

			local var_323_3 = 0
			local var_323_4 = 0.85

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_3 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, false)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_320_1.iconTrs_.gameObject, false)
				arg_320_1.callingController_:SetSelectedState("normal")

				local var_323_5 = arg_320_1:FormatText(arg_320_1:GetWordFromCfg(324081078).content)

				arg_320_1.text_.text = var_323_5

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_7 = 34 <= 0 and var_323_4 or var_323_4 * (utf8.len(var_323_5) / 34)

				if (34 <= 0 and var_323_4 or var_323_4 * (utf8.len(var_323_5) / 34)) > 0 and var_323_4 < var_323_7 then
					arg_320_1.talkMaxDuration = var_323_7

					if var_323_7 + var_323_3 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_3
					end
				end

				arg_320_1.text_.text = var_323_5
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)
				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_8 = math.max(var_323_4, arg_320_1.talkMaxDuration)

			if var_323_3 <= arg_320_1.time_ and arg_320_1.time_ < var_323_3 + var_323_8 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_3) / var_323_8

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_3 + var_323_8 and arg_320_1.time_ < var_323_3 + var_323_8 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_320_1:InitPlayNodeList()
	end,
	Play324081079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 324081079
		arg_324_1.duration_ = 2

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play324081080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 and not isNil(arg_324_1.actors_["10171ui_story"]) and arg_324_1.var_.characterEffect10171ui_story == nil then
				arg_324_1.var_.characterEffect10171ui_story = arg_324_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_0 = 0.200000002980232

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_0 and not isNil(arg_324_1.actors_["10171ui_story"]) then
				if arg_324_1.var_.characterEffect10171ui_story and not isNil(arg_324_1.actors_["10171ui_story"]) then
					arg_324_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_324_1.time_ >= 0 + var_327_0 and arg_324_1.time_ < 0 + var_327_0 + arg_327_0 and not isNil(arg_324_1.actors_["10171ui_story"]) and arg_324_1.var_.characterEffect10171ui_story then
				arg_324_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_327_2 = arg_324_1.actors_["10171ui_story"].transform

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.var_.moveOldPos10171ui_story = var_327_2.localPosition

				local var_327_3 = GameObjectTools.GetOrAddComponent(var_327_2.gameObject, typeof(DynamicBoneHelper))

				if var_327_3 then
					var_327_3:EnableDynamicBone(false)
				end
			end

			local var_327_4 = 0.001

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				var_327_2.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_324_1.time_ - 0) / var_327_4)
				var_327_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_2.position).x, (manager.ui.mainCamera.transform.position - var_327_2.position).y, (manager.ui.mainCamera.transform.position - var_327_2.position).z)
				var_327_2.localEulerAngles.z = 0
				var_327_2.localEulerAngles.x = 0
				var_327_2.localEulerAngles = var_327_2.localEulerAngles
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				var_327_2.localPosition = Vector3.New(0, -0.95, -6.05)
				var_327_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_2.position).x, (manager.ui.mainCamera.transform.position - var_327_2.position).y, (manager.ui.mainCamera.transform.position - var_327_2.position).z)
				var_327_2.localEulerAngles.z = 0
				var_327_2.localEulerAngles.x = 0
				var_327_2.localEulerAngles = var_327_2.localEulerAngles

				local var_327_5 = GameObjectTools.GetOrAddComponent(var_327_2.gameObject, typeof(DynamicBoneHelper))

				if var_327_5 then
					var_327_5:EnableDynamicBone(true)
				end
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action34_2")
			end

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_327_6 = 0
			local var_327_7 = 0.25

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_6 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, true)

				arg_324_1.leftNameTxt_.text = arg_324_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_324_1.leftNameTxt_.transform)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1.leftNameTxt_.text)
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_8 = arg_324_1:GetWordFromCfg(324081079)
				local var_327_9 = arg_324_1:FormatText(var_327_8.content)

				arg_324_1.text_.text = var_327_9

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_11 = 10 <= 0 and var_327_7 or var_327_7 * (utf8.len(var_327_9) / 10)

				if (10 <= 0 and var_327_7 or var_327_7 * (utf8.len(var_327_9) / 10)) > 0 and var_327_7 < var_327_11 then
					arg_324_1.talkMaxDuration = var_327_11

					if var_327_11 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_11 + var_327_6
					end
				end

				arg_324_1.text_.text = var_327_9
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081079", "story_v_out_324081.awb") ~= 0 then
					local var_327_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081079", "story_v_out_324081.awb") / 1000

					if var_327_12 + var_327_6 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_12 + var_327_6
					end

					if var_327_8.prefab_name ~= "" and arg_324_1.actors_[var_327_8.prefab_name] ~= nil then
						local var_327_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_324_1.actors_[var_327_8.prefab_name].transform, "story_v_out_324081", "324081079", "story_v_out_324081.awb")

						arg_324_1:RecordAudio("324081079", var_327_13)
						arg_324_1:RecordAudio("324081079", var_327_13)
					else
						arg_324_1:AudioAction("play", "voice", "story_v_out_324081", "324081079", "story_v_out_324081.awb")
					end

					arg_324_1:RecordHistoryTalkVoice("story_v_out_324081", "324081079", "story_v_out_324081.awb")
				end

				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_14 = math.max(var_327_7, arg_324_1.talkMaxDuration)

			if var_327_6 <= arg_324_1.time_ and arg_324_1.time_ < var_327_6 + var_327_14 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_6) / var_327_14

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_6 + var_327_14 and arg_324_1.time_ < var_327_6 + var_327_14 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play324081080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 324081080
		arg_328_1.duration_ = 5.58

		local var_328_0 = {
			zh = 5.37859469829127,
			ja = 5.57859469829127
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play324081081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 1.8 < arg_328_1.time_ and arg_328_1.time_ <= 1.8 + arg_331_0 then
				local var_331_0 = arg_328_1.bgs_.J22f

				arg_328_1.bgs_.J22f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_331_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_331_1 = var_331_0:GetComponent("SpriteRenderer")

				if var_331_1 and var_331_1.sprite then
					local var_331_2 = 2 * (var_331_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_331_0.transform.localScale = Vector3.New(var_331_2 / var_331_1.sprite.bounds.size.y < var_331_2 * manager.ui.mainCameraCom_.aspect / var_331_1.sprite.bounds.size.x and var_331_2 * manager.ui.mainCameraCom_.aspect / var_331_1.sprite.bounds.size.x or var_331_2 / var_331_1.sprite.bounds.size.y, var_331_2 / var_331_1.sprite.bounds.size.y < var_331_2 * manager.ui.mainCameraCom_.aspect / var_331_1.sprite.bounds.size.x and var_331_2 * manager.ui.mainCameraCom_.aspect / var_331_1.sprite.bounds.size.x or var_331_2 / var_331_1.sprite.bounds.size.y, 0)
				end

				for iter_331_0, iter_331_1 in pairs(arg_328_1.bgs_) do
					if iter_331_0 ~= "J22f" then
						iter_331_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_331_3 = 1.8

			if 1.8 < arg_328_1.time_ and arg_328_1.time_ <= var_331_3 + arg_331_0 then
				arg_328_1.allBtn_.enabled = false
			end

			if arg_328_1.time_ >= var_331_3 + 0.3 and arg_328_1.time_ < var_331_3 + 0.3 + arg_331_0 then
				arg_328_1.allBtn_.enabled = true
			end

			local var_331_4 = 0

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1.mask_.enabled = true
				arg_328_1.mask_.raycastTarget = true

				arg_328_1:SetGaussion(false)
			end

			local var_331_5 = 1.8

			if var_331_4 <= arg_328_1.time_ and arg_328_1.time_ < var_331_4 + var_331_5 then
				local var_331_6 = Color.New(0, 0, 0)

				var_331_6.a = Mathf.Lerp(0, 1, (arg_328_1.time_ - var_331_4) / var_331_5)
				arg_328_1.mask_.color = var_331_6
			end

			if arg_328_1.time_ >= var_331_4 + var_331_5 and arg_328_1.time_ < var_331_4 + var_331_5 + arg_331_0 then
				local var_331_7 = Color.New(0, 0, 0)

				var_331_7.a = 1
				arg_328_1.mask_.color = var_331_7
			end

			local var_331_8 = 1.8

			if 1.8 < arg_328_1.time_ and arg_328_1.time_ <= var_331_8 + arg_331_0 then
				arg_328_1.mask_.enabled = true
				arg_328_1.mask_.raycastTarget = true

				arg_328_1:SetGaussion(false)
			end

			local var_331_9 = 2

			if var_331_8 <= arg_328_1.time_ and arg_328_1.time_ < var_331_8 + var_331_9 then
				local var_331_10 = Color.New(0, 0, 0)

				var_331_10.a = Mathf.Lerp(1, 0, (arg_328_1.time_ - var_331_8) / var_331_9)
				arg_328_1.mask_.color = var_331_10
			end

			if arg_328_1.time_ >= var_331_8 + var_331_9 and arg_328_1.time_ < var_331_8 + var_331_9 + arg_331_0 then
				local var_331_11 = Color.New(0, 0, 0)

				arg_328_1.mask_.enabled = false
				var_331_11.a = 0
				arg_328_1.mask_.color = var_331_11
			end

			local var_331_12 = arg_328_1.actors_["1070ui_story"]

			if 1.8 < arg_328_1.time_ and arg_328_1.time_ <= 1.8 + arg_331_0 and not isNil(var_331_12) and arg_328_1.var_.characterEffect1070ui_story == nil then
				arg_328_1.var_.characterEffect1070ui_story = var_331_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_13 = 0.200000002980232

			if 1.8 <= arg_328_1.time_ and arg_328_1.time_ < 1.8 + var_331_13 and not isNil(var_331_12) then
				if arg_328_1.var_.characterEffect1070ui_story and not isNil(var_331_12) then
					arg_328_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_328_1.time_ >= 1.8 + var_331_13 and arg_328_1.time_ < 1.8 + var_331_13 + arg_331_0 and not isNil(var_331_12) and arg_328_1.var_.characterEffect1070ui_story then
				arg_328_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_331_15 = arg_328_1.actors_["10171ui_story"]

			if 1.8 < arg_328_1.time_ and arg_328_1.time_ <= 1.8 + arg_331_0 and not isNil(var_331_15) and arg_328_1.var_.characterEffect10171ui_story == nil then
				arg_328_1.var_.characterEffect10171ui_story = var_331_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_331_16 = 0.200000002980232

			if 1.8 <= arg_328_1.time_ and arg_328_1.time_ < 1.8 + var_331_16 and not isNil(var_331_15) then
				if arg_328_1.var_.characterEffect10171ui_story and not isNil(var_331_15) then
					arg_328_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_328_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_328_1.time_ - 1.8) / var_331_16)
				end
			end

			if arg_328_1.time_ >= 1.8 + var_331_16 and arg_328_1.time_ < 1.8 + var_331_16 + arg_331_0 and not isNil(var_331_15) and arg_328_1.var_.characterEffect10171ui_story then
				arg_328_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_328_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_331_17 = arg_328_1.actors_["10171ui_story"].transform

			if 1.8 < arg_328_1.time_ and arg_328_1.time_ <= 1.8 + arg_331_0 then
				arg_328_1.var_.moveOldPos10171ui_story = var_331_17.localPosition

				local var_331_18 = GameObjectTools.GetOrAddComponent(var_331_17.gameObject, typeof(DynamicBoneHelper))

				if var_331_18 then
					var_331_18:EnableDynamicBone(false)
				end
			end

			local var_331_19 = 0.001

			if 1.8 <= arg_328_1.time_ and arg_328_1.time_ < 1.8 + var_331_19 then
				var_331_17.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_328_1.time_ - 1.8) / var_331_19)
				var_331_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_331_17.position).x, (manager.ui.mainCamera.transform.position - var_331_17.position).y, (manager.ui.mainCamera.transform.position - var_331_17.position).z)
				var_331_17.localEulerAngles.z = 0
				var_331_17.localEulerAngles.x = 0
				var_331_17.localEulerAngles = var_331_17.localEulerAngles
			end

			if arg_328_1.time_ >= 1.8 + var_331_19 and arg_328_1.time_ < 1.8 + var_331_19 + arg_331_0 then
				var_331_17.localPosition = Vector3.New(0, 100, 0)
				var_331_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_331_17.position).x, (manager.ui.mainCamera.transform.position - var_331_17.position).y, (manager.ui.mainCamera.transform.position - var_331_17.position).z)
				var_331_17.localEulerAngles.z = 0
				var_331_17.localEulerAngles.x = 0
				var_331_17.localEulerAngles = var_331_17.localEulerAngles

				local var_331_20 = GameObjectTools.GetOrAddComponent(var_331_17.gameObject, typeof(DynamicBoneHelper))

				if var_331_20 then
					var_331_20:EnableDynamicBone(true)
				end
			end

			if 1.2 < arg_328_1.time_ and arg_328_1.time_ <= 1.2 + arg_331_0 then
				arg_328_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_lost_city", "")
			end

			if 0.1 < arg_328_1.time_ and arg_328_1.time_ <= 0.1 + arg_331_0 then
				arg_328_1:AudioAction("stop", "effect", "se_story_145", "se_story_145_amb_construction", "")
			end

			if arg_328_1.frameCnt_ <= 1 then
				arg_328_1.dialog_:SetActive(false)
			end

			local var_331_23 = 3.57859469829127
			local var_331_24 = 0.2

			if 3.57859469829127 < arg_328_1.time_ and arg_328_1.time_ <= var_331_23 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0

				arg_328_1.dialog_:SetActive(true)

				arg_328_1.dialogCg_.alpha = 0

				local var_331_25 = LeanTween.value(arg_328_1.dialog_, 0, 1, 0.3)

				var_331_25:setOnUpdate(LuaHelper.FloatAction(function(arg_332_0)
					arg_328_1.dialogCg_.alpha = arg_332_0
				end))
				var_331_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_328_1.dialog_)
					var_331_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_328_1.duration_ = arg_328_1.duration_ + 0.3

				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, true)
				arg_328_1.iconController_:SetSelectedState("hero")

				arg_328_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_328_1.callingController_:SetSelectedState("normal")

				arg_328_1.keyicon_.color = Color.New(1, 1, 1)
				arg_328_1.icon_.color = Color.New(1, 1, 1)

				local var_331_26 = arg_328_1:GetWordFromCfg(324081080)
				local var_331_27 = arg_328_1:FormatText(var_331_26.content)

				arg_328_1.text_.text = var_331_27

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_29 = 8 <= 0 and var_331_24 or var_331_24 * (utf8.len(var_331_27) / 8)

				if (8 <= 0 and var_331_24 or var_331_24 * (utf8.len(var_331_27) / 8)) > 0 and var_331_24 < var_331_29 then
					arg_328_1.talkMaxDuration = var_331_29
					var_331_23 = var_331_23 + 0.3

					if var_331_29 + var_331_23 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_29 + var_331_23
					end
				end

				arg_328_1.text_.text = var_331_27
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081080", "story_v_out_324081.awb") ~= 0 then
					local var_331_30 = manager.audio:GetVoiceLength("story_v_out_324081", "324081080", "story_v_out_324081.awb") / 1000

					if var_331_30 + var_331_23 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_30 + var_331_23
					end

					if var_331_26.prefab_name ~= "" and arg_328_1.actors_[var_331_26.prefab_name] ~= nil then
						local var_331_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_26.prefab_name].transform, "story_v_out_324081", "324081080", "story_v_out_324081.awb")

						arg_328_1:RecordAudio("324081080", var_331_31)
						arg_328_1:RecordAudio("324081080", var_331_31)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_324081", "324081080", "story_v_out_324081.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_324081", "324081080", "story_v_out_324081.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_32 = var_331_23 + 0.3
			local var_331_33 = math.max(var_331_24, arg_328_1.talkMaxDuration)

			if var_331_23 + 0.3 <= arg_328_1.time_ and arg_328_1.time_ < var_331_32 + var_331_33 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_32) / var_331_33

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_32 + var_331_33 and arg_328_1.time_ < var_331_32 + var_331_33 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play324081081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 324081081
		arg_334_1.duration_ = 5

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play324081082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos10171ui_story = arg_334_1.actors_["10171ui_story"].transform.localPosition

				local var_337_0 = GameObjectTools.GetOrAddComponent(arg_334_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_337_0 then
					var_337_0:EnableDynamicBone(false)
				end
			end

			local var_337_1 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_1 then
				arg_334_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_334_1.time_ - 0) / var_337_1)
				arg_334_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10171ui_story"].transform.position).z)
				arg_334_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["10171ui_story"].transform.localEulerAngles = arg_334_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_1 and arg_334_1.time_ < 0 + var_337_1 + arg_337_0 then
				arg_334_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10171ui_story"].transform.position).z)
				arg_334_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["10171ui_story"].transform.localEulerAngles = arg_334_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_337_2 = GameObjectTools.GetOrAddComponent(arg_334_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_337_2 then
					var_337_2:EnableDynamicBone(true)
				end
			end

			local var_337_3 = arg_334_1.actors_["1070ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_3) and arg_334_1.var_.characterEffect1070ui_story == nil then
				arg_334_1.var_.characterEffect1070ui_story = var_337_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_4 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_4 and not isNil(var_337_3) then
				if arg_334_1.var_.characterEffect1070ui_story and not isNil(var_337_3) then
					arg_334_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_334_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_4)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_4 and arg_334_1.time_ < 0 + var_337_4 + arg_337_0 and not isNil(var_337_3) and arg_334_1.var_.characterEffect1070ui_story then
				arg_334_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_334_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_337_5 = 0
			local var_337_6 = 1.025

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, false)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_7 = arg_334_1:FormatText(arg_334_1:GetWordFromCfg(324081081).content)

				arg_334_1.text_.text = var_337_7

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_9 = 41 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_7) / 41)

				if (41 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_7) / 41)) > 0 and var_337_6 < var_337_9 then
					arg_334_1.talkMaxDuration = var_337_9

					if var_337_9 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_9 + var_337_5
					end
				end

				arg_334_1.text_.text = var_337_7
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)
				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_10 = math.max(var_337_6, arg_334_1.talkMaxDuration)

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_10 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_5) / var_337_10

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_5 + var_337_10 and arg_334_1.time_ < var_337_5 + var_337_10 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play324081082 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 324081082
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play324081083(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0.6 < arg_338_1.time_ and arg_338_1.time_ <= 0.6 + arg_341_0 then
				arg_338_1:AudioAction("play", "effect", "se_story_150", "se_story_150_branch", "")
			end

			local var_341_1 = 0
			local var_341_2 = 1

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_1 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_3 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(324081082).content)

				arg_338_1.text_.text = var_341_3

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_5 = 40 <= 0 and var_341_2 or var_341_2 * (utf8.len(var_341_3) / 40)

				if (40 <= 0 and var_341_2 or var_341_2 * (utf8.len(var_341_3) / 40)) > 0 and var_341_2 < var_341_5 then
					arg_338_1.talkMaxDuration = var_341_5

					if var_341_5 + var_341_1 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_5 + var_341_1
					end
				end

				arg_338_1.text_.text = var_341_3
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_6 = math.max(var_341_2, arg_338_1.talkMaxDuration)

			if var_341_1 <= arg_338_1.time_ and arg_338_1.time_ < var_341_1 + var_341_6 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_1) / var_341_6

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_1 + var_341_6 and arg_338_1.time_ < var_341_1 + var_341_6 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {}

		arg_338_1:InitPlayNodeList()
	end,
	Play324081083 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 324081083
		arg_342_1.duration_ = 3.9

		local var_342_0 = {
			zh = 3.9,
			ja = 2.1
		}
		local var_342_1 = manager.audio:GetLocalizationFlag()

		if var_342_0[var_342_1] ~= nil then
			arg_342_1.duration_ = var_342_0[var_342_1]
		end

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play324081084(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.var_.moveOldPos10171ui_story = arg_342_1.actors_["10171ui_story"].transform.localPosition

				local var_345_0 = GameObjectTools.GetOrAddComponent(arg_342_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_345_0 then
					var_345_0:EnableDynamicBone(false)
				end
			end

			local var_345_1 = 0.001

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_1 then
				arg_342_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_342_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_342_1.time_ - 0) / var_345_1)
				arg_342_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["10171ui_story"].transform.position).z)
				arg_342_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["10171ui_story"].transform.localEulerAngles = arg_342_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_342_1.time_ >= 0 + var_345_1 and arg_342_1.time_ < 0 + var_345_1 + arg_345_0 then
				arg_342_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_342_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_342_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_342_1.actors_["10171ui_story"].transform.position).z)
				arg_342_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_342_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_342_1.actors_["10171ui_story"].transform.localEulerAngles = arg_342_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_345_2 = GameObjectTools.GetOrAddComponent(arg_342_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_345_2 then
					var_345_2:EnableDynamicBone(true)
				end
			end

			local var_345_3 = arg_342_1.actors_["10171ui_story"]

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 and not isNil(var_345_3) and arg_342_1.var_.characterEffect10171ui_story == nil then
				arg_342_1.var_.characterEffect10171ui_story = var_345_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_345_4 = 0.200000002980232

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 and not isNil(var_345_3) then
				if arg_342_1.var_.characterEffect10171ui_story and not isNil(var_345_3) then
					arg_342_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 and not isNil(var_345_3) and arg_342_1.var_.characterEffect10171ui_story then
				arg_342_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action33_1")
			end

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_gandong", "EmotionTimelineAnimator")
			end

			local var_345_6 = 0

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_6 + arg_345_0 then
				arg_342_1.allBtn_.enabled = false
			end

			if arg_342_1.time_ >= var_345_6 + 1.6 and arg_342_1.time_ < var_345_6 + 1.6 + arg_345_0 then
				arg_342_1.allBtn_.enabled = true
			end

			local var_345_7 = 0
			local var_345_8 = 0.2

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= var_345_7 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, false)
				arg_342_1.callingController_:SetSelectedState("normal")

				local var_345_9 = arg_342_1:GetWordFromCfg(324081083)
				local var_345_10 = arg_342_1:FormatText(var_345_9.content)

				arg_342_1.text_.text = var_345_10

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_12 = 8 <= 0 and var_345_8 or var_345_8 * (utf8.len(var_345_10) / 8)

				if (8 <= 0 and var_345_8 or var_345_8 * (utf8.len(var_345_10) / 8)) > 0 and var_345_8 < var_345_12 then
					arg_342_1.talkMaxDuration = var_345_12

					if var_345_12 + var_345_7 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_12 + var_345_7
					end
				end

				arg_342_1.text_.text = var_345_10
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081083", "story_v_out_324081.awb") ~= 0 then
					local var_345_13 = manager.audio:GetVoiceLength("story_v_out_324081", "324081083", "story_v_out_324081.awb") / 1000

					if var_345_13 + var_345_7 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_13 + var_345_7
					end

					if var_345_9.prefab_name ~= "" and arg_342_1.actors_[var_345_9.prefab_name] ~= nil then
						local var_345_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_342_1.actors_[var_345_9.prefab_name].transform, "story_v_out_324081", "324081083", "story_v_out_324081.awb")

						arg_342_1:RecordAudio("324081083", var_345_14)
						arg_342_1:RecordAudio("324081083", var_345_14)
					else
						arg_342_1:AudioAction("play", "voice", "story_v_out_324081", "324081083", "story_v_out_324081.awb")
					end

					arg_342_1:RecordHistoryTalkVoice("story_v_out_324081", "324081083", "story_v_out_324081.awb")
				end

				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_15 = math.max(var_345_8, arg_342_1.talkMaxDuration)

			if var_345_7 <= arg_342_1.time_ and arg_342_1.time_ < var_345_7 + var_345_15 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - var_345_7) / var_345_15

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= var_345_7 + var_345_15 and arg_342_1.time_ < var_345_7 + var_345_15 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_342_1:InitPlayNodeList()
	end,
	Play324081084 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 324081084
		arg_346_1.duration_ = 6.33

		local var_346_0 = {
			zh = 4.566,
			ja = 6.333
		}
		local var_346_1 = manager.audio:GetLocalizationFlag()

		if var_346_0[var_346_1] ~= nil then
			arg_346_1.duration_ = var_346_0[var_346_1]
		end

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play324081085(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1.var_.moveOldPos1070ui_story = arg_346_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_349_0 = 0.001

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_0 then
				arg_346_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_346_1.time_ - 0) / var_349_0)
				arg_346_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1070ui_story"].transform.position).z)
				arg_346_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["1070ui_story"].transform.localEulerAngles = arg_346_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_346_1.time_ >= 0 + var_349_0 and arg_346_1.time_ < 0 + var_349_0 + arg_349_0 then
				arg_346_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_346_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_346_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_346_1.actors_["1070ui_story"].transform.position).z)
				arg_346_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_346_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_346_1.actors_["1070ui_story"].transform.localEulerAngles = arg_346_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_349_1 = arg_346_1.actors_["1070ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect1070ui_story == nil then
				arg_346_1.var_.characterEffect1070ui_story = var_349_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_2 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_2 and not isNil(var_349_1) then
				if arg_346_1.var_.characterEffect1070ui_story and not isNil(var_349_1) then
					arg_346_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_346_1.time_ >= 0 + var_349_2 and arg_346_1.time_ < 0 + var_349_2 + arg_349_0 and not isNil(var_349_1) and arg_346_1.var_.characterEffect1070ui_story then
				arg_346_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_349_4 = arg_346_1.actors_["10171ui_story"]

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 and not isNil(var_349_4) and arg_346_1.var_.characterEffect10171ui_story == nil then
				arg_346_1.var_.characterEffect10171ui_story = var_349_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_349_5 = 0.200000002980232

			if 0 <= arg_346_1.time_ and arg_346_1.time_ < 0 + var_349_5 and not isNil(var_349_4) then
				if arg_346_1.var_.characterEffect10171ui_story and not isNil(var_349_4) then
					arg_346_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_346_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_346_1.time_ - 0) / var_349_5)
				end
			end

			if arg_346_1.time_ >= 0 + var_349_5 and arg_346_1.time_ < 0 + var_349_5 + arg_349_0 and not isNil(var_349_4) and arg_346_1.var_.characterEffect10171ui_story then
				arg_346_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_346_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= 0 + arg_349_0 then
				arg_346_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_349_6 = 0
			local var_349_7 = 0.45

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_6 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0
				arg_346_1.dialogCg_.alpha = 1

				arg_346_1.dialog_:SetActive(true)
				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_8 = arg_346_1:GetWordFromCfg(324081084)
				local var_349_9 = arg_346_1:FormatText(var_349_8.content)

				arg_346_1.text_.text = var_349_9

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_11 = 18 <= 0 and var_349_7 or var_349_7 * (utf8.len(var_349_9) / 18)

				if (18 <= 0 and var_349_7 or var_349_7 * (utf8.len(var_349_9) / 18)) > 0 and var_349_7 < var_349_11 then
					arg_346_1.talkMaxDuration = var_349_11

					if var_349_11 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_11 + var_349_6
					end
				end

				arg_346_1.text_.text = var_349_9
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081084", "story_v_out_324081.awb") ~= 0 then
					local var_349_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081084", "story_v_out_324081.awb") / 1000

					if var_349_12 + var_349_6 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_12 + var_349_6
					end

					if var_349_8.prefab_name ~= "" and arg_346_1.actors_[var_349_8.prefab_name] ~= nil then
						local var_349_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_8.prefab_name].transform, "story_v_out_324081", "324081084", "story_v_out_324081.awb")

						arg_346_1:RecordAudio("324081084", var_349_13)
						arg_346_1:RecordAudio("324081084", var_349_13)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_324081", "324081084", "story_v_out_324081.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_324081", "324081084", "story_v_out_324081.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_14 = math.max(var_349_7, arg_346_1.talkMaxDuration)

			if var_349_6 <= arg_346_1.time_ and arg_346_1.time_ < var_349_6 + var_349_14 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_6) / var_349_14

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_6 + var_349_14 and arg_346_1.time_ < var_349_6 + var_349_14 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play324081085 = function(arg_350_0, arg_350_1)
		arg_350_1.time_ = 0
		arg_350_1.frameCnt_ = 0
		arg_350_1.state_ = "playing"
		arg_350_1.curTalkId_ = 324081085
		arg_350_1.duration_ = 6.77

		local var_350_0 = {
			zh = 6.766,
			ja = 5.766
		}
		local var_350_1 = manager.audio:GetLocalizationFlag()

		if var_350_0[var_350_1] ~= nil then
			arg_350_1.duration_ = var_350_0[var_350_1]
		end

		SetActive(arg_350_1.tipsGo_, false)

		function arg_350_1.onSingleLineFinish_()
			arg_350_1.onSingleLineUpdate_ = nil
			arg_350_1.onSingleLineFinish_ = nil
			arg_350_1.state_ = "waiting"
		end

		function arg_350_1.playNext_(arg_352_0)
			if arg_352_0 == 1 then
				arg_350_0:Play324081086(arg_350_1)
			end
		end

		function arg_350_1.onSingleLineUpdate_(arg_353_0)
			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(arg_350_1.actors_["10171ui_story"]) and arg_350_1.var_.characterEffect10171ui_story == nil then
				arg_350_1.var_.characterEffect10171ui_story = arg_350_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_0 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_0 and not isNil(arg_350_1.actors_["10171ui_story"]) then
				if arg_350_1.var_.characterEffect10171ui_story and not isNil(arg_350_1.actors_["10171ui_story"]) then
					arg_350_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_350_1.time_ >= 0 + var_353_0 and arg_350_1.time_ < 0 + var_353_0 + arg_353_0 and not isNil(arg_350_1.actors_["10171ui_story"]) and arg_350_1.var_.characterEffect10171ui_story then
				arg_350_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_353_2 = arg_350_1.actors_["1070ui_story"]

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= 0 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.characterEffect1070ui_story == nil then
				arg_350_1.var_.characterEffect1070ui_story = var_353_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_353_3 = 0.200000002980232

			if 0 <= arg_350_1.time_ and arg_350_1.time_ < 0 + var_353_3 and not isNil(var_353_2) then
				if arg_350_1.var_.characterEffect1070ui_story and not isNil(var_353_2) then
					arg_350_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_350_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_350_1.time_ - 0) / var_353_3)
				end
			end

			if arg_350_1.time_ >= 0 + var_353_3 and arg_350_1.time_ < 0 + var_353_3 + arg_353_0 and not isNil(var_353_2) and arg_350_1.var_.characterEffect1070ui_story then
				arg_350_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_350_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_353_4 = 0
			local var_353_5 = 0.725

			if 0 < arg_350_1.time_ and arg_350_1.time_ <= var_353_4 + arg_353_0 then
				arg_350_1.talkMaxDuration = 0
				arg_350_1.dialogCg_.alpha = 1

				arg_350_1.dialog_:SetActive(true)
				SetActive(arg_350_1.leftNameGo_, true)

				arg_350_1.leftNameTxt_.text = arg_350_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_350_1.leftNameTxt_.transform)

				arg_350_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_350_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_350_1:RecordName(arg_350_1.leftNameTxt_.text)
				SetActive(arg_350_1.iconTrs_.gameObject, false)
				arg_350_1.callingController_:SetSelectedState("normal")

				local var_353_6 = arg_350_1:GetWordFromCfg(324081085)
				local var_353_7 = arg_350_1:FormatText(var_353_6.content)

				arg_350_1.text_.text = var_353_7

				LuaForUtil.ClearLinePrefixSymbol(arg_350_1.text_)

				local var_353_9 = 29 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_7) / 29)

				if (29 <= 0 and var_353_5 or var_353_5 * (utf8.len(var_353_7) / 29)) > 0 and var_353_5 < var_353_9 then
					arg_350_1.talkMaxDuration = var_353_9

					if var_353_9 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_9 + var_353_4
					end
				end

				arg_350_1.text_.text = var_353_7
				arg_350_1.typewritter.percent = 0

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081085", "story_v_out_324081.awb") ~= 0 then
					local var_353_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081085", "story_v_out_324081.awb") / 1000

					if var_353_10 + var_353_4 > arg_350_1.duration_ then
						arg_350_1.duration_ = var_353_10 + var_353_4
					end

					if var_353_6.prefab_name ~= "" and arg_350_1.actors_[var_353_6.prefab_name] ~= nil then
						local var_353_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_350_1.actors_[var_353_6.prefab_name].transform, "story_v_out_324081", "324081085", "story_v_out_324081.awb")

						arg_350_1:RecordAudio("324081085", var_353_11)
						arg_350_1:RecordAudio("324081085", var_353_11)
					else
						arg_350_1:AudioAction("play", "voice", "story_v_out_324081", "324081085", "story_v_out_324081.awb")
					end

					arg_350_1:RecordHistoryTalkVoice("story_v_out_324081", "324081085", "story_v_out_324081.awb")
				end

				arg_350_1:RecordContent(arg_350_1.text_.text)
			end

			local var_353_12 = math.max(var_353_5, arg_350_1.talkMaxDuration)

			if var_353_4 <= arg_350_1.time_ and arg_350_1.time_ < var_353_4 + var_353_12 then
				arg_350_1.typewritter.percent = (arg_350_1.time_ - var_353_4) / var_353_12

				arg_350_1.typewritter:SetDirty()
			end

			if arg_350_1.time_ >= var_353_4 + var_353_12 and arg_350_1.time_ < var_353_4 + var_353_12 + arg_353_0 then
				arg_350_1.typewritter.percent = 1

				arg_350_1.typewritter:SetDirty()
				arg_350_1:ShowNextGo(true)
			end
		end

		arg_350_1.nodeConfigList_ = {}

		arg_350_1:InitPlayNodeList()
	end,
	Play324081086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 324081086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play324081087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos1070ui_story = arg_354_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_357_0 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_0 then
				arg_354_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_354_1.time_ - 0) / var_357_0)
				arg_354_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1070ui_story"].transform.position).z)
				arg_354_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1070ui_story"].transform.localEulerAngles = arg_354_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_0 and arg_354_1.time_ < 0 + var_357_0 + arg_357_0 then
				arg_354_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_354_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_354_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_354_1.actors_["1070ui_story"].transform.position).z)
				arg_354_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_354_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_354_1.actors_["1070ui_story"].transform.localEulerAngles = arg_354_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_357_1 = arg_354_1.actors_["10171ui_story"].transform

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.var_.moveOldPos10171ui_story = var_357_1.localPosition

				local var_357_2 = GameObjectTools.GetOrAddComponent(var_357_1.gameObject, typeof(DynamicBoneHelper))

				if var_357_2 then
					var_357_2:EnableDynamicBone(false)
				end
			end

			local var_357_3 = 0.001

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_3 then
				var_357_1.localPosition = Vector3.Lerp(arg_354_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_354_1.time_ - 0) / var_357_3)
				var_357_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_1.position).x, (manager.ui.mainCamera.transform.position - var_357_1.position).y, (manager.ui.mainCamera.transform.position - var_357_1.position).z)
				var_357_1.localEulerAngles.z = 0
				var_357_1.localEulerAngles.x = 0
				var_357_1.localEulerAngles = var_357_1.localEulerAngles
			end

			if arg_354_1.time_ >= 0 + var_357_3 and arg_354_1.time_ < 0 + var_357_3 + arg_357_0 then
				var_357_1.localPosition = Vector3.New(0, 100, 0)
				var_357_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_357_1.position).x, (manager.ui.mainCamera.transform.position - var_357_1.position).y, (manager.ui.mainCamera.transform.position - var_357_1.position).z)
				var_357_1.localEulerAngles.z = 0
				var_357_1.localEulerAngles.x = 0
				var_357_1.localEulerAngles = var_357_1.localEulerAngles

				local var_357_4 = GameObjectTools.GetOrAddComponent(var_357_1.gameObject, typeof(DynamicBoneHelper))

				if var_357_4 then
					var_357_4:EnableDynamicBone(true)
				end
			end

			local var_357_5 = arg_354_1.actors_["10171ui_story"]

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 and not isNil(var_357_5) and arg_354_1.var_.characterEffect10171ui_story == nil then
				arg_354_1.var_.characterEffect10171ui_story = var_357_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_357_6 = 0.200000002980232

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_6 and not isNil(var_357_5) then
				if arg_354_1.var_.characterEffect10171ui_story and not isNil(var_357_5) then
					arg_354_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_354_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_354_1.time_ - 0) / var_357_6)
				end
			end

			if arg_354_1.time_ >= 0 + var_357_6 and arg_354_1.time_ < 0 + var_357_6 + arg_357_0 and not isNil(var_357_5) and arg_354_1.var_.characterEffect10171ui_story then
				arg_354_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_354_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_357_7 = 0
			local var_357_8 = 0.75

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= var_357_7 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_9 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(324081086).content)

				arg_354_1.text_.text = var_357_9

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_11 = 30 <= 0 and var_357_8 or var_357_8 * (utf8.len(var_357_9) / 30)

				if (30 <= 0 and var_357_8 or var_357_8 * (utf8.len(var_357_9) / 30)) > 0 and var_357_8 < var_357_11 then
					arg_354_1.talkMaxDuration = var_357_11

					if var_357_11 + var_357_7 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_11 + var_357_7
					end
				end

				arg_354_1.text_.text = var_357_9
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_12 = math.max(var_357_8, arg_354_1.talkMaxDuration)

			if var_357_7 <= arg_354_1.time_ and arg_354_1.time_ < var_357_7 + var_357_12 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - var_357_7) / var_357_12

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= var_357_7 + var_357_12 and arg_354_1.time_ < var_357_7 + var_357_12 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_354_1:InitPlayNodeList()
	end,
	Play324081087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 324081087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play324081088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 1.425

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(324081087).content)

				arg_358_1.text_.text = var_361_1

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_3 = 57 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 57)

				if (57 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 57)) > 0 and var_361_0 < var_361_3 then
					arg_358_1.talkMaxDuration = var_361_3

					if var_361_3 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_3 + 0
					end
				end

				arg_358_1.text_.text = var_361_1
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_4 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_4

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play324081088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 324081088
		arg_362_1.duration_ = 7.23

		local var_362_0 = {
			zh = 4.633,
			ja = 7.233
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play324081089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.var_.moveOldPos1070ui_story = arg_362_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_365_0 = 0.001

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 then
				arg_362_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_362_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_362_1.time_ - 0) / var_365_0)
				arg_362_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1070ui_story"].transform.position).z)
				arg_362_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["1070ui_story"].transform.localEulerAngles = arg_362_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 then
				arg_362_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_362_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_362_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_362_1.actors_["1070ui_story"].transform.position).z)
				arg_362_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_362_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_362_1.actors_["1070ui_story"].transform.localEulerAngles = arg_362_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_365_1 = arg_362_1.actors_["1070ui_story"]

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect1070ui_story == nil then
				arg_362_1.var_.characterEffect1070ui_story = var_365_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_2 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_2 and not isNil(var_365_1) then
				if arg_362_1.var_.characterEffect1070ui_story and not isNil(var_365_1) then
					arg_362_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= 0 + var_365_2 and arg_362_1.time_ < 0 + var_365_2 + arg_365_0 and not isNil(var_365_1) and arg_362_1.var_.characterEffect1070ui_story then
				arg_362_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_365_4 = 0
			local var_365_5 = 0.55

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_4 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_6 = arg_362_1:GetWordFromCfg(324081088)
				local var_365_7 = arg_362_1:FormatText(var_365_6.content)

				arg_362_1.text_.text = var_365_7

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_9 = 22 <= 0 and var_365_5 or var_365_5 * (utf8.len(var_365_7) / 22)

				if (22 <= 0 and var_365_5 or var_365_5 * (utf8.len(var_365_7) / 22)) > 0 and var_365_5 < var_365_9 then
					arg_362_1.talkMaxDuration = var_365_9

					if var_365_9 + var_365_4 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_9 + var_365_4
					end
				end

				arg_362_1.text_.text = var_365_7
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081088", "story_v_out_324081.awb") ~= 0 then
					local var_365_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081088", "story_v_out_324081.awb") / 1000

					if var_365_10 + var_365_4 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_10 + var_365_4
					end

					if var_365_6.prefab_name ~= "" and arg_362_1.actors_[var_365_6.prefab_name] ~= nil then
						local var_365_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_6.prefab_name].transform, "story_v_out_324081", "324081088", "story_v_out_324081.awb")

						arg_362_1:RecordAudio("324081088", var_365_11)
						arg_362_1:RecordAudio("324081088", var_365_11)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_324081", "324081088", "story_v_out_324081.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_324081", "324081088", "story_v_out_324081.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_12 = math.max(var_365_5, arg_362_1.talkMaxDuration)

			if var_365_4 <= arg_362_1.time_ and arg_362_1.time_ < var_365_4 + var_365_12 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_4) / var_365_12

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_4 + var_365_12 and arg_362_1.time_ < var_365_4 + var_365_12 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_362_1:InitPlayNodeList()
	end,
	Play324081089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 324081089
		arg_366_1.duration_ = 4.73

		local var_366_0 = {
			zh = 3.6,
			ja = 4.733
		}
		local var_366_1 = manager.audio:GetLocalizationFlag()

		if var_366_0[var_366_1] ~= nil then
			arg_366_1.duration_ = var_366_0[var_366_1]
		end

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play324081090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.var_.moveOldPos10171ui_story = arg_366_1.actors_["10171ui_story"].transform.localPosition

				local var_369_0 = GameObjectTools.GetOrAddComponent(arg_366_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_369_0 then
					var_369_0:EnableDynamicBone(false)
				end
			end

			local var_369_1 = 0.001

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_1 then
				arg_366_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_366_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_366_1.time_ - 0) / var_369_1)
				arg_366_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10171ui_story"].transform.position).z)
				arg_366_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["10171ui_story"].transform.localEulerAngles = arg_366_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_366_1.time_ >= 0 + var_369_1 and arg_366_1.time_ < 0 + var_369_1 + arg_369_0 then
				arg_366_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_366_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_366_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_366_1.actors_["10171ui_story"].transform.position).z)
				arg_366_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_366_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_366_1.actors_["10171ui_story"].transform.localEulerAngles = arg_366_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_369_2 = GameObjectTools.GetOrAddComponent(arg_366_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_369_2 then
					var_369_2:EnableDynamicBone(true)
				end
			end

			local var_369_3 = arg_366_1.actors_["10171ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_3) and arg_366_1.var_.characterEffect10171ui_story == nil then
				arg_366_1.var_.characterEffect10171ui_story = var_369_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_4 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_4 and not isNil(var_369_3) then
				if arg_366_1.var_.characterEffect10171ui_story and not isNil(var_369_3) then
					arg_366_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_366_1.time_ >= 0 + var_369_4 and arg_366_1.time_ < 0 + var_369_4 + arg_369_0 and not isNil(var_369_3) and arg_366_1.var_.characterEffect10171ui_story then
				arg_366_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_369_6 = arg_366_1.actors_["1070ui_story"]

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(var_369_6) and arg_366_1.var_.characterEffect1070ui_story == nil then
				arg_366_1.var_.characterEffect1070ui_story = var_369_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_7 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_7 and not isNil(var_369_6) then
				if arg_366_1.var_.characterEffect1070ui_story and not isNil(var_369_6) then
					arg_366_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_366_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_366_1.time_ - 0) / var_369_7)
				end
			end

			if arg_366_1.time_ >= 0 + var_369_7 and arg_366_1.time_ < 0 + var_369_7 + arg_369_0 and not isNil(var_369_6) and arg_366_1.var_.characterEffect1070ui_story then
				arg_366_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_366_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action33_2")
			end

			local var_369_8 = 0
			local var_369_9 = 0.375

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_8 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, true)

				arg_366_1.leftNameTxt_.text = arg_366_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_366_1.leftNameTxt_.transform)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1.leftNameTxt_.text)
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_10 = arg_366_1:GetWordFromCfg(324081089)
				local var_369_11 = arg_366_1:FormatText(var_369_10.content)

				arg_366_1.text_.text = var_369_11

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_13 = 15 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 15)

				if (15 <= 0 and var_369_9 or var_369_9 * (utf8.len(var_369_11) / 15)) > 0 and var_369_9 < var_369_13 then
					arg_366_1.talkMaxDuration = var_369_13

					if var_369_13 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_13 + var_369_8
					end
				end

				arg_366_1.text_.text = var_369_11
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081089", "story_v_out_324081.awb") ~= 0 then
					local var_369_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081089", "story_v_out_324081.awb") / 1000

					if var_369_14 + var_369_8 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_14 + var_369_8
					end

					if var_369_10.prefab_name ~= "" and arg_366_1.actors_[var_369_10.prefab_name] ~= nil then
						local var_369_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_366_1.actors_[var_369_10.prefab_name].transform, "story_v_out_324081", "324081089", "story_v_out_324081.awb")

						arg_366_1:RecordAudio("324081089", var_369_15)
						arg_366_1:RecordAudio("324081089", var_369_15)
					else
						arg_366_1:AudioAction("play", "voice", "story_v_out_324081", "324081089", "story_v_out_324081.awb")
					end

					arg_366_1:RecordHistoryTalkVoice("story_v_out_324081", "324081089", "story_v_out_324081.awb")
				end

				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_16 = math.max(var_369_9, arg_366_1.talkMaxDuration)

			if var_369_8 <= arg_366_1.time_ and arg_366_1.time_ < var_369_8 + var_369_16 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_8) / var_369_16

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_8 + var_369_16 and arg_366_1.time_ < var_369_8 + var_369_16 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_366_1:InitPlayNodeList()
	end,
	Play324081090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 324081090
		arg_370_1.duration_ = 5.07

		local var_370_0 = {
			zh = 3.6,
			ja = 5.066
		}
		local var_370_1 = manager.audio:GetLocalizationFlag()

		if var_370_0[var_370_1] ~= nil then
			arg_370_1.duration_ = var_370_0[var_370_1]
		end

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play324081091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(arg_370_1.actors_["1070ui_story"]) and arg_370_1.var_.characterEffect1070ui_story == nil then
				arg_370_1.var_.characterEffect1070ui_story = arg_370_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_0 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_0 and not isNil(arg_370_1.actors_["1070ui_story"]) then
				if arg_370_1.var_.characterEffect1070ui_story and not isNil(arg_370_1.actors_["1070ui_story"]) then
					arg_370_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_370_1.time_ >= 0 + var_373_0 and arg_370_1.time_ < 0 + var_373_0 + arg_373_0 and not isNil(arg_370_1.actors_["1070ui_story"]) and arg_370_1.var_.characterEffect1070ui_story then
				arg_370_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_373_2 = arg_370_1.actors_["10171ui_story"]

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.characterEffect10171ui_story == nil then
				arg_370_1.var_.characterEffect10171ui_story = var_373_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_373_3 = 0.200000002980232

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_3 and not isNil(var_373_2) then
				if arg_370_1.var_.characterEffect10171ui_story and not isNil(var_373_2) then
					arg_370_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_370_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_370_1.time_ - 0) / var_373_3)
				end
			end

			if arg_370_1.time_ >= 0 + var_373_3 and arg_370_1.time_ < 0 + var_373_3 + arg_373_0 and not isNil(var_373_2) and arg_370_1.var_.characterEffect10171ui_story then
				arg_370_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_370_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_373_4 = 0
			local var_373_5 = 0.375

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= var_373_4 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_6 = arg_370_1:GetWordFromCfg(324081090)
				local var_373_7 = arg_370_1:FormatText(var_373_6.content)

				arg_370_1.text_.text = var_373_7

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_9 = 15 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 15)

				if (15 <= 0 and var_373_5 or var_373_5 * (utf8.len(var_373_7) / 15)) > 0 and var_373_5 < var_373_9 then
					arg_370_1.talkMaxDuration = var_373_9

					if var_373_9 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_9 + var_373_4
					end
				end

				arg_370_1.text_.text = var_373_7
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081090", "story_v_out_324081.awb") ~= 0 then
					local var_373_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081090", "story_v_out_324081.awb") / 1000

					if var_373_10 + var_373_4 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_10 + var_373_4
					end

					if var_373_6.prefab_name ~= "" and arg_370_1.actors_[var_373_6.prefab_name] ~= nil then
						local var_373_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_6.prefab_name].transform, "story_v_out_324081", "324081090", "story_v_out_324081.awb")

						arg_370_1:RecordAudio("324081090", var_373_11)
						arg_370_1:RecordAudio("324081090", var_373_11)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_324081", "324081090", "story_v_out_324081.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_324081", "324081090", "story_v_out_324081.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_12 = math.max(var_373_5, arg_370_1.talkMaxDuration)

			if var_373_4 <= arg_370_1.time_ and arg_370_1.time_ < var_373_4 + var_373_12 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - var_373_4) / var_373_12

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= var_373_4 + var_373_12 and arg_370_1.time_ < var_373_4 + var_373_12 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play324081091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 324081091
		arg_374_1.duration_ = 10

		local var_374_0 = {
			zh = 9.566,
			ja = 10
		}
		local var_374_1 = manager.audio:GetLocalizationFlag()

		if var_374_0[var_374_1] ~= nil then
			arg_374_1.duration_ = var_374_0[var_374_1]
		end

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play324081092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(arg_374_1.actors_["10171ui_story"]) and arg_374_1.var_.characterEffect10171ui_story == nil then
				arg_374_1.var_.characterEffect10171ui_story = arg_374_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_0 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_0 and not isNil(arg_374_1.actors_["10171ui_story"]) then
				if arg_374_1.var_.characterEffect10171ui_story and not isNil(arg_374_1.actors_["10171ui_story"]) then
					arg_374_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_374_1.time_ >= 0 + var_377_0 and arg_374_1.time_ < 0 + var_377_0 + arg_377_0 and not isNil(arg_374_1.actors_["10171ui_story"]) and arg_374_1.var_.characterEffect10171ui_story then
				arg_374_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_377_2 = arg_374_1.actors_["1070ui_story"]

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.characterEffect1070ui_story == nil then
				arg_374_1.var_.characterEffect1070ui_story = var_377_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_377_3 = 0.200000002980232

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_3 and not isNil(var_377_2) then
				if arg_374_1.var_.characterEffect1070ui_story and not isNil(var_377_2) then
					arg_374_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_374_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_374_1.time_ - 0) / var_377_3)
				end
			end

			if arg_374_1.time_ >= 0 + var_377_3 and arg_374_1.time_ < 0 + var_377_3 + arg_377_0 and not isNil(var_377_2) and arg_374_1.var_.characterEffect1070ui_story then
				arg_374_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_374_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_377_4 = 0
			local var_377_5 = 1.15

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, true)

				arg_374_1.leftNameTxt_.text = arg_374_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_374_1.leftNameTxt_.transform)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1.leftNameTxt_.text)
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_6 = arg_374_1:GetWordFromCfg(324081091)
				local var_377_7 = arg_374_1:FormatText(var_377_6.content)

				arg_374_1.text_.text = var_377_7

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_9 = 46 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 46)

				if (46 <= 0 and var_377_5 or var_377_5 * (utf8.len(var_377_7) / 46)) > 0 and var_377_5 < var_377_9 then
					arg_374_1.talkMaxDuration = var_377_9

					if var_377_9 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_9 + var_377_4
					end
				end

				arg_374_1.text_.text = var_377_7
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081091", "story_v_out_324081.awb") ~= 0 then
					local var_377_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081091", "story_v_out_324081.awb") / 1000

					if var_377_10 + var_377_4 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_10 + var_377_4
					end

					if var_377_6.prefab_name ~= "" and arg_374_1.actors_[var_377_6.prefab_name] ~= nil then
						local var_377_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_374_1.actors_[var_377_6.prefab_name].transform, "story_v_out_324081", "324081091", "story_v_out_324081.awb")

						arg_374_1:RecordAudio("324081091", var_377_11)
						arg_374_1:RecordAudio("324081091", var_377_11)
					else
						arg_374_1:AudioAction("play", "voice", "story_v_out_324081", "324081091", "story_v_out_324081.awb")
					end

					arg_374_1:RecordHistoryTalkVoice("story_v_out_324081", "324081091", "story_v_out_324081.awb")
				end

				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_12 = math.max(var_377_5, arg_374_1.talkMaxDuration)

			if var_377_4 <= arg_374_1.time_ and arg_374_1.time_ < var_377_4 + var_377_12 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_4) / var_377_12

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_4 + var_377_12 and arg_374_1.time_ < var_377_4 + var_377_12 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play324081092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 324081092
		arg_378_1.duration_ = 12.23

		local var_378_0 = {
			zh = 12.233,
			ja = 6.7
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play324081093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_1")
			end

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_381_0 = 0
			local var_381_1 = 1.425

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= var_381_0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_2 = arg_378_1:GetWordFromCfg(324081092)
				local var_381_3 = arg_378_1:FormatText(var_381_2.content)

				arg_378_1.text_.text = var_381_3

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_5 = 57 <= 0 and var_381_1 or var_381_1 * (utf8.len(var_381_3) / 57)

				if (57 <= 0 and var_381_1 or var_381_1 * (utf8.len(var_381_3) / 57)) > 0 and var_381_1 < var_381_5 then
					arg_378_1.talkMaxDuration = var_381_5

					if var_381_5 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + var_381_0
					end
				end

				arg_378_1.text_.text = var_381_3
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081092", "story_v_out_324081.awb") ~= 0 then
					local var_381_6 = manager.audio:GetVoiceLength("story_v_out_324081", "324081092", "story_v_out_324081.awb") / 1000

					if var_381_6 + var_381_0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_6 + var_381_0
					end

					if var_381_2.prefab_name ~= "" and arg_378_1.actors_[var_381_2.prefab_name] ~= nil then
						local var_381_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_2.prefab_name].transform, "story_v_out_324081", "324081092", "story_v_out_324081.awb")

						arg_378_1:RecordAudio("324081092", var_381_7)
						arg_378_1:RecordAudio("324081092", var_381_7)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_324081", "324081092", "story_v_out_324081.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_324081", "324081092", "story_v_out_324081.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_8 = math.max(var_381_1, arg_378_1.talkMaxDuration)

			if var_381_0 <= arg_378_1.time_ and arg_378_1.time_ < var_381_0 + var_381_8 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - var_381_0) / var_381_8

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= var_381_0 + var_381_8 and arg_378_1.time_ < var_381_0 + var_381_8 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play324081093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 324081093
		arg_382_1.duration_ = 12.83

		local var_382_0 = {
			zh = 11.066,
			ja = 12.833
		}
		local var_382_1 = manager.audio:GetLocalizationFlag()

		if var_382_0[var_382_1] ~= nil then
			arg_382_1.duration_ = var_382_0[var_382_1]
		end

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play324081094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(arg_382_1.actors_["1070ui_story"]) and arg_382_1.var_.characterEffect1070ui_story == nil then
				arg_382_1.var_.characterEffect1070ui_story = arg_382_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_0 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_0 and not isNil(arg_382_1.actors_["1070ui_story"]) then
				if arg_382_1.var_.characterEffect1070ui_story and not isNil(arg_382_1.actors_["1070ui_story"]) then
					arg_382_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_382_1.time_ >= 0 + var_385_0 and arg_382_1.time_ < 0 + var_385_0 + arg_385_0 and not isNil(arg_382_1.actors_["1070ui_story"]) and arg_382_1.var_.characterEffect1070ui_story then
				arg_382_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_385_2 = arg_382_1.actors_["10171ui_story"]

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.characterEffect10171ui_story == nil then
				arg_382_1.var_.characterEffect10171ui_story = var_385_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_385_3 = 0.200000002980232

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_3 and not isNil(var_385_2) then
				if arg_382_1.var_.characterEffect10171ui_story and not isNil(var_385_2) then
					arg_382_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_382_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_382_1.time_ - 0) / var_385_3)
				end
			end

			if arg_382_1.time_ >= 0 + var_385_3 and arg_382_1.time_ < 0 + var_385_3 + arg_385_0 and not isNil(var_385_2) and arg_382_1.var_.characterEffect10171ui_story then
				arg_382_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_382_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_385_4 = 0
			local var_385_5 = 1.225

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= var_385_4 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, true)

				arg_382_1.leftNameTxt_.text = arg_382_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_382_1.leftNameTxt_.transform)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1.leftNameTxt_.text)
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_6 = arg_382_1:GetWordFromCfg(324081093)
				local var_385_7 = arg_382_1:FormatText(var_385_6.content)

				arg_382_1.text_.text = var_385_7

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_9 = 49 <= 0 and var_385_5 or var_385_5 * (utf8.len(var_385_7) / 49)

				if (49 <= 0 and var_385_5 or var_385_5 * (utf8.len(var_385_7) / 49)) > 0 and var_385_5 < var_385_9 then
					arg_382_1.talkMaxDuration = var_385_9

					if var_385_9 + var_385_4 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_9 + var_385_4
					end
				end

				arg_382_1.text_.text = var_385_7
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081093", "story_v_out_324081.awb") ~= 0 then
					local var_385_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081093", "story_v_out_324081.awb") / 1000

					if var_385_10 + var_385_4 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_10 + var_385_4
					end

					if var_385_6.prefab_name ~= "" and arg_382_1.actors_[var_385_6.prefab_name] ~= nil then
						local var_385_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_382_1.actors_[var_385_6.prefab_name].transform, "story_v_out_324081", "324081093", "story_v_out_324081.awb")

						arg_382_1:RecordAudio("324081093", var_385_11)
						arg_382_1:RecordAudio("324081093", var_385_11)
					else
						arg_382_1:AudioAction("play", "voice", "story_v_out_324081", "324081093", "story_v_out_324081.awb")
					end

					arg_382_1:RecordHistoryTalkVoice("story_v_out_324081", "324081093", "story_v_out_324081.awb")
				end

				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_12 = math.max(var_385_5, arg_382_1.talkMaxDuration)

			if var_385_4 <= arg_382_1.time_ and arg_382_1.time_ < var_385_4 + var_385_12 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - var_385_4) / var_385_12

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= var_385_4 + var_385_12 and arg_382_1.time_ < var_385_4 + var_385_12 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play324081094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 324081094
		arg_386_1.duration_ = 2

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play324081095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(arg_386_1.actors_["10171ui_story"]) and arg_386_1.var_.characterEffect10171ui_story == nil then
				arg_386_1.var_.characterEffect10171ui_story = arg_386_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_0 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_0 and not isNil(arg_386_1.actors_["10171ui_story"]) then
				if arg_386_1.var_.characterEffect10171ui_story and not isNil(arg_386_1.actors_["10171ui_story"]) then
					arg_386_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_386_1.time_ >= 0 + var_389_0 and arg_386_1.time_ < 0 + var_389_0 + arg_389_0 and not isNil(arg_386_1.actors_["10171ui_story"]) and arg_386_1.var_.characterEffect10171ui_story then
				arg_386_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_389_2 = arg_386_1.actors_["1070ui_story"]

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 and not isNil(var_389_2) and arg_386_1.var_.characterEffect1070ui_story == nil then
				arg_386_1.var_.characterEffect1070ui_story = var_389_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_389_3 = 0.200000002980232

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_3 and not isNil(var_389_2) then
				if arg_386_1.var_.characterEffect1070ui_story and not isNil(var_389_2) then
					arg_386_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_386_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_386_1.time_ - 0) / var_389_3)
				end
			end

			if arg_386_1.time_ >= 0 + var_389_3 and arg_386_1.time_ < 0 + var_389_3 + arg_389_0 and not isNil(var_389_2) and arg_386_1.var_.characterEffect1070ui_story then
				arg_386_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_386_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_2")
			end

			local var_389_4 = 0
			local var_389_5 = 0.125

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_4 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, true)

				arg_386_1.leftNameTxt_.text = arg_386_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_386_1.leftNameTxt_.transform)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1.leftNameTxt_.text)
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_6 = arg_386_1:GetWordFromCfg(324081094)
				local var_389_7 = arg_386_1:FormatText(var_389_6.content)

				arg_386_1.text_.text = var_389_7

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_9 = 5 <= 0 and var_389_5 or var_389_5 * (utf8.len(var_389_7) / 5)

				if (5 <= 0 and var_389_5 or var_389_5 * (utf8.len(var_389_7) / 5)) > 0 and var_389_5 < var_389_9 then
					arg_386_1.talkMaxDuration = var_389_9

					if var_389_9 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_9 + var_389_4
					end
				end

				arg_386_1.text_.text = var_389_7
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081094", "story_v_out_324081.awb") ~= 0 then
					local var_389_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081094", "story_v_out_324081.awb") / 1000

					if var_389_10 + var_389_4 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_10 + var_389_4
					end

					if var_389_6.prefab_name ~= "" and arg_386_1.actors_[var_389_6.prefab_name] ~= nil then
						local var_389_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_386_1.actors_[var_389_6.prefab_name].transform, "story_v_out_324081", "324081094", "story_v_out_324081.awb")

						arg_386_1:RecordAudio("324081094", var_389_11)
						arg_386_1:RecordAudio("324081094", var_389_11)
					else
						arg_386_1:AudioAction("play", "voice", "story_v_out_324081", "324081094", "story_v_out_324081.awb")
					end

					arg_386_1:RecordHistoryTalkVoice("story_v_out_324081", "324081094", "story_v_out_324081.awb")
				end

				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_12 = math.max(var_389_5, arg_386_1.talkMaxDuration)

			if var_389_4 <= arg_386_1.time_ and arg_386_1.time_ < var_389_4 + var_389_12 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_4) / var_389_12

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_4 + var_389_12 and arg_386_1.time_ < var_389_4 + var_389_12 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play324081095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 324081095
		arg_390_1.duration_ = 4.4

		local var_390_0 = {
			zh = 4.1,
			ja = 4.4
		}
		local var_390_1 = manager.audio:GetLocalizationFlag()

		if var_390_0[var_390_1] ~= nil then
			arg_390_1.duration_ = var_390_0[var_390_1]
		end

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play324081096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(arg_390_1.actors_["1070ui_story"]) and arg_390_1.var_.characterEffect1070ui_story == nil then
				arg_390_1.var_.characterEffect1070ui_story = arg_390_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_0 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_0 and not isNil(arg_390_1.actors_["1070ui_story"]) then
				if arg_390_1.var_.characterEffect1070ui_story and not isNil(arg_390_1.actors_["1070ui_story"]) then
					arg_390_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_390_1.time_ >= 0 + var_393_0 and arg_390_1.time_ < 0 + var_393_0 + arg_393_0 and not isNil(arg_390_1.actors_["1070ui_story"]) and arg_390_1.var_.characterEffect1070ui_story then
				arg_390_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_393_2 = arg_390_1.actors_["10171ui_story"]

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.characterEffect10171ui_story == nil then
				arg_390_1.var_.characterEffect10171ui_story = var_393_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_393_3 = 0.200000002980232

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_3 and not isNil(var_393_2) then
				if arg_390_1.var_.characterEffect10171ui_story and not isNil(var_393_2) then
					arg_390_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_390_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_390_1.time_ - 0) / var_393_3)
				end
			end

			if arg_390_1.time_ >= 0 + var_393_3 and arg_390_1.time_ < 0 + var_393_3 + arg_393_0 and not isNil(var_393_2) and arg_390_1.var_.characterEffect10171ui_story then
				arg_390_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_390_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_393_4 = 0
			local var_393_5 = 0.45

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= var_393_4 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_6 = arg_390_1:GetWordFromCfg(324081095)
				local var_393_7 = arg_390_1:FormatText(var_393_6.content)

				arg_390_1.text_.text = var_393_7

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_9 = 18 <= 0 and var_393_5 or var_393_5 * (utf8.len(var_393_7) / 18)

				if (18 <= 0 and var_393_5 or var_393_5 * (utf8.len(var_393_7) / 18)) > 0 and var_393_5 < var_393_9 then
					arg_390_1.talkMaxDuration = var_393_9

					if var_393_9 + var_393_4 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_9 + var_393_4
					end
				end

				arg_390_1.text_.text = var_393_7
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081095", "story_v_out_324081.awb") ~= 0 then
					local var_393_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081095", "story_v_out_324081.awb") / 1000

					if var_393_10 + var_393_4 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_10 + var_393_4
					end

					if var_393_6.prefab_name ~= "" and arg_390_1.actors_[var_393_6.prefab_name] ~= nil then
						local var_393_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_6.prefab_name].transform, "story_v_out_324081", "324081095", "story_v_out_324081.awb")

						arg_390_1:RecordAudio("324081095", var_393_11)
						arg_390_1:RecordAudio("324081095", var_393_11)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_324081", "324081095", "story_v_out_324081.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_324081", "324081095", "story_v_out_324081.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_12 = math.max(var_393_5, arg_390_1.talkMaxDuration)

			if var_393_4 <= arg_390_1.time_ and arg_390_1.time_ < var_393_4 + var_393_12 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - var_393_4) / var_393_12

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= var_393_4 + var_393_12 and arg_390_1.time_ < var_393_4 + var_393_12 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play324081096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 324081096
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play324081097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos1070ui_story = arg_394_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_397_0 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_0 then
				arg_394_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_394_1.time_ - 0) / var_397_0)
				arg_394_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_394_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1070ui_story"].transform.position).z)
				arg_394_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_394_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_394_1.actors_["1070ui_story"].transform.localEulerAngles = arg_394_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_394_1.time_ >= 0 + var_397_0 and arg_394_1.time_ < 0 + var_397_0 + arg_397_0 then
				arg_394_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_394_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_394_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_394_1.actors_["1070ui_story"].transform.position).z)
				arg_394_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_394_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_394_1.actors_["1070ui_story"].transform.localEulerAngles = arg_394_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_397_1 = arg_394_1.actors_["10171ui_story"].transform

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.var_.moveOldPos10171ui_story = var_397_1.localPosition

				local var_397_2 = GameObjectTools.GetOrAddComponent(var_397_1.gameObject, typeof(DynamicBoneHelper))

				if var_397_2 then
					var_397_2:EnableDynamicBone(false)
				end
			end

			local var_397_3 = 0.001

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_3 then
				var_397_1.localPosition = Vector3.Lerp(arg_394_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_394_1.time_ - 0) / var_397_3)
				var_397_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_397_1.position).x, (manager.ui.mainCamera.transform.position - var_397_1.position).y, (manager.ui.mainCamera.transform.position - var_397_1.position).z)
				var_397_1.localEulerAngles.z = 0
				var_397_1.localEulerAngles.x = 0
				var_397_1.localEulerAngles = var_397_1.localEulerAngles
			end

			if arg_394_1.time_ >= 0 + var_397_3 and arg_394_1.time_ < 0 + var_397_3 + arg_397_0 then
				var_397_1.localPosition = Vector3.New(0, 100, 0)
				var_397_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_397_1.position).x, (manager.ui.mainCamera.transform.position - var_397_1.position).y, (manager.ui.mainCamera.transform.position - var_397_1.position).z)
				var_397_1.localEulerAngles.z = 0
				var_397_1.localEulerAngles.x = 0
				var_397_1.localEulerAngles = var_397_1.localEulerAngles

				local var_397_4 = GameObjectTools.GetOrAddComponent(var_397_1.gameObject, typeof(DynamicBoneHelper))

				if var_397_4 then
					var_397_4:EnableDynamicBone(true)
				end
			end

			local var_397_5 = arg_394_1.actors_["1070ui_story"]

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 and not isNil(var_397_5) and arg_394_1.var_.characterEffect1070ui_story == nil then
				arg_394_1.var_.characterEffect1070ui_story = var_397_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_397_6 = 0.200000002980232

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_6 and not isNil(var_397_5) then
				if arg_394_1.var_.characterEffect1070ui_story and not isNil(var_397_5) then
					arg_394_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_394_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_394_1.time_ - 0) / var_397_6)
				end
			end

			if arg_394_1.time_ >= 0 + var_397_6 and arg_394_1.time_ < 0 + var_397_6 + arg_397_0 and not isNil(var_397_5) and arg_394_1.var_.characterEffect1070ui_story then
				arg_394_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_394_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_397_7 = 0
			local var_397_8 = 0.85

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= var_397_7 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_9 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(324081096).content)

				arg_394_1.text_.text = var_397_9

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_11 = 34 <= 0 and var_397_8 or var_397_8 * (utf8.len(var_397_9) / 34)

				if (34 <= 0 and var_397_8 or var_397_8 * (utf8.len(var_397_9) / 34)) > 0 and var_397_8 < var_397_11 then
					arg_394_1.talkMaxDuration = var_397_11

					if var_397_11 + var_397_7 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_11 + var_397_7
					end
				end

				arg_394_1.text_.text = var_397_9
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_12 = math.max(var_397_8, arg_394_1.talkMaxDuration)

			if var_397_7 <= arg_394_1.time_ and arg_394_1.time_ < var_397_7 + var_397_12 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - var_397_7) / var_397_12

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= var_397_7 + var_397_12 and arg_394_1.time_ < var_397_7 + var_397_12 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_394_1:InitPlayNodeList()
	end,
	Play324081097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 324081097
		arg_398_1.duration_ = 4.23

		local var_398_0 = {
			zh = 2.566,
			ja = 4.233
		}
		local var_398_1 = manager.audio:GetLocalizationFlag()

		if var_398_0[var_398_1] ~= nil then
			arg_398_1.duration_ = var_398_0[var_398_1]
		end

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play324081098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.var_.moveOldPos1070ui_story = arg_398_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_401_0 = 0.001

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_0 then
				arg_398_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_398_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_398_1.time_ - 0) / var_401_0)
				arg_398_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1070ui_story"].transform.position).z)
				arg_398_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1070ui_story"].transform.localEulerAngles = arg_398_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_398_1.time_ >= 0 + var_401_0 and arg_398_1.time_ < 0 + var_401_0 + arg_401_0 then
				arg_398_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_398_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_398_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_398_1.actors_["1070ui_story"].transform.position).z)
				arg_398_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_398_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_398_1.actors_["1070ui_story"].transform.localEulerAngles = arg_398_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_401_1 = arg_398_1.actors_["1070ui_story"]

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1070ui_story == nil then
				arg_398_1.var_.characterEffect1070ui_story = var_401_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_401_2 = 0.200000002980232

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_2 and not isNil(var_401_1) then
				if arg_398_1.var_.characterEffect1070ui_story and not isNil(var_401_1) then
					arg_398_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_398_1.time_ >= 0 + var_401_2 and arg_398_1.time_ < 0 + var_401_2 + arg_401_0 and not isNil(var_401_1) and arg_398_1.var_.characterEffect1070ui_story then
				arg_398_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action1_1")
			end

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_401_4 = 0
			local var_401_5 = 0.35

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_4 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, true)

				arg_398_1.leftNameTxt_.text = arg_398_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_398_1.leftNameTxt_.transform)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1.leftNameTxt_.text)
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_6 = arg_398_1:GetWordFromCfg(324081097)
				local var_401_7 = arg_398_1:FormatText(var_401_6.content)

				arg_398_1.text_.text = var_401_7

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_9 = 14 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 14)

				if (14 <= 0 and var_401_5 or var_401_5 * (utf8.len(var_401_7) / 14)) > 0 and var_401_5 < var_401_9 then
					arg_398_1.talkMaxDuration = var_401_9

					if var_401_9 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_9 + var_401_4
					end
				end

				arg_398_1.text_.text = var_401_7
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081097", "story_v_out_324081.awb") ~= 0 then
					local var_401_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081097", "story_v_out_324081.awb") / 1000

					if var_401_10 + var_401_4 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_10 + var_401_4
					end

					if var_401_6.prefab_name ~= "" and arg_398_1.actors_[var_401_6.prefab_name] ~= nil then
						local var_401_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_398_1.actors_[var_401_6.prefab_name].transform, "story_v_out_324081", "324081097", "story_v_out_324081.awb")

						arg_398_1:RecordAudio("324081097", var_401_11)
						arg_398_1:RecordAudio("324081097", var_401_11)
					else
						arg_398_1:AudioAction("play", "voice", "story_v_out_324081", "324081097", "story_v_out_324081.awb")
					end

					arg_398_1:RecordHistoryTalkVoice("story_v_out_324081", "324081097", "story_v_out_324081.awb")
				end

				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_12 = math.max(var_401_5, arg_398_1.talkMaxDuration)

			if var_401_4 <= arg_398_1.time_ and arg_398_1.time_ < var_401_4 + var_401_12 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_4) / var_401_12

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_4 + var_401_12 and arg_398_1.time_ < var_401_4 + var_401_12 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_398_1:InitPlayNodeList()
	end,
	Play324081098 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 324081098
		arg_402_1.duration_ = 3.07

		local var_402_0 = {
			zh = 2.6,
			ja = 3.066
		}
		local var_402_1 = manager.audio:GetLocalizationFlag()

		if var_402_0[var_402_1] ~= nil then
			arg_402_1.duration_ = var_402_0[var_402_1]
		end

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play324081099(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.var_.moveOldPos10171ui_story = arg_402_1.actors_["10171ui_story"].transform.localPosition

				local var_405_0 = GameObjectTools.GetOrAddComponent(arg_402_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_405_0 then
					var_405_0:EnableDynamicBone(false)
				end
			end

			local var_405_1 = 0.001

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_1 then
				arg_402_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_402_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_402_1.time_ - 0) / var_405_1)
				arg_402_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_402_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["10171ui_story"].transform.position).z)
				arg_402_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_402_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_402_1.actors_["10171ui_story"].transform.localEulerAngles = arg_402_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_402_1.time_ >= 0 + var_405_1 and arg_402_1.time_ < 0 + var_405_1 + arg_405_0 then
				arg_402_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_402_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_402_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_402_1.actors_["10171ui_story"].transform.position).z)
				arg_402_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_402_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_402_1.actors_["10171ui_story"].transform.localEulerAngles = arg_402_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_405_2 = GameObjectTools.GetOrAddComponent(arg_402_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_405_2 then
					var_405_2:EnableDynamicBone(true)
				end
			end

			local var_405_3 = arg_402_1.actors_["10171ui_story"]

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(var_405_3) and arg_402_1.var_.characterEffect10171ui_story == nil then
				arg_402_1.var_.characterEffect10171ui_story = var_405_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_4 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_4 and not isNil(var_405_3) then
				if arg_402_1.var_.characterEffect10171ui_story and not isNil(var_405_3) then
					arg_402_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_402_1.time_ >= 0 + var_405_4 and arg_402_1.time_ < 0 + var_405_4 + arg_405_0 and not isNil(var_405_3) and arg_402_1.var_.characterEffect10171ui_story then
				arg_402_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_405_6 = arg_402_1.actors_["1070ui_story"]

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 and not isNil(var_405_6) and arg_402_1.var_.characterEffect1070ui_story == nil then
				arg_402_1.var_.characterEffect1070ui_story = var_405_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_405_7 = 0.200000002980232

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_7 and not isNil(var_405_6) then
				if arg_402_1.var_.characterEffect1070ui_story and not isNil(var_405_6) then
					arg_402_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_402_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_402_1.time_ - 0) / var_405_7)
				end
			end

			if arg_402_1.time_ >= 0 + var_405_7 and arg_402_1.time_ < 0 + var_405_7 + arg_405_0 and not isNil(var_405_6) and arg_402_1.var_.characterEffect1070ui_story then
				arg_402_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_402_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action1_1")
			end

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_405_8 = 0
			local var_405_9 = 0.225

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= var_405_8 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, false)
				arg_402_1.callingController_:SetSelectedState("normal")

				local var_405_10 = arg_402_1:GetWordFromCfg(324081098)
				local var_405_11 = arg_402_1:FormatText(var_405_10.content)

				arg_402_1.text_.text = var_405_11

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_13 = 9 <= 0 and var_405_9 or var_405_9 * (utf8.len(var_405_11) / 9)

				if (9 <= 0 and var_405_9 or var_405_9 * (utf8.len(var_405_11) / 9)) > 0 and var_405_9 < var_405_13 then
					arg_402_1.talkMaxDuration = var_405_13

					if var_405_13 + var_405_8 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_13 + var_405_8
					end
				end

				arg_402_1.text_.text = var_405_11
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081098", "story_v_out_324081.awb") ~= 0 then
					local var_405_14 = manager.audio:GetVoiceLength("story_v_out_324081", "324081098", "story_v_out_324081.awb") / 1000

					if var_405_14 + var_405_8 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_14 + var_405_8
					end

					if var_405_10.prefab_name ~= "" and arg_402_1.actors_[var_405_10.prefab_name] ~= nil then
						local var_405_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_402_1.actors_[var_405_10.prefab_name].transform, "story_v_out_324081", "324081098", "story_v_out_324081.awb")

						arg_402_1:RecordAudio("324081098", var_405_15)
						arg_402_1:RecordAudio("324081098", var_405_15)
					else
						arg_402_1:AudioAction("play", "voice", "story_v_out_324081", "324081098", "story_v_out_324081.awb")
					end

					arg_402_1:RecordHistoryTalkVoice("story_v_out_324081", "324081098", "story_v_out_324081.awb")
				end

				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_16 = math.max(var_405_9, arg_402_1.talkMaxDuration)

			if var_405_8 <= arg_402_1.time_ and arg_402_1.time_ < var_405_8 + var_405_16 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - var_405_8) / var_405_16

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= var_405_8 + var_405_16 and arg_402_1.time_ < var_405_8 + var_405_16 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_402_1:InitPlayNodeList()
	end,
	Play324081099 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 324081099
		arg_406_1.duration_ = 5.1

		local var_406_0 = {
			zh = 3.266,
			ja = 5.1
		}
		local var_406_1 = manager.audio:GetLocalizationFlag()

		if var_406_0[var_406_1] ~= nil then
			arg_406_1.duration_ = var_406_0[var_406_1]
		end

		SetActive(arg_406_1.tipsGo_, false)

		function arg_406_1.onSingleLineFinish_()
			arg_406_1.onSingleLineUpdate_ = nil
			arg_406_1.onSingleLineFinish_ = nil
			arg_406_1.state_ = "waiting"
		end

		function arg_406_1.playNext_(arg_408_0)
			if arg_408_0 == 1 then
				arg_406_0:Play324081100(arg_406_1)
			end
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(arg_406_1.actors_["1070ui_story"]) and arg_406_1.var_.characterEffect1070ui_story == nil then
				arg_406_1.var_.characterEffect1070ui_story = arg_406_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_0 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_0 and not isNil(arg_406_1.actors_["1070ui_story"]) then
				if arg_406_1.var_.characterEffect1070ui_story and not isNil(arg_406_1.actors_["1070ui_story"]) then
					arg_406_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_406_1.time_ >= 0 + var_409_0 and arg_406_1.time_ < 0 + var_409_0 + arg_409_0 and not isNil(arg_406_1.actors_["1070ui_story"]) and arg_406_1.var_.characterEffect1070ui_story then
				arg_406_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_409_2 = arg_406_1.actors_["10171ui_story"]

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.characterEffect10171ui_story == nil then
				arg_406_1.var_.characterEffect10171ui_story = var_409_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_409_3 = 0.200000002980232

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_3 and not isNil(var_409_2) then
				if arg_406_1.var_.characterEffect10171ui_story and not isNil(var_409_2) then
					arg_406_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_406_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_406_1.time_ - 0) / var_409_3)
				end
			end

			if arg_406_1.time_ >= 0 + var_409_3 and arg_406_1.time_ < 0 + var_409_3 + arg_409_0 and not isNil(var_409_2) and arg_406_1.var_.characterEffect10171ui_story then
				arg_406_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_406_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_409_4 = 0
			local var_409_5 = 0.375

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= var_409_4 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, false)
				arg_406_1.callingController_:SetSelectedState("normal")

				local var_409_6 = arg_406_1:GetWordFromCfg(324081099)
				local var_409_7 = arg_406_1:FormatText(var_409_6.content)

				arg_406_1.text_.text = var_409_7

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_9 = 15 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 15)

				if (15 <= 0 and var_409_5 or var_409_5 * (utf8.len(var_409_7) / 15)) > 0 and var_409_5 < var_409_9 then
					arg_406_1.talkMaxDuration = var_409_9

					if var_409_9 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_9 + var_409_4
					end
				end

				arg_406_1.text_.text = var_409_7
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081099", "story_v_out_324081.awb") ~= 0 then
					local var_409_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081099", "story_v_out_324081.awb") / 1000

					if var_409_10 + var_409_4 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_10 + var_409_4
					end

					if var_409_6.prefab_name ~= "" and arg_406_1.actors_[var_409_6.prefab_name] ~= nil then
						local var_409_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_6.prefab_name].transform, "story_v_out_324081", "324081099", "story_v_out_324081.awb")

						arg_406_1:RecordAudio("324081099", var_409_11)
						arg_406_1:RecordAudio("324081099", var_409_11)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_324081", "324081099", "story_v_out_324081.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_324081", "324081099", "story_v_out_324081.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_12 = math.max(var_409_5, arg_406_1.talkMaxDuration)

			if var_409_4 <= arg_406_1.time_ and arg_406_1.time_ < var_409_4 + var_409_12 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - var_409_4) / var_409_12

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= var_409_4 + var_409_12 and arg_406_1.time_ < var_409_4 + var_409_12 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	Play324081100 = function(arg_410_0, arg_410_1)
		arg_410_1.time_ = 0
		arg_410_1.frameCnt_ = 0
		arg_410_1.state_ = "playing"
		arg_410_1.curTalkId_ = 324081100
		arg_410_1.duration_ = 6.8

		local var_410_0 = {
			zh = 6,
			ja = 6.8
		}
		local var_410_1 = manager.audio:GetLocalizationFlag()

		if var_410_0[var_410_1] ~= nil then
			arg_410_1.duration_ = var_410_0[var_410_1]
		end

		SetActive(arg_410_1.tipsGo_, false)

		function arg_410_1.onSingleLineFinish_()
			arg_410_1.onSingleLineUpdate_ = nil
			arg_410_1.onSingleLineFinish_ = nil
			arg_410_1.state_ = "waiting"
		end

		function arg_410_1.playNext_(arg_412_0)
			if arg_412_0 == 1 then
				arg_410_0:Play324081101(arg_410_1)
			end
		end

		function arg_410_1.onSingleLineUpdate_(arg_413_0)
			if 0 < arg_410_1.time_ and arg_410_1.time_ <= 0 + arg_413_0 then
				arg_410_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_1")
			end

			local var_413_0 = 0
			local var_413_1 = 0.65

			if 0 < arg_410_1.time_ and arg_410_1.time_ <= var_413_0 + arg_413_0 then
				arg_410_1.talkMaxDuration = 0
				arg_410_1.dialogCg_.alpha = 1

				arg_410_1.dialog_:SetActive(true)
				SetActive(arg_410_1.leftNameGo_, true)

				arg_410_1.leftNameTxt_.text = arg_410_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_410_1.leftNameTxt_.transform)

				arg_410_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_410_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_410_1:RecordName(arg_410_1.leftNameTxt_.text)
				SetActive(arg_410_1.iconTrs_.gameObject, false)
				arg_410_1.callingController_:SetSelectedState("normal")

				local var_413_2 = arg_410_1:GetWordFromCfg(324081100)
				local var_413_3 = arg_410_1:FormatText(var_413_2.content)

				arg_410_1.text_.text = var_413_3

				LuaForUtil.ClearLinePrefixSymbol(arg_410_1.text_)

				local var_413_5 = 26 <= 0 and var_413_1 or var_413_1 * (utf8.len(var_413_3) / 26)

				if (26 <= 0 and var_413_1 or var_413_1 * (utf8.len(var_413_3) / 26)) > 0 and var_413_1 < var_413_5 then
					arg_410_1.talkMaxDuration = var_413_5

					if var_413_5 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_5 + var_413_0
					end
				end

				arg_410_1.text_.text = var_413_3
				arg_410_1.typewritter.percent = 0

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081100", "story_v_out_324081.awb") ~= 0 then
					local var_413_6 = manager.audio:GetVoiceLength("story_v_out_324081", "324081100", "story_v_out_324081.awb") / 1000

					if var_413_6 + var_413_0 > arg_410_1.duration_ then
						arg_410_1.duration_ = var_413_6 + var_413_0
					end

					if var_413_2.prefab_name ~= "" and arg_410_1.actors_[var_413_2.prefab_name] ~= nil then
						local var_413_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_410_1.actors_[var_413_2.prefab_name].transform, "story_v_out_324081", "324081100", "story_v_out_324081.awb")

						arg_410_1:RecordAudio("324081100", var_413_7)
						arg_410_1:RecordAudio("324081100", var_413_7)
					else
						arg_410_1:AudioAction("play", "voice", "story_v_out_324081", "324081100", "story_v_out_324081.awb")
					end

					arg_410_1:RecordHistoryTalkVoice("story_v_out_324081", "324081100", "story_v_out_324081.awb")
				end

				arg_410_1:RecordContent(arg_410_1.text_.text)
			end

			local var_413_8 = math.max(var_413_1, arg_410_1.talkMaxDuration)

			if var_413_0 <= arg_410_1.time_ and arg_410_1.time_ < var_413_0 + var_413_8 then
				arg_410_1.typewritter.percent = (arg_410_1.time_ - var_413_0) / var_413_8

				arg_410_1.typewritter:SetDirty()
			end

			if arg_410_1.time_ >= var_413_0 + var_413_8 and arg_410_1.time_ < var_413_0 + var_413_8 + arg_413_0 then
				arg_410_1.typewritter.percent = 1

				arg_410_1.typewritter:SetDirty()
				arg_410_1:ShowNextGo(true)
			end
		end

		arg_410_1.nodeConfigList_ = {}

		arg_410_1:InitPlayNodeList()
	end,
	Play324081101 = function(arg_414_0, arg_414_1)
		arg_414_1.time_ = 0
		arg_414_1.frameCnt_ = 0
		arg_414_1.state_ = "playing"
		arg_414_1.curTalkId_ = 324081101
		arg_414_1.duration_ = 5

		SetActive(arg_414_1.tipsGo_, false)

		function arg_414_1.onSingleLineFinish_()
			arg_414_1.onSingleLineUpdate_ = nil
			arg_414_1.onSingleLineFinish_ = nil
			arg_414_1.state_ = "waiting"
		end

		function arg_414_1.playNext_(arg_416_0)
			if arg_416_0 == 1 then
				arg_414_0:Play324081102(arg_414_1)
			end
		end

		function arg_414_1.onSingleLineUpdate_(arg_417_0)
			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos1070ui_story = arg_414_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_417_0 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_0 then
				arg_414_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_414_1.time_ - 0) / var_417_0)
				arg_414_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1070ui_story"].transform.position).z)
				arg_414_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1070ui_story"].transform.localEulerAngles = arg_414_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_0 and arg_414_1.time_ < 0 + var_417_0 + arg_417_0 then
				arg_414_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_414_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_414_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_414_1.actors_["1070ui_story"].transform.position).z)
				arg_414_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_414_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_414_1.actors_["1070ui_story"].transform.localEulerAngles = arg_414_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_417_1 = arg_414_1.actors_["10171ui_story"].transform

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 then
				arg_414_1.var_.moveOldPos10171ui_story = var_417_1.localPosition

				local var_417_2 = GameObjectTools.GetOrAddComponent(var_417_1.gameObject, typeof(DynamicBoneHelper))

				if var_417_2 then
					var_417_2:EnableDynamicBone(false)
				end
			end

			local var_417_3 = 0.001

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_3 then
				var_417_1.localPosition = Vector3.Lerp(arg_414_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_414_1.time_ - 0) / var_417_3)
				var_417_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_1.position).x, (manager.ui.mainCamera.transform.position - var_417_1.position).y, (manager.ui.mainCamera.transform.position - var_417_1.position).z)
				var_417_1.localEulerAngles.z = 0
				var_417_1.localEulerAngles.x = 0
				var_417_1.localEulerAngles = var_417_1.localEulerAngles
			end

			if arg_414_1.time_ >= 0 + var_417_3 and arg_414_1.time_ < 0 + var_417_3 + arg_417_0 then
				var_417_1.localPosition = Vector3.New(0, 100, 0)
				var_417_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_417_1.position).x, (manager.ui.mainCamera.transform.position - var_417_1.position).y, (manager.ui.mainCamera.transform.position - var_417_1.position).z)
				var_417_1.localEulerAngles.z = 0
				var_417_1.localEulerAngles.x = 0
				var_417_1.localEulerAngles = var_417_1.localEulerAngles

				local var_417_4 = GameObjectTools.GetOrAddComponent(var_417_1.gameObject, typeof(DynamicBoneHelper))

				if var_417_4 then
					var_417_4:EnableDynamicBone(true)
				end
			end

			local var_417_5 = arg_414_1.actors_["1070ui_story"]

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= 0 + arg_417_0 and not isNil(var_417_5) and arg_414_1.var_.characterEffect1070ui_story == nil then
				arg_414_1.var_.characterEffect1070ui_story = var_417_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_417_6 = 0.200000002980232

			if 0 <= arg_414_1.time_ and arg_414_1.time_ < 0 + var_417_6 and not isNil(var_417_5) then
				if arg_414_1.var_.characterEffect1070ui_story and not isNil(var_417_5) then
					arg_414_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_414_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_414_1.time_ - 0) / var_417_6)
				end
			end

			if arg_414_1.time_ >= 0 + var_417_6 and arg_414_1.time_ < 0 + var_417_6 + arg_417_0 and not isNil(var_417_5) and arg_414_1.var_.characterEffect1070ui_story then
				arg_414_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_414_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_417_7 = 0
			local var_417_8 = 0.875

			if 0 < arg_414_1.time_ and arg_414_1.time_ <= var_417_7 + arg_417_0 then
				arg_414_1.talkMaxDuration = 0
				arg_414_1.dialogCg_.alpha = 1

				arg_414_1.dialog_:SetActive(true)
				SetActive(arg_414_1.leftNameGo_, false)

				arg_414_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_414_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_414_1:RecordName(arg_414_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_414_1.iconTrs_.gameObject, false)
				arg_414_1.callingController_:SetSelectedState("normal")

				local var_417_9 = arg_414_1:FormatText(arg_414_1:GetWordFromCfg(324081101).content)

				arg_414_1.text_.text = var_417_9

				LuaForUtil.ClearLinePrefixSymbol(arg_414_1.text_)

				local var_417_11 = 35 <= 0 and var_417_8 or var_417_8 * (utf8.len(var_417_9) / 35)

				if (35 <= 0 and var_417_8 or var_417_8 * (utf8.len(var_417_9) / 35)) > 0 and var_417_8 < var_417_11 then
					arg_414_1.talkMaxDuration = var_417_11

					if var_417_11 + var_417_7 > arg_414_1.duration_ then
						arg_414_1.duration_ = var_417_11 + var_417_7
					end
				end

				arg_414_1.text_.text = var_417_9
				arg_414_1.typewritter.percent = 0

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(false)
				arg_414_1:RecordContent(arg_414_1.text_.text)
			end

			local var_417_12 = math.max(var_417_8, arg_414_1.talkMaxDuration)

			if var_417_7 <= arg_414_1.time_ and arg_414_1.time_ < var_417_7 + var_417_12 then
				arg_414_1.typewritter.percent = (arg_414_1.time_ - var_417_7) / var_417_12

				arg_414_1.typewritter:SetDirty()
			end

			if arg_414_1.time_ >= var_417_7 + var_417_12 and arg_414_1.time_ < var_417_7 + var_417_12 + arg_417_0 then
				arg_414_1.typewritter.percent = 1

				arg_414_1.typewritter:SetDirty()
				arg_414_1:ShowNextGo(true)
			end
		end

		arg_414_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_414_1:InitPlayNodeList()
	end,
	Play324081102 = function(arg_418_0, arg_418_1)
		arg_418_1.time_ = 0
		arg_418_1.frameCnt_ = 0
		arg_418_1.state_ = "playing"
		arg_418_1.curTalkId_ = 324081102
		arg_418_1.duration_ = 8.67

		local var_418_0 = {
			zh = 8.066,
			ja = 8.666
		}
		local var_418_1 = manager.audio:GetLocalizationFlag()

		if var_418_0[var_418_1] ~= nil then
			arg_418_1.duration_ = var_418_0[var_418_1]
		end

		SetActive(arg_418_1.tipsGo_, false)

		function arg_418_1.onSingleLineFinish_()
			arg_418_1.onSingleLineUpdate_ = nil
			arg_418_1.onSingleLineFinish_ = nil
			arg_418_1.state_ = "waiting"
		end

		function arg_418_1.playNext_(arg_420_0)
			if arg_420_0 == 1 then
				arg_418_0:Play324081103(arg_418_1)
			end
		end

		function arg_418_1.onSingleLineUpdate_(arg_421_0)
			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1.var_.moveOldPos1070ui_story = arg_418_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_421_0 = 0.001

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_0 then
				arg_418_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_418_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_418_1.time_ - 0) / var_421_0)
				arg_418_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_418_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1070ui_story"].transform.position).z)
				arg_418_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_418_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_418_1.actors_["1070ui_story"].transform.localEulerAngles = arg_418_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_418_1.time_ >= 0 + var_421_0 and arg_418_1.time_ < 0 + var_421_0 + arg_421_0 then
				arg_418_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_418_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_418_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_418_1.actors_["1070ui_story"].transform.position).z)
				arg_418_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_418_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_418_1.actors_["1070ui_story"].transform.localEulerAngles = arg_418_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_421_1 = arg_418_1.actors_["1070ui_story"]

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 and not isNil(var_421_1) and arg_418_1.var_.characterEffect1070ui_story == nil then
				arg_418_1.var_.characterEffect1070ui_story = var_421_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_421_2 = 0.200000002980232

			if 0 <= arg_418_1.time_ and arg_418_1.time_ < 0 + var_421_2 and not isNil(var_421_1) then
				if arg_418_1.var_.characterEffect1070ui_story and not isNil(var_421_1) then
					arg_418_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_418_1.time_ >= 0 + var_421_2 and arg_418_1.time_ < 0 + var_421_2 + arg_421_0 and not isNil(var_421_1) and arg_418_1.var_.characterEffect1070ui_story then
				arg_418_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action2_2")
			end

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= 0 + arg_421_0 then
				arg_418_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_421_4 = 0
			local var_421_5 = 1

			if 0 < arg_418_1.time_ and arg_418_1.time_ <= var_421_4 + arg_421_0 then
				arg_418_1.talkMaxDuration = 0
				arg_418_1.dialogCg_.alpha = 1

				arg_418_1.dialog_:SetActive(true)
				SetActive(arg_418_1.leftNameGo_, true)

				arg_418_1.leftNameTxt_.text = arg_418_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_418_1.leftNameTxt_.transform)

				arg_418_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_418_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_418_1:RecordName(arg_418_1.leftNameTxt_.text)
				SetActive(arg_418_1.iconTrs_.gameObject, false)
				arg_418_1.callingController_:SetSelectedState("normal")

				local var_421_6 = arg_418_1:GetWordFromCfg(324081102)
				local var_421_7 = arg_418_1:FormatText(var_421_6.content)

				arg_418_1.text_.text = var_421_7

				LuaForUtil.ClearLinePrefixSymbol(arg_418_1.text_)

				local var_421_9 = 40 <= 0 and var_421_5 or var_421_5 * (utf8.len(var_421_7) / 40)

				if (40 <= 0 and var_421_5 or var_421_5 * (utf8.len(var_421_7) / 40)) > 0 and var_421_5 < var_421_9 then
					arg_418_1.talkMaxDuration = var_421_9

					if var_421_9 + var_421_4 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_9 + var_421_4
					end
				end

				arg_418_1.text_.text = var_421_7
				arg_418_1.typewritter.percent = 0

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081102", "story_v_out_324081.awb") ~= 0 then
					local var_421_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081102", "story_v_out_324081.awb") / 1000

					if var_421_10 + var_421_4 > arg_418_1.duration_ then
						arg_418_1.duration_ = var_421_10 + var_421_4
					end

					if var_421_6.prefab_name ~= "" and arg_418_1.actors_[var_421_6.prefab_name] ~= nil then
						local var_421_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_418_1.actors_[var_421_6.prefab_name].transform, "story_v_out_324081", "324081102", "story_v_out_324081.awb")

						arg_418_1:RecordAudio("324081102", var_421_11)
						arg_418_1:RecordAudio("324081102", var_421_11)
					else
						arg_418_1:AudioAction("play", "voice", "story_v_out_324081", "324081102", "story_v_out_324081.awb")
					end

					arg_418_1:RecordHistoryTalkVoice("story_v_out_324081", "324081102", "story_v_out_324081.awb")
				end

				arg_418_1:RecordContent(arg_418_1.text_.text)
			end

			local var_421_12 = math.max(var_421_5, arg_418_1.talkMaxDuration)

			if var_421_4 <= arg_418_1.time_ and arg_418_1.time_ < var_421_4 + var_421_12 then
				arg_418_1.typewritter.percent = (arg_418_1.time_ - var_421_4) / var_421_12

				arg_418_1.typewritter:SetDirty()
			end

			if arg_418_1.time_ >= var_421_4 + var_421_12 and arg_418_1.time_ < var_421_4 + var_421_12 + arg_421_0 then
				arg_418_1.typewritter.percent = 1

				arg_418_1.typewritter:SetDirty()
				arg_418_1:ShowNextGo(true)
			end
		end

		arg_418_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_418_1:InitPlayNodeList()
	end,
	Play324081103 = function(arg_422_0, arg_422_1)
		arg_422_1.time_ = 0
		arg_422_1.frameCnt_ = 0
		arg_422_1.state_ = "playing"
		arg_422_1.curTalkId_ = 324081103
		arg_422_1.duration_ = 2.63

		local var_422_0 = {
			zh = 2.366,
			ja = 2.633
		}
		local var_422_1 = manager.audio:GetLocalizationFlag()

		if var_422_0[var_422_1] ~= nil then
			arg_422_1.duration_ = var_422_0[var_422_1]
		end

		SetActive(arg_422_1.tipsGo_, false)

		function arg_422_1.onSingleLineFinish_()
			arg_422_1.onSingleLineUpdate_ = nil
			arg_422_1.onSingleLineFinish_ = nil
			arg_422_1.state_ = "waiting"
		end

		function arg_422_1.playNext_(arg_424_0)
			if arg_424_0 == 1 then
				arg_422_0:Play324081104(arg_422_1)
			end
		end

		function arg_422_1.onSingleLineUpdate_(arg_425_0)
			if 0 < arg_422_1.time_ and arg_422_1.time_ <= 0 + arg_425_0 and not isNil(arg_422_1.actors_["1070ui_story"]) and arg_422_1.var_.characterEffect1070ui_story == nil then
				arg_422_1.var_.characterEffect1070ui_story = arg_422_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_425_0 = 0.200000002980232

			if 0 <= arg_422_1.time_ and arg_422_1.time_ < 0 + var_425_0 and not isNil(arg_422_1.actors_["1070ui_story"]) then
				if arg_422_1.var_.characterEffect1070ui_story and not isNil(arg_422_1.actors_["1070ui_story"]) then
					arg_422_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_422_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_422_1.time_ - 0) / var_425_0)
				end
			end

			if arg_422_1.time_ >= 0 + var_425_0 and arg_422_1.time_ < 0 + var_425_0 + arg_425_0 and not isNil(arg_422_1.actors_["1070ui_story"]) and arg_422_1.var_.characterEffect1070ui_story then
				arg_422_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_422_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_425_1 = 0
			local var_425_2 = 0.225

			if 0 < arg_422_1.time_ and arg_422_1.time_ <= var_425_1 + arg_425_0 then
				arg_422_1.talkMaxDuration = 0
				arg_422_1.dialogCg_.alpha = 1

				arg_422_1.dialog_:SetActive(true)
				SetActive(arg_422_1.leftNameGo_, true)

				arg_422_1.leftNameTxt_.text = arg_422_1:FormatText(StoryNameCfg[1501].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_422_1.leftNameTxt_.transform)

				arg_422_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_422_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_422_1:RecordName(arg_422_1.leftNameTxt_.text)
				SetActive(arg_422_1.iconTrs_.gameObject, true)
				arg_422_1.iconController_:SetSelectedState("hero")

				arg_422_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_422_1.callingController_:SetSelectedState("normal")

				arg_422_1.keyicon_.color = Color.New(1, 1, 1)
				arg_422_1.icon_.color = Color.New(1, 1, 1)

				local var_425_3 = arg_422_1:GetWordFromCfg(324081103)
				local var_425_4 = arg_422_1:FormatText(var_425_3.content)

				arg_422_1.text_.text = var_425_4

				LuaForUtil.ClearLinePrefixSymbol(arg_422_1.text_)

				local var_425_6 = 9 <= 0 and var_425_2 or var_425_2 * (utf8.len(var_425_4) / 9)

				if (9 <= 0 and var_425_2 or var_425_2 * (utf8.len(var_425_4) / 9)) > 0 and var_425_2 < var_425_6 then
					arg_422_1.talkMaxDuration = var_425_6

					if var_425_6 + var_425_1 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_6 + var_425_1
					end
				end

				arg_422_1.text_.text = var_425_4
				arg_422_1.typewritter.percent = 0

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081103", "story_v_out_324081.awb") ~= 0 then
					local var_425_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081103", "story_v_out_324081.awb") / 1000

					if var_425_7 + var_425_1 > arg_422_1.duration_ then
						arg_422_1.duration_ = var_425_7 + var_425_1
					end

					if var_425_3.prefab_name ~= "" and arg_422_1.actors_[var_425_3.prefab_name] ~= nil then
						local var_425_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_422_1.actors_[var_425_3.prefab_name].transform, "story_v_out_324081", "324081103", "story_v_out_324081.awb")

						arg_422_1:RecordAudio("324081103", var_425_8)
						arg_422_1:RecordAudio("324081103", var_425_8)
					else
						arg_422_1:AudioAction("play", "voice", "story_v_out_324081", "324081103", "story_v_out_324081.awb")
					end

					arg_422_1:RecordHistoryTalkVoice("story_v_out_324081", "324081103", "story_v_out_324081.awb")
				end

				arg_422_1:RecordContent(arg_422_1.text_.text)
			end

			local var_425_9 = math.max(var_425_2, arg_422_1.talkMaxDuration)

			if var_425_1 <= arg_422_1.time_ and arg_422_1.time_ < var_425_1 + var_425_9 then
				arg_422_1.typewritter.percent = (arg_422_1.time_ - var_425_1) / var_425_9

				arg_422_1.typewritter:SetDirty()
			end

			if arg_422_1.time_ >= var_425_1 + var_425_9 and arg_422_1.time_ < var_425_1 + var_425_9 + arg_425_0 then
				arg_422_1.typewritter.percent = 1

				arg_422_1.typewritter:SetDirty()
				arg_422_1:ShowNextGo(true)
			end
		end

		arg_422_1.nodeConfigList_ = {}

		arg_422_1:InitPlayNodeList()
	end,
	Play324081104 = function(arg_426_0, arg_426_1)
		arg_426_1.time_ = 0
		arg_426_1.frameCnt_ = 0
		arg_426_1.state_ = "playing"
		arg_426_1.curTalkId_ = 324081104
		arg_426_1.duration_ = 2.2

		local var_426_0 = {
			zh = 1.966,
			ja = 2.2
		}
		local var_426_1 = manager.audio:GetLocalizationFlag()

		if var_426_0[var_426_1] ~= nil then
			arg_426_1.duration_ = var_426_0[var_426_1]
		end

		SetActive(arg_426_1.tipsGo_, false)

		function arg_426_1.onSingleLineFinish_()
			arg_426_1.onSingleLineUpdate_ = nil
			arg_426_1.onSingleLineFinish_ = nil
			arg_426_1.state_ = "waiting"
		end

		function arg_426_1.playNext_(arg_428_0)
			if arg_428_0 == 1 then
				arg_426_0:Play324081105(arg_426_1)
			end
		end

		function arg_426_1.onSingleLineUpdate_(arg_429_0)
			if 0 < arg_426_1.time_ and arg_426_1.time_ <= 0 + arg_429_0 and not isNil(arg_426_1.actors_["1070ui_story"]) and arg_426_1.var_.characterEffect1070ui_story == nil then
				arg_426_1.var_.characterEffect1070ui_story = arg_426_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_429_0 = 0.200000002980232

			if 0 <= arg_426_1.time_ and arg_426_1.time_ < 0 + var_429_0 and not isNil(arg_426_1.actors_["1070ui_story"]) then
				if arg_426_1.var_.characterEffect1070ui_story and not isNil(arg_426_1.actors_["1070ui_story"]) then
					arg_426_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_426_1.time_ >= 0 + var_429_0 and arg_426_1.time_ < 0 + var_429_0 + arg_429_0 and not isNil(arg_426_1.actors_["1070ui_story"]) and arg_426_1.var_.characterEffect1070ui_story then
				arg_426_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_429_2 = 0
			local var_429_3 = 0.125

			if 0 < arg_426_1.time_ and arg_426_1.time_ <= var_429_2 + arg_429_0 then
				arg_426_1.talkMaxDuration = 0
				arg_426_1.dialogCg_.alpha = 1

				arg_426_1.dialog_:SetActive(true)
				SetActive(arg_426_1.leftNameGo_, true)

				arg_426_1.leftNameTxt_.text = arg_426_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_426_1.leftNameTxt_.transform)

				arg_426_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_426_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_426_1:RecordName(arg_426_1.leftNameTxt_.text)
				SetActive(arg_426_1.iconTrs_.gameObject, false)
				arg_426_1.callingController_:SetSelectedState("normal")

				local var_429_4 = arg_426_1:GetWordFromCfg(324081104)
				local var_429_5 = arg_426_1:FormatText(var_429_4.content)

				arg_426_1.text_.text = var_429_5

				LuaForUtil.ClearLinePrefixSymbol(arg_426_1.text_)

				local var_429_7 = 5 <= 0 and var_429_3 or var_429_3 * (utf8.len(var_429_5) / 5)

				if (5 <= 0 and var_429_3 or var_429_3 * (utf8.len(var_429_5) / 5)) > 0 and var_429_3 < var_429_7 then
					arg_426_1.talkMaxDuration = var_429_7

					if var_429_7 + var_429_2 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_7 + var_429_2
					end
				end

				arg_426_1.text_.text = var_429_5
				arg_426_1.typewritter.percent = 0

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081104", "story_v_out_324081.awb") ~= 0 then
					local var_429_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081104", "story_v_out_324081.awb") / 1000

					if var_429_8 + var_429_2 > arg_426_1.duration_ then
						arg_426_1.duration_ = var_429_8 + var_429_2
					end

					if var_429_4.prefab_name ~= "" and arg_426_1.actors_[var_429_4.prefab_name] ~= nil then
						local var_429_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_426_1.actors_[var_429_4.prefab_name].transform, "story_v_out_324081", "324081104", "story_v_out_324081.awb")

						arg_426_1:RecordAudio("324081104", var_429_9)
						arg_426_1:RecordAudio("324081104", var_429_9)
					else
						arg_426_1:AudioAction("play", "voice", "story_v_out_324081", "324081104", "story_v_out_324081.awb")
					end

					arg_426_1:RecordHistoryTalkVoice("story_v_out_324081", "324081104", "story_v_out_324081.awb")
				end

				arg_426_1:RecordContent(arg_426_1.text_.text)
			end

			local var_429_10 = math.max(var_429_3, arg_426_1.talkMaxDuration)

			if var_429_2 <= arg_426_1.time_ and arg_426_1.time_ < var_429_2 + var_429_10 then
				arg_426_1.typewritter.percent = (arg_426_1.time_ - var_429_2) / var_429_10

				arg_426_1.typewritter:SetDirty()
			end

			if arg_426_1.time_ >= var_429_2 + var_429_10 and arg_426_1.time_ < var_429_2 + var_429_10 + arg_429_0 then
				arg_426_1.typewritter.percent = 1

				arg_426_1.typewritter:SetDirty()
				arg_426_1:ShowNextGo(true)
			end
		end

		arg_426_1.nodeConfigList_ = {}

		arg_426_1:InitPlayNodeList()
	end,
	Play324081105 = function(arg_430_0, arg_430_1)
		arg_430_1.time_ = 0
		arg_430_1.frameCnt_ = 0
		arg_430_1.state_ = "playing"
		arg_430_1.curTalkId_ = 324081105
		arg_430_1.duration_ = 5.9

		local var_430_0 = {
			zh = 4.533,
			ja = 5.9
		}
		local var_430_1 = manager.audio:GetLocalizationFlag()

		if var_430_0[var_430_1] ~= nil then
			arg_430_1.duration_ = var_430_0[var_430_1]
		end

		SetActive(arg_430_1.tipsGo_, false)

		function arg_430_1.onSingleLineFinish_()
			arg_430_1.onSingleLineUpdate_ = nil
			arg_430_1.onSingleLineFinish_ = nil
			arg_430_1.state_ = "waiting"
		end

		function arg_430_1.playNext_(arg_432_0)
			if arg_432_0 == 1 then
				arg_430_0:Play324081106(arg_430_1)
			end
		end

		function arg_430_1.onSingleLineUpdate_(arg_433_0)
			if 0 < arg_430_1.time_ and arg_430_1.time_ <= 0 + arg_433_0 and not isNil(arg_430_1.actors_["1070ui_story"]) and arg_430_1.var_.characterEffect1070ui_story == nil then
				arg_430_1.var_.characterEffect1070ui_story = arg_430_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_433_0 = 0.200000002980232

			if 0 <= arg_430_1.time_ and arg_430_1.time_ < 0 + var_433_0 and not isNil(arg_430_1.actors_["1070ui_story"]) then
				if arg_430_1.var_.characterEffect1070ui_story and not isNil(arg_430_1.actors_["1070ui_story"]) then
					arg_430_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_430_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_430_1.time_ - 0) / var_433_0)
				end
			end

			if arg_430_1.time_ >= 0 + var_433_0 and arg_430_1.time_ < 0 + var_433_0 + arg_433_0 and not isNil(arg_430_1.actors_["1070ui_story"]) and arg_430_1.var_.characterEffect1070ui_story then
				arg_430_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_430_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_433_1 = 0
			local var_433_2 = 0.55

			if 0 < arg_430_1.time_ and arg_430_1.time_ <= var_433_1 + arg_433_0 then
				arg_430_1.talkMaxDuration = 0
				arg_430_1.dialogCg_.alpha = 1

				arg_430_1.dialog_:SetActive(true)
				SetActive(arg_430_1.leftNameGo_, true)

				arg_430_1.leftNameTxt_.text = arg_430_1:FormatText(StoryNameCfg[1501].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_430_1.leftNameTxt_.transform)

				arg_430_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_430_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_430_1:RecordName(arg_430_1.leftNameTxt_.text)
				SetActive(arg_430_1.iconTrs_.gameObject, true)
				arg_430_1.iconController_:SetSelectedState("hero")

				arg_430_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_430_1.callingController_:SetSelectedState("normal")

				arg_430_1.keyicon_.color = Color.New(1, 1, 1)
				arg_430_1.icon_.color = Color.New(1, 1, 1)

				local var_433_3 = arg_430_1:GetWordFromCfg(324081105)
				local var_433_4 = arg_430_1:FormatText(var_433_3.content)

				arg_430_1.text_.text = var_433_4

				LuaForUtil.ClearLinePrefixSymbol(arg_430_1.text_)

				local var_433_6 = 22 <= 0 and var_433_2 or var_433_2 * (utf8.len(var_433_4) / 22)

				if (22 <= 0 and var_433_2 or var_433_2 * (utf8.len(var_433_4) / 22)) > 0 and var_433_2 < var_433_6 then
					arg_430_1.talkMaxDuration = var_433_6

					if var_433_6 + var_433_1 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_6 + var_433_1
					end
				end

				arg_430_1.text_.text = var_433_4
				arg_430_1.typewritter.percent = 0

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081105", "story_v_out_324081.awb") ~= 0 then
					local var_433_7 = manager.audio:GetVoiceLength("story_v_out_324081", "324081105", "story_v_out_324081.awb") / 1000

					if var_433_7 + var_433_1 > arg_430_1.duration_ then
						arg_430_1.duration_ = var_433_7 + var_433_1
					end

					if var_433_3.prefab_name ~= "" and arg_430_1.actors_[var_433_3.prefab_name] ~= nil then
						local var_433_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_430_1.actors_[var_433_3.prefab_name].transform, "story_v_out_324081", "324081105", "story_v_out_324081.awb")

						arg_430_1:RecordAudio("324081105", var_433_8)
						arg_430_1:RecordAudio("324081105", var_433_8)
					else
						arg_430_1:AudioAction("play", "voice", "story_v_out_324081", "324081105", "story_v_out_324081.awb")
					end

					arg_430_1:RecordHistoryTalkVoice("story_v_out_324081", "324081105", "story_v_out_324081.awb")
				end

				arg_430_1:RecordContent(arg_430_1.text_.text)
			end

			local var_433_9 = math.max(var_433_2, arg_430_1.talkMaxDuration)

			if var_433_1 <= arg_430_1.time_ and arg_430_1.time_ < var_433_1 + var_433_9 then
				arg_430_1.typewritter.percent = (arg_430_1.time_ - var_433_1) / var_433_9

				arg_430_1.typewritter:SetDirty()
			end

			if arg_430_1.time_ >= var_433_1 + var_433_9 and arg_430_1.time_ < var_433_1 + var_433_9 + arg_433_0 then
				arg_430_1.typewritter.percent = 1

				arg_430_1.typewritter:SetDirty()
				arg_430_1:ShowNextGo(true)
			end
		end

		arg_430_1.nodeConfigList_ = {}

		arg_430_1:InitPlayNodeList()
	end,
	Play324081106 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 324081106
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play324081107(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.var_.moveOldPos1070ui_story = arg_434_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_437_0 = 0.001

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_0 then
				arg_434_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_434_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_434_1.time_ - 0) / var_437_0)
				arg_434_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1070ui_story"].transform.position).z)
				arg_434_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["1070ui_story"].transform.localEulerAngles = arg_434_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_434_1.time_ >= 0 + var_437_0 and arg_434_1.time_ < 0 + var_437_0 + arg_437_0 then
				arg_434_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_434_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_434_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_434_1.actors_["1070ui_story"].transform.position).z)
				arg_434_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_434_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_434_1.actors_["1070ui_story"].transform.localEulerAngles = arg_434_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_437_1 = 0
			local var_437_2 = 1.1

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= var_437_1 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_3 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(324081106).content)

				arg_434_1.text_.text = var_437_3

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_5 = 44 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_3) / 44)

				if (44 <= 0 and var_437_2 or var_437_2 * (utf8.len(var_437_3) / 44)) > 0 and var_437_2 < var_437_5 then
					arg_434_1.talkMaxDuration = var_437_5

					if var_437_5 + var_437_1 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_5 + var_437_1
					end
				end

				arg_434_1.text_.text = var_437_3
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_6 = math.max(var_437_2, arg_434_1.talkMaxDuration)

			if var_437_1 <= arg_434_1.time_ and arg_434_1.time_ < var_437_1 + var_437_6 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - var_437_1) / var_437_6

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= var_437_1 + var_437_6 and arg_434_1.time_ < var_437_1 + var_437_6 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_434_1:InitPlayNodeList()
	end,
	Play324081107 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 324081107
		arg_438_1.duration_ = 9.63

		local var_438_0 = {
			zh = 8.133,
			ja = 9.633
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play324081108(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			local var_441_0 = 0.975

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, true)
				arg_438_1.iconController_:SetSelectedState("hero")

				arg_438_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_438_1.callingController_:SetSelectedState("normal")

				arg_438_1.keyicon_.color = Color.New(1, 1, 1)
				arg_438_1.icon_.color = Color.New(1, 1, 1)

				local var_441_1 = arg_438_1:GetWordFromCfg(324081107)
				local var_441_2 = arg_438_1:FormatText(var_441_1.content)

				arg_438_1.text_.text = var_441_2

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_4 = 39 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 39)

				if (39 <= 0 and var_441_0 or var_441_0 * (utf8.len(var_441_2) / 39)) > 0 and var_441_0 < var_441_4 then
					arg_438_1.talkMaxDuration = var_441_4

					if var_441_4 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_4 + 0
					end
				end

				arg_438_1.text_.text = var_441_2
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081107", "story_v_out_324081.awb") ~= 0 then
					local var_441_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081107", "story_v_out_324081.awb") / 1000

					if var_441_5 + 0 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_5 + 0
					end

					if var_441_1.prefab_name ~= "" and arg_438_1.actors_[var_441_1.prefab_name] ~= nil then
						local var_441_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_1.prefab_name].transform, "story_v_out_324081", "324081107", "story_v_out_324081.awb")

						arg_438_1:RecordAudio("324081107", var_441_6)
						arg_438_1:RecordAudio("324081107", var_441_6)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_324081", "324081107", "story_v_out_324081.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_324081", "324081107", "story_v_out_324081.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_7 = math.max(var_441_0, arg_438_1.talkMaxDuration)

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_7 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - 0) / var_441_7

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= 0 + var_441_7 and arg_438_1.time_ < 0 + var_441_7 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {}

		arg_438_1:InitPlayNodeList()
	end,
	Play324081108 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 324081108
		arg_442_1.duration_ = 2.53

		local var_442_0 = {
			zh = 2.3,
			ja = 2.533
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play324081109(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			local var_445_0 = 0.175

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[1501].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, true)
				arg_442_1.iconController_:SetSelectedState("hero")

				arg_442_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_442_1.callingController_:SetSelectedState("normal")

				arg_442_1.keyicon_.color = Color.New(1, 1, 1)
				arg_442_1.icon_.color = Color.New(1, 1, 1)

				local var_445_1 = arg_442_1:GetWordFromCfg(324081108)
				local var_445_2 = arg_442_1:FormatText(var_445_1.content)

				arg_442_1.text_.text = var_445_2

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_4 = 7 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 7)

				if (7 <= 0 and var_445_0 or var_445_0 * (utf8.len(var_445_2) / 7)) > 0 and var_445_0 < var_445_4 then
					arg_442_1.talkMaxDuration = var_445_4

					if var_445_4 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_4 + 0
					end
				end

				arg_442_1.text_.text = var_445_2
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081108", "story_v_out_324081.awb") ~= 0 then
					local var_445_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081108", "story_v_out_324081.awb") / 1000

					if var_445_5 + 0 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_5 + 0
					end

					if var_445_1.prefab_name ~= "" and arg_442_1.actors_[var_445_1.prefab_name] ~= nil then
						local var_445_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_1.prefab_name].transform, "story_v_out_324081", "324081108", "story_v_out_324081.awb")

						arg_442_1:RecordAudio("324081108", var_445_6)
						arg_442_1:RecordAudio("324081108", var_445_6)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_324081", "324081108", "story_v_out_324081.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_324081", "324081108", "story_v_out_324081.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_7 = math.max(var_445_0, arg_442_1.talkMaxDuration)

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_7 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - 0) / var_445_7

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= 0 + var_445_7 and arg_442_1.time_ < 0 + var_445_7 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {}

		arg_442_1:InitPlayNodeList()
	end,
	Play324081109 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 324081109
		arg_446_1.duration_ = 3.73

		local var_446_0 = {
			zh = 3.533,
			ja = 3.733
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play324081110(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			local var_449_0 = 0.35

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, true)
				arg_446_1.iconController_:SetSelectedState("hero")

				arg_446_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_446_1.callingController_:SetSelectedState("normal")

				arg_446_1.keyicon_.color = Color.New(1, 1, 1)
				arg_446_1.icon_.color = Color.New(1, 1, 1)

				local var_449_1 = arg_446_1:GetWordFromCfg(324081109)
				local var_449_2 = arg_446_1:FormatText(var_449_1.content)

				arg_446_1.text_.text = var_449_2

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_4 = 14 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 14)

				if (14 <= 0 and var_449_0 or var_449_0 * (utf8.len(var_449_2) / 14)) > 0 and var_449_0 < var_449_4 then
					arg_446_1.talkMaxDuration = var_449_4

					if var_449_4 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_4 + 0
					end
				end

				arg_446_1.text_.text = var_449_2
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081109", "story_v_out_324081.awb") ~= 0 then
					local var_449_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081109", "story_v_out_324081.awb") / 1000

					if var_449_5 + 0 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_5 + 0
					end

					if var_449_1.prefab_name ~= "" and arg_446_1.actors_[var_449_1.prefab_name] ~= nil then
						local var_449_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_1.prefab_name].transform, "story_v_out_324081", "324081109", "story_v_out_324081.awb")

						arg_446_1:RecordAudio("324081109", var_449_6)
						arg_446_1:RecordAudio("324081109", var_449_6)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_324081", "324081109", "story_v_out_324081.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_324081", "324081109", "story_v_out_324081.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_7 = math.max(var_449_0, arg_446_1.talkMaxDuration)

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_7 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - 0) / var_449_7

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= 0 + var_449_7 and arg_446_1.time_ < 0 + var_449_7 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play324081110 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 324081110
		arg_450_1.duration_ = 6.73

		local var_450_0 = {
			zh = 4.366,
			ja = 6.733
		}
		local var_450_1 = manager.audio:GetLocalizationFlag()

		if var_450_0[var_450_1] ~= nil then
			arg_450_1.duration_ = var_450_0[var_450_1]
		end

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play324081111(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			local var_453_0 = 0.575

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, true)

				arg_450_1.leftNameTxt_.text = arg_450_1:FormatText(StoryNameCfg[1501].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_450_1.leftNameTxt_.transform)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1.leftNameTxt_.text)
				SetActive(arg_450_1.iconTrs_.gameObject, true)
				arg_450_1.iconController_:SetSelectedState("hero")

				arg_450_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_450_1.callingController_:SetSelectedState("normal")

				arg_450_1.keyicon_.color = Color.New(1, 1, 1)
				arg_450_1.icon_.color = Color.New(1, 1, 1)

				local var_453_1 = arg_450_1:GetWordFromCfg(324081110)
				local var_453_2 = arg_450_1:FormatText(var_453_1.content)

				arg_450_1.text_.text = var_453_2

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_4 = 23 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 23)

				if (23 <= 0 and var_453_0 or var_453_0 * (utf8.len(var_453_2) / 23)) > 0 and var_453_0 < var_453_4 then
					arg_450_1.talkMaxDuration = var_453_4

					if var_453_4 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_4 + 0
					end
				end

				arg_450_1.text_.text = var_453_2
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081110", "story_v_out_324081.awb") ~= 0 then
					local var_453_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081110", "story_v_out_324081.awb") / 1000

					if var_453_5 + 0 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + 0
					end

					if var_453_1.prefab_name ~= "" and arg_450_1.actors_[var_453_1.prefab_name] ~= nil then
						local var_453_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_450_1.actors_[var_453_1.prefab_name].transform, "story_v_out_324081", "324081110", "story_v_out_324081.awb")

						arg_450_1:RecordAudio("324081110", var_453_6)
						arg_450_1:RecordAudio("324081110", var_453_6)
					else
						arg_450_1:AudioAction("play", "voice", "story_v_out_324081", "324081110", "story_v_out_324081.awb")
					end

					arg_450_1:RecordHistoryTalkVoice("story_v_out_324081", "324081110", "story_v_out_324081.awb")
				end

				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_7 = math.max(var_453_0, arg_450_1.talkMaxDuration)

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_7 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - 0) / var_453_7

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= 0 + var_453_7 and arg_450_1.time_ < 0 + var_453_7 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play324081111 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 324081111
		arg_454_1.duration_ = 3.73

		local var_454_0 = {
			zh = 1.9,
			ja = 3.733
		}
		local var_454_1 = manager.audio:GetLocalizationFlag()

		if var_454_0[var_454_1] ~= nil then
			arg_454_1.duration_ = var_454_0[var_454_1]
		end

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play324081112(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 and not isNil(arg_454_1.actors_["1070ui_story"]) and arg_454_1.var_.characterEffect1070ui_story == nil then
				arg_454_1.var_.characterEffect1070ui_story = arg_454_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_457_0 = 0.200000002980232

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_0 and not isNil(arg_454_1.actors_["1070ui_story"]) then
				if arg_454_1.var_.characterEffect1070ui_story and not isNil(arg_454_1.actors_["1070ui_story"]) then
					arg_454_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_454_1.time_ >= 0 + var_457_0 and arg_454_1.time_ < 0 + var_457_0 + arg_457_0 and not isNil(arg_454_1.actors_["1070ui_story"]) and arg_454_1.var_.characterEffect1070ui_story then
				arg_454_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_457_2 = 0
			local var_457_3 = 0.25

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= var_457_2 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0
				arg_454_1.dialogCg_.alpha = 1

				arg_454_1.dialog_:SetActive(true)
				SetActive(arg_454_1.leftNameGo_, true)

				arg_454_1.leftNameTxt_.text = arg_454_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_454_1.leftNameTxt_.transform)

				arg_454_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_454_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_454_1:RecordName(arg_454_1.leftNameTxt_.text)
				SetActive(arg_454_1.iconTrs_.gameObject, true)
				arg_454_1.iconController_:SetSelectedState("hero")

				arg_454_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_454_1.callingController_:SetSelectedState("normal")

				arg_454_1.keyicon_.color = Color.New(1, 1, 1)
				arg_454_1.icon_.color = Color.New(1, 1, 1)

				local var_457_4 = arg_454_1:GetWordFromCfg(324081111)
				local var_457_5 = arg_454_1:FormatText(var_457_4.content)

				arg_454_1.text_.text = var_457_5

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.text_)

				local var_457_7 = 10 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 10)

				if (10 <= 0 and var_457_3 or var_457_3 * (utf8.len(var_457_5) / 10)) > 0 and var_457_3 < var_457_7 then
					arg_454_1.talkMaxDuration = var_457_7

					if var_457_7 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_7 + var_457_2
					end
				end

				arg_454_1.text_.text = var_457_5
				arg_454_1.typewritter.percent = 0

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081111", "story_v_out_324081.awb") ~= 0 then
					local var_457_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081111", "story_v_out_324081.awb") / 1000

					if var_457_8 + var_457_2 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_8 + var_457_2
					end

					if var_457_4.prefab_name ~= "" and arg_454_1.actors_[var_457_4.prefab_name] ~= nil then
						local var_457_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_454_1.actors_[var_457_4.prefab_name].transform, "story_v_out_324081", "324081111", "story_v_out_324081.awb")

						arg_454_1:RecordAudio("324081111", var_457_9)
						arg_454_1:RecordAudio("324081111", var_457_9)
					else
						arg_454_1:AudioAction("play", "voice", "story_v_out_324081", "324081111", "story_v_out_324081.awb")
					end

					arg_454_1:RecordHistoryTalkVoice("story_v_out_324081", "324081111", "story_v_out_324081.awb")
				end

				arg_454_1:RecordContent(arg_454_1.text_.text)
			end

			local var_457_10 = math.max(var_457_3, arg_454_1.talkMaxDuration)

			if var_457_2 <= arg_454_1.time_ and arg_454_1.time_ < var_457_2 + var_457_10 then
				arg_454_1.typewritter.percent = (arg_454_1.time_ - var_457_2) / var_457_10

				arg_454_1.typewritter:SetDirty()
			end

			if arg_454_1.time_ >= var_457_2 + var_457_10 and arg_454_1.time_ < var_457_2 + var_457_10 + arg_457_0 then
				arg_454_1.typewritter.percent = 1

				arg_454_1.typewritter:SetDirty()
				arg_454_1:ShowNextGo(true)
			end
		end

		arg_454_1.nodeConfigList_ = {}

		arg_454_1:InitPlayNodeList()
	end,
	Play324081112 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 324081112
		arg_458_1.duration_ = 5

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play324081113(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 and not isNil(arg_458_1.actors_["1070ui_story"]) and arg_458_1.var_.characterEffect1070ui_story == nil then
				arg_458_1.var_.characterEffect1070ui_story = arg_458_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_461_0 = 0.200000002980232

			if 0 <= arg_458_1.time_ and arg_458_1.time_ < 0 + var_461_0 and not isNil(arg_458_1.actors_["1070ui_story"]) then
				if arg_458_1.var_.characterEffect1070ui_story and not isNil(arg_458_1.actors_["1070ui_story"]) then
					arg_458_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_458_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_458_1.time_ - 0) / var_461_0)
				end
			end

			if arg_458_1.time_ >= 0 + var_461_0 and arg_458_1.time_ < 0 + var_461_0 + arg_461_0 and not isNil(arg_458_1.actors_["1070ui_story"]) and arg_458_1.var_.characterEffect1070ui_story then
				arg_458_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_458_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_461_1 = 0
			local var_461_2 = 0.95

			if 0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_1 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0
				arg_458_1.dialogCg_.alpha = 1

				arg_458_1.dialog_:SetActive(true)
				SetActive(arg_458_1.leftNameGo_, false)

				arg_458_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_458_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_458_1:RecordName(arg_458_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_458_1.iconTrs_.gameObject, false)
				arg_458_1.callingController_:SetSelectedState("normal")

				local var_461_3 = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(324081112).content)

				arg_458_1.text_.text = var_461_3

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.text_)

				local var_461_5 = 38 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 38)

				if (38 <= 0 and var_461_2 or var_461_2 * (utf8.len(var_461_3) / 38)) > 0 and var_461_2 < var_461_5 then
					arg_458_1.talkMaxDuration = var_461_5

					if var_461_5 + var_461_1 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_5 + var_461_1
					end
				end

				arg_458_1.text_.text = var_461_3
				arg_458_1.typewritter.percent = 0

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(false)
				arg_458_1:RecordContent(arg_458_1.text_.text)
			end

			local var_461_6 = math.max(var_461_2, arg_458_1.talkMaxDuration)

			if var_461_1 <= arg_458_1.time_ and arg_458_1.time_ < var_461_1 + var_461_6 then
				arg_458_1.typewritter.percent = (arg_458_1.time_ - var_461_1) / var_461_6

				arg_458_1.typewritter:SetDirty()
			end

			if arg_458_1.time_ >= var_461_1 + var_461_6 and arg_458_1.time_ < var_461_1 + var_461_6 + arg_461_0 then
				arg_458_1.typewritter.percent = 1

				arg_458_1.typewritter:SetDirty()
				arg_458_1:ShowNextGo(true)
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play324081113 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 324081113
		arg_462_1.duration_ = 5

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play324081114(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			local var_465_0 = 1.675

			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0
				arg_462_1.dialogCg_.alpha = 1

				arg_462_1.dialog_:SetActive(true)
				SetActive(arg_462_1.leftNameGo_, false)

				arg_462_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_462_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_462_1:RecordName(arg_462_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_462_1.iconTrs_.gameObject, false)
				arg_462_1.callingController_:SetSelectedState("normal")

				local var_465_1 = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(324081113).content)

				arg_462_1.text_.text = var_465_1

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.text_)

				local var_465_3 = 67 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 67)

				if (67 <= 0 and var_465_0 or var_465_0 * (utf8.len(var_465_1) / 67)) > 0 and var_465_0 < var_465_3 then
					arg_462_1.talkMaxDuration = var_465_3

					if var_465_3 + 0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_3 + 0
					end
				end

				arg_462_1.text_.text = var_465_1
				arg_462_1.typewritter.percent = 0

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(false)
				arg_462_1:RecordContent(arg_462_1.text_.text)
			end

			local var_465_4 = math.max(var_465_0, arg_462_1.talkMaxDuration)

			if 0 <= arg_462_1.time_ and arg_462_1.time_ < 0 + var_465_4 then
				arg_462_1.typewritter.percent = (arg_462_1.time_ - 0) / var_465_4

				arg_462_1.typewritter:SetDirty()
			end

			if arg_462_1.time_ >= 0 + var_465_4 and arg_462_1.time_ < 0 + var_465_4 + arg_465_0 then
				arg_462_1.typewritter.percent = 1

				arg_462_1.typewritter:SetDirty()
				arg_462_1:ShowNextGo(true)
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play324081114 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 324081114
		arg_466_1.duration_ = 2

		local var_466_0 = {
			zh = 2,
			ja = 1.2
		}
		local var_466_1 = manager.audio:GetLocalizationFlag()

		if var_466_0[var_466_1] ~= nil then
			arg_466_1.duration_ = var_466_0[var_466_1]
		end

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play324081115(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 and not isNil(arg_466_1.actors_["1070ui_story"]) and arg_466_1.var_.characterEffect1070ui_story == nil then
				arg_466_1.var_.characterEffect1070ui_story = arg_466_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_469_0 = 0.200000002980232

			if 0 <= arg_466_1.time_ and arg_466_1.time_ < 0 + var_469_0 and not isNil(arg_466_1.actors_["1070ui_story"]) then
				if arg_466_1.var_.characterEffect1070ui_story and not isNil(arg_466_1.actors_["1070ui_story"]) then
					arg_466_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_466_1.time_ >= 0 + var_469_0 and arg_466_1.time_ < 0 + var_469_0 + arg_469_0 and not isNil(arg_466_1.actors_["1070ui_story"]) and arg_466_1.var_.characterEffect1070ui_story then
				arg_466_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_469_2 = 0
			local var_469_3 = 0.125

			if 0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_2 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0
				arg_466_1.dialogCg_.alpha = 1

				arg_466_1.dialog_:SetActive(true)
				SetActive(arg_466_1.leftNameGo_, true)

				arg_466_1.leftNameTxt_.text = arg_466_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_466_1.leftNameTxt_.transform)

				arg_466_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_466_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_466_1:RecordName(arg_466_1.leftNameTxt_.text)
				SetActive(arg_466_1.iconTrs_.gameObject, true)
				arg_466_1.iconController_:SetSelectedState("hero")

				arg_466_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_466_1.callingController_:SetSelectedState("normal")

				arg_466_1.keyicon_.color = Color.New(1, 1, 1)
				arg_466_1.icon_.color = Color.New(1, 1, 1)

				local var_469_4 = arg_466_1:GetWordFromCfg(324081114)
				local var_469_5 = arg_466_1:FormatText(var_469_4.content)

				arg_466_1.text_.text = var_469_5

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.text_)

				local var_469_7 = 5 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_5) / 5)

				if (5 <= 0 and var_469_3 or var_469_3 * (utf8.len(var_469_5) / 5)) > 0 and var_469_3 < var_469_7 then
					arg_466_1.talkMaxDuration = var_469_7

					if var_469_7 + var_469_2 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_7 + var_469_2
					end
				end

				arg_466_1.text_.text = var_469_5
				arg_466_1.typewritter.percent = 0

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081114", "story_v_out_324081.awb") ~= 0 then
					local var_469_8 = manager.audio:GetVoiceLength("story_v_out_324081", "324081114", "story_v_out_324081.awb") / 1000

					if var_469_8 + var_469_2 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_8 + var_469_2
					end

					if var_469_4.prefab_name ~= "" and arg_466_1.actors_[var_469_4.prefab_name] ~= nil then
						local var_469_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_466_1.actors_[var_469_4.prefab_name].transform, "story_v_out_324081", "324081114", "story_v_out_324081.awb")

						arg_466_1:RecordAudio("324081114", var_469_9)
						arg_466_1:RecordAudio("324081114", var_469_9)
					else
						arg_466_1:AudioAction("play", "voice", "story_v_out_324081", "324081114", "story_v_out_324081.awb")
					end

					arg_466_1:RecordHistoryTalkVoice("story_v_out_324081", "324081114", "story_v_out_324081.awb")
				end

				arg_466_1:RecordContent(arg_466_1.text_.text)
			end

			local var_469_10 = math.max(var_469_3, arg_466_1.talkMaxDuration)

			if var_469_2 <= arg_466_1.time_ and arg_466_1.time_ < var_469_2 + var_469_10 then
				arg_466_1.typewritter.percent = (arg_466_1.time_ - var_469_2) / var_469_10

				arg_466_1.typewritter:SetDirty()
			end

			if arg_466_1.time_ >= var_469_2 + var_469_10 and arg_466_1.time_ < var_469_2 + var_469_10 + arg_469_0 then
				arg_466_1.typewritter.percent = 1

				arg_466_1.typewritter:SetDirty()
				arg_466_1:ShowNextGo(true)
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play324081115 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 324081115
		arg_470_1.duration_ = 5

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play324081116(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 and not isNil(arg_470_1.actors_["1070ui_story"]) and arg_470_1.var_.characterEffect1070ui_story == nil then
				arg_470_1.var_.characterEffect1070ui_story = arg_470_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_0 = 0.200000002980232

			if 0 <= arg_470_1.time_ and arg_470_1.time_ < 0 + var_473_0 and not isNil(arg_470_1.actors_["1070ui_story"]) then
				if arg_470_1.var_.characterEffect1070ui_story and not isNil(arg_470_1.actors_["1070ui_story"]) then
					arg_470_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_470_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_470_1.time_ - 0) / var_473_0)
				end
			end

			if arg_470_1.time_ >= 0 + var_473_0 and arg_470_1.time_ < 0 + var_473_0 + arg_473_0 and not isNil(arg_470_1.actors_["1070ui_story"]) and arg_470_1.var_.characterEffect1070ui_story then
				arg_470_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_470_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0.6 < arg_470_1.time_ and arg_470_1.time_ <= 0.6 + arg_473_0 then
				arg_470_1:AudioAction("play", "effect", "se_story_150", "se_story_150_marble01", "")
			end

			local var_473_2 = 0
			local var_473_3 = 1.225

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= var_473_2 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, false)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_4 = arg_470_1:FormatText(arg_470_1:GetWordFromCfg(324081115).content)

				arg_470_1.text_.text = var_473_4

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_6 = 49 <= 0 and var_473_3 or var_473_3 * (utf8.len(var_473_4) / 49)

				if (49 <= 0 and var_473_3 or var_473_3 * (utf8.len(var_473_4) / 49)) > 0 and var_473_3 < var_473_6 then
					arg_470_1.talkMaxDuration = var_473_6

					if var_473_6 + var_473_2 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_6 + var_473_2
					end
				end

				arg_470_1.text_.text = var_473_4
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)
				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_7 = math.max(var_473_3, arg_470_1.talkMaxDuration)

			if var_473_2 <= arg_470_1.time_ and arg_470_1.time_ < var_473_2 + var_473_7 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_2) / var_473_7

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_2 + var_473_7 and arg_470_1.time_ < var_473_2 + var_473_7 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {}

		arg_470_1:InitPlayNodeList()
	end,
	Play324081116 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 324081116
		arg_474_1.duration_ = 2

		local var_474_0 = {
			zh = 1.3,
			ja = 2
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play324081117(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			local var_477_0 = 0.1

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[1501].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, true)
				arg_474_1.iconController_:SetSelectedState("hero")

				arg_474_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_474_1.callingController_:SetSelectedState("normal")

				arg_474_1.keyicon_.color = Color.New(1, 1, 1)
				arg_474_1.icon_.color = Color.New(1, 1, 1)

				local var_477_1 = arg_474_1:GetWordFromCfg(324081116)
				local var_477_2 = arg_474_1:FormatText(var_477_1.content)

				arg_474_1.text_.text = var_477_2

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_4 = 4 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_2) / 4)

				if (4 <= 0 and var_477_0 or var_477_0 * (utf8.len(var_477_2) / 4)) > 0 and var_477_0 < var_477_4 then
					arg_474_1.talkMaxDuration = var_477_4

					if var_477_4 + 0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_4 + 0
					end
				end

				arg_474_1.text_.text = var_477_2
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081116", "story_v_out_324081.awb") ~= 0 then
					local var_477_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081116", "story_v_out_324081.awb") / 1000

					if var_477_5 + 0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_5 + 0
					end

					if var_477_1.prefab_name ~= "" and arg_474_1.actors_[var_477_1.prefab_name] ~= nil then
						local var_477_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_1.prefab_name].transform, "story_v_out_324081", "324081116", "story_v_out_324081.awb")

						arg_474_1:RecordAudio("324081116", var_477_6)
						arg_474_1:RecordAudio("324081116", var_477_6)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_324081", "324081116", "story_v_out_324081.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_324081", "324081116", "story_v_out_324081.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_7 = math.max(var_477_0, arg_474_1.talkMaxDuration)

			if 0 <= arg_474_1.time_ and arg_474_1.time_ < 0 + var_477_7 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - 0) / var_477_7

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= 0 + var_477_7 and arg_474_1.time_ < 0 + var_477_7 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play324081117 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 324081117
		arg_478_1.duration_ = 5

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play324081118(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 1 < arg_478_1.time_ and arg_478_1.time_ <= 1 + arg_481_0 then
				arg_478_1:AudioAction("play", "effect", "se_story_150", "se_story_150_marble02", "")
			end

			local var_481_1 = 0
			local var_481_2 = 1.45

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_1 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, false)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_3 = arg_478_1:FormatText(arg_478_1:GetWordFromCfg(324081117).content)

				arg_478_1.text_.text = var_481_3

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_5 = 58 <= 0 and var_481_2 or var_481_2 * (utf8.len(var_481_3) / 58)

				if (58 <= 0 and var_481_2 or var_481_2 * (utf8.len(var_481_3) / 58)) > 0 and var_481_2 < var_481_5 then
					arg_478_1.talkMaxDuration = var_481_5

					if var_481_5 + var_481_1 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_5 + var_481_1
					end
				end

				arg_478_1.text_.text = var_481_3
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)
				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_6 = math.max(var_481_2, arg_478_1.talkMaxDuration)

			if var_481_1 <= arg_478_1.time_ and arg_478_1.time_ < var_481_1 + var_481_6 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_1) / var_481_6

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_1 + var_481_6 and arg_478_1.time_ < var_481_1 + var_481_6 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play324081118 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 324081118
		arg_482_1.duration_ = 3

		local var_482_0 = {
			zh = 2.6,
			ja = 3
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play324081119(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			local var_485_0 = 0.3

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[1501].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, true)
				arg_482_1.iconController_:SetSelectedState("hero")

				arg_482_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_researchera")

				arg_482_1.callingController_:SetSelectedState("normal")

				arg_482_1.keyicon_.color = Color.New(1, 1, 1)
				arg_482_1.icon_.color = Color.New(1, 1, 1)

				local var_485_1 = arg_482_1:GetWordFromCfg(324081118)
				local var_485_2 = arg_482_1:FormatText(var_485_1.content)

				arg_482_1.text_.text = var_485_2

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_4 = 12 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 12)

				if (12 <= 0 and var_485_0 or var_485_0 * (utf8.len(var_485_2) / 12)) > 0 and var_485_0 < var_485_4 then
					arg_482_1.talkMaxDuration = var_485_4

					if var_485_4 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_4 + 0
					end
				end

				arg_482_1.text_.text = var_485_2
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081118", "story_v_out_324081.awb") ~= 0 then
					local var_485_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081118", "story_v_out_324081.awb") / 1000

					if var_485_5 + 0 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_5 + 0
					end

					if var_485_1.prefab_name ~= "" and arg_482_1.actors_[var_485_1.prefab_name] ~= nil then
						local var_485_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_1.prefab_name].transform, "story_v_out_324081", "324081118", "story_v_out_324081.awb")

						arg_482_1:RecordAudio("324081118", var_485_6)
						arg_482_1:RecordAudio("324081118", var_485_6)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_324081", "324081118", "story_v_out_324081.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_324081", "324081118", "story_v_out_324081.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_7 = math.max(var_485_0, arg_482_1.talkMaxDuration)

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_7 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - 0) / var_485_7

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= 0 + var_485_7 and arg_482_1.time_ < 0 + var_485_7 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play324081119 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 324081119
		arg_486_1.duration_ = 3.43

		local var_486_0 = {
			zh = 2.2,
			ja = 3.433
		}
		local var_486_1 = manager.audio:GetLocalizationFlag()

		if var_486_0[var_486_1] ~= nil then
			arg_486_1.duration_ = var_486_0[var_486_1]
		end

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play324081120(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			local var_489_0 = 0.125

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, true)

				arg_486_1.leftNameTxt_.text = arg_486_1:FormatText(StoryNameCfg[1468].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_486_1.leftNameTxt_.transform)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1.leftNameTxt_.text)
				SetActive(arg_486_1.iconTrs_.gameObject, true)
				arg_486_1.iconController_:SetSelectedState("hero")

				arg_486_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_citizenma")

				arg_486_1.callingController_:SetSelectedState("normal")

				arg_486_1.keyicon_.color = Color.New(1, 1, 1)
				arg_486_1.icon_.color = Color.New(1, 1, 1)

				local var_489_1 = arg_486_1:GetWordFromCfg(324081119)
				local var_489_2 = arg_486_1:FormatText(var_489_1.content)

				arg_486_1.text_.text = var_489_2

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_4 = 5 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_2) / 5)

				if (5 <= 0 and var_489_0 or var_489_0 * (utf8.len(var_489_2) / 5)) > 0 and var_489_0 < var_489_4 then
					arg_486_1.talkMaxDuration = var_489_4

					if var_489_4 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_4 + 0
					end
				end

				arg_486_1.text_.text = var_489_2
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081119", "story_v_out_324081.awb") ~= 0 then
					local var_489_5 = manager.audio:GetVoiceLength("story_v_out_324081", "324081119", "story_v_out_324081.awb") / 1000

					if var_489_5 + 0 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_5 + 0
					end

					if var_489_1.prefab_name ~= "" and arg_486_1.actors_[var_489_1.prefab_name] ~= nil then
						local var_489_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_486_1.actors_[var_489_1.prefab_name].transform, "story_v_out_324081", "324081119", "story_v_out_324081.awb")

						arg_486_1:RecordAudio("324081119", var_489_6)
						arg_486_1:RecordAudio("324081119", var_489_6)
					else
						arg_486_1:AudioAction("play", "voice", "story_v_out_324081", "324081119", "story_v_out_324081.awb")
					end

					arg_486_1:RecordHistoryTalkVoice("story_v_out_324081", "324081119", "story_v_out_324081.awb")
				end

				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_7 = math.max(var_489_0, arg_486_1.talkMaxDuration)

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_7 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - 0) / var_489_7

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= 0 + var_489_7 and arg_486_1.time_ < 0 + var_489_7 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play324081120 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 324081120
		arg_490_1.duration_ = 5.13

		local var_490_0 = {
			zh = 2.666,
			ja = 5.133
		}
		local var_490_1 = manager.audio:GetLocalizationFlag()

		if var_490_0[var_490_1] ~= nil then
			arg_490_1.duration_ = var_490_0[var_490_1]
		end

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play324081121(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1.var_.moveOldPos10171ui_story = arg_490_1.actors_["10171ui_story"].transform.localPosition

				local var_493_0 = GameObjectTools.GetOrAddComponent(arg_490_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_493_0 then
					var_493_0:EnableDynamicBone(false)
				end
			end

			local var_493_1 = 0.001

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_1 then
				arg_490_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_490_1.var_.moveOldPos10171ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_490_1.time_ - 0) / var_493_1)
				arg_490_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_490_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["10171ui_story"].transform.position).z)
				arg_490_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_490_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_490_1.actors_["10171ui_story"].transform.localEulerAngles = arg_490_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_490_1.time_ >= 0 + var_493_1 and arg_490_1.time_ < 0 + var_493_1 + arg_493_0 then
				arg_490_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_490_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_490_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_490_1.actors_["10171ui_story"].transform.position).z)
				arg_490_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_490_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_490_1.actors_["10171ui_story"].transform.localEulerAngles = arg_490_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_493_2 = GameObjectTools.GetOrAddComponent(arg_490_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_493_2 then
					var_493_2:EnableDynamicBone(true)
				end
			end

			local var_493_3 = arg_490_1.actors_["10171ui_story"]

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 and not isNil(var_493_3) and arg_490_1.var_.characterEffect10171ui_story == nil then
				arg_490_1.var_.characterEffect10171ui_story = var_493_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_493_4 = 0.200000002980232

			if 0 <= arg_490_1.time_ and arg_490_1.time_ < 0 + var_493_4 and not isNil(var_493_3) then
				if arg_490_1.var_.characterEffect10171ui_story and not isNil(var_493_3) then
					arg_490_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_490_1.time_ >= 0 + var_493_4 and arg_490_1.time_ < 0 + var_493_4 + arg_493_0 and not isNil(var_493_3) and arg_490_1.var_.characterEffect10171ui_story then
				arg_490_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action27_1")
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_493_6 = 0
			local var_493_7 = 0.325

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_6 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, true)

				arg_490_1.leftNameTxt_.text = arg_490_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_490_1.leftNameTxt_.transform)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1.leftNameTxt_.text)
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_8 = arg_490_1:GetWordFromCfg(324081120)
				local var_493_9 = arg_490_1:FormatText(var_493_8.content)

				arg_490_1.text_.text = var_493_9

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_11 = 13 <= 0 and var_493_7 or var_493_7 * (utf8.len(var_493_9) / 13)

				if (13 <= 0 and var_493_7 or var_493_7 * (utf8.len(var_493_9) / 13)) > 0 and var_493_7 < var_493_11 then
					arg_490_1.talkMaxDuration = var_493_11

					if var_493_11 + var_493_6 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_11 + var_493_6
					end
				end

				arg_490_1.text_.text = var_493_9
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081120", "story_v_out_324081.awb") ~= 0 then
					local var_493_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081120", "story_v_out_324081.awb") / 1000

					if var_493_12 + var_493_6 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_12 + var_493_6
					end

					if var_493_8.prefab_name ~= "" and arg_490_1.actors_[var_493_8.prefab_name] ~= nil then
						local var_493_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_490_1.actors_[var_493_8.prefab_name].transform, "story_v_out_324081", "324081120", "story_v_out_324081.awb")

						arg_490_1:RecordAudio("324081120", var_493_13)
						arg_490_1:RecordAudio("324081120", var_493_13)
					else
						arg_490_1:AudioAction("play", "voice", "story_v_out_324081", "324081120", "story_v_out_324081.awb")
					end

					arg_490_1:RecordHistoryTalkVoice("story_v_out_324081", "324081120", "story_v_out_324081.awb")
				end

				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_14 = math.max(var_493_7, arg_490_1.talkMaxDuration)

			if var_493_6 <= arg_490_1.time_ and arg_490_1.time_ < var_493_6 + var_493_14 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_6) / var_493_14

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_6 + var_493_14 and arg_490_1.time_ < var_493_6 + var_493_14 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_490_1:InitPlayNodeList()
	end,
	Play324081121 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 324081121
		arg_494_1.duration_ = 8.5

		local var_494_0 = {
			zh = 7.033,
			ja = 8.5
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play324081122(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1.var_.moveOldPos1070ui_story = arg_494_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_497_0 = 0.001

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 then
				arg_494_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_494_1.var_.moveOldPos1070ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_494_1.time_ - 0) / var_497_0)
				arg_494_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_494_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1070ui_story"].transform.position).z)
				arg_494_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_494_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_494_1.actors_["1070ui_story"].transform.localEulerAngles = arg_494_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 then
				arg_494_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_494_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_494_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_494_1.actors_["1070ui_story"].transform.position).z)
				arg_494_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_494_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_494_1.actors_["1070ui_story"].transform.localEulerAngles = arg_494_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_497_1 = arg_494_1.actors_["1070ui_story"]

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(var_497_1) and arg_494_1.var_.characterEffect1070ui_story == nil then
				arg_494_1.var_.characterEffect1070ui_story = var_497_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_2 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_2 and not isNil(var_497_1) then
				if arg_494_1.var_.characterEffect1070ui_story and not isNil(var_497_1) then
					arg_494_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= 0 + var_497_2 and arg_494_1.time_ < 0 + var_497_2 + arg_497_0 and not isNil(var_497_1) and arg_494_1.var_.characterEffect1070ui_story then
				arg_494_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_497_4 = arg_494_1.actors_["10171ui_story"]

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(var_497_4) and arg_494_1.var_.characterEffect10171ui_story == nil then
				arg_494_1.var_.characterEffect10171ui_story = var_497_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_5 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_5 and not isNil(var_497_4) then
				if arg_494_1.var_.characterEffect10171ui_story and not isNil(var_497_4) then
					arg_494_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_494_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_494_1.time_ - 0) / var_497_5)
				end
			end

			if arg_494_1.time_ >= 0 + var_497_5 and arg_494_1.time_ < 0 + var_497_5 + arg_497_0 and not isNil(var_497_4) and arg_494_1.var_.characterEffect10171ui_story then
				arg_494_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_494_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_497_6 = 0
			local var_497_7 = 0.65

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_6 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_8 = arg_494_1:GetWordFromCfg(324081121)
				local var_497_9 = arg_494_1:FormatText(var_497_8.content)

				arg_494_1.text_.text = var_497_9

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_11 = 26 <= 0 and var_497_7 or var_497_7 * (utf8.len(var_497_9) / 26)

				if (26 <= 0 and var_497_7 or var_497_7 * (utf8.len(var_497_9) / 26)) > 0 and var_497_7 < var_497_11 then
					arg_494_1.talkMaxDuration = var_497_11

					if var_497_11 + var_497_6 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_11 + var_497_6
					end
				end

				arg_494_1.text_.text = var_497_9
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081121", "story_v_out_324081.awb") ~= 0 then
					local var_497_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081121", "story_v_out_324081.awb") / 1000

					if var_497_12 + var_497_6 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_12 + var_497_6
					end

					if var_497_8.prefab_name ~= "" and arg_494_1.actors_[var_497_8.prefab_name] ~= nil then
						local var_497_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_8.prefab_name].transform, "story_v_out_324081", "324081121", "story_v_out_324081.awb")

						arg_494_1:RecordAudio("324081121", var_497_13)
						arg_494_1:RecordAudio("324081121", var_497_13)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_324081", "324081121", "story_v_out_324081.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_324081", "324081121", "story_v_out_324081.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_14 = math.max(var_497_7, arg_494_1.talkMaxDuration)

			if var_497_6 <= arg_494_1.time_ and arg_494_1.time_ < var_497_6 + var_497_14 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_6) / var_497_14

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_6 + var_497_14 and arg_494_1.time_ < var_497_6 + var_497_14 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_494_1:InitPlayNodeList()
	end,
	Play324081122 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 324081122
		arg_498_1.duration_ = 10.2

		local var_498_0 = {
			zh = 8.133,
			ja = 10.2
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play324081123(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["10171ui_story"]) and arg_498_1.var_.characterEffect10171ui_story == nil then
				arg_498_1.var_.characterEffect10171ui_story = arg_498_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_0 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["10171ui_story"]) then
				if arg_498_1.var_.characterEffect10171ui_story and not isNil(arg_498_1.actors_["10171ui_story"]) then
					arg_498_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["10171ui_story"]) and arg_498_1.var_.characterEffect10171ui_story then
				arg_498_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_501_2 = arg_498_1.actors_["1070ui_story"]

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(var_501_2) and arg_498_1.var_.characterEffect1070ui_story == nil then
				arg_498_1.var_.characterEffect1070ui_story = var_501_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_3 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_3 and not isNil(var_501_2) then
				if arg_498_1.var_.characterEffect1070ui_story and not isNil(var_501_2) then
					arg_498_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_498_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_498_1.time_ - 0) / var_501_3)
				end
			end

			if arg_498_1.time_ >= 0 + var_501_3 and arg_498_1.time_ < 0 + var_501_3 + arg_501_0 and not isNil(var_501_2) and arg_498_1.var_.characterEffect1070ui_story then
				arg_498_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_498_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_501_4 = 0
			local var_501_5 = 0.975

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_4 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_6 = arg_498_1:GetWordFromCfg(324081122)
				local var_501_7 = arg_498_1:FormatText(var_501_6.content)

				arg_498_1.text_.text = var_501_7

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_9 = 39 <= 0 and var_501_5 or var_501_5 * (utf8.len(var_501_7) / 39)

				if (39 <= 0 and var_501_5 or var_501_5 * (utf8.len(var_501_7) / 39)) > 0 and var_501_5 < var_501_9 then
					arg_498_1.talkMaxDuration = var_501_9

					if var_501_9 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_9 + var_501_4
					end
				end

				arg_498_1.text_.text = var_501_7
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081122", "story_v_out_324081.awb") ~= 0 then
					local var_501_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081122", "story_v_out_324081.awb") / 1000

					if var_501_10 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_10 + var_501_4
					end

					if var_501_6.prefab_name ~= "" and arg_498_1.actors_[var_501_6.prefab_name] ~= nil then
						local var_501_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_6.prefab_name].transform, "story_v_out_324081", "324081122", "story_v_out_324081.awb")

						arg_498_1:RecordAudio("324081122", var_501_11)
						arg_498_1:RecordAudio("324081122", var_501_11)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_324081", "324081122", "story_v_out_324081.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_324081", "324081122", "story_v_out_324081.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_12 = math.max(var_501_5, arg_498_1.talkMaxDuration)

			if var_501_4 <= arg_498_1.time_ and arg_498_1.time_ < var_501_4 + var_501_12 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_4) / var_501_12

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_4 + var_501_12 and arg_498_1.time_ < var_501_4 + var_501_12 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play324081123 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 324081123
		arg_502_1.duration_ = 7.27

		local var_502_0 = {
			zh = 7.1,
			ja = 7.266
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play324081124(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(arg_502_1.actors_["1070ui_story"]) and arg_502_1.var_.characterEffect1070ui_story == nil then
				arg_502_1.var_.characterEffect1070ui_story = arg_502_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_0 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 and not isNil(arg_502_1.actors_["1070ui_story"]) then
				if arg_502_1.var_.characterEffect1070ui_story and not isNil(arg_502_1.actors_["1070ui_story"]) then
					arg_502_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 and not isNil(arg_502_1.actors_["1070ui_story"]) and arg_502_1.var_.characterEffect1070ui_story then
				arg_502_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_505_2 = arg_502_1.actors_["10171ui_story"]

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(var_505_2) and arg_502_1.var_.characterEffect10171ui_story == nil then
				arg_502_1.var_.characterEffect10171ui_story = var_505_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_3 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_3 and not isNil(var_505_2) then
				if arg_502_1.var_.characterEffect10171ui_story and not isNil(var_505_2) then
					arg_502_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_502_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_502_1.time_ - 0) / var_505_3)
				end
			end

			if arg_502_1.time_ >= 0 + var_505_3 and arg_502_1.time_ < 0 + var_505_3 + arg_505_0 and not isNil(var_505_2) and arg_502_1.var_.characterEffect10171ui_story then
				arg_502_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_502_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			local var_505_4 = 0
			local var_505_5 = 0.825

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_4 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_6 = arg_502_1:GetWordFromCfg(324081123)
				local var_505_7 = arg_502_1:FormatText(var_505_6.content)

				arg_502_1.text_.text = var_505_7

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_9 = 33 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_7) / 33)

				if (33 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_7) / 33)) > 0 and var_505_5 < var_505_9 then
					arg_502_1.talkMaxDuration = var_505_9

					if var_505_9 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_9 + var_505_4
					end
				end

				arg_502_1.text_.text = var_505_7
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081123", "story_v_out_324081.awb") ~= 0 then
					local var_505_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081123", "story_v_out_324081.awb") / 1000

					if var_505_10 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_10 + var_505_4
					end

					if var_505_6.prefab_name ~= "" and arg_502_1.actors_[var_505_6.prefab_name] ~= nil then
						local var_505_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_6.prefab_name].transform, "story_v_out_324081", "324081123", "story_v_out_324081.awb")

						arg_502_1:RecordAudio("324081123", var_505_11)
						arg_502_1:RecordAudio("324081123", var_505_11)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_324081", "324081123", "story_v_out_324081.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_324081", "324081123", "story_v_out_324081.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_12 = math.max(var_505_5, arg_502_1.talkMaxDuration)

			if var_505_4 <= arg_502_1.time_ and arg_502_1.time_ < var_505_4 + var_505_12 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_4) / var_505_12

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_4 + var_505_12 and arg_502_1.time_ < var_505_4 + var_505_12 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play324081124 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 324081124
		arg_506_1.duration_ = 10.17

		local var_506_0 = {
			zh = 8.1,
			ja = 10.166
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play324081125(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(arg_506_1.actors_["10171ui_story"]) and arg_506_1.var_.characterEffect10171ui_story == nil then
				arg_506_1.var_.characterEffect10171ui_story = arg_506_1.actors_["10171ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_0 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 and not isNil(arg_506_1.actors_["10171ui_story"]) then
				if arg_506_1.var_.characterEffect10171ui_story and not isNil(arg_506_1.actors_["10171ui_story"]) then
					arg_506_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 and not isNil(arg_506_1.actors_["10171ui_story"]) and arg_506_1.var_.characterEffect10171ui_story then
				arg_506_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			local var_509_2 = arg_506_1.actors_["1070ui_story"]

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(var_509_2) and arg_506_1.var_.characterEffect1070ui_story == nil then
				arg_506_1.var_.characterEffect1070ui_story = var_509_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_3 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_3 and not isNil(var_509_2) then
				if arg_506_1.var_.characterEffect1070ui_story and not isNil(var_509_2) then
					arg_506_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_506_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_506_1.time_ - 0) / var_509_3)
				end
			end

			if arg_506_1.time_ >= 0 + var_509_3 and arg_506_1.time_ < 0 + var_509_3 + arg_509_0 and not isNil(var_509_2) and arg_506_1.var_.characterEffect1070ui_story then
				arg_506_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_506_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171actionlink/10171action42731")
			end

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 then
				arg_506_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_509_4 = 0

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_4 + arg_509_0 then
				arg_506_1.allBtn_.enabled = false
			end

			if arg_506_1.time_ >= var_509_4 + 1.63333333333333 and arg_506_1.time_ < var_509_4 + 1.63333333333333 + arg_509_0 then
				arg_506_1.allBtn_.enabled = true
			end

			local var_509_5 = 0
			local var_509_6 = 0.95

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_5 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_7 = arg_506_1:GetWordFromCfg(324081124)
				local var_509_8 = arg_506_1:FormatText(var_509_7.content)

				arg_506_1.text_.text = var_509_8

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_10 = 38 <= 0 and var_509_6 or var_509_6 * (utf8.len(var_509_8) / 38)

				if (38 <= 0 and var_509_6 or var_509_6 * (utf8.len(var_509_8) / 38)) > 0 and var_509_6 < var_509_10 then
					arg_506_1.talkMaxDuration = var_509_10

					if var_509_10 + var_509_5 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_10 + var_509_5
					end
				end

				arg_506_1.text_.text = var_509_8
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081124", "story_v_out_324081.awb") ~= 0 then
					local var_509_11 = manager.audio:GetVoiceLength("story_v_out_324081", "324081124", "story_v_out_324081.awb") / 1000

					if var_509_11 + var_509_5 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_11 + var_509_5
					end

					if var_509_7.prefab_name ~= "" and arg_506_1.actors_[var_509_7.prefab_name] ~= nil then
						local var_509_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_7.prefab_name].transform, "story_v_out_324081", "324081124", "story_v_out_324081.awb")

						arg_506_1:RecordAudio("324081124", var_509_12)
						arg_506_1:RecordAudio("324081124", var_509_12)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_324081", "324081124", "story_v_out_324081.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_324081", "324081124", "story_v_out_324081.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_13 = math.max(var_509_6, arg_506_1.talkMaxDuration)

			if var_509_5 <= arg_506_1.time_ and arg_506_1.time_ < var_509_5 + var_509_13 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_5) / var_509_13

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_5 + var_509_13 and arg_506_1.time_ < var_509_5 + var_509_13 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play324081125 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 324081125
		arg_510_1.duration_ = 2

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play324081126(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(arg_510_1.actors_["1070ui_story"]) and arg_510_1.var_.characterEffect1070ui_story == nil then
				arg_510_1.var_.characterEffect1070ui_story = arg_510_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_0 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 and not isNil(arg_510_1.actors_["1070ui_story"]) then
				if arg_510_1.var_.characterEffect1070ui_story and not isNil(arg_510_1.actors_["1070ui_story"]) then
					arg_510_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 and not isNil(arg_510_1.actors_["1070ui_story"]) and arg_510_1.var_.characterEffect1070ui_story then
				arg_510_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_513_2 = arg_510_1.actors_["10171ui_story"]

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(var_513_2) and arg_510_1.var_.characterEffect10171ui_story == nil then
				arg_510_1.var_.characterEffect10171ui_story = var_513_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_3 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_3 and not isNil(var_513_2) then
				if arg_510_1.var_.characterEffect10171ui_story and not isNil(var_513_2) then
					arg_510_1.var_.characterEffect10171ui_story.fillFlat = true
					arg_510_1.var_.characterEffect10171ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_510_1.time_ - 0) / var_513_3)
				end
			end

			if arg_510_1.time_ >= 0 + var_513_3 and arg_510_1.time_ < 0 + var_513_3 + arg_513_0 and not isNil(var_513_2) and arg_510_1.var_.characterEffect10171ui_story then
				arg_510_1.var_.characterEffect10171ui_story.fillFlat = true
				arg_510_1.var_.characterEffect10171ui_story.fillRatio = 0.5
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			local var_513_4 = 0
			local var_513_5 = 0.05

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_4 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, true)

				arg_510_1.leftNameTxt_.text = arg_510_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_510_1.leftNameTxt_.transform)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1.leftNameTxt_.text)
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_6 = arg_510_1:GetWordFromCfg(324081125)
				local var_513_7 = arg_510_1:FormatText(var_513_6.content)

				arg_510_1.text_.text = var_513_7

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_9 = 2 <= 0 and var_513_5 or var_513_5 * (utf8.len(var_513_7) / 2)

				if (2 <= 0 and var_513_5 or var_513_5 * (utf8.len(var_513_7) / 2)) > 0 and var_513_5 < var_513_9 then
					arg_510_1.talkMaxDuration = var_513_9

					if var_513_9 + var_513_4 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_9 + var_513_4
					end
				end

				arg_510_1.text_.text = var_513_7
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081125", "story_v_out_324081.awb") ~= 0 then
					local var_513_10 = manager.audio:GetVoiceLength("story_v_out_324081", "324081125", "story_v_out_324081.awb") / 1000

					if var_513_10 + var_513_4 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_10 + var_513_4
					end

					if var_513_6.prefab_name ~= "" and arg_510_1.actors_[var_513_6.prefab_name] ~= nil then
						local var_513_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_510_1.actors_[var_513_6.prefab_name].transform, "story_v_out_324081", "324081125", "story_v_out_324081.awb")

						arg_510_1:RecordAudio("324081125", var_513_11)
						arg_510_1:RecordAudio("324081125", var_513_11)
					else
						arg_510_1:AudioAction("play", "voice", "story_v_out_324081", "324081125", "story_v_out_324081.awb")
					end

					arg_510_1:RecordHistoryTalkVoice("story_v_out_324081", "324081125", "story_v_out_324081.awb")
				end

				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_12 = math.max(var_513_5, arg_510_1.talkMaxDuration)

			if var_513_4 <= arg_510_1.time_ and arg_510_1.time_ < var_513_4 + var_513_12 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_4) / var_513_12

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_4 + var_513_12 and arg_510_1.time_ < var_513_4 + var_513_12 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play324081126 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 324081126
		arg_514_1.duration_ = 5

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play324081127(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.var_.moveOldPos10171ui_story = arg_514_1.actors_["10171ui_story"].transform.localPosition

				local var_517_0 = GameObjectTools.GetOrAddComponent(arg_514_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_517_0 then
					var_517_0:EnableDynamicBone(false)
				end
			end

			local var_517_1 = 0.001

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_1 then
				arg_514_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos10171ui_story, Vector3.New(0, 100, 0), (arg_514_1.time_ - 0) / var_517_1)
				arg_514_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["10171ui_story"].transform.position).z)
				arg_514_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["10171ui_story"].transform.localEulerAngles = arg_514_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_514_1.time_ >= 0 + var_517_1 and arg_514_1.time_ < 0 + var_517_1 + arg_517_0 then
				arg_514_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_514_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_514_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_514_1.actors_["10171ui_story"].transform.position).z)
				arg_514_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_514_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_514_1.actors_["10171ui_story"].transform.localEulerAngles = arg_514_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_517_2 = GameObjectTools.GetOrAddComponent(arg_514_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_517_2 then
					var_517_2:EnableDynamicBone(true)
				end
			end

			local var_517_3 = arg_514_1.actors_["1070ui_story"].transform

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 then
				arg_514_1.var_.moveOldPos1070ui_story = var_517_3.localPosition
			end

			local var_517_4 = 0.001

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_4 then
				var_517_3.localPosition = Vector3.Lerp(arg_514_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_514_1.time_ - 0) / var_517_4)
				var_517_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_3.position).x, (manager.ui.mainCamera.transform.position - var_517_3.position).y, (manager.ui.mainCamera.transform.position - var_517_3.position).z)
				var_517_3.localEulerAngles.z = 0
				var_517_3.localEulerAngles.x = 0
				var_517_3.localEulerAngles = var_517_3.localEulerAngles
			end

			if arg_514_1.time_ >= 0 + var_517_4 and arg_514_1.time_ < 0 + var_517_4 + arg_517_0 then
				var_517_3.localPosition = Vector3.New(0, 100, 0)
				var_517_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_517_3.position).x, (manager.ui.mainCamera.transform.position - var_517_3.position).y, (manager.ui.mainCamera.transform.position - var_517_3.position).z)
				var_517_3.localEulerAngles.z = 0
				var_517_3.localEulerAngles.x = 0
				var_517_3.localEulerAngles = var_517_3.localEulerAngles
			end

			local var_517_5 = arg_514_1.actors_["1070ui_story"]

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(var_517_5) and arg_514_1.var_.characterEffect1070ui_story == nil then
				arg_514_1.var_.characterEffect1070ui_story = var_517_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_6 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_6 and not isNil(var_517_5) then
				if arg_514_1.var_.characterEffect1070ui_story and not isNil(var_517_5) then
					arg_514_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_514_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_514_1.time_ - 0) / var_517_6)
				end
			end

			if arg_514_1.time_ >= 0 + var_517_6 and arg_514_1.time_ < 0 + var_517_6 + arg_517_0 and not isNil(var_517_5) and arg_514_1.var_.characterEffect1070ui_story then
				arg_514_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_514_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_517_7 = 0
			local var_517_8 = 1.35

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_7 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, false)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_9 = arg_514_1:FormatText(arg_514_1:GetWordFromCfg(324081126).content)

				arg_514_1.text_.text = var_517_9

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_11 = 54 <= 0 and var_517_8 or var_517_8 * (utf8.len(var_517_9) / 54)

				if (54 <= 0 and var_517_8 or var_517_8 * (utf8.len(var_517_9) / 54)) > 0 and var_517_8 < var_517_11 then
					arg_514_1.talkMaxDuration = var_517_11

					if var_517_11 + var_517_7 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_11 + var_517_7
					end
				end

				arg_514_1.text_.text = var_517_9
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)
				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_12 = math.max(var_517_8, arg_514_1.talkMaxDuration)

			if var_517_7 <= arg_514_1.time_ and arg_514_1.time_ < var_517_7 + var_517_12 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_7) / var_517_12

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_7 + var_517_12 and arg_514_1.time_ < var_517_7 + var_517_12 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_514_1:InitPlayNodeList()
	end,
	Play324081127 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 324081127
		arg_518_1.duration_ = 3.93

		local var_518_0 = {
			zh = 3.1,
			ja = 3.933
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
			arg_518_1.auto_ = false
		end

		function arg_518_1.playNext_(arg_520_0)
			arg_518_1.onStoryFinished_()
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1.var_.moveOldPos10171ui_story = arg_518_1.actors_["10171ui_story"].transform.localPosition

				local var_521_0 = GameObjectTools.GetOrAddComponent(arg_518_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_521_0 then
					var_521_0:EnableDynamicBone(false)
				end
			end

			local var_521_1 = 0.001

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_1 then
				arg_518_1.actors_["10171ui_story"].transform.localPosition = Vector3.Lerp(arg_518_1.var_.moveOldPos10171ui_story, Vector3.New(0, -0.95, -6.05), (arg_518_1.time_ - 0) / var_521_1)
				arg_518_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_518_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["10171ui_story"].transform.position).z)
				arg_518_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_518_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_518_1.actors_["10171ui_story"].transform.localEulerAngles = arg_518_1.actors_["10171ui_story"].transform.localEulerAngles
			end

			if arg_518_1.time_ >= 0 + var_521_1 and arg_518_1.time_ < 0 + var_521_1 + arg_521_0 then
				arg_518_1.actors_["10171ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_518_1.actors_["10171ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_518_1.actors_["10171ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["10171ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_518_1.actors_["10171ui_story"].transform.position).z)
				arg_518_1.actors_["10171ui_story"].transform.localEulerAngles.z = 0
				arg_518_1.actors_["10171ui_story"].transform.localEulerAngles.x = 0
				arg_518_1.actors_["10171ui_story"].transform.localEulerAngles = arg_518_1.actors_["10171ui_story"].transform.localEulerAngles

				local var_521_2 = GameObjectTools.GetOrAddComponent(arg_518_1.actors_["10171ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_521_2 then
					var_521_2:EnableDynamicBone(true)
				end
			end

			local var_521_3 = arg_518_1.actors_["10171ui_story"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_3) and arg_518_1.var_.characterEffect10171ui_story == nil then
				arg_518_1.var_.characterEffect10171ui_story = var_521_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_4 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_4 and not isNil(var_521_3) then
				if arg_518_1.var_.characterEffect10171ui_story and not isNil(var_521_3) then
					arg_518_1.var_.characterEffect10171ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= 0 + var_521_4 and arg_518_1.time_ < 0 + var_521_4 + arg_521_0 and not isNil(var_521_3) and arg_518_1.var_.characterEffect10171ui_story then
				arg_518_1.var_.characterEffect10171ui_story.fillFlat = false
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/story10171/story10171action/10171action31_2")
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("10171ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_521_6 = 0
			local var_521_7 = 0.325

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_6 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[1451].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_8 = arg_518_1:GetWordFromCfg(324081127)
				local var_521_9 = arg_518_1:FormatText(var_521_8.content)

				arg_518_1.text_.text = var_521_9

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_11 = 13 <= 0 and var_521_7 or var_521_7 * (utf8.len(var_521_9) / 13)

				if (13 <= 0 and var_521_7 or var_521_7 * (utf8.len(var_521_9) / 13)) > 0 and var_521_7 < var_521_11 then
					arg_518_1.talkMaxDuration = var_521_11

					if var_521_11 + var_521_6 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_11 + var_521_6
					end
				end

				arg_518_1.text_.text = var_521_9
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324081", "324081127", "story_v_out_324081.awb") ~= 0 then
					local var_521_12 = manager.audio:GetVoiceLength("story_v_out_324081", "324081127", "story_v_out_324081.awb") / 1000

					if var_521_12 + var_521_6 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_12 + var_521_6
					end

					if var_521_8.prefab_name ~= "" and arg_518_1.actors_[var_521_8.prefab_name] ~= nil then
						local var_521_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_8.prefab_name].transform, "story_v_out_324081", "324081127", "story_v_out_324081.awb")

						arg_518_1:RecordAudio("324081127", var_521_13)
						arg_518_1:RecordAudio("324081127", var_521_13)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_324081", "324081127", "story_v_out_324081.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_324081", "324081127", "story_v_out_324081.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_14 = math.max(var_521_7, arg_518_1.talkMaxDuration)

			if var_521_6 <= arg_518_1.time_ and arg_518_1.time_ < var_521_6 + var_521_14 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_6) / var_521_14

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_6 + var_521_14 and arg_518_1.time_ < var_521_6 + var_521_14 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10171ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_518_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/J27f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/J22f",
		"TextureConfig/Background/J22g"
	},
	voices = {
		"story_v_out_324081.awb"
	}
}
