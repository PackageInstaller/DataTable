return {
	Play109052001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109052001
		arg_1_1.duration_ = 4.2

		local var_1_0 = {
			ja = 3.366,
			ko = 3.7,
			zh = 4.2,
			en = 3.633
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
				arg_1_0:Play109052002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST06a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST06a")
				var_4_0.name = "ST06a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST06a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST06a

				arg_1_1.bgs_.ST06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST06a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.ST06a:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueST06a = var_4_4.color.a
					arg_1_1.var_.alphaMatValueST06a = var_4_4
				end

				arg_1_1.var_.alphaOldValueST06a = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueST06a then
					arg_1_1.var_.alphaMatValueST06a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueST06a, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueST06a.color = arg_1_1.var_.alphaMatValueST06a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueST06a then
				arg_1_1.var_.alphaMatValueST06a.color.a = 1
				arg_1_1.var_.alphaMatValueST06a.color = arg_1_1.var_.alphaMatValueST06a.color
			end

			local var_4_6 = manager.ui.mainCamera.transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_6.localPosition
			end

			local var_4_7 = 0.6

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_7 then
				local var_4_8, var_4_9 = math.modf((arg_1_1.time_ - 2) / 0.099)

				var_4_6.localPosition = Vector3.New(var_4_9 * 0.13, var_4_9 * 0.13, var_4_9 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 2 + var_4_7 and arg_1_1.time_ < 2 + var_4_7 + arg_4_0 then
				var_4_6.localPosition = arg_1_1.var_.shakeOldPos
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_12 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_12 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_12

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_12
						arg_1_1.bgmTxt2_.text = var_4_12
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_4_13 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_13 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_13 + 2 and arg_1_1.time_ < var_4_13 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_9", "se_story_9_bounce_off", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 0.175

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_18 = arg_1_1:GetWordFromCfg(109052001)
				local var_4_19 = arg_1_1:FormatText(var_4_18.content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 7 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 7)

				if (7 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_19) / 7)) > 0 and var_4_16 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_15 = var_4_15 + 0.3

					if var_4_21 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052001", "story_v_out_109052.awb") ~= 0 then
					local var_4_22 = manager.audio:GetVoiceLength("story_v_out_109052", "109052001", "story_v_out_109052.awb") / 1000

					if var_4_22 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_22 + var_4_15
					end

					if var_4_18.prefab_name ~= "" and arg_1_1.actors_[var_4_18.prefab_name] ~= nil then
						local var_4_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_18.prefab_name].transform, "story_v_out_109052", "109052001", "story_v_out_109052.awb")

						arg_1_1:RecordAudio("109052001", var_4_23)
						arg_1_1:RecordAudio("109052001", var_4_23)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_109052", "109052001", "story_v_out_109052.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_109052", "109052001", "story_v_out_109052.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_15 + 0.3
			local var_4_25 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play109052002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109052002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play109052003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0.100000001490116 < arg_8_1.time_ and arg_8_1.time_ <= 0.100000001490116 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_9", "se_story_9_bite", "")
			end

			local var_11_1 = 0
			local var_11_2 = 1.475

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_1 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(109052002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 59 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 59)

				if (59 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 59)) > 0 and var_11_2 < var_11_5 then
					arg_8_1.talkMaxDuration = var_11_5

					if var_11_5 + var_11_1 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_5 + var_11_1
					end
				end

				arg_8_1.text_.text = var_11_3
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_6 = math.max(var_11_2, arg_8_1.talkMaxDuration)

			if var_11_1 <= arg_8_1.time_ and arg_8_1.time_ < var_11_1 + var_11_6 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_1) / var_11_6

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_1 + var_11_6 and arg_8_1.time_ < var_11_1 + var_11_6 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play109052003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109052003
		arg_12_1.duration_ = 10.5

		local var_12_0 = {
			ja = 10.5,
			ko = 7.066,
			zh = 5.433,
			en = 7.6
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play109052004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["4014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4014_tpose"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_12_1.stage_.transform)

				var_15_0.name = "4014_tpose"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["4014_tpose"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["4014_tpose" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["4014_tpose" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["4014_tpose" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["4014_tpose"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos4014_tpose = var_15_3.localPosition

				local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_3.gameObject, typeof(DynamicBoneHelper))

				if var_15_4 then
					var_15_4:EnableDynamicBone(false)
				end
			end

			local var_15_5 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_5 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_12_1.time_ - 0) / var_15_5)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_5 and arg_12_1.time_ < 0 + var_15_5 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, -1.95, -4.2)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles

				local var_15_6 = GameObjectTools.GetOrAddComponent(var_15_3.gameObject, typeof(DynamicBoneHelper))

				if var_15_6 then
					var_15_6:EnableDynamicBone(true)
				end
			end

			local var_15_7 = arg_12_1.actors_["4014_tpose"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_7) and arg_12_1.var_.characterEffect4014_tpose == nil then
				arg_12_1.var_.characterEffect4014_tpose = var_15_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_8 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_8 and not isNil(var_15_7) then
				if arg_12_1.var_.characterEffect4014_tpose and not isNil(var_15_7) then
					arg_12_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_8 and arg_12_1.time_ < 0 + var_15_8 + arg_15_0 and not isNil(var_15_7) and arg_12_1.var_.characterEffect4014_tpose then
				arg_12_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_15_10 = "3007_tpose"

			if arg_12_1.actors_["3007_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3007_tpose"))) then
				local var_15_11 = Object.Instantiate(Asset.Load("Char/" .. "3007_tpose"), arg_12_1.stage_.transform)

				var_15_11.name = var_15_10
				var_15_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_[var_15_10] = var_15_11

				local var_15_12 = var_15_11:GetComponentInChildren(typeof(CharacterEffect))

				var_15_12.enabled = true

				local var_15_13 = GameObjectTools.GetOrAddComponent(var_15_11, typeof(DynamicBoneHelper))

				if var_15_13 then
					var_15_13:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_12.transform, false)

				arg_12_1.var_[var_15_10 .. "Animator"] = var_15_12.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_[var_15_10 .. "Animator"].applyRootMotion = true
				arg_12_1.var_[var_15_10 .. "LipSync"] = var_15_12.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_14 = arg_12_1.actors_["3007_tpose"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos3007_tpose = var_15_14.localPosition

				local var_15_15 = GameObjectTools.GetOrAddComponent(var_15_14.gameObject, typeof(DynamicBoneHelper))

				if var_15_15 then
					var_15_15:EnableDynamicBone(false)
				end
			end

			local var_15_16 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_16 then
				var_15_14.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3007_tpose, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_16)
				var_15_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_14.position).x, (manager.ui.mainCamera.transform.position - var_15_14.position).y, (manager.ui.mainCamera.transform.position - var_15_14.position).z)
				var_15_14.localEulerAngles.z = 0
				var_15_14.localEulerAngles.x = 0
				var_15_14.localEulerAngles = var_15_14.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_16 and arg_12_1.time_ < 0 + var_15_16 + arg_15_0 then
				var_15_14.localPosition = Vector3.New(0, 100, 0)
				var_15_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_14.position).x, (manager.ui.mainCamera.transform.position - var_15_14.position).y, (manager.ui.mainCamera.transform.position - var_15_14.position).z)
				var_15_14.localEulerAngles.z = 0
				var_15_14.localEulerAngles.x = 0
				var_15_14.localEulerAngles = var_15_14.localEulerAngles

				local var_15_17 = GameObjectTools.GetOrAddComponent(var_15_14.gameObject, typeof(DynamicBoneHelper))

				if var_15_17 then
					var_15_17:EnableDynamicBone(true)
				end
			end

			local var_15_18 = 0
			local var_15_19 = 0.55

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_18 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_20 = arg_12_1:GetWordFromCfg(109052003)
				local var_15_21 = arg_12_1:FormatText(var_15_20.content)

				arg_12_1.text_.text = var_15_21

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_23 = 22 <= 0 and var_15_19 or var_15_19 * (utf8.len(var_15_21) / 22)

				if (22 <= 0 and var_15_19 or var_15_19 * (utf8.len(var_15_21) / 22)) > 0 and var_15_19 < var_15_23 then
					arg_12_1.talkMaxDuration = var_15_23

					if var_15_23 + var_15_18 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_23 + var_15_18
					end
				end

				arg_12_1.text_.text = var_15_21
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052003", "story_v_out_109052.awb") ~= 0 then
					local var_15_24 = manager.audio:GetVoiceLength("story_v_out_109052", "109052003", "story_v_out_109052.awb") / 1000

					if var_15_24 + var_15_18 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_24 + var_15_18
					end

					if var_15_20.prefab_name ~= "" and arg_12_1.actors_[var_15_20.prefab_name] ~= nil then
						local var_15_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_20.prefab_name].transform, "story_v_out_109052", "109052003", "story_v_out_109052.awb")

						arg_12_1:RecordAudio("109052003", var_15_25)
						arg_12_1:RecordAudio("109052003", var_15_25)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109052", "109052003", "story_v_out_109052.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109052", "109052003", "story_v_out_109052.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_26 = math.max(var_15_19, arg_12_1.talkMaxDuration)

			if var_15_18 <= arg_12_1.time_ and arg_12_1.time_ < var_15_18 + var_15_26 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_18) / var_15_26

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_18 + var_15_26 and arg_12_1.time_ < var_15_18 + var_15_26 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play109052004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109052004
		arg_16_1.duration_ = 7.6

		local var_16_0 = {
			ja = 5.6,
			ko = 2.2,
			zh = 4.7,
			en = 7.6
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play109052005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos4014_tpose = arg_16_1.actors_["4014_tpose"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4014_tpose"].transform.position).z)
				arg_16_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["4014_tpose"].transform.localEulerAngles = arg_16_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["4014_tpose"].transform.position).z)
				arg_16_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["4014_tpose"].transform.localEulerAngles = arg_16_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = arg_16_1.actors_["3007_tpose"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos3007_tpose = var_19_3.localPosition

				local var_19_4 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_4 then
					var_19_4:EnableDynamicBone(false)
				end
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_3.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3007_tpose, Vector3.New(0, -2.25, -1.9), (arg_16_1.time_ - 0) / var_19_5)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_3.localPosition = Vector3.New(0, -2.25, -1.9)
				var_19_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_3.position).x, (manager.ui.mainCamera.transform.position - var_19_3.position).y, (manager.ui.mainCamera.transform.position - var_19_3.position).z)
				var_19_3.localEulerAngles.z = 0
				var_19_3.localEulerAngles.x = 0
				var_19_3.localEulerAngles = var_19_3.localEulerAngles

				local var_19_6 = GameObjectTools.GetOrAddComponent(var_19_3.gameObject, typeof(DynamicBoneHelper))

				if var_19_6 then
					var_19_6:EnableDynamicBone(true)
				end
			end

			local var_19_7 = arg_16_1.actors_["3007_tpose"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect3007_tpose == nil then
				arg_16_1.var_.characterEffect3007_tpose = var_19_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_8 = 0.2

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_8 and not isNil(var_19_7) then
				if arg_16_1.var_.characterEffect3007_tpose and not isNil(var_19_7) then
					arg_16_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_8 and arg_16_1.time_ < 0 + var_19_8 + arg_19_0 and not isNil(var_19_7) and arg_16_1.var_.characterEffect3007_tpose then
				arg_16_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_19_10 = 0
			local var_19_11 = 0.1

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_10 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[158].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_12 = arg_16_1:GetWordFromCfg(109052004)
				local var_19_13 = arg_16_1:FormatText(var_19_12.content)

				arg_16_1.text_.text = var_19_13

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_15 = 4 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 4)

				if (4 <= 0 and var_19_11 or var_19_11 * (utf8.len(var_19_13) / 4)) > 0 and var_19_11 < var_19_15 then
					arg_16_1.talkMaxDuration = var_19_15

					if var_19_15 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_15 + var_19_10
					end
				end

				arg_16_1.text_.text = var_19_13
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052004", "story_v_out_109052.awb") ~= 0 then
					local var_19_16 = manager.audio:GetVoiceLength("story_v_out_109052", "109052004", "story_v_out_109052.awb") / 1000

					if var_19_16 + var_19_10 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_16 + var_19_10
					end

					if var_19_12.prefab_name ~= "" and arg_16_1.actors_[var_19_12.prefab_name] ~= nil then
						local var_19_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_12.prefab_name].transform, "story_v_out_109052", "109052004", "story_v_out_109052.awb")

						arg_16_1:RecordAudio("109052004", var_19_17)
						arg_16_1:RecordAudio("109052004", var_19_17)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109052", "109052004", "story_v_out_109052.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109052", "109052004", "story_v_out_109052.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_18 = math.max(var_19_11, arg_16_1.talkMaxDuration)

			if var_19_10 <= arg_16_1.time_ and arg_16_1.time_ < var_19_10 + var_19_18 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_10) / var_19_18

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_10 + var_19_18 and arg_16_1.time_ < var_19_10 + var_19_18 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play109052005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109052005
		arg_20_1.duration_ = 5

		local var_20_0 = {
			ja = 3.866,
			ko = 2.7,
			zh = 3.933,
			en = 5
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play109052006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos3007_tpose = arg_20_1.actors_["3007_tpose"].transform.localPosition

				local var_23_0 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_0 then
					var_23_0:EnableDynamicBone(false)
				end
			end

			local var_23_1 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_1 then
				arg_20_1.actors_["3007_tpose"].transform.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos3007_tpose, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_1)
				arg_20_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["3007_tpose"].transform.position).z)
				arg_20_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["3007_tpose"].transform.localEulerAngles = arg_20_1.actors_["3007_tpose"].transform.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_1 and arg_20_1.time_ < 0 + var_23_1 + arg_23_0 then
				arg_20_1.actors_["3007_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_20_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_20_1.actors_["3007_tpose"].transform.position).z)
				arg_20_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_20_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_20_1.actors_["3007_tpose"].transform.localEulerAngles = arg_20_1.actors_["3007_tpose"].transform.localEulerAngles

				local var_23_2 = GameObjectTools.GetOrAddComponent(arg_20_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(true)
				end
			end

			local var_23_3 = arg_20_1.actors_["4014_tpose"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos4014_tpose = var_23_3.localPosition

				local var_23_4 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_4 then
					var_23_4:EnableDynamicBone(false)
				end
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_3.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_20_1.time_ - 0) / var_23_5)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_3.localPosition = Vector3.New(0, -1.95, -4.2)
				var_23_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_3.position).x, (manager.ui.mainCamera.transform.position - var_23_3.position).y, (manager.ui.mainCamera.transform.position - var_23_3.position).z)
				var_23_3.localEulerAngles.z = 0
				var_23_3.localEulerAngles.x = 0
				var_23_3.localEulerAngles = var_23_3.localEulerAngles

				local var_23_6 = GameObjectTools.GetOrAddComponent(var_23_3.gameObject, typeof(DynamicBoneHelper))

				if var_23_6 then
					var_23_6:EnableDynamicBone(true)
				end
			end

			local var_23_7 = arg_20_1.actors_["4014_tpose"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect4014_tpose == nil then
				arg_20_1.var_.characterEffect4014_tpose = var_23_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_8 = 0.2

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 and not isNil(var_23_7) then
				if arg_20_1.var_.characterEffect4014_tpose and not isNil(var_23_7) then
					arg_20_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 and not isNil(var_23_7) and arg_20_1.var_.characterEffect4014_tpose then
				arg_20_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_23_10 = 0
			local var_23_11 = 0.325

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_10 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_12 = arg_20_1:GetWordFromCfg(109052005)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 13 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 13)

				if (13 <= 0 and var_23_11 or var_23_11 * (utf8.len(var_23_13) / 13)) > 0 and var_23_11 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15

					if var_23_15 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_10
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052005", "story_v_out_109052.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_out_109052", "109052005", "story_v_out_109052.awb") / 1000

					if var_23_16 + var_23_10 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_10
					end

					if var_23_12.prefab_name ~= "" and arg_20_1.actors_[var_23_12.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_12.prefab_name].transform, "story_v_out_109052", "109052005", "story_v_out_109052.awb")

						arg_20_1:RecordAudio("109052005", var_23_17)
						arg_20_1:RecordAudio("109052005", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_109052", "109052005", "story_v_out_109052.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_109052", "109052005", "story_v_out_109052.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_18 = math.max(var_23_11, arg_20_1.talkMaxDuration)

			if var_23_10 <= arg_20_1.time_ and arg_20_1.time_ < var_23_10 + var_23_18 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_10) / var_23_18

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_10 + var_23_18 and arg_20_1.time_ < var_23_10 + var_23_18 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play109052006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109052006
		arg_24_1.duration_ = 8.5

		local var_24_0 = {
			ja = 3.1,
			ko = 7.1,
			zh = 8.5,
			en = 8.166
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play109052007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos4014_tpose = arg_24_1.actors_["4014_tpose"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).z)
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles = arg_24_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["4014_tpose"].transform.position).z)
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["4014_tpose"].transform.localEulerAngles = arg_24_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = "3004_tpose"

			if arg_24_1.actors_["3004_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3004_tpose"))) then
				local var_27_4 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_24_1.stage_.transform)

				var_27_4.name = var_27_3
				var_27_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_[var_27_3] = var_27_4

				local var_27_5 = var_27_4:GetComponentInChildren(typeof(CharacterEffect))

				var_27_5.enabled = true

				local var_27_6 = GameObjectTools.GetOrAddComponent(var_27_4, typeof(DynamicBoneHelper))

				if var_27_6 then
					var_27_6:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_5.transform, false)

				arg_24_1.var_[var_27_3 .. "Animator"] = var_27_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_[var_27_3 .. "Animator"].applyRootMotion = true
				arg_24_1.var_[var_27_3 .. "LipSync"] = var_27_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_7 = arg_24_1.actors_["3004_tpose"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos3004_tpose = var_27_7.localPosition

				local var_27_8 = GameObjectTools.GetOrAddComponent(var_27_7.gameObject, typeof(DynamicBoneHelper))

				if var_27_8 then
					var_27_8:EnableDynamicBone(false)
				end
			end

			local var_27_9 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 then
				var_27_7.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_24_1.time_ - 0) / var_27_9)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 then
				var_27_7.localPosition = Vector3.New(0, -2.22, -3.1)
				var_27_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_7.position).x, (manager.ui.mainCamera.transform.position - var_27_7.position).y, (manager.ui.mainCamera.transform.position - var_27_7.position).z)
				var_27_7.localEulerAngles.z = 0
				var_27_7.localEulerAngles.x = 0
				var_27_7.localEulerAngles = var_27_7.localEulerAngles

				local var_27_10 = GameObjectTools.GetOrAddComponent(var_27_7.gameObject, typeof(DynamicBoneHelper))

				if var_27_10 then
					var_27_10:EnableDynamicBone(true)
				end
			end

			local var_27_11 = arg_24_1.actors_["3004_tpose"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect3004_tpose == nil then
				arg_24_1.var_.characterEffect3004_tpose = var_27_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_12 = 0.2

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_12 and not isNil(var_27_11) then
				if arg_24_1.var_.characterEffect3004_tpose and not isNil(var_27_11) then
					arg_24_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_12 and arg_24_1.time_ < 0 + var_27_12 + arg_27_0 and not isNil(var_27_11) and arg_24_1.var_.characterEffect3004_tpose then
				arg_24_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_27_14 = 0
			local var_27_15 = 0.65

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_16 = arg_24_1:GetWordFromCfg(109052006)
				local var_27_17 = arg_24_1:FormatText(var_27_16.content)

				arg_24_1.text_.text = var_27_17

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_19 = 26 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 26)

				if (26 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 26)) > 0 and var_27_15 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_14
					end
				end

				arg_24_1.text_.text = var_27_17
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052006", "story_v_out_109052.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_109052", "109052006", "story_v_out_109052.awb") / 1000

					if var_27_20 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_14
					end

					if var_27_16.prefab_name ~= "" and arg_24_1.actors_[var_27_16.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_16.prefab_name].transform, "story_v_out_109052", "109052006", "story_v_out_109052.awb")

						arg_24_1:RecordAudio("109052006", var_27_21)
						arg_24_1:RecordAudio("109052006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109052", "109052006", "story_v_out_109052.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109052", "109052006", "story_v_out_109052.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_15, arg_24_1.talkMaxDuration)

			if var_27_14 <= arg_24_1.time_ and arg_24_1.time_ < var_27_14 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_14) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_14 + var_27_22 and arg_24_1.time_ < var_27_14 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play109052007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109052007
		arg_28_1.duration_ = 6.9

		local var_28_0 = {
			ja = 3.433,
			ko = 6.133,
			zh = 4.533,
			en = 6.9
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play109052008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos3004_tpose = arg_28_1.actors_["3004_tpose"].transform.localPosition

				local var_31_0 = GameObjectTools.GetOrAddComponent(arg_28_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_31_0 then
					var_31_0:EnableDynamicBone(false)
				end
			end

			local var_31_1 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_1 then
				arg_28_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_1)
				arg_28_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).z)
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles = arg_28_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_1 and arg_28_1.time_ < 0 + var_31_1 + arg_31_0 then
				arg_28_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).z)
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles = arg_28_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_31_2 = GameObjectTools.GetOrAddComponent(arg_28_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(true)
				end
			end

			local var_31_3 = arg_28_1.actors_["4014_tpose"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos4014_tpose = var_31_3.localPosition

				local var_31_4 = GameObjectTools.GetOrAddComponent(var_31_3.gameObject, typeof(DynamicBoneHelper))

				if var_31_4 then
					var_31_4:EnableDynamicBone(false)
				end
			end

			local var_31_5 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_5 then
				var_31_3.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_28_1.time_ - 0) / var_31_5)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_5 and arg_28_1.time_ < 0 + var_31_5 + arg_31_0 then
				var_31_3.localPosition = Vector3.New(0, -1.95, -4.2)
				var_31_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_3.position).x, (manager.ui.mainCamera.transform.position - var_31_3.position).y, (manager.ui.mainCamera.transform.position - var_31_3.position).z)
				var_31_3.localEulerAngles.z = 0
				var_31_3.localEulerAngles.x = 0
				var_31_3.localEulerAngles = var_31_3.localEulerAngles

				local var_31_6 = GameObjectTools.GetOrAddComponent(var_31_3.gameObject, typeof(DynamicBoneHelper))

				if var_31_6 then
					var_31_6:EnableDynamicBone(true)
				end
			end

			local var_31_7 = arg_28_1.actors_["4014_tpose"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_7) and arg_28_1.var_.characterEffect4014_tpose == nil then
				arg_28_1.var_.characterEffect4014_tpose = var_31_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_8 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_8 and not isNil(var_31_7) then
				if arg_28_1.var_.characterEffect4014_tpose and not isNil(var_31_7) then
					arg_28_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_8 and arg_28_1.time_ < 0 + var_31_8 + arg_31_0 and not isNil(var_31_7) and arg_28_1.var_.characterEffect4014_tpose then
				arg_28_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_31_10 = 0
			local var_31_11 = 0.466666666666667

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(109052007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 19 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 19)

				if (19 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 19)) > 0 and var_31_11 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052007", "story_v_out_109052.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_109052", "109052007", "story_v_out_109052.awb") / 1000

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_109052", "109052007", "story_v_out_109052.awb")

						arg_28_1:RecordAudio("109052007", var_31_17)
						arg_28_1:RecordAudio("109052007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_109052", "109052007", "story_v_out_109052.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_109052", "109052007", "story_v_out_109052.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_18 and arg_28_1.time_ < var_31_10 + var_31_18 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play109052008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 109052008
		arg_32_1.duration_ = 8.97

		local var_32_0 = {
			ja = 8.966,
			ko = 8.066,
			zh = 5.433,
			en = 5.566
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play109052009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			local var_35_0 = 0.55

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_1 = arg_32_1:GetWordFromCfg(109052008)
				local var_35_2 = arg_32_1:FormatText(var_35_1.content)

				arg_32_1.text_.text = var_35_2

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_4 = 22 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 22)

				if (22 <= 0 and var_35_0 or var_35_0 * (utf8.len(var_35_2) / 22)) > 0 and var_35_0 < var_35_4 then
					arg_32_1.talkMaxDuration = var_35_4

					if var_35_4 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_4 + 0
					end
				end

				arg_32_1.text_.text = var_35_2
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052008", "story_v_out_109052.awb") ~= 0 then
					local var_35_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052008", "story_v_out_109052.awb") / 1000

					if var_35_5 + 0 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + 0
					end

					if var_35_1.prefab_name ~= "" and arg_32_1.actors_[var_35_1.prefab_name] ~= nil then
						local var_35_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_1.prefab_name].transform, "story_v_out_109052", "109052008", "story_v_out_109052.awb")

						arg_32_1:RecordAudio("109052008", var_35_6)
						arg_32_1:RecordAudio("109052008", var_35_6)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_109052", "109052008", "story_v_out_109052.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_109052", "109052008", "story_v_out_109052.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_7 = math.max(var_35_0, arg_32_1.talkMaxDuration)

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - 0) / var_35_7

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play109052009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 109052009
		arg_36_1.duration_ = 2

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play109052010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["3004_tpose"]) and arg_36_1.var_.characterEffect3004_tpose == nil then
				arg_36_1.var_.characterEffect3004_tpose = arg_36_1.actors_["3004_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.2

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["3004_tpose"]) then
				if arg_36_1.var_.characterEffect3004_tpose and not isNil(arg_36_1.actors_["3004_tpose"]) then
					arg_36_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["3004_tpose"]) and arg_36_1.var_.characterEffect3004_tpose then
				arg_36_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["4014_tpose"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos4014_tpose = var_39_2.localPosition

				local var_39_3 = GameObjectTools.GetOrAddComponent(var_39_2.gameObject, typeof(DynamicBoneHelper))

				if var_39_3 then
					var_39_3:EnableDynamicBone(false)
				end
			end

			local var_39_4 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 then
				var_39_2.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_4)
				var_39_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_2.position).x, (manager.ui.mainCamera.transform.position - var_39_2.position).y, (manager.ui.mainCamera.transform.position - var_39_2.position).z)
				var_39_2.localEulerAngles.z = 0
				var_39_2.localEulerAngles.x = 0
				var_39_2.localEulerAngles = var_39_2.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 then
				var_39_2.localPosition = Vector3.New(0, 100, 0)
				var_39_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_2.position).x, (manager.ui.mainCamera.transform.position - var_39_2.position).y, (manager.ui.mainCamera.transform.position - var_39_2.position).z)
				var_39_2.localEulerAngles.z = 0
				var_39_2.localEulerAngles.x = 0
				var_39_2.localEulerAngles = var_39_2.localEulerAngles

				local var_39_5 = GameObjectTools.GetOrAddComponent(var_39_2.gameObject, typeof(DynamicBoneHelper))

				if var_39_5 then
					var_39_5:EnableDynamicBone(true)
				end
			end

			local var_39_6 = arg_36_1.actors_["3004_tpose"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos3004_tpose = var_39_6.localPosition

				local var_39_7 = GameObjectTools.GetOrAddComponent(var_39_6.gameObject, typeof(DynamicBoneHelper))

				if var_39_7 then
					var_39_7:EnableDynamicBone(false)
				end
			end

			local var_39_8 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_8 then
				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_36_1.time_ - 0) / var_39_8)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_8 and arg_36_1.time_ < 0 + var_39_8 + arg_39_0 then
				var_39_6.localPosition = Vector3.New(0, -2.22, -3.1)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles

				local var_39_9 = GameObjectTools.GetOrAddComponent(var_39_6.gameObject, typeof(DynamicBoneHelper))

				if var_39_9 then
					var_39_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_39_10 = 0
			local var_39_11 = 0.1

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_12 = arg_36_1:GetWordFromCfg(109052009)
				local var_39_13 = arg_36_1:FormatText(var_39_12.content)

				arg_36_1.text_.text = var_39_13

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 4 <= 0 and var_39_11 or var_39_11 * (utf8.len(var_39_13) / 4)

				if (4 <= 0 and var_39_11 or var_39_11 * (utf8.len(var_39_13) / 4)) > 0 and var_39_11 < var_39_15 then
					arg_36_1.talkMaxDuration = var_39_15

					if var_39_15 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_15 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_13
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052009", "story_v_out_109052.awb") ~= 0 then
					local var_39_16 = manager.audio:GetVoiceLength("story_v_out_109052", "109052009", "story_v_out_109052.awb") / 1000

					if var_39_16 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_16 + var_39_10
					end

					if var_39_12.prefab_name ~= "" and arg_36_1.actors_[var_39_12.prefab_name] ~= nil then
						local var_39_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_12.prefab_name].transform, "story_v_out_109052", "109052009", "story_v_out_109052.awb")

						arg_36_1:RecordAudio("109052009", var_39_17)
						arg_36_1:RecordAudio("109052009", var_39_17)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_109052", "109052009", "story_v_out_109052.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_109052", "109052009", "story_v_out_109052.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_18 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_18 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_18

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_18 and arg_36_1.time_ < var_39_10 + var_39_18 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play109052010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 109052010
		arg_40_1.duration_ = 4.07

		local var_40_0 = {
			ja = 1.366,
			ko = 3.5,
			zh = 3.533,
			en = 4.066
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play109052011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0.7 < arg_40_1.time_ and arg_40_1.time_ <= 0.7 + arg_43_0 then
				arg_40_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_43_0 = 0.1

			if 0.7 <= arg_40_1.time_ and arg_40_1.time_ < 0.7 + var_43_0 then
				local var_43_1, var_43_2 = math.modf((arg_40_1.time_ - 0.7) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_43_2 * 0.13, var_43_2 * 0.13, var_43_2 * 0.13) + arg_40_1.var_.shakeOldPos
			end

			if arg_40_1.time_ >= 0.7 + var_43_0 and arg_40_1.time_ < 0.7 + var_43_0 + arg_43_0 then
				manager.ui.mainCamera.transform.localPosition = arg_40_1.var_.shakeOldPos
			end

			local var_43_3 = 0
			local var_43_4 = 0.3

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_3 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_5 = arg_40_1:GetWordFromCfg(109052010)
				local var_43_6 = arg_40_1:FormatText(var_43_5.content)

				arg_40_1.text_.text = var_43_6

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_8 = 12 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_6) / 12)

				if (12 <= 0 and var_43_4 or var_43_4 * (utf8.len(var_43_6) / 12)) > 0 and var_43_4 < var_43_8 then
					arg_40_1.talkMaxDuration = var_43_8

					if var_43_8 + var_43_3 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_3
					end
				end

				arg_40_1.text_.text = var_43_6
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052010", "story_v_out_109052.awb") ~= 0 then
					local var_43_9 = manager.audio:GetVoiceLength("story_v_out_109052", "109052010", "story_v_out_109052.awb") / 1000

					if var_43_9 + var_43_3 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_3
					end

					if var_43_5.prefab_name ~= "" and arg_40_1.actors_[var_43_5.prefab_name] ~= nil then
						local var_43_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_5.prefab_name].transform, "story_v_out_109052", "109052010", "story_v_out_109052.awb")

						arg_40_1:RecordAudio("109052010", var_43_10)
						arg_40_1:RecordAudio("109052010", var_43_10)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_109052", "109052010", "story_v_out_109052.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_109052", "109052010", "story_v_out_109052.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_11 = math.max(var_43_4, arg_40_1.talkMaxDuration)

			if var_43_3 <= arg_40_1.time_ and arg_40_1.time_ < var_43_3 + var_43_11 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_3) / var_43_11

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_3 + var_43_11 and arg_40_1.time_ < var_43_3 + var_43_11 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play109052011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 109052011
		arg_44_1.duration_ = 10.93

		local var_44_0 = {
			ja = 10.933,
			ko = 4.3,
			zh = 7.8,
			en = 7.133
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play109052012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if arg_44_1.bgs_.S0904 == nil then
				local var_47_0 = Object.Instantiate(arg_44_1.paintGo_)

				var_47_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "S0904")
				var_47_0.name = "S0904"
				var_47_0.transform.parent = arg_44_1.stage_.transform
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.bgs_.S0904 = var_47_0
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				local var_47_1 = arg_44_1.bgs_.S0904

				arg_44_1.bgs_.S0904.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_47_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_47_2 = var_47_1:GetComponent("SpriteRenderer")

				if var_47_2 and var_47_2.sprite then
					local var_47_3 = 2 * (var_47_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_47_1.transform.localScale = Vector3.New(var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, var_47_3 / var_47_2.sprite.bounds.size.y < var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x and var_47_3 * manager.ui.mainCameraCom_.aspect / var_47_2.sprite.bounds.size.x or var_47_3 / var_47_2.sprite.bounds.size.y, 0)
				end

				for iter_47_0, iter_47_1 in pairs(arg_44_1.bgs_) do
					if iter_47_0 ~= "S0904" then
						iter_47_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_47_4 = arg_44_1.bgs_.S0904.transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPosS0904 = var_47_4.localPosition
			end

			local var_47_5 = 2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPosS0904, Vector3.New(0, 1, 9.5), (arg_44_1.time_ - 0) / var_47_5)
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_47_6 = arg_44_1.actors_["3004_tpose"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos3004_tpose = var_47_6.localPosition

				local var_47_7 = GameObjectTools.GetOrAddComponent(var_47_6.gameObject, typeof(DynamicBoneHelper))

				if var_47_7 then
					var_47_7:EnableDynamicBone(false)
				end
			end

			local var_47_8 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_8 then
				var_47_6.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_8)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_8 and arg_44_1.time_ < 0 + var_47_8 + arg_47_0 then
				var_47_6.localPosition = Vector3.New(0, 100, 0)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles

				local var_47_9 = GameObjectTools.GetOrAddComponent(var_47_6.gameObject, typeof(DynamicBoneHelper))

				if var_47_9 then
					var_47_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				local var_47_10 = arg_44_1.bgs_.S0904:GetComponent("SpriteRenderer")

				if var_47_10 then
					arg_44_1.var_.alphaOldValueS0904 = var_47_10.color.a
					arg_44_1.var_.alphaMatValueS0904 = var_47_10
				end

				arg_44_1.var_.alphaOldValueS0904 = 0
			end

			local var_47_11 = 1.13333333333333

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_11 then
				if arg_44_1.var_.alphaMatValueS0904 then
					arg_44_1.var_.alphaMatValueS0904.color.a = Mathf.Lerp(arg_44_1.var_.alphaOldValueS0904, 1, (arg_44_1.time_ - 0) / var_47_11)
					arg_44_1.var_.alphaMatValueS0904.color = arg_44_1.var_.alphaMatValueS0904.color
				end
			end

			if arg_44_1.time_ >= 0 + var_47_11 and arg_44_1.time_ < 0 + var_47_11 + arg_47_0 and arg_44_1.var_.alphaMatValueS0904 then
				arg_44_1.var_.alphaMatValueS0904.color.a = 1
				arg_44_1.var_.alphaMatValueS0904.color = arg_44_1.var_.alphaMatValueS0904.color
			end

			local var_47_12 = 0
			local var_47_13 = 0.575

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_12 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_14 = arg_44_1:GetWordFromCfg(109052011)
				local var_47_15 = arg_44_1:FormatText(var_47_14.content)

				arg_44_1.text_.text = var_47_15

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_17 = 23 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 23)

				if (23 <= 0 and var_47_13 or var_47_13 * (utf8.len(var_47_15) / 23)) > 0 and var_47_13 < var_47_17 then
					arg_44_1.talkMaxDuration = var_47_17

					if var_47_17 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_17 + var_47_12
					end
				end

				arg_44_1.text_.text = var_47_15
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052011", "story_v_out_109052.awb") ~= 0 then
					local var_47_18 = manager.audio:GetVoiceLength("story_v_out_109052", "109052011", "story_v_out_109052.awb") / 1000

					if var_47_18 + var_47_12 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_12
					end

					if var_47_14.prefab_name ~= "" and arg_44_1.actors_[var_47_14.prefab_name] ~= nil then
						local var_47_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_14.prefab_name].transform, "story_v_out_109052", "109052011", "story_v_out_109052.awb")

						arg_44_1:RecordAudio("109052011", var_47_19)
						arg_44_1:RecordAudio("109052011", var_47_19)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_109052", "109052011", "story_v_out_109052.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_109052", "109052011", "story_v_out_109052.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_20 = math.max(var_47_13, arg_44_1.talkMaxDuration)

			if var_47_12 <= arg_44_1.time_ and arg_44_1.time_ < var_47_12 + var_47_20 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_12) / var_47_20

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_12 + var_47_20 and arg_44_1.time_ < var_47_12 + var_47_20 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "S0904",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play109052012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109052012
		arg_48_1.duration_ = 5.83

		local var_48_0 = {
			ja = 5.4,
			ko = 4.1,
			zh = 5.833,
			en = 4.633
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play109052013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.575

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_1 = arg_48_1:GetWordFromCfg(109052012)
				local var_51_2 = arg_48_1:FormatText(var_51_1.content)

				arg_48_1.text_.text = var_51_2

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_4 = 23 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 23)

				if (23 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_2) / 23)) > 0 and var_51_0 < var_51_4 then
					arg_48_1.talkMaxDuration = var_51_4

					if var_51_4 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_4 + 0
					end
				end

				arg_48_1.text_.text = var_51_2
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052012", "story_v_out_109052.awb") ~= 0 then
					local var_51_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052012", "story_v_out_109052.awb") / 1000

					if var_51_5 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + 0
					end

					if var_51_1.prefab_name ~= "" and arg_48_1.actors_[var_51_1.prefab_name] ~= nil then
						local var_51_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_1.prefab_name].transform, "story_v_out_109052", "109052012", "story_v_out_109052.awb")

						arg_48_1:RecordAudio("109052012", var_51_6)
						arg_48_1:RecordAudio("109052012", var_51_6)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_109052", "109052012", "story_v_out_109052.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_109052", "109052012", "story_v_out_109052.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_7 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_7

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play109052013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 109052013
		arg_52_1.duration_ = 6.93

		local var_52_0 = {
			ja = 6.933,
			ko = 5.7,
			zh = 5.1,
			en = 4.966
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play109052014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 0.55

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_1 = arg_52_1:GetWordFromCfg(109052013)
				local var_55_2 = arg_52_1:FormatText(var_55_1.content)

				arg_52_1.text_.text = var_55_2

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_4 = 22 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 22)

				if (22 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_2) / 22)) > 0 and var_55_0 < var_55_4 then
					arg_52_1.talkMaxDuration = var_55_4

					if var_55_4 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_4 + 0
					end
				end

				arg_52_1.text_.text = var_55_2
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052013", "story_v_out_109052.awb") ~= 0 then
					local var_55_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052013", "story_v_out_109052.awb") / 1000

					if var_55_5 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + 0
					end

					if var_55_1.prefab_name ~= "" and arg_52_1.actors_[var_55_1.prefab_name] ~= nil then
						local var_55_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_1.prefab_name].transform, "story_v_out_109052", "109052013", "story_v_out_109052.awb")

						arg_52_1:RecordAudio("109052013", var_55_6)
						arg_52_1:RecordAudio("109052013", var_55_6)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_109052", "109052013", "story_v_out_109052.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_109052", "109052013", "story_v_out_109052.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_7 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_7

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play109052014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 109052014
		arg_56_1.duration_ = 12.57

		local var_56_0 = {
			ja = 12.566,
			ko = 12.3,
			zh = 12,
			en = 11.8
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play109052015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 1.35

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:GetWordFromCfg(109052014)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 54 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 54)

				if (54 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 54)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052014", "story_v_out_109052.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052014", "story_v_out_109052.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_109052", "109052014", "story_v_out_109052.awb")

						arg_56_1:RecordAudio("109052014", var_59_6)
						arg_56_1:RecordAudio("109052014", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_109052", "109052014", "story_v_out_109052.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_109052", "109052014", "story_v_out_109052.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_7 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_7 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_7

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_7 and arg_56_1.time_ < 0 + var_59_7 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play109052015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 109052015
		arg_60_1.duration_ = 10.83

		local var_60_0 = {
			ja = 9.6,
			ko = 8.3,
			zh = 10.833,
			en = 7.9
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play109052016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.925

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:GetWordFromCfg(109052015)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 37 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 37)

				if (37 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 37)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052015", "story_v_out_109052.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052015", "story_v_out_109052.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_109052", "109052015", "story_v_out_109052.awb")

						arg_60_1:RecordAudio("109052015", var_63_6)
						arg_60_1:RecordAudio("109052015", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_109052", "109052015", "story_v_out_109052.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_109052", "109052015", "story_v_out_109052.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_7 = math.max(var_63_0, arg_60_1.talkMaxDuration)

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - 0) / var_63_7

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play109052016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 109052016
		arg_64_1.duration_ = 11.1

		local var_64_0 = {
			ja = 10.266,
			ko = 11.1,
			zh = 10.866,
			en = 10.566
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play109052017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			local var_67_0 = 0.975

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_1 = arg_64_1:GetWordFromCfg(109052016)
				local var_67_2 = arg_64_1:FormatText(var_67_1.content)

				arg_64_1.text_.text = var_67_2

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_4 = 39 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 39)

				if (39 <= 0 and var_67_0 or var_67_0 * (utf8.len(var_67_2) / 39)) > 0 and var_67_0 < var_67_4 then
					arg_64_1.talkMaxDuration = var_67_4

					if var_67_4 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_4 + 0
					end
				end

				arg_64_1.text_.text = var_67_2
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052016", "story_v_out_109052.awb") ~= 0 then
					local var_67_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052016", "story_v_out_109052.awb") / 1000

					if var_67_5 + 0 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + 0
					end

					if var_67_1.prefab_name ~= "" and arg_64_1.actors_[var_67_1.prefab_name] ~= nil then
						local var_67_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_1.prefab_name].transform, "story_v_out_109052", "109052016", "story_v_out_109052.awb")

						arg_64_1:RecordAudio("109052016", var_67_6)
						arg_64_1:RecordAudio("109052016", var_67_6)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_109052", "109052016", "story_v_out_109052.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_109052", "109052016", "story_v_out_109052.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_7 = math.max(var_67_0, arg_64_1.talkMaxDuration)

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - 0) / var_67_7

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play109052017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 109052017
		arg_68_1.duration_ = 3.97

		local var_68_0 = {
			ja = 2.8,
			ko = 2.433,
			zh = 3.233,
			en = 3.966
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play109052018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.2

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_1 = arg_68_1:GetWordFromCfg(109052017)
				local var_71_2 = arg_68_1:FormatText(var_71_1.content)

				arg_68_1.text_.text = var_71_2

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_4 = 8 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 8)

				if (8 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_2) / 8)) > 0 and var_71_0 < var_71_4 then
					arg_68_1.talkMaxDuration = var_71_4

					if var_71_4 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_4 + 0
					end
				end

				arg_68_1.text_.text = var_71_2
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052017", "story_v_out_109052.awb") ~= 0 then
					local var_71_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052017", "story_v_out_109052.awb") / 1000

					if var_71_5 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + 0
					end

					if var_71_1.prefab_name ~= "" and arg_68_1.actors_[var_71_1.prefab_name] ~= nil then
						local var_71_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_1.prefab_name].transform, "story_v_out_109052", "109052017", "story_v_out_109052.awb")

						arg_68_1:RecordAudio("109052017", var_71_6)
						arg_68_1:RecordAudio("109052017", var_71_6)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_109052", "109052017", "story_v_out_109052.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_109052", "109052017", "story_v_out_109052.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_7 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_7

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play109052018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 109052018
		arg_72_1.duration_ = 14.23

		local var_72_0 = {
			ja = 14.233,
			ko = 7.766,
			zh = 10.466,
			en = 10.9
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play109052019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.875

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:GetWordFromCfg(109052018)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 35 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 35)

				if (35 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 35)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052018", "story_v_out_109052.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052018", "story_v_out_109052.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_109052", "109052018", "story_v_out_109052.awb")

						arg_72_1:RecordAudio("109052018", var_75_6)
						arg_72_1:RecordAudio("109052018", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_109052", "109052018", "story_v_out_109052.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_109052", "109052018", "story_v_out_109052.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_7 = math.max(var_75_0, arg_72_1.talkMaxDuration)

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_7 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - 0) / var_75_7

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= 0 + var_75_7 and arg_72_1.time_ < 0 + var_75_7 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play109052019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 109052019
		arg_76_1.duration_ = 10.87

		local var_76_0 = {
			ja = 10.866,
			ko = 9.866,
			zh = 9.066,
			en = 8.733
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play109052020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 1.025

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:GetWordFromCfg(109052019)
				local var_79_2 = arg_76_1:FormatText(var_79_1.content)

				arg_76_1.text_.text = var_79_2

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_4 = 41 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 41)

				if (41 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_2) / 41)) > 0 and var_79_0 < var_79_4 then
					arg_76_1.talkMaxDuration = var_79_4

					if var_79_4 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_4 + 0
					end
				end

				arg_76_1.text_.text = var_79_2
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052019", "story_v_out_109052.awb") ~= 0 then
					local var_79_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052019", "story_v_out_109052.awb") / 1000

					if var_79_5 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + 0
					end

					if var_79_1.prefab_name ~= "" and arg_76_1.actors_[var_79_1.prefab_name] ~= nil then
						local var_79_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_1.prefab_name].transform, "story_v_out_109052", "109052019", "story_v_out_109052.awb")

						arg_76_1:RecordAudio("109052019", var_79_6)
						arg_76_1:RecordAudio("109052019", var_79_6)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_109052", "109052019", "story_v_out_109052.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_109052", "109052019", "story_v_out_109052.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_7 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_7

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play109052020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 109052020
		arg_80_1.duration_ = 9.6

		local var_80_0 = {
			ja = 9.6,
			ko = 7.6,
			zh = 9.4,
			en = 7.666
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play109052021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.875

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:GetWordFromCfg(109052020)
				local var_83_2 = arg_80_1:FormatText(var_83_1.content)

				arg_80_1.text_.text = var_83_2

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_4 = 35 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 35)

				if (35 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_2) / 35)) > 0 and var_83_0 < var_83_4 then
					arg_80_1.talkMaxDuration = var_83_4

					if var_83_4 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_4 + 0
					end
				end

				arg_80_1.text_.text = var_83_2
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052020", "story_v_out_109052.awb") ~= 0 then
					local var_83_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052020", "story_v_out_109052.awb") / 1000

					if var_83_5 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_5 + 0
					end

					if var_83_1.prefab_name ~= "" and arg_80_1.actors_[var_83_1.prefab_name] ~= nil then
						local var_83_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_1.prefab_name].transform, "story_v_out_109052", "109052020", "story_v_out_109052.awb")

						arg_80_1:RecordAudio("109052020", var_83_6)
						arg_80_1:RecordAudio("109052020", var_83_6)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_109052", "109052020", "story_v_out_109052.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_109052", "109052020", "story_v_out_109052.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_7 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_7

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play109052021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 109052021
		arg_84_1.duration_ = 12.07

		local var_84_0 = {
			ja = 11.733,
			ko = 12.066,
			zh = 11.1,
			en = 11.833
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play109052022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.95

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:GetWordFromCfg(109052021)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 38 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 38)

				if (38 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 38)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052021", "story_v_out_109052.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052021", "story_v_out_109052.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_109052", "109052021", "story_v_out_109052.awb")

						arg_84_1:RecordAudio("109052021", var_87_6)
						arg_84_1:RecordAudio("109052021", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_109052", "109052021", "story_v_out_109052.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_109052", "109052021", "story_v_out_109052.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_7 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_7 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_7

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_7 and arg_84_1.time_ < 0 + var_87_7 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play109052022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 109052022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play109052023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.7

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, false)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(109052022).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 28 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 28)

				if (28 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 28)) > 0 and var_91_0 < var_91_3 then
					arg_88_1.talkMaxDuration = var_91_3

					if var_91_3 + 0 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_3 + 0
					end
				end

				arg_88_1.text_.text = var_91_1
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_4 = math.max(var_91_0, arg_88_1.talkMaxDuration)

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - 0) / var_91_4

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play109052023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 109052023
		arg_92_1.duration_ = 3.9

		local var_92_0 = {
			ja = 2.3,
			ko = 2.2,
			zh = 3.9,
			en = 2.6
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play109052024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			local var_95_0 = 0.175

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_1 = arg_92_1:GetWordFromCfg(109052023)
				local var_95_2 = arg_92_1:FormatText(var_95_1.content)

				arg_92_1.text_.text = var_95_2

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_4 = 7 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 7)

				if (7 <= 0 and var_95_0 or var_95_0 * (utf8.len(var_95_2) / 7)) > 0 and var_95_0 < var_95_4 then
					arg_92_1.talkMaxDuration = var_95_4

					if var_95_4 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_4 + 0
					end
				end

				arg_92_1.text_.text = var_95_2
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052023", "story_v_out_109052.awb") ~= 0 then
					local var_95_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052023", "story_v_out_109052.awb") / 1000

					if var_95_5 + 0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + 0
					end

					if var_95_1.prefab_name ~= "" and arg_92_1.actors_[var_95_1.prefab_name] ~= nil then
						local var_95_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_1.prefab_name].transform, "story_v_out_109052", "109052023", "story_v_out_109052.awb")

						arg_92_1:RecordAudio("109052023", var_95_6)
						arg_92_1:RecordAudio("109052023", var_95_6)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_109052", "109052023", "story_v_out_109052.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_109052", "109052023", "story_v_out_109052.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_7 = math.max(var_95_0, arg_92_1.talkMaxDuration)

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - 0) / var_95_7

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play109052024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 109052024
		arg_96_1.duration_ = 3.93

		local var_96_0 = {
			ja = 3.033,
			ko = 1.5,
			zh = 3.933,
			en = 2
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
			arg_96_1.auto_ = false
		end

		function arg_96_1.playNext_(arg_98_0)
			arg_96_1.onStoryFinished_()
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			local var_99_0 = 0.5

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_1 = arg_96_1:GetWordFromCfg(109052024)
				local var_99_2 = arg_96_1:FormatText(var_99_1.content)

				arg_96_1.text_.text = var_99_2

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_4 = 7 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 7)

				if (7 <= 0 and var_99_0 or var_99_0 * (utf8.len(var_99_2) / 7)) > 0 and var_99_0 < var_99_4 then
					arg_96_1.talkMaxDuration = var_99_4

					if var_99_4 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_4 + 0
					end
				end

				arg_96_1.text_.text = var_99_2
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109052", "109052024", "story_v_out_109052.awb") ~= 0 then
					local var_99_5 = manager.audio:GetVoiceLength("story_v_out_109052", "109052024", "story_v_out_109052.awb") / 1000

					if var_99_5 + 0 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + 0
					end

					if var_99_1.prefab_name ~= "" and arg_96_1.actors_[var_99_1.prefab_name] ~= nil then
						local var_99_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_1.prefab_name].transform, "story_v_out_109052", "109052024", "story_v_out_109052.awb")

						arg_96_1:RecordAudio("109052024", var_99_6)
						arg_96_1:RecordAudio("109052024", var_99_6)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_109052", "109052024", "story_v_out_109052.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_109052", "109052024", "story_v_out_109052.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_7 = math.max(var_99_0, arg_96_1.talkMaxDuration)

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - 0) / var_99_7

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST06a",
		"TextureConfig/Background/S0904"
	},
	voices = {
		"story_v_out_109052.awb"
	}
}
