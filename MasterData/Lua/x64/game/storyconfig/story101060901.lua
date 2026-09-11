return {
	Play106091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 106091001
		arg_1_1.duration_ = 8.1

		local var_1_0 = {
			ja = 6.8,
			ko = 4.8,
			zh = 7.766,
			en = 8.1
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
				arg_1_0:Play106091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C05b == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C05b")
				var_4_0.name = "C05b"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C05b = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C05b

				arg_1_1.bgs_.C05b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C05b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.C05b:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueC05b = var_4_4.color.a
					arg_1_1.var_.alphaMatValueC05b = var_4_4
				end

				arg_1_1.var_.alphaOldValueC05b = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueC05b then
					arg_1_1.var_.alphaMatValueC05b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueC05b, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueC05b.color = arg_1_1.var_.alphaMatValueC05b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueC05b then
				arg_1_1.var_.alphaMatValueC05b.color.a = 1
				arg_1_1.var_.alphaMatValueC05b.color = arg_1_1.var_.alphaMatValueC05b.color
			end

			local var_4_6 = manager.ui.mainCamera.transform

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_6.localPosition
			end

			local var_4_7 = 0.6

			if 1.5 <= arg_1_1.time_ and arg_1_1.time_ < 1.5 + var_4_7 then
				local var_4_8, var_4_9 = math.modf((arg_1_1.time_ - 1.5) / 0.066)

				var_4_6.localPosition = Vector3.New(var_4_9 * 0.13, var_4_9 * 0.13, var_4_9 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 1.5 + var_4_7 and arg_1_1.time_ < 1.5 + var_4_7 + arg_4_0 then
				var_4_6.localPosition = arg_1_1.var_.shakeOldPos
			end

			local var_4_10 = 1.825

			if 1.825 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

				arg_1_1:SetGaussion(false)
			end

			local var_4_11 = 0.5

			if var_4_10 <= arg_1_1.time_ and arg_1_1.time_ < var_4_10 + var_4_11 then
				local var_4_12 = Color.New(1, 1, 1)

				var_4_12.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_10) / var_4_11)
				arg_1_1.mask_.color = var_4_12
			end

			if arg_1_1.time_ >= var_4_10 + var_4_11 and arg_1_1.time_ < var_4_10 + var_4_11 + arg_4_0 then
				local var_4_13 = Color.New(1, 1, 1)

				arg_1_1.mask_.enabled = false
				var_4_13.a = 0
				arg_1_1.mask_.color = var_4_13
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_16 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			local var_4_17 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_17 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_17 + 2 and arg_1_1.time_ < var_4_17 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_6", "se_story_6_slap01", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_19 = 2
			local var_4_20 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[88].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_22 = arg_1_1:GetWordFromCfg(106091001)
				local var_4_23 = arg_1_1:FormatText(var_4_22.content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 13 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 13)

				if (13 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_23) / 13)) > 0 and var_4_20 < var_4_25 then
					arg_1_1.talkMaxDuration = var_4_25
					var_4_19 = var_4_19 + 0.3

					if var_4_25 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_23
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091001", "story_v_out_106091.awb") ~= 0 then
					local var_4_26 = manager.audio:GetVoiceLength("story_v_out_106091", "106091001", "story_v_out_106091.awb") / 1000

					if var_4_26 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_19
					end

					if var_4_22.prefab_name ~= "" and arg_1_1.actors_[var_4_22.prefab_name] ~= nil then
						local var_4_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_22.prefab_name].transform, "story_v_out_106091", "106091001", "story_v_out_106091.awb")

						arg_1_1:RecordAudio("106091001", var_4_27)
						arg_1_1:RecordAudio("106091001", var_4_27)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_106091", "106091001", "story_v_out_106091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_106091", "106091001", "story_v_out_106091.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_28 = var_4_19 + 0.3
			local var_4_29 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_28 + var_4_29 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_28) / var_4_29

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_28 + var_4_29 and arg_1_1.time_ < var_4_28 + var_4_29 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play106091002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 106091002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play106091003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["2026_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2026_tpose"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "2026_tpose"), arg_8_1.stage_.transform)

				var_11_0.name = "2026_tpose"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["2026_tpose"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["2026_tpose" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["2026_tpose" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["2026_tpose" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["2026_tpose"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect2026_tpose == nil then
				arg_8_1.var_.characterEffect2026_tpose = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect2026_tpose and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect2026_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect2026_tpose then
				arg_8_1.var_.characterEffect2026_tpose.fillFlat = false
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_6", "se_story_6_monster", "")
			end

			local var_11_7 = 0
			local var_11_8 = 0.1

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_7 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[68].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, true)
				arg_8_1.iconController_:SetSelectedState("hero")

				arg_8_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2037")

				arg_8_1.callingController_:SetSelectedState("normal")

				arg_8_1.keyicon_.color = Color.New(1, 1, 1)
				arg_8_1.icon_.color = Color.New(1, 1, 1)

				local var_11_9 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(106091002).content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 4 <= 0 and var_11_8 or var_11_8 * (utf8.len(var_11_9) / 4)

				if (4 <= 0 and var_11_8 or var_11_8 * (utf8.len(var_11_9) / 4)) > 0 and var_11_8 < var_11_11 then
					arg_8_1.talkMaxDuration = var_11_11

					if var_11_11 + var_11_7 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_11 + var_11_7
					end
				end

				arg_8_1.text_.text = var_11_9
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_12 = math.max(var_11_8, arg_8_1.talkMaxDuration)

			if var_11_7 <= arg_8_1.time_ and arg_8_1.time_ < var_11_7 + var_11_12 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_7) / var_11_12

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_7 + var_11_12 and arg_8_1.time_ < var_11_7 + var_11_12 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play106091003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 106091003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play106091004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["2026_tpose"]) and arg_12_1.var_.characterEffect2026_tpose == nil then
				arg_12_1.var_.characterEffect2026_tpose = arg_12_1.actors_["2026_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["2026_tpose"]) then
				if arg_12_1.var_.characterEffect2026_tpose and not isNil(arg_12_1.actors_["2026_tpose"]) then
					arg_12_1.var_.characterEffect2026_tpose.fillFlat = true
					arg_12_1.var_.characterEffect2026_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["2026_tpose"]) and arg_12_1.var_.characterEffect2026_tpose then
				arg_12_1.var_.characterEffect2026_tpose.fillFlat = true
				arg_12_1.var_.characterEffect2026_tpose.fillRatio = 0.5
			end

			local var_15_1 = arg_12_1.actors_["2026_tpose"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos2026_tpose = var_15_1.localPosition

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_1.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end
			end

			local var_15_3 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 then
				var_15_1.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos2026_tpose, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_3)
				var_15_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_1.position).x, (manager.ui.mainCamera.transform.position - var_15_1.position).y, (manager.ui.mainCamera.transform.position - var_15_1.position).z)
				var_15_1.localEulerAngles.z = 0
				var_15_1.localEulerAngles.x = 0
				var_15_1.localEulerAngles = var_15_1.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 then
				var_15_1.localPosition = Vector3.New(0, 100, 0)
				var_15_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_1.position).x, (manager.ui.mainCamera.transform.position - var_15_1.position).y, (manager.ui.mainCamera.transform.position - var_15_1.position).z)
				var_15_1.localEulerAngles.z = 0
				var_15_1.localEulerAngles.x = 0
				var_15_1.localEulerAngles = var_15_1.localEulerAngles

				local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_1.gameObject, typeof(DynamicBoneHelper))

				if var_15_4 then
					var_15_4:EnableDynamicBone(true)
				end
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:AudioAction("play", "effect", "se_story_6", "se_story_6_slap02", "")
			end

			local var_15_6 = 0
			local var_15_7 = 1.075

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_6 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_8 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(106091003).content)

				arg_12_1.text_.text = var_15_8

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 43 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_8) / 43)

				if (43 <= 0 and var_15_7 or var_15_7 * (utf8.len(var_15_8) / 43)) > 0 and var_15_7 < var_15_10 then
					arg_12_1.talkMaxDuration = var_15_10

					if var_15_10 + var_15_6 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_6
					end
				end

				arg_12_1.text_.text = var_15_8
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_11 = math.max(var_15_7, arg_12_1.talkMaxDuration)

			if var_15_6 <= arg_12_1.time_ and arg_12_1.time_ < var_15_6 + var_15_11 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_6) / var_15_11

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_6 + var_15_11 and arg_12_1.time_ < var_15_6 + var_15_11 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2026_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play106091004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 106091004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play106091005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_6", "se_story_6_corrosion_loop", "")
			end

			local var_19_1 = 0
			local var_19_2 = 1.125

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(106091004).content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 45 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 45)

				if (45 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 45)) > 0 and var_19_2 < var_19_5 then
					arg_16_1.talkMaxDuration = var_19_5

					if var_19_5 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_6 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_6 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_6

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_6 and arg_16_1.time_ < var_19_1 + var_19_6 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play106091005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 106091005
		arg_20_1.duration_ = 2

		local var_20_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2
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
				arg_20_0:Play106091006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["4014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4014_tpose"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_20_1.stage_.transform)

				var_23_0.name = "4014_tpose"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["4014_tpose"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["4014_tpose" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["4014_tpose" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["4014_tpose" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["4014_tpose"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect4014_tpose == nil then
				arg_20_1.var_.characterEffect4014_tpose = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect4014_tpose and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect4014_tpose then
				arg_20_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_23_6 = arg_20_1.actors_["4014_tpose"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos4014_tpose = var_23_6.localPosition

				local var_23_7 = GameObjectTools.GetOrAddComponent(var_23_6.gameObject, typeof(DynamicBoneHelper))

				if var_23_7 then
					var_23_7:EnableDynamicBone(false)
				end
			end

			local var_23_8 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_8 then
				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_20_1.time_ - 0) / var_23_8)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_8 and arg_20_1.time_ < 0 + var_23_8 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(0, -1.95, -4.2)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles

				local var_23_9 = GameObjectTools.GetOrAddComponent(var_23_6.gameObject, typeof(DynamicBoneHelper))

				if var_23_9 then
					var_23_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			if 0.4 < arg_20_1.time_ and arg_20_1.time_ <= 0.4 + arg_23_0 then
				arg_20_1:AudioAction("play", "effect", "se_story_6", "se_story_6_slap03", "")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:AudioAction("stop", "effect", "se_story_6", "se_story_6_corrosion_loop", "")
			end

			local var_23_12 = 0
			local var_23_13 = 0.125

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_12 + arg_23_0 then
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

				local var_23_14 = arg_20_1:GetWordFromCfg(106091005)
				local var_23_15 = arg_20_1:FormatText(var_23_14.content)

				arg_20_1.text_.text = var_23_15

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_17 = 5 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 5)

				if (5 <= 0 and var_23_13 or var_23_13 * (utf8.len(var_23_15) / 5)) > 0 and var_23_13 < var_23_17 then
					arg_20_1.talkMaxDuration = var_23_17

					if var_23_17 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_17 + var_23_12
					end
				end

				arg_20_1.text_.text = var_23_15
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091005", "story_v_out_106091.awb") ~= 0 then
					local var_23_18 = manager.audio:GetVoiceLength("story_v_out_106091", "106091005", "story_v_out_106091.awb") / 1000

					if var_23_18 + var_23_12 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_18 + var_23_12
					end

					if var_23_14.prefab_name ~= "" and arg_20_1.actors_[var_23_14.prefab_name] ~= nil then
						local var_23_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_14.prefab_name].transform, "story_v_out_106091", "106091005", "story_v_out_106091.awb")

						arg_20_1:RecordAudio("106091005", var_23_19)
						arg_20_1:RecordAudio("106091005", var_23_19)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_106091", "106091005", "story_v_out_106091.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_106091", "106091005", "story_v_out_106091.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_20 = math.max(var_23_13, arg_20_1.talkMaxDuration)

			if var_23_12 <= arg_20_1.time_ and arg_20_1.time_ < var_23_12 + var_23_20 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_12) / var_23_20

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_12 + var_23_20 and arg_20_1.time_ < var_23_12 + var_23_20 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play106091006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 106091006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play106091007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["4014_tpose"]) and arg_24_1.var_.characterEffect4014_tpose == nil then
				arg_24_1.var_.characterEffect4014_tpose = arg_24_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["4014_tpose"]) then
				if arg_24_1.var_.characterEffect4014_tpose and not isNil(arg_24_1.actors_["4014_tpose"]) then
					arg_24_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_24_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["4014_tpose"]) and arg_24_1.var_.characterEffect4014_tpose then
				arg_24_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_24_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_27_1 = arg_24_1.actors_["4014_tpose"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos4014_tpose = var_27_1.localPosition

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_1.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end
			end

			local var_27_3 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 then
				var_27_1.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_3)
				var_27_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_1.position).x, (manager.ui.mainCamera.transform.position - var_27_1.position).y, (manager.ui.mainCamera.transform.position - var_27_1.position).z)
				var_27_1.localEulerAngles.z = 0
				var_27_1.localEulerAngles.x = 0
				var_27_1.localEulerAngles = var_27_1.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 then
				var_27_1.localPosition = Vector3.New(0, 100, 0)
				var_27_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_1.position).x, (manager.ui.mainCamera.transform.position - var_27_1.position).y, (manager.ui.mainCamera.transform.position - var_27_1.position).z)
				var_27_1.localEulerAngles.z = 0
				var_27_1.localEulerAngles.x = 0
				var_27_1.localEulerAngles = var_27_1.localEulerAngles

				local var_27_4 = GameObjectTools.GetOrAddComponent(var_27_1.gameObject, typeof(DynamicBoneHelper))

				if var_27_4 then
					var_27_4:EnableDynamicBone(true)
				end
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:AudioAction("play", "effect", "se_story_6", "se_story_6_vessel_open", "")
			end

			local var_27_6 = 0
			local var_27_7 = 1.3

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, false)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(106091006).content)

				arg_24_1.text_.text = var_27_8

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_10 = 52 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_8) / 52)

				if (52 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_8) / 52)) > 0 and var_27_7 < var_27_10 then
					arg_24_1.talkMaxDuration = var_27_10

					if var_27_10 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_8
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_11 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_11 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_11

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_11 and arg_24_1.time_ < var_27_6 + var_27_11 + arg_27_0 then
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play106091007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 106091007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play106091008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			local var_31_0 = 0.9

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_1 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(106091007).content)

				arg_28_1.text_.text = var_31_1

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_3 = 36 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 36)

				if (36 <= 0 and var_31_0 or var_31_0 * (utf8.len(var_31_1) / 36)) > 0 and var_31_0 < var_31_3 then
					arg_28_1.talkMaxDuration = var_31_3

					if var_31_3 + 0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_3 + 0
					end
				end

				arg_28_1.text_.text = var_31_1
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_4 = math.max(var_31_0, arg_28_1.talkMaxDuration)

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - 0) / var_31_4

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play106091008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 106091008
		arg_32_1.duration_ = 7.73

		local var_32_0 = {
			ja = 7.233,
			ko = 5.2,
			zh = 6.266,
			en = 7.733
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
				arg_32_0:Play106091009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["4014_tpose"]) and arg_32_1.var_.characterEffect4014_tpose == nil then
				arg_32_1.var_.characterEffect4014_tpose = arg_32_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["4014_tpose"]) then
				if arg_32_1.var_.characterEffect4014_tpose and not isNil(arg_32_1.actors_["4014_tpose"]) then
					arg_32_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["4014_tpose"]) and arg_32_1.var_.characterEffect4014_tpose then
				arg_32_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_35_2 = "10004ui_story"

			if arg_32_1.actors_["10004ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10004ui_story"))) then
				local var_35_3 = Object.Instantiate(Asset.Load("Char/" .. "10004ui_story"), arg_32_1.stage_.transform)

				var_35_3.name = var_35_2
				var_35_3.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_[var_35_2] = var_35_3

				local var_35_4 = var_35_3:GetComponentInChildren(typeof(CharacterEffect))

				var_35_4.enabled = true

				local var_35_5 = GameObjectTools.GetOrAddComponent(var_35_3, typeof(DynamicBoneHelper))

				if var_35_5 then
					var_35_5:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_4.transform, false)

				arg_32_1.var_[var_35_2 .. "Animator"] = var_35_4.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_[var_35_2 .. "Animator"].applyRootMotion = true
				arg_32_1.var_[var_35_2 .. "LipSync"] = var_35_4.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_6 = arg_32_1.actors_["10004ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect10004ui_story == nil then
				arg_32_1.var_.characterEffect10004ui_story = var_35_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_7 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 and not isNil(var_35_6) then
				if arg_32_1.var_.characterEffect10004ui_story and not isNil(var_35_6) then
					arg_32_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_32_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_7)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect10004ui_story then
				arg_32_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_32_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_35_8 = arg_32_1.actors_["4014_tpose"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos4014_tpose = var_35_8.localPosition

				local var_35_9 = GameObjectTools.GetOrAddComponent(var_35_8.gameObject, typeof(DynamicBoneHelper))

				if var_35_9 then
					var_35_9:EnableDynamicBone(false)
				end
			end

			local var_35_10 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_10 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4014_tpose, Vector3.New(-0.7, -1.95, -4.2), (arg_32_1.time_ - 0) / var_35_10)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_10 and arg_32_1.time_ < 0 + var_35_10 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(-0.7, -1.95, -4.2)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles

				local var_35_11 = GameObjectTools.GetOrAddComponent(var_35_8.gameObject, typeof(DynamicBoneHelper))

				if var_35_11 then
					var_35_11:EnableDynamicBone(true)
				end
			end

			local var_35_12 = arg_32_1.actors_["10004ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos10004ui_story = var_35_12.localPosition
			end

			local var_35_13 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_13 then
				var_35_12.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10004ui_story, Vector3.New(0.7, -1.1, -5.6), (arg_32_1.time_ - 0) / var_35_13)
				var_35_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_12.position).x, (manager.ui.mainCamera.transform.position - var_35_12.position).y, (manager.ui.mainCamera.transform.position - var_35_12.position).z)
				var_35_12.localEulerAngles.z = 0
				var_35_12.localEulerAngles.x = 0
				var_35_12.localEulerAngles = var_35_12.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_13 and arg_32_1.time_ < 0 + var_35_13 + arg_35_0 then
				var_35_12.localPosition = Vector3.New(0.7, -1.1, -5.6)
				var_35_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_12.position).x, (manager.ui.mainCamera.transform.position - var_35_12.position).y, (manager.ui.mainCamera.transform.position - var_35_12.position).z)
				var_35_12.localEulerAngles.z = 0
				var_35_12.localEulerAngles.x = 0
				var_35_12.localEulerAngles = var_35_12.localEulerAngles
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action1_1")
			end

			local var_35_14 = 0
			local var_35_15 = 0.525

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_14 + arg_35_0 then
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

				local var_35_16 = arg_32_1:GetWordFromCfg(106091008)
				local var_35_17 = arg_32_1:FormatText(var_35_16.content)

				arg_32_1.text_.text = var_35_17

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_19 = 21 <= 0 and var_35_15 or var_35_15 * (utf8.len(var_35_17) / 21)

				if (21 <= 0 and var_35_15 or var_35_15 * (utf8.len(var_35_17) / 21)) > 0 and var_35_15 < var_35_19 then
					arg_32_1.talkMaxDuration = var_35_19

					if var_35_19 + var_35_14 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_19 + var_35_14
					end
				end

				arg_32_1.text_.text = var_35_17
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091008", "story_v_out_106091.awb") ~= 0 then
					local var_35_20 = manager.audio:GetVoiceLength("story_v_out_106091", "106091008", "story_v_out_106091.awb") / 1000

					if var_35_20 + var_35_14 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_20 + var_35_14
					end

					if var_35_16.prefab_name ~= "" and arg_32_1.actors_[var_35_16.prefab_name] ~= nil then
						local var_35_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_16.prefab_name].transform, "story_v_out_106091", "106091008", "story_v_out_106091.awb")

						arg_32_1:RecordAudio("106091008", var_35_21)
						arg_32_1:RecordAudio("106091008", var_35_21)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_106091", "106091008", "story_v_out_106091.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_106091", "106091008", "story_v_out_106091.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_22 = math.max(var_35_15, arg_32_1.talkMaxDuration)

			if var_35_14 <= arg_32_1.time_ and arg_32_1.time_ < var_35_14 + var_35_22 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_14) / var_35_22

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_14 + var_35_22 and arg_32_1.time_ < var_35_14 + var_35_22 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play106091009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 106091009
		arg_36_1.duration_ = 10.97

		local var_36_0 = {
			ja = 9.1,
			ko = 10.6,
			zh = 9.4,
			en = 10.966
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play106091010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 1.05

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_1 = arg_36_1:GetWordFromCfg(106091009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 42 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 42)

				if (42 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 42)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091009", "story_v_out_106091.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_106091", "106091009", "story_v_out_106091.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_106091", "106091009", "story_v_out_106091.awb")

						arg_36_1:RecordAudio("106091009", var_39_6)
						arg_36_1:RecordAudio("106091009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_106091", "106091009", "story_v_out_106091.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_106091", "106091009", "story_v_out_106091.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_7 = math.max(var_39_0, arg_36_1.talkMaxDuration)

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - 0) / var_39_7

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play106091010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 106091010
		arg_40_1.duration_ = 12.37

		local var_40_0 = {
			ja = 12.366,
			ko = 5.2,
			zh = 5.4,
			en = 5.266
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
				arg_40_0:Play106091011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.55

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:GetWordFromCfg(106091010)
				local var_43_2 = arg_40_1:FormatText(var_43_1.content)

				arg_40_1.text_.text = var_43_2

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_4 = 22 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 22)

				if (22 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_2) / 22)) > 0 and var_43_0 < var_43_4 then
					arg_40_1.talkMaxDuration = var_43_4

					if var_43_4 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_4 + 0
					end
				end

				arg_40_1.text_.text = var_43_2
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091010", "story_v_out_106091.awb") ~= 0 then
					local var_43_5 = manager.audio:GetVoiceLength("story_v_out_106091", "106091010", "story_v_out_106091.awb") / 1000

					if var_43_5 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + 0
					end

					if var_43_1.prefab_name ~= "" and arg_40_1.actors_[var_43_1.prefab_name] ~= nil then
						local var_43_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_1.prefab_name].transform, "story_v_out_106091", "106091010", "story_v_out_106091.awb")

						arg_40_1:RecordAudio("106091010", var_43_6)
						arg_40_1:RecordAudio("106091010", var_43_6)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_106091", "106091010", "story_v_out_106091.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_106091", "106091010", "story_v_out_106091.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_7 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_7

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play106091011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 106091011
		arg_44_1.duration_ = 12.23

		local var_44_0 = {
			ja = 9.766,
			ko = 11.066,
			zh = 9.566,
			en = 12.233
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
				arg_44_0:Play106091012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.95

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:GetWordFromCfg(106091011)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 38 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 38)

				if (38 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 38)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091011", "story_v_out_106091.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_106091", "106091011", "story_v_out_106091.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_106091", "106091011", "story_v_out_106091.awb")

						arg_44_1:RecordAudio("106091011", var_47_6)
						arg_44_1:RecordAudio("106091011", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_106091", "106091011", "story_v_out_106091.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_106091", "106091011", "story_v_out_106091.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play106091012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 106091012
		arg_48_1.duration_ = 4.43

		local var_48_0 = {
			ja = 0.9,
			ko = 0.566,
			zh = 4.433,
			en = 1.233
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
				arg_48_0:Play106091013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["4014_tpose"]) and arg_48_1.var_.characterEffect4014_tpose == nil then
				arg_48_1.var_.characterEffect4014_tpose = arg_48_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["4014_tpose"]) then
				if arg_48_1.var_.characterEffect4014_tpose and not isNil(arg_48_1.actors_["4014_tpose"]) then
					arg_48_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_48_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_0)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["4014_tpose"]) and arg_48_1.var_.characterEffect4014_tpose then
				arg_48_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_48_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_51_1 = arg_48_1.actors_["10004ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect10004ui_story == nil then
				arg_48_1.var_.characterEffect10004ui_story = var_51_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_2 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_2 and not isNil(var_51_1) then
				if arg_48_1.var_.characterEffect10004ui_story and not isNil(var_51_1) then
					arg_48_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_2 and arg_48_1.time_ < 0 + var_51_2 + arg_51_0 and not isNil(var_51_1) and arg_48_1.var_.characterEffect10004ui_story then
				arg_48_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_51_4 = 0
			local var_51_5 = 0.05

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(106091012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 2 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 2)

				if (2 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 2)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091012", "story_v_out_106091.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_106091", "106091012", "story_v_out_106091.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_106091", "106091012", "story_v_out_106091.awb")

						arg_48_1:RecordAudio("106091012", var_51_11)
						arg_48_1:RecordAudio("106091012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_106091", "106091012", "story_v_out_106091.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_106091", "106091012", "story_v_out_106091.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play106091013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 106091013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play106091014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos4014_tpose = arg_52_1.actors_["4014_tpose"].transform.localPosition

				local var_55_0 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_0 then
					var_55_0:EnableDynamicBone(false)
				end
			end

			local var_55_1 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_1 then
				arg_52_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_1)
				arg_52_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["4014_tpose"].transform.position).z)
				arg_52_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["4014_tpose"].transform.localEulerAngles = arg_52_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_1 and arg_52_1.time_ < 0 + var_55_1 + arg_55_0 then
				arg_52_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["4014_tpose"].transform.position).z)
				arg_52_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["4014_tpose"].transform.localEulerAngles = arg_52_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_55_2 = GameObjectTools.GetOrAddComponent(arg_52_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(true)
				end
			end

			local var_55_3 = arg_52_1.actors_["10004ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos10004ui_story = var_55_3.localPosition
			end

			local var_55_4 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				var_55_3.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos10004ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_4)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				var_55_3.localPosition = Vector3.New(0, 100, 0)
				var_55_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_3.position).x, (manager.ui.mainCamera.transform.position - var_55_3.position).y, (manager.ui.mainCamera.transform.position - var_55_3.position).z)
				var_55_3.localEulerAngles.z = 0
				var_55_3.localEulerAngles.x = 0
				var_55_3.localEulerAngles = var_55_3.localEulerAngles
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:AudioAction("play", "effect", "se_story_6", "se_story_6_foot", "")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:AudioAction("play", "effect", "se_story_6", "se_story_6_black_fog03", "")
			end

			local var_55_7 = 0
			local var_55_8 = 1.1

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_7 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_9 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(106091013).content)

				arg_52_1.text_.text = var_55_9

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_11 = 44 <= 0 and var_55_8 or var_55_8 * (utf8.len(var_55_9) / 44)

				if (44 <= 0 and var_55_8 or var_55_8 * (utf8.len(var_55_9) / 44)) > 0 and var_55_8 < var_55_11 then
					arg_52_1.talkMaxDuration = var_55_11

					if var_55_11 + var_55_7 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_11 + var_55_7
					end
				end

				arg_52_1.text_.text = var_55_9
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_8, arg_52_1.talkMaxDuration)

			if var_55_7 <= arg_52_1.time_ and arg_52_1.time_ < var_55_7 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_7) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_7 + var_55_12 and arg_52_1.time_ < var_55_7 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play106091014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 106091014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play106091015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 1.475

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(106091014).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 59 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 59)

				if (59 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 59)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play106091015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 106091015
		arg_60_1.duration_ = 6.53

		local var_60_0 = {
			ja = 5.566,
			ko = 4.366,
			zh = 3.9,
			en = 6.533
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
				arg_60_0:Play106091016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0
			local var_63_1 = 0.3

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_2 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_2:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_2:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_2:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[89].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_3 = arg_60_1:GetWordFromCfg(106091015)
				local var_63_4 = arg_60_1:FormatText(var_63_3.content)

				arg_60_1.text_.text = var_63_4

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_6 = 12 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_4) / 12)

				if (12 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_4) / 12)) > 0 and var_63_1 < var_63_6 then
					arg_60_1.talkMaxDuration = var_63_6
					var_63_0 = var_63_0 + 0.3

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_4
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091015", "story_v_out_106091.awb") ~= 0 then
					local var_63_7 = manager.audio:GetVoiceLength("story_v_out_106091", "106091015", "story_v_out_106091.awb") / 1000

					if var_63_7 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_0
					end

					if var_63_3.prefab_name ~= "" and arg_60_1.actors_[var_63_3.prefab_name] ~= nil then
						local var_63_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_3.prefab_name].transform, "story_v_out_106091", "106091015", "story_v_out_106091.awb")

						arg_60_1:RecordAudio("106091015", var_63_8)
						arg_60_1:RecordAudio("106091015", var_63_8)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_106091", "106091015", "story_v_out_106091.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_106091", "106091015", "story_v_out_106091.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_9 = var_63_0 + 0.3
			local var_63_10 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 + 0.3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_9 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_9) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_9 + var_63_10 and arg_60_1.time_ < var_63_9 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play106091016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 106091016
		arg_66_1.duration_ = 8.7

		local var_66_0 = {
			ja = 7.866,
			ko = 4.666,
			zh = 8.7,
			en = 8.666
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
				arg_66_0:Play106091017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if arg_66_1.actors_["2032_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2032_tpose"))) then
				local var_69_0 = Object.Instantiate(Asset.Load("Char/" .. "2032_tpose"), arg_66_1.stage_.transform)

				var_69_0.name = "2032_tpose"
				var_69_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_66_1.actors_["2032_tpose"] = var_69_0

				local var_69_1 = var_69_0:GetComponentInChildren(typeof(CharacterEffect))

				var_69_1.enabled = true

				local var_69_2 = GameObjectTools.GetOrAddComponent(var_69_0, typeof(DynamicBoneHelper))

				if var_69_2 then
					var_69_2:EnableDynamicBone(false)
				end

				arg_66_1:ShowWeapon(var_69_1.transform, false)

				arg_66_1.var_["2032_tpose" .. "Animator"] = var_69_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_66_1.var_["2032_tpose" .. "Animator"].applyRootMotion = true
				arg_66_1.var_["2032_tpose" .. "LipSync"] = var_69_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_69_3 = arg_66_1.actors_["2032_tpose"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.characterEffect2032_tpose == nil then
				arg_66_1.var_.characterEffect2032_tpose = var_69_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_4 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 and not isNil(var_69_3) then
				if arg_66_1.var_.characterEffect2032_tpose and not isNil(var_69_3) then
					arg_66_1.var_.characterEffect2032_tpose.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.characterEffect2032_tpose then
				arg_66_1.var_.characterEffect2032_tpose.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("2032_tpose", "StoryTimeline/CharAction/story2032/story2032action/2032action1_1")
			end

			local var_69_6 = arg_66_1.actors_["2032_tpose"].transform

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.var_.moveOldPos2032_tpose = var_69_6.localPosition

				local var_69_7 = GameObjectTools.GetOrAddComponent(var_69_6.gameObject, typeof(DynamicBoneHelper))

				if var_69_7 then
					var_69_7:EnableDynamicBone(false)
				end
			end

			local var_69_8 = 0.001

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_8 then
				var_69_6.localPosition = Vector3.Lerp(arg_66_1.var_.moveOldPos2032_tpose, Vector3.New(0, -1.15, -4.2), (arg_66_1.time_ - 0) / var_69_8)
				var_69_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_6.position).x, (manager.ui.mainCamera.transform.position - var_69_6.position).y, (manager.ui.mainCamera.transform.position - var_69_6.position).z)
				var_69_6.localEulerAngles.z = 0
				var_69_6.localEulerAngles.x = 0
				var_69_6.localEulerAngles = var_69_6.localEulerAngles
			end

			if arg_66_1.time_ >= 0 + var_69_8 and arg_66_1.time_ < 0 + var_69_8 + arg_69_0 then
				var_69_6.localPosition = Vector3.New(0, -1.15, -4.2)
				var_69_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_69_6.position).x, (manager.ui.mainCamera.transform.position - var_69_6.position).y, (manager.ui.mainCamera.transform.position - var_69_6.position).z)
				var_69_6.localEulerAngles.z = 0
				var_69_6.localEulerAngles.x = 0
				var_69_6.localEulerAngles = var_69_6.localEulerAngles

				local var_69_9 = GameObjectTools.GetOrAddComponent(var_69_6.gameObject, typeof(DynamicBoneHelper))

				if var_69_9 then
					var_69_9:EnableDynamicBone(true)
				end
			end

			local var_69_10 = 0
			local var_69_11 = 0.325

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_10 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[88].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_12 = arg_66_1:GetWordFromCfg(106091016)
				local var_69_13 = arg_66_1:FormatText(var_69_12.content)

				arg_66_1.text_.text = var_69_13

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_15 = 13 <= 0 and var_69_11 or var_69_11 * (utf8.len(var_69_13) / 13)

				if (13 <= 0 and var_69_11 or var_69_11 * (utf8.len(var_69_13) / 13)) > 0 and var_69_11 < var_69_15 then
					arg_66_1.talkMaxDuration = var_69_15

					if var_69_15 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_15 + var_69_10
					end
				end

				arg_66_1.text_.text = var_69_13
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091016", "story_v_out_106091.awb") ~= 0 then
					local var_69_16 = manager.audio:GetVoiceLength("story_v_out_106091", "106091016", "story_v_out_106091.awb") / 1000

					if var_69_16 + var_69_10 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_16 + var_69_10
					end

					if var_69_12.prefab_name ~= "" and arg_66_1.actors_[var_69_12.prefab_name] ~= nil then
						local var_69_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_12.prefab_name].transform, "story_v_out_106091", "106091016", "story_v_out_106091.awb")

						arg_66_1:RecordAudio("106091016", var_69_17)
						arg_66_1:RecordAudio("106091016", var_69_17)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_106091", "106091016", "story_v_out_106091.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_106091", "106091016", "story_v_out_106091.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_18 = math.max(var_69_11, arg_66_1.talkMaxDuration)

			if var_69_10 <= arg_66_1.time_ and arg_66_1.time_ < var_69_10 + var_69_18 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_10) / var_69_18

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_10 + var_69_18 and arg_66_1.time_ < var_69_10 + var_69_18 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_66_1:InitPlayNodeList()
	end,
	Play106091017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 106091017
		arg_70_1.duration_ = 9.4

		local var_70_0 = {
			ja = 9.4,
			ko = 6.733,
			zh = 5.766,
			en = 9.233
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
				arg_70_0:Play106091018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["2032_tpose"]) and arg_70_1.var_.characterEffect2032_tpose == nil then
				arg_70_1.var_.characterEffect2032_tpose = arg_70_1.actors_["2032_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["2032_tpose"]) then
				if arg_70_1.var_.characterEffect2032_tpose and not isNil(arg_70_1.actors_["2032_tpose"]) then
					arg_70_1.var_.characterEffect2032_tpose.fillFlat = true
					arg_70_1.var_.characterEffect2032_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_0)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["2032_tpose"]) and arg_70_1.var_.characterEffect2032_tpose then
				arg_70_1.var_.characterEffect2032_tpose.fillFlat = true
				arg_70_1.var_.characterEffect2032_tpose.fillRatio = 0.5
			end

			local var_73_1 = 0
			local var_73_2 = 0.475

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_1 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[89].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_3 = arg_70_1:GetWordFromCfg(106091017)
				local var_73_4 = arg_70_1:FormatText(var_73_3.content)

				arg_70_1.text_.text = var_73_4

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_6 = 19 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_4) / 19)

				if (19 <= 0 and var_73_2 or var_73_2 * (utf8.len(var_73_4) / 19)) > 0 and var_73_2 < var_73_6 then
					arg_70_1.talkMaxDuration = var_73_6

					if var_73_6 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_6 + var_73_1
					end
				end

				arg_70_1.text_.text = var_73_4
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091017", "story_v_out_106091.awb") ~= 0 then
					local var_73_7 = manager.audio:GetVoiceLength("story_v_out_106091", "106091017", "story_v_out_106091.awb") / 1000

					if var_73_7 + var_73_1 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_1
					end

					if var_73_3.prefab_name ~= "" and arg_70_1.actors_[var_73_3.prefab_name] ~= nil then
						local var_73_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_3.prefab_name].transform, "story_v_out_106091", "106091017", "story_v_out_106091.awb")

						arg_70_1:RecordAudio("106091017", var_73_8)
						arg_70_1:RecordAudio("106091017", var_73_8)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_106091", "106091017", "story_v_out_106091.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_106091", "106091017", "story_v_out_106091.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_9 = math.max(var_73_2, arg_70_1.talkMaxDuration)

			if var_73_1 <= arg_70_1.time_ and arg_70_1.time_ < var_73_1 + var_73_9 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_1) / var_73_9

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_1 + var_73_9 and arg_70_1.time_ < var_73_1 + var_73_9 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play106091018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 106091018
		arg_74_1.duration_ = 8.57

		local var_74_0 = {
			ja = 8.566,
			ko = 3.8,
			zh = 7.033,
			en = 4.5
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
				arg_74_0:Play106091019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["2032_tpose"]) and arg_74_1.var_.characterEffect2032_tpose == nil then
				arg_74_1.var_.characterEffect2032_tpose = arg_74_1.actors_["2032_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["2032_tpose"]) then
				if arg_74_1.var_.characterEffect2032_tpose and not isNil(arg_74_1.actors_["2032_tpose"]) then
					arg_74_1.var_.characterEffect2032_tpose.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["2032_tpose"]) and arg_74_1.var_.characterEffect2032_tpose then
				arg_74_1.var_.characterEffect2032_tpose.fillFlat = false
			end

			local var_77_2 = 0
			local var_77_3 = 0.25

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_2 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[88].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_4 = arg_74_1:GetWordFromCfg(106091018)
				local var_77_5 = arg_74_1:FormatText(var_77_4.content)

				arg_74_1.text_.text = var_77_5

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_7 = 10 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 10)

				if (10 <= 0 and var_77_3 or var_77_3 * (utf8.len(var_77_5) / 10)) > 0 and var_77_3 < var_77_7 then
					arg_74_1.talkMaxDuration = var_77_7

					if var_77_7 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_7 + var_77_2
					end
				end

				arg_74_1.text_.text = var_77_5
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091018", "story_v_out_106091.awb") ~= 0 then
					local var_77_8 = manager.audio:GetVoiceLength("story_v_out_106091", "106091018", "story_v_out_106091.awb") / 1000

					if var_77_8 + var_77_2 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_8 + var_77_2
					end

					if var_77_4.prefab_name ~= "" and arg_74_1.actors_[var_77_4.prefab_name] ~= nil then
						local var_77_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_4.prefab_name].transform, "story_v_out_106091", "106091018", "story_v_out_106091.awb")

						arg_74_1:RecordAudio("106091018", var_77_9)
						arg_74_1:RecordAudio("106091018", var_77_9)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_106091", "106091018", "story_v_out_106091.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_106091", "106091018", "story_v_out_106091.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_3, arg_74_1.talkMaxDuration)

			if var_77_2 <= arg_74_1.time_ and arg_74_1.time_ < var_77_2 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_2) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_2 + var_77_10 and arg_74_1.time_ < var_77_2 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play106091019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 106091019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play106091020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["2032_tpose"]) and arg_78_1.var_.characterEffect2032_tpose == nil then
				arg_78_1.var_.characterEffect2032_tpose = arg_78_1.actors_["2032_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["2032_tpose"]) then
				if arg_78_1.var_.characterEffect2032_tpose and not isNil(arg_78_1.actors_["2032_tpose"]) then
					arg_78_1.var_.characterEffect2032_tpose.fillFlat = true
					arg_78_1.var_.characterEffect2032_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_0)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["2032_tpose"]) and arg_78_1.var_.characterEffect2032_tpose then
				arg_78_1.var_.characterEffect2032_tpose.fillFlat = true
				arg_78_1.var_.characterEffect2032_tpose.fillRatio = 0.5
			end

			local var_81_1 = arg_78_1.actors_["2032_tpose"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos2032_tpose = var_81_1.localPosition

				local var_81_2 = GameObjectTools.GetOrAddComponent(var_81_1.gameObject, typeof(DynamicBoneHelper))

				if var_81_2 then
					var_81_2:EnableDynamicBone(false)
				end
			end

			local var_81_3 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 then
				var_81_1.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos2032_tpose, Vector3.New(0, 100, 0), (arg_78_1.time_ - 0) / var_81_3)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 then
				var_81_1.localPosition = Vector3.New(0, 100, 0)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles

				local var_81_4 = GameObjectTools.GetOrAddComponent(var_81_1.gameObject, typeof(DynamicBoneHelper))

				if var_81_4 then
					var_81_4:EnableDynamicBone(true)
				end
			end

			local var_81_5 = 0
			local var_81_6 = 0.725

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_7 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(106091019).content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 29 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_7) / 29)

				if (29 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_7) / 29)) > 0 and var_81_6 < var_81_9 then
					arg_78_1.talkMaxDuration = var_81_9

					if var_81_9 + var_81_5 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_9 + var_81_5
					end
				end

				arg_78_1.text_.text = var_81_7
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_6, arg_78_1.talkMaxDuration)

			if var_81_5 <= arg_78_1.time_ and arg_78_1.time_ < var_81_5 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_5) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_5 + var_81_10 and arg_78_1.time_ < var_81_5 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play106091020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 106091020
		arg_82_1.duration_ = 2.5

		local var_82_0 = {
			ja = 2.033,
			ko = 1.999999999999,
			zh = 2.5,
			en = 1.999999999999
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
				arg_82_0:Play106091021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(arg_82_1.actors_["4014_tpose"]) and arg_82_1.var_.characterEffect4014_tpose == nil then
				arg_82_1.var_.characterEffect4014_tpose = arg_82_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_0 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 and not isNil(arg_82_1.actors_["4014_tpose"]) then
				if arg_82_1.var_.characterEffect4014_tpose and not isNil(arg_82_1.actors_["4014_tpose"]) then
					arg_82_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_82_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_82_1.time_ - 0) / var_85_0)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 and not isNil(arg_82_1.actors_["4014_tpose"]) and arg_82_1.var_.characterEffect4014_tpose then
				arg_82_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_82_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_85_1 = arg_82_1.actors_["10004ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect10004ui_story == nil then
				arg_82_1.var_.characterEffect10004ui_story = var_85_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_2 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_2 and not isNil(var_85_1) then
				if arg_82_1.var_.characterEffect10004ui_story and not isNil(var_85_1) then
					arg_82_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_2 and arg_82_1.time_ < 0 + var_85_2 + arg_85_0 and not isNil(var_85_1) and arg_82_1.var_.characterEffect10004ui_story then
				arg_82_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_85_4 = arg_82_1.actors_["4014_tpose"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos4014_tpose = var_85_4.localPosition

				local var_85_5 = GameObjectTools.GetOrAddComponent(var_85_4.gameObject, typeof(DynamicBoneHelper))

				if var_85_5 then
					var_85_5:EnableDynamicBone(false)
				end
			end

			local var_85_6 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_6 then
				var_85_4.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos4014_tpose, Vector3.New(-0.7, -1.95, -4.2), (arg_82_1.time_ - 0) / var_85_6)
				var_85_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_4.position).x, (manager.ui.mainCamera.transform.position - var_85_4.position).y, (manager.ui.mainCamera.transform.position - var_85_4.position).z)
				var_85_4.localEulerAngles.z = 0
				var_85_4.localEulerAngles.x = 0
				var_85_4.localEulerAngles = var_85_4.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_6 and arg_82_1.time_ < 0 + var_85_6 + arg_85_0 then
				var_85_4.localPosition = Vector3.New(-0.7, -1.95, -4.2)
				var_85_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_4.position).x, (manager.ui.mainCamera.transform.position - var_85_4.position).y, (manager.ui.mainCamera.transform.position - var_85_4.position).z)
				var_85_4.localEulerAngles.z = 0
				var_85_4.localEulerAngles.x = 0
				var_85_4.localEulerAngles = var_85_4.localEulerAngles

				local var_85_7 = GameObjectTools.GetOrAddComponent(var_85_4.gameObject, typeof(DynamicBoneHelper))

				if var_85_7 then
					var_85_7:EnableDynamicBone(true)
				end
			end

			local var_85_8 = arg_82_1.actors_["10004ui_story"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos10004ui_story = var_85_8.localPosition
			end

			local var_85_9 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_9 then
				var_85_8.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10004ui_story, Vector3.New(0.7, -1.1, -5.6), (arg_82_1.time_ - 0) / var_85_9)
				var_85_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_8.position).x, (manager.ui.mainCamera.transform.position - var_85_8.position).y, (manager.ui.mainCamera.transform.position - var_85_8.position).z)
				var_85_8.localEulerAngles.z = 0
				var_85_8.localEulerAngles.x = 0
				var_85_8.localEulerAngles = var_85_8.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_9 and arg_82_1.time_ < 0 + var_85_9 + arg_85_0 then
				var_85_8.localPosition = Vector3.New(0.7, -1.1, -5.6)
				var_85_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_8.position).x, (manager.ui.mainCamera.transform.position - var_85_8.position).y, (manager.ui.mainCamera.transform.position - var_85_8.position).z)
				var_85_8.localEulerAngles.z = 0
				var_85_8.localEulerAngles.x = 0
				var_85_8.localEulerAngles = var_85_8.localEulerAngles
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action1_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_85_10 = 0
			local var_85_11 = 0.25

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_10 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_12 = arg_82_1:GetWordFromCfg(106091020)
				local var_85_13 = arg_82_1:FormatText(var_85_12.content)

				arg_82_1.text_.text = var_85_13

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_15 = 10 <= 0 and var_85_11 or var_85_11 * (utf8.len(var_85_13) / 10)

				if (10 <= 0 and var_85_11 or var_85_11 * (utf8.len(var_85_13) / 10)) > 0 and var_85_11 < var_85_15 then
					arg_82_1.talkMaxDuration = var_85_15

					if var_85_15 + var_85_10 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_15 + var_85_10
					end
				end

				arg_82_1.text_.text = var_85_13
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091020", "story_v_out_106091.awb") ~= 0 then
					local var_85_16 = manager.audio:GetVoiceLength("story_v_out_106091", "106091020", "story_v_out_106091.awb") / 1000

					if var_85_16 + var_85_10 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_16 + var_85_10
					end

					if var_85_12.prefab_name ~= "" and arg_82_1.actors_[var_85_12.prefab_name] ~= nil then
						local var_85_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_12.prefab_name].transform, "story_v_out_106091", "106091020", "story_v_out_106091.awb")

						arg_82_1:RecordAudio("106091020", var_85_17)
						arg_82_1:RecordAudio("106091020", var_85_17)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_106091", "106091020", "story_v_out_106091.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_106091", "106091020", "story_v_out_106091.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_18 = math.max(var_85_11, arg_82_1.talkMaxDuration)

			if var_85_10 <= arg_82_1.time_ and arg_82_1.time_ < var_85_10 + var_85_18 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_10) / var_85_18

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_10 + var_85_18 and arg_82_1.time_ < var_85_10 + var_85_18 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play106091021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 106091021
		arg_86_1.duration_ = 6.23

		local var_86_0 = {
			ja = 6.233,
			ko = 4.9,
			zh = 4.766,
			en = 5.9
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play106091022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["4014_tpose"]) and arg_86_1.var_.characterEffect4014_tpose == nil then
				arg_86_1.var_.characterEffect4014_tpose = arg_86_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["4014_tpose"]) then
				if arg_86_1.var_.characterEffect4014_tpose and not isNil(arg_86_1.actors_["4014_tpose"]) then
					arg_86_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["4014_tpose"]) and arg_86_1.var_.characterEffect4014_tpose then
				arg_86_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_89_2 = arg_86_1.actors_["10004ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect10004ui_story == nil then
				arg_86_1.var_.characterEffect10004ui_story = var_89_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_3 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 and not isNil(var_89_2) then
				if arg_86_1.var_.characterEffect10004ui_story and not isNil(var_89_2) then
					arg_86_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_86_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_3)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 and not isNil(var_89_2) and arg_86_1.var_.characterEffect10004ui_story then
				arg_86_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_86_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_89_4 = 0
			local var_89_5 = 0.55

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(106091021)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 22 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 22)

				if (22 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 22)) > 0 and var_89_5 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091021", "story_v_out_106091.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_out_106091", "106091021", "story_v_out_106091.awb") / 1000

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end

					if var_89_6.prefab_name ~= "" and arg_86_1.actors_[var_89_6.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_6.prefab_name].transform, "story_v_out_106091", "106091021", "story_v_out_106091.awb")

						arg_86_1:RecordAudio("106091021", var_89_11)
						arg_86_1:RecordAudio("106091021", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_106091", "106091021", "story_v_out_106091.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_106091", "106091021", "story_v_out_106091.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_12 and arg_86_1.time_ < var_89_4 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play106091022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 106091022
		arg_90_1.duration_ = 9.7

		local var_90_0 = {
			ja = 8.666,
			ko = 7.2,
			zh = 8.633,
			en = 9.7
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
				arg_90_0:Play106091023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["4014_tpose"]) and arg_90_1.var_.characterEffect4014_tpose == nil then
				arg_90_1.var_.characterEffect4014_tpose = arg_90_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.1

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["4014_tpose"]) then
				if arg_90_1.var_.characterEffect4014_tpose and not isNil(arg_90_1.actors_["4014_tpose"]) then
					arg_90_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_90_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["4014_tpose"]) and arg_90_1.var_.characterEffect4014_tpose then
				arg_90_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_90_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_93_1 = arg_90_1.actors_["10004ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect10004ui_story == nil then
				arg_90_1.var_.characterEffect10004ui_story = var_93_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_2 = 0.1

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_2 and not isNil(var_93_1) then
				if arg_90_1.var_.characterEffect10004ui_story and not isNil(var_93_1) then
					arg_90_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_2 and arg_90_1.time_ < 0 + var_93_2 + arg_93_0 and not isNil(var_93_1) and arg_90_1.var_.characterEffect10004ui_story then
				arg_90_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_93_4 = 0
			local var_93_5 = 0.95

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(106091022)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 38 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 38)

				if (38 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 38)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091022", "story_v_out_106091.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_out_106091", "106091022", "story_v_out_106091.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_out_106091", "106091022", "story_v_out_106091.awb")

						arg_90_1:RecordAudio("106091022", var_93_11)
						arg_90_1:RecordAudio("106091022", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_106091", "106091022", "story_v_out_106091.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_106091", "106091022", "story_v_out_106091.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_12 and arg_90_1.time_ < var_93_4 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play106091023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 106091023
		arg_94_1.duration_ = 15.6

		local var_94_0 = {
			ja = 15.6,
			ko = 10.233,
			zh = 11.733,
			en = 12.8
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
				arg_94_0:Play106091024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["4014_tpose"]) and arg_94_1.var_.characterEffect4014_tpose == nil then
				arg_94_1.var_.characterEffect4014_tpose = arg_94_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["4014_tpose"]) then
				if arg_94_1.var_.characterEffect4014_tpose and not isNil(arg_94_1.actors_["4014_tpose"]) then
					arg_94_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["4014_tpose"]) and arg_94_1.var_.characterEffect4014_tpose then
				arg_94_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["10004ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect10004ui_story == nil then
				arg_94_1.var_.characterEffect10004ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect10004ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_94_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect10004ui_story then
				arg_94_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_94_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_97_4 = 0
			local var_97_5 = 1.175

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_6 = arg_94_1:GetWordFromCfg(106091023)
				local var_97_7 = arg_94_1:FormatText(var_97_6.content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 47 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 47)

				if (47 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 47)) > 0 and var_97_5 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091023", "story_v_out_106091.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_out_106091", "106091023", "story_v_out_106091.awb") / 1000

					if var_97_10 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_4
					end

					if var_97_6.prefab_name ~= "" and arg_94_1.actors_[var_97_6.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_6.prefab_name].transform, "story_v_out_106091", "106091023", "story_v_out_106091.awb")

						arg_94_1:RecordAudio("106091023", var_97_11)
						arg_94_1:RecordAudio("106091023", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_106091", "106091023", "story_v_out_106091.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_106091", "106091023", "story_v_out_106091.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_12 = math.max(var_97_5, arg_94_1.talkMaxDuration)

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_12 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_4) / var_97_12

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_4 + var_97_12 and arg_94_1.time_ < var_97_4 + var_97_12 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play106091024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 106091024
		arg_98_1.duration_ = 20.13

		local var_98_0 = {
			ja = 20.133,
			ko = 12.2,
			zh = 11.966,
			en = 11.9
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
				arg_98_0:Play106091025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 1.15

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(106091024)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 46 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 46)

				if (46 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 46)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091024", "story_v_out_106091.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_106091", "106091024", "story_v_out_106091.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_106091", "106091024", "story_v_out_106091.awb")

						arg_98_1:RecordAudio("106091024", var_101_6)
						arg_98_1:RecordAudio("106091024", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_106091", "106091024", "story_v_out_106091.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_106091", "106091024", "story_v_out_106091.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play106091025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 106091025
		arg_102_1.duration_ = 6.8

		local var_102_0 = {
			ja = 6.8,
			ko = 4.266,
			zh = 2.566,
			en = 3.9
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
				arg_102_0:Play106091026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["4014_tpose"]) and arg_102_1.var_.characterEffect4014_tpose == nil then
				arg_102_1.var_.characterEffect4014_tpose = arg_102_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["4014_tpose"]) then
				if arg_102_1.var_.characterEffect4014_tpose and not isNil(arg_102_1.actors_["4014_tpose"]) then
					arg_102_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_102_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["4014_tpose"]) and arg_102_1.var_.characterEffect4014_tpose then
				arg_102_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_102_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_105_1 = arg_102_1.actors_["10004ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect10004ui_story == nil then
				arg_102_1.var_.characterEffect10004ui_story = var_105_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_2 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 and not isNil(var_105_1) then
				if arg_102_1.var_.characterEffect10004ui_story and not isNil(var_105_1) then
					arg_102_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 and not isNil(var_105_1) and arg_102_1.var_.characterEffect10004ui_story then
				arg_102_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_105_4 = 0
			local var_105_5 = 0.4

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(106091025)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 15 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 15)

				if (15 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 15)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091025", "story_v_out_106091.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_106091", "106091025", "story_v_out_106091.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_106091", "106091025", "story_v_out_106091.awb")

						arg_102_1:RecordAudio("106091025", var_105_11)
						arg_102_1:RecordAudio("106091025", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_106091", "106091025", "story_v_out_106091.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_106091", "106091025", "story_v_out_106091.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play106091026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 106091026
		arg_106_1.duration_ = 12.63

		local var_106_0 = {
			ja = 10.433,
			ko = 11.533,
			zh = 12.633,
			en = 10.533
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
				arg_106_0:Play106091027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["4014_tpose"]) and arg_106_1.var_.characterEffect4014_tpose == nil then
				arg_106_1.var_.characterEffect4014_tpose = arg_106_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["4014_tpose"]) then
				if arg_106_1.var_.characterEffect4014_tpose and not isNil(arg_106_1.actors_["4014_tpose"]) then
					arg_106_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["4014_tpose"]) and arg_106_1.var_.characterEffect4014_tpose then
				arg_106_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_109_2 = arg_106_1.actors_["10004ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect10004ui_story == nil then
				arg_106_1.var_.characterEffect10004ui_story = var_109_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_3 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.characterEffect10004ui_story and not isNil(var_109_2) then
					arg_106_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_106_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_3)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect10004ui_story then
				arg_106_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_106_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_109_4 = 0
			local var_109_5 = 1.05

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(106091026)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 42 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 42)

				if (42 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 42)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091026", "story_v_out_106091.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_106091", "106091026", "story_v_out_106091.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_out_106091", "106091026", "story_v_out_106091.awb")

						arg_106_1:RecordAudio("106091026", var_109_11)
						arg_106_1:RecordAudio("106091026", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_106091", "106091026", "story_v_out_106091.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_106091", "106091026", "story_v_out_106091.awb")
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
	Play106091027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 106091027
		arg_110_1.duration_ = 2.43

		local var_110_0 = {
			ja = 2.433,
			ko = 2.266,
			zh = 2.2,
			en = 1.966
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
				arg_110_0:Play106091028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["4014_tpose"]) and arg_110_1.var_.characterEffect4014_tpose == nil then
				arg_110_1.var_.characterEffect4014_tpose = arg_110_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["4014_tpose"]) then
				if arg_110_1.var_.characterEffect4014_tpose and not isNil(arg_110_1.actors_["4014_tpose"]) then
					arg_110_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_110_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_0)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["4014_tpose"]) and arg_110_1.var_.characterEffect4014_tpose then
				arg_110_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_110_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_113_1 = 0
			local var_113_2 = 0.15

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_1 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[90].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10012")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_3 = arg_110_1:GetWordFromCfg(106091027)
				local var_113_4 = arg_110_1:FormatText(var_113_3.content)

				arg_110_1.text_.text = var_113_4

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_6 = 6 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_4) / 6)

				if (6 <= 0 and var_113_2 or var_113_2 * (utf8.len(var_113_4) / 6)) > 0 and var_113_2 < var_113_6 then
					arg_110_1.talkMaxDuration = var_113_6

					if var_113_6 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_6 + var_113_1
					end
				end

				arg_110_1.text_.text = var_113_4
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091027", "story_v_out_106091.awb") ~= 0 then
					local var_113_7 = manager.audio:GetVoiceLength("story_v_out_106091", "106091027", "story_v_out_106091.awb") / 1000

					if var_113_7 + var_113_1 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_1
					end

					if var_113_3.prefab_name ~= "" and arg_110_1.actors_[var_113_3.prefab_name] ~= nil then
						local var_113_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_3.prefab_name].transform, "story_v_out_106091", "106091027", "story_v_out_106091.awb")

						arg_110_1:RecordAudio("106091027", var_113_8)
						arg_110_1:RecordAudio("106091027", var_113_8)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_106091", "106091027", "story_v_out_106091.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_106091", "106091027", "story_v_out_106091.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_9 = math.max(var_113_2, arg_110_1.talkMaxDuration)

			if var_113_1 <= arg_110_1.time_ and arg_110_1.time_ < var_113_1 + var_113_9 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_1) / var_113_9

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_1 + var_113_9 and arg_110_1.time_ < var_113_1 + var_113_9 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play106091028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 106091028
		arg_114_1.duration_ = 1

		local var_114_0 = {
			ja = 0.9,
			ko = 0.8,
			zh = 1,
			en = 0.966
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play106091029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["4014_tpose"]) and arg_114_1.var_.characterEffect4014_tpose == nil then
				arg_114_1.var_.characterEffect4014_tpose = arg_114_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["4014_tpose"]) then
				if arg_114_1.var_.characterEffect4014_tpose and not isNil(arg_114_1.actors_["4014_tpose"]) then
					arg_114_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["4014_tpose"]) and arg_114_1.var_.characterEffect4014_tpose then
				arg_114_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_117_2 = 0
			local var_117_3 = 0.05

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_4 = arg_114_1:GetWordFromCfg(106091028)
				local var_117_5 = arg_114_1:FormatText(var_117_4.content)

				arg_114_1.text_.text = var_117_5

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_7 = 2 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 2)

				if (2 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 2)) > 0 and var_117_3 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_2
					end
				end

				arg_114_1.text_.text = var_117_5
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091028", "story_v_out_106091.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_106091", "106091028", "story_v_out_106091.awb") / 1000

					if var_117_8 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_2
					end

					if var_117_4.prefab_name ~= "" and arg_114_1.actors_[var_117_4.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_4.prefab_name].transform, "story_v_out_106091", "106091028", "story_v_out_106091.awb")

						arg_114_1:RecordAudio("106091028", var_117_9)
						arg_114_1:RecordAudio("106091028", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_106091", "106091028", "story_v_out_106091.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_106091", "106091028", "story_v_out_106091.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_3, arg_114_1.talkMaxDuration)

			if var_117_2 <= arg_114_1.time_ and arg_114_1.time_ < var_117_2 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_2) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_2 + var_117_10 and arg_114_1.time_ < var_117_2 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play106091029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 106091029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play106091030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["4014_tpose"]) and arg_118_1.var_.characterEffect4014_tpose == nil then
				arg_118_1.var_.characterEffect4014_tpose = arg_118_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["4014_tpose"]) then
				if arg_118_1.var_.characterEffect4014_tpose and not isNil(arg_118_1.actors_["4014_tpose"]) then
					arg_118_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_118_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["4014_tpose"]) and arg_118_1.var_.characterEffect4014_tpose then
				arg_118_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_118_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_121_1 = arg_118_1.actors_["4014_tpose"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos4014_tpose = var_121_1.localPosition

				local var_121_2 = GameObjectTools.GetOrAddComponent(var_121_1.gameObject, typeof(DynamicBoneHelper))

				if var_121_2 then
					var_121_2:EnableDynamicBone(false)
				end
			end

			local var_121_3 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 then
				var_121_1.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_3)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 then
				var_121_1.localPosition = Vector3.New(0, 100, 0)
				var_121_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_1.position).x, (manager.ui.mainCamera.transform.position - var_121_1.position).y, (manager.ui.mainCamera.transform.position - var_121_1.position).z)
				var_121_1.localEulerAngles.z = 0
				var_121_1.localEulerAngles.x = 0
				var_121_1.localEulerAngles = var_121_1.localEulerAngles

				local var_121_4 = GameObjectTools.GetOrAddComponent(var_121_1.gameObject, typeof(DynamicBoneHelper))

				if var_121_4 then
					var_121_4:EnableDynamicBone(true)
				end
			end

			local var_121_5 = arg_118_1.actors_["10004ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos10004ui_story = var_121_5.localPosition
			end

			local var_121_6 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_6 then
				var_121_5.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos10004ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_6)
				var_121_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_5.position).x, (manager.ui.mainCamera.transform.position - var_121_5.position).y, (manager.ui.mainCamera.transform.position - var_121_5.position).z)
				var_121_5.localEulerAngles.z = 0
				var_121_5.localEulerAngles.x = 0
				var_121_5.localEulerAngles = var_121_5.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_6 and arg_118_1.time_ < 0 + var_121_6 + arg_121_0 then
				var_121_5.localPosition = Vector3.New(0, 100, 0)
				var_121_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_5.position).x, (manager.ui.mainCamera.transform.position - var_121_5.position).y, (manager.ui.mainCamera.transform.position - var_121_5.position).z)
				var_121_5.localEulerAngles.z = 0
				var_121_5.localEulerAngles.x = 0
				var_121_5.localEulerAngles = var_121_5.localEulerAngles
			end

			local var_121_7 = 0
			local var_121_8 = 0.875

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_7 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_9 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_9:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_10 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(106091029).content)

				arg_118_1.text_.text = var_121_10

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_12 = 34 <= 0 and var_121_8 or var_121_8 * (utf8.len(var_121_10) / 34)

				if (34 <= 0 and var_121_8 or var_121_8 * (utf8.len(var_121_10) / 34)) > 0 and var_121_8 < var_121_12 then
					arg_118_1.talkMaxDuration = var_121_12
					var_121_7 = var_121_7 + 0.3

					if var_121_12 + var_121_7 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_12 + var_121_7
					end
				end

				arg_118_1.text_.text = var_121_10
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_13 = var_121_7 + 0.3
			local var_121_14 = math.max(var_121_8, arg_118_1.talkMaxDuration)

			if var_121_7 + 0.3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_13 + var_121_14 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_13) / var_121_14

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_13 + var_121_14 and arg_118_1.time_ < var_121_13 + var_121_14 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play106091030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 106091030
		arg_124_1.duration_ = 5.2

		local var_124_0 = {
			ja = 3.9,
			ko = 4.333,
			zh = 4.5,
			en = 5.2
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play106091031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.525

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[89].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_1 = arg_124_1:GetWordFromCfg(106091030)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 21 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 21)

				if (21 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 21)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091030", "story_v_out_106091.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_106091", "106091030", "story_v_out_106091.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_106091", "106091030", "story_v_out_106091.awb")

						arg_124_1:RecordAudio("106091030", var_127_6)
						arg_124_1:RecordAudio("106091030", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_106091", "106091030", "story_v_out_106091.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_106091", "106091030", "story_v_out_106091.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_7 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_7

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play106091031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 106091031
		arg_128_1.duration_ = 8.9

		local var_128_0 = {
			ja = 8.833,
			ko = 8.433,
			zh = 7.333,
			en = 8.9
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play106091032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos2032_tpose = arg_128_1.actors_["2032_tpose"].transform.localPosition

				local var_131_0 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["2032_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_0 then
					var_131_0:EnableDynamicBone(false)
				end
			end

			local var_131_1 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_1 then
				arg_128_1.actors_["2032_tpose"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos2032_tpose, Vector3.New(0, -1.15, -4.2), (arg_128_1.time_ - 0) / var_131_1)
				arg_128_1.actors_["2032_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["2032_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["2032_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["2032_tpose"].transform.position).z)
				arg_128_1.actors_["2032_tpose"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["2032_tpose"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["2032_tpose"].transform.localEulerAngles = arg_128_1.actors_["2032_tpose"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_1 and arg_128_1.time_ < 0 + var_131_1 + arg_131_0 then
				arg_128_1.actors_["2032_tpose"].transform.localPosition = Vector3.New(0, -1.15, -4.2)
				arg_128_1.actors_["2032_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["2032_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["2032_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["2032_tpose"].transform.position).z)
				arg_128_1.actors_["2032_tpose"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["2032_tpose"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["2032_tpose"].transform.localEulerAngles = arg_128_1.actors_["2032_tpose"].transform.localEulerAngles

				local var_131_2 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["2032_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(true)
				end
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("2032_tpose", "StoryTimeline/CharAction/story2032/story2032action/2032action1_1")
			end

			local var_131_3 = 0
			local var_131_4 = 0.775

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_3 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[90].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, true)
				arg_128_1.iconController_:SetSelectedState("hero")

				arg_128_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10012")

				arg_128_1.callingController_:SetSelectedState("normal")

				arg_128_1.keyicon_.color = Color.New(1, 1, 1)
				arg_128_1.icon_.color = Color.New(1, 1, 1)

				local var_131_5 = arg_128_1:GetWordFromCfg(106091031)
				local var_131_6 = arg_128_1:FormatText(var_131_5.content)

				arg_128_1.text_.text = var_131_6

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_8 = 31 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_6) / 31)

				if (31 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_6) / 31)) > 0 and var_131_4 < var_131_8 then
					arg_128_1.talkMaxDuration = var_131_8

					if var_131_8 + var_131_3 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_8 + var_131_3
					end
				end

				arg_128_1.text_.text = var_131_6
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091031", "story_v_out_106091.awb") ~= 0 then
					local var_131_9 = manager.audio:GetVoiceLength("story_v_out_106091", "106091031", "story_v_out_106091.awb") / 1000

					if var_131_9 + var_131_3 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_3
					end

					if var_131_5.prefab_name ~= "" and arg_128_1.actors_[var_131_5.prefab_name] ~= nil then
						local var_131_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_5.prefab_name].transform, "story_v_out_106091", "106091031", "story_v_out_106091.awb")

						arg_128_1:RecordAudio("106091031", var_131_10)
						arg_128_1:RecordAudio("106091031", var_131_10)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_106091", "106091031", "story_v_out_106091.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_106091", "106091031", "story_v_out_106091.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_11 = math.max(var_131_4, arg_128_1.talkMaxDuration)

			if var_131_3 <= arg_128_1.time_ and arg_128_1.time_ < var_131_3 + var_131_11 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_3) / var_131_11

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_3 + var_131_11 and arg_128_1.time_ < var_131_3 + var_131_11 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play106091032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 106091032
		arg_132_1.duration_ = 7.07

		local var_132_0 = {
			ja = 5.7,
			ko = 1.966,
			zh = 3.3,
			en = 7.066
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play106091033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["2032_tpose"]) and arg_132_1.var_.characterEffect2032_tpose == nil then
				arg_132_1.var_.characterEffect2032_tpose = arg_132_1.actors_["2032_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.1

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["2032_tpose"]) then
				if arg_132_1.var_.characterEffect2032_tpose and not isNil(arg_132_1.actors_["2032_tpose"]) then
					arg_132_1.var_.characterEffect2032_tpose.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["2032_tpose"]) and arg_132_1.var_.characterEffect2032_tpose then
				arg_132_1.var_.characterEffect2032_tpose.fillFlat = false
			end

			local var_135_2 = 0
			local var_135_3 = 0.05

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_2 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[88].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_4 = arg_132_1:GetWordFromCfg(106091032)
				local var_135_5 = arg_132_1:FormatText(var_135_4.content)

				arg_132_1.text_.text = var_135_5

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_7 = 2 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 2)

				if (2 <= 0 and var_135_3 or var_135_3 * (utf8.len(var_135_5) / 2)) > 0 and var_135_3 < var_135_7 then
					arg_132_1.talkMaxDuration = var_135_7

					if var_135_7 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_2
					end
				end

				arg_132_1.text_.text = var_135_5
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091032", "story_v_out_106091.awb") ~= 0 then
					local var_135_8 = manager.audio:GetVoiceLength("story_v_out_106091", "106091032", "story_v_out_106091.awb") / 1000

					if var_135_8 + var_135_2 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_8 + var_135_2
					end

					if var_135_4.prefab_name ~= "" and arg_132_1.actors_[var_135_4.prefab_name] ~= nil then
						local var_135_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_4.prefab_name].transform, "story_v_out_106091", "106091032", "story_v_out_106091.awb")

						arg_132_1:RecordAudio("106091032", var_135_9)
						arg_132_1:RecordAudio("106091032", var_135_9)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_106091", "106091032", "story_v_out_106091.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_106091", "106091032", "story_v_out_106091.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_10 = math.max(var_135_3, arg_132_1.talkMaxDuration)

			if var_135_2 <= arg_132_1.time_ and arg_132_1.time_ < var_135_2 + var_135_10 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_2) / var_135_10

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_2 + var_135_10 and arg_132_1.time_ < var_135_2 + var_135_10 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play106091033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 106091033
		arg_136_1.duration_ = 5

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play106091034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos2032_tpose = arg_136_1.actors_["2032_tpose"].transform.localPosition

				local var_139_0 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["2032_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_0 then
					var_139_0:EnableDynamicBone(false)
				end
			end

			local var_139_1 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 then
				arg_136_1.actors_["2032_tpose"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos2032_tpose, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_1)
				arg_136_1.actors_["2032_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["2032_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["2032_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["2032_tpose"].transform.position).z)
				arg_136_1.actors_["2032_tpose"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["2032_tpose"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["2032_tpose"].transform.localEulerAngles = arg_136_1.actors_["2032_tpose"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 then
				arg_136_1.actors_["2032_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.actors_["2032_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["2032_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["2032_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["2032_tpose"].transform.position).z)
				arg_136_1.actors_["2032_tpose"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["2032_tpose"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["2032_tpose"].transform.localEulerAngles = arg_136_1.actors_["2032_tpose"].transform.localEulerAngles

				local var_139_2 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["2032_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(true)
				end
			end

			local var_139_3 = 0
			local var_139_4 = 1.2

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_3 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, false)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_5 = arg_136_1:FormatText(arg_136_1:GetWordFromCfg(106091033).content)

				arg_136_1.text_.text = var_139_5

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_7 = 48 <= 0 and var_139_4 or var_139_4 * (utf8.len(var_139_5) / 48)

				if (48 <= 0 and var_139_4 or var_139_4 * (utf8.len(var_139_5) / 48)) > 0 and var_139_4 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_3 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_3
					end
				end

				arg_136_1.text_.text = var_139_5
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)
				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_8 = math.max(var_139_4, arg_136_1.talkMaxDuration)

			if var_139_3 <= arg_136_1.time_ and arg_136_1.time_ < var_139_3 + var_139_8 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_3) / var_139_8

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_3 + var_139_8 and arg_136_1.time_ < var_139_3 + var_139_8 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2032_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play106091034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 106091034
		arg_140_1.duration_ = 10.3

		local var_140_0 = {
			ja = 8.7,
			ko = 8.9,
			zh = 10.3,
			en = 7.833
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
				arg_140_0:Play106091035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["4014_tpose"]) and arg_140_1.var_.characterEffect4014_tpose == nil then
				arg_140_1.var_.characterEffect4014_tpose = arg_140_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.1

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["4014_tpose"]) then
				if arg_140_1.var_.characterEffect4014_tpose and not isNil(arg_140_1.actors_["4014_tpose"]) then
					arg_140_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["4014_tpose"]) and arg_140_1.var_.characterEffect4014_tpose then
				arg_140_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_143_2 = arg_140_1.actors_["4014_tpose"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos4014_tpose = var_143_2.localPosition

				local var_143_3 = GameObjectTools.GetOrAddComponent(var_143_2.gameObject, typeof(DynamicBoneHelper))

				if var_143_3 then
					var_143_3:EnableDynamicBone(false)
				end
			end

			local var_143_4 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_4 then
				var_143_2.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos4014_tpose, Vector3.New(-0.7, -1.95, -4.2), (arg_140_1.time_ - 0) / var_143_4)
				var_143_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_2.position).x, (manager.ui.mainCamera.transform.position - var_143_2.position).y, (manager.ui.mainCamera.transform.position - var_143_2.position).z)
				var_143_2.localEulerAngles.z = 0
				var_143_2.localEulerAngles.x = 0
				var_143_2.localEulerAngles = var_143_2.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_4 and arg_140_1.time_ < 0 + var_143_4 + arg_143_0 then
				var_143_2.localPosition = Vector3.New(-0.7, -1.95, -4.2)
				var_143_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_2.position).x, (manager.ui.mainCamera.transform.position - var_143_2.position).y, (manager.ui.mainCamera.transform.position - var_143_2.position).z)
				var_143_2.localEulerAngles.z = 0
				var_143_2.localEulerAngles.x = 0
				var_143_2.localEulerAngles = var_143_2.localEulerAngles

				local var_143_5 = GameObjectTools.GetOrAddComponent(var_143_2.gameObject, typeof(DynamicBoneHelper))

				if var_143_5 then
					var_143_5:EnableDynamicBone(true)
				end
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_143_6 = 0
			local var_143_7 = 0.8

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_6 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_8 = arg_140_1:GetWordFromCfg(106091034)
				local var_143_9 = arg_140_1:FormatText(var_143_8.content)

				arg_140_1.text_.text = var_143_9

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_11 = 32 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 32)

				if (32 <= 0 and var_143_7 or var_143_7 * (utf8.len(var_143_9) / 32)) > 0 and var_143_7 < var_143_11 then
					arg_140_1.talkMaxDuration = var_143_11

					if var_143_11 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_11 + var_143_6
					end
				end

				arg_140_1.text_.text = var_143_9
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091034", "story_v_out_106091.awb") ~= 0 then
					local var_143_12 = manager.audio:GetVoiceLength("story_v_out_106091", "106091034", "story_v_out_106091.awb") / 1000

					if var_143_12 + var_143_6 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_12 + var_143_6
					end

					if var_143_8.prefab_name ~= "" and arg_140_1.actors_[var_143_8.prefab_name] ~= nil then
						local var_143_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_8.prefab_name].transform, "story_v_out_106091", "106091034", "story_v_out_106091.awb")

						arg_140_1:RecordAudio("106091034", var_143_13)
						arg_140_1:RecordAudio("106091034", var_143_13)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_106091", "106091034", "story_v_out_106091.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_106091", "106091034", "story_v_out_106091.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_14 = math.max(var_143_7, arg_140_1.talkMaxDuration)

			if var_143_6 <= arg_140_1.time_ and arg_140_1.time_ < var_143_6 + var_143_14 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_6) / var_143_14

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_6 + var_143_14 and arg_140_1.time_ < var_143_6 + var_143_14 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4014_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play106091035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 106091035
		arg_144_1.duration_ = 2.5

		local var_144_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2.5,
			en = 1.999999999999
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
				arg_144_0:Play106091036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["4014_tpose"]) and arg_144_1.var_.characterEffect4014_tpose == nil then
				arg_144_1.var_.characterEffect4014_tpose = arg_144_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.1

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["4014_tpose"]) then
				if arg_144_1.var_.characterEffect4014_tpose and not isNil(arg_144_1.actors_["4014_tpose"]) then
					arg_144_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_144_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["4014_tpose"]) and arg_144_1.var_.characterEffect4014_tpose then
				arg_144_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_144_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_147_1 = arg_144_1.actors_["10004ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect10004ui_story == nil then
				arg_144_1.var_.characterEffect10004ui_story = var_147_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.1

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_2 and not isNil(var_147_1) then
				if arg_144_1.var_.characterEffect10004ui_story and not isNil(var_147_1) then
					arg_144_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_2 and arg_144_1.time_ < 0 + var_147_2 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect10004ui_story then
				arg_144_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			local var_147_4 = arg_144_1.actors_["10004ui_story"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos10004ui_story = var_147_4.localPosition
			end

			local var_147_5 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_5 then
				var_147_4.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos10004ui_story, Vector3.New(0.7, -1.1, -5.6), (arg_144_1.time_ - 0) / var_147_5)
				var_147_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_4.position).x, (manager.ui.mainCamera.transform.position - var_147_4.position).y, (manager.ui.mainCamera.transform.position - var_147_4.position).z)
				var_147_4.localEulerAngles.z = 0
				var_147_4.localEulerAngles.x = 0
				var_147_4.localEulerAngles = var_147_4.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_5 and arg_144_1.time_ < 0 + var_147_5 + arg_147_0 then
				var_147_4.localPosition = Vector3.New(0.7, -1.1, -5.6)
				var_147_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_4.position).x, (manager.ui.mainCamera.transform.position - var_147_4.position).y, (manager.ui.mainCamera.transform.position - var_147_4.position).z)
				var_147_4.localEulerAngles.z = 0
				var_147_4.localEulerAngles.x = 0
				var_147_4.localEulerAngles = var_147_4.localEulerAngles
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action3_2")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_147_6 = 0
			local var_147_7 = 0.2

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_6 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_8 = arg_144_1:GetWordFromCfg(106091035)
				local var_147_9 = arg_144_1:FormatText(var_147_8.content)

				arg_144_1.text_.text = var_147_9

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_11 = 8 <= 0 and var_147_7 or var_147_7 * (utf8.len(var_147_9) / 8)

				if (8 <= 0 and var_147_7 or var_147_7 * (utf8.len(var_147_9) / 8)) > 0 and var_147_7 < var_147_11 then
					arg_144_1.talkMaxDuration = var_147_11

					if var_147_11 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_11 + var_147_6
					end
				end

				arg_144_1.text_.text = var_147_9
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091035", "story_v_out_106091.awb") ~= 0 then
					local var_147_12 = manager.audio:GetVoiceLength("story_v_out_106091", "106091035", "story_v_out_106091.awb") / 1000

					if var_147_12 + var_147_6 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_12 + var_147_6
					end

					if var_147_8.prefab_name ~= "" and arg_144_1.actors_[var_147_8.prefab_name] ~= nil then
						local var_147_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_8.prefab_name].transform, "story_v_out_106091", "106091035", "story_v_out_106091.awb")

						arg_144_1:RecordAudio("106091035", var_147_13)
						arg_144_1:RecordAudio("106091035", var_147_13)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_106091", "106091035", "story_v_out_106091.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_106091", "106091035", "story_v_out_106091.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_14 = math.max(var_147_7, arg_144_1.talkMaxDuration)

			if var_147_6 <= arg_144_1.time_ and arg_144_1.time_ < var_147_6 + var_147_14 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_6) / var_147_14

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_6 + var_147_14 and arg_144_1.time_ < var_147_6 + var_147_14 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10004ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play106091036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 106091036
		arg_148_1.duration_ = 1.5

		local var_148_0 = {
			ja = 1.5,
			ko = 1.333,
			zh = 1.433,
			en = 1.5
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
				arg_148_0:Play106091037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(arg_148_1.actors_["4014_tpose"]) and arg_148_1.var_.characterEffect4014_tpose == nil then
				arg_148_1.var_.characterEffect4014_tpose = arg_148_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_0 = 0.1

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 and not isNil(arg_148_1.actors_["4014_tpose"]) then
				if arg_148_1.var_.characterEffect4014_tpose and not isNil(arg_148_1.actors_["4014_tpose"]) then
					arg_148_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 and not isNil(arg_148_1.actors_["4014_tpose"]) and arg_148_1.var_.characterEffect4014_tpose then
				arg_148_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_151_2 = arg_148_1.actors_["10004ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect10004ui_story == nil then
				arg_148_1.var_.characterEffect10004ui_story = var_151_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_3 = 0.1

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_3 and not isNil(var_151_2) then
				if arg_148_1.var_.characterEffect10004ui_story and not isNil(var_151_2) then
					arg_148_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_148_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_148_1.time_ - 0) / var_151_3)
				end
			end

			if arg_148_1.time_ >= 0 + var_151_3 and arg_148_1.time_ < 0 + var_151_3 + arg_151_0 and not isNil(var_151_2) and arg_148_1.var_.characterEffect10004ui_story then
				arg_148_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_148_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_151_4 = 0
			local var_151_5 = 0.1

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_6 = arg_148_1:GetWordFromCfg(106091036)
				local var_151_7 = arg_148_1:FormatText(var_151_6.content)

				arg_148_1.text_.text = var_151_7

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_9 = 4 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 4)

				if (4 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_7) / 4)) > 0 and var_151_5 < var_151_9 then
					arg_148_1.talkMaxDuration = var_151_9

					if var_151_9 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_9 + var_151_4
					end
				end

				arg_148_1.text_.text = var_151_7
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091036", "story_v_out_106091.awb") ~= 0 then
					local var_151_10 = manager.audio:GetVoiceLength("story_v_out_106091", "106091036", "story_v_out_106091.awb") / 1000

					if var_151_10 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_10 + var_151_4
					end

					if var_151_6.prefab_name ~= "" and arg_148_1.actors_[var_151_6.prefab_name] ~= nil then
						local var_151_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_6.prefab_name].transform, "story_v_out_106091", "106091036", "story_v_out_106091.awb")

						arg_148_1:RecordAudio("106091036", var_151_11)
						arg_148_1:RecordAudio("106091036", var_151_11)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_106091", "106091036", "story_v_out_106091.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_106091", "106091036", "story_v_out_106091.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_12 = math.max(var_151_5, arg_148_1.talkMaxDuration)

			if var_151_4 <= arg_148_1.time_ and arg_148_1.time_ < var_151_4 + var_151_12 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_4) / var_151_12

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_4 + var_151_12 and arg_148_1.time_ < var_151_4 + var_151_12 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play106091037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 106091037
		arg_152_1.duration_ = 4.8

		local var_152_0 = {
			ja = 1.999999999999,
			ko = 3.566,
			zh = 4.8,
			en = 3.7
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
				arg_152_0:Play106091038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["4014_tpose"]) and arg_152_1.var_.characterEffect4014_tpose == nil then
				arg_152_1.var_.characterEffect4014_tpose = arg_152_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.1

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["4014_tpose"]) then
				if arg_152_1.var_.characterEffect4014_tpose and not isNil(arg_152_1.actors_["4014_tpose"]) then
					arg_152_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_152_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_0)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["4014_tpose"]) and arg_152_1.var_.characterEffect4014_tpose then
				arg_152_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_152_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_155_1 = arg_152_1.actors_["10004ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect10004ui_story == nil then
				arg_152_1.var_.characterEffect10004ui_story = var_155_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_2 = 0.1

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 and not isNil(var_155_1) then
				if arg_152_1.var_.characterEffect10004ui_story and not isNil(var_155_1) then
					arg_152_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 and not isNil(var_155_1) and arg_152_1.var_.characterEffect10004ui_story then
				arg_152_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_155_4 = 0
			local var_155_5 = 0.35

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_4 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_6 = arg_152_1:GetWordFromCfg(106091037)
				local var_155_7 = arg_152_1:FormatText(var_155_6.content)

				arg_152_1.text_.text = var_155_7

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_9 = 14 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 14)

				if (14 <= 0 and var_155_5 or var_155_5 * (utf8.len(var_155_7) / 14)) > 0 and var_155_5 < var_155_9 then
					arg_152_1.talkMaxDuration = var_155_9

					if var_155_9 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_9 + var_155_4
					end
				end

				arg_152_1.text_.text = var_155_7
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091037", "story_v_out_106091.awb") ~= 0 then
					local var_155_10 = manager.audio:GetVoiceLength("story_v_out_106091", "106091037", "story_v_out_106091.awb") / 1000

					if var_155_10 + var_155_4 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_10 + var_155_4
					end

					if var_155_6.prefab_name ~= "" and arg_152_1.actors_[var_155_6.prefab_name] ~= nil then
						local var_155_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_6.prefab_name].transform, "story_v_out_106091", "106091037", "story_v_out_106091.awb")

						arg_152_1:RecordAudio("106091037", var_155_11)
						arg_152_1:RecordAudio("106091037", var_155_11)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_106091", "106091037", "story_v_out_106091.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_106091", "106091037", "story_v_out_106091.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_12 = math.max(var_155_5, arg_152_1.talkMaxDuration)

			if var_155_4 <= arg_152_1.time_ and arg_152_1.time_ < var_155_4 + var_155_12 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_4) / var_155_12

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_4 + var_155_12 and arg_152_1.time_ < var_155_4 + var_155_12 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play106091038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 106091038
		arg_156_1.duration_ = 3.93

		local var_156_0 = {
			ja = 2.9,
			ko = 3,
			zh = 3.933,
			en = 3
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
				arg_156_0:Play106091039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action5_1")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_159_0 = 0
			local var_159_1 = 0.325

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_2 = arg_156_1:GetWordFromCfg(106091038)
				local var_159_3 = arg_156_1:FormatText(var_159_2.content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 13 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 13)

				if (13 <= 0 and var_159_1 or var_159_1 * (utf8.len(var_159_3) / 13)) > 0 and var_159_1 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_0
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091038", "story_v_out_106091.awb") ~= 0 then
					local var_159_6 = manager.audio:GetVoiceLength("story_v_out_106091", "106091038", "story_v_out_106091.awb") / 1000

					if var_159_6 + var_159_0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_6 + var_159_0
					end

					if var_159_2.prefab_name ~= "" and arg_156_1.actors_[var_159_2.prefab_name] ~= nil then
						local var_159_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_2.prefab_name].transform, "story_v_out_106091", "106091038", "story_v_out_106091.awb")

						arg_156_1:RecordAudio("106091038", var_159_7)
						arg_156_1:RecordAudio("106091038", var_159_7)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_106091", "106091038", "story_v_out_106091.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_106091", "106091038", "story_v_out_106091.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_8 = math.max(var_159_1, arg_156_1.talkMaxDuration)

			if var_159_0 <= arg_156_1.time_ and arg_156_1.time_ < var_159_0 + var_159_8 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_0) / var_159_8

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_0 + var_159_8 and arg_156_1.time_ < var_159_0 + var_159_8 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play106091039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 106091039
		arg_160_1.duration_ = 1.53

		local var_160_0 = {
			ja = 1,
			ko = 1.333,
			zh = 1.533,
			en = 1.433
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
				arg_160_0:Play106091040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 and not isNil(arg_160_1.actors_["10004ui_story"]) and arg_160_1.var_.characterEffect10004ui_story == nil then
				arg_160_1.var_.characterEffect10004ui_story = arg_160_1.actors_["10004ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_0 = 0.1

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 and not isNil(arg_160_1.actors_["10004ui_story"]) then
				if arg_160_1.var_.characterEffect10004ui_story and not isNil(arg_160_1.actors_["10004ui_story"]) then
					arg_160_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_160_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 0) / var_163_0)
				end
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 and not isNil(arg_160_1.actors_["10004ui_story"]) and arg_160_1.var_.characterEffect10004ui_story then
				arg_160_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_160_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_163_1 = 0
			local var_163_2 = 0.05

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_1 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, true)
				arg_160_1.iconController_:SetSelectedState("hero")

				arg_160_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3004")

				arg_160_1.callingController_:SetSelectedState("normal")

				arg_160_1.keyicon_.color = Color.New(1, 1, 1)
				arg_160_1.icon_.color = Color.New(1, 1, 1)

				local var_163_3 = arg_160_1:GetWordFromCfg(106091039)
				local var_163_4 = arg_160_1:FormatText(var_163_3.content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_6 = 2 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_4) / 2)

				if (2 <= 0 and var_163_2 or var_163_2 * (utf8.len(var_163_4) / 2)) > 0 and var_163_2 < var_163_6 then
					arg_160_1.talkMaxDuration = var_163_6

					if var_163_6 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_6 + var_163_1
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091039", "story_v_out_106091.awb") ~= 0 then
					local var_163_7 = manager.audio:GetVoiceLength("story_v_out_106091", "106091039", "story_v_out_106091.awb") / 1000

					if var_163_7 + var_163_1 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_1
					end

					if var_163_3.prefab_name ~= "" and arg_160_1.actors_[var_163_3.prefab_name] ~= nil then
						local var_163_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_3.prefab_name].transform, "story_v_out_106091", "106091039", "story_v_out_106091.awb")

						arg_160_1:RecordAudio("106091039", var_163_8)
						arg_160_1:RecordAudio("106091039", var_163_8)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_106091", "106091039", "story_v_out_106091.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_106091", "106091039", "story_v_out_106091.awb")
				end

				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_9 = math.max(var_163_2, arg_160_1.talkMaxDuration)

			if var_163_1 <= arg_160_1.time_ and arg_160_1.time_ < var_163_1 + var_163_9 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_1) / var_163_9

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_1 + var_163_9 and arg_160_1.time_ < var_163_1 + var_163_9 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play106091040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 106091040
		arg_164_1.duration_ = 10.87

		local var_164_0 = {
			ja = 6.533,
			ko = 7.733,
			zh = 9.033,
			en = 10.866
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
				arg_164_0:Play106091041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(arg_164_1.actors_["4014_tpose"]) and arg_164_1.var_.characterEffect4014_tpose == nil then
				arg_164_1.var_.characterEffect4014_tpose = arg_164_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_0 = 0.1

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 and not isNil(arg_164_1.actors_["4014_tpose"]) then
				if arg_164_1.var_.characterEffect4014_tpose and not isNil(arg_164_1.actors_["4014_tpose"]) then
					arg_164_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 and not isNil(arg_164_1.actors_["4014_tpose"]) and arg_164_1.var_.characterEffect4014_tpose then
				arg_164_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_167_2 = arg_164_1.actors_["10004ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect10004ui_story == nil then
				arg_164_1.var_.characterEffect10004ui_story = var_167_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_3 = 0.1

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_3 and not isNil(var_167_2) then
				if arg_164_1.var_.characterEffect10004ui_story and not isNil(var_167_2) then
					arg_164_1.var_.characterEffect10004ui_story.fillFlat = true
					arg_164_1.var_.characterEffect10004ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_164_1.time_ - 0) / var_167_3)
				end
			end

			if arg_164_1.time_ >= 0 + var_167_3 and arg_164_1.time_ < 0 + var_167_3 + arg_167_0 and not isNil(var_167_2) and arg_164_1.var_.characterEffect10004ui_story then
				arg_164_1.var_.characterEffect10004ui_story.fillFlat = true
				arg_164_1.var_.characterEffect10004ui_story.fillRatio = 0.5
			end

			local var_167_4 = 0
			local var_167_5 = 0.95

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_6 = arg_164_1:GetWordFromCfg(106091040)
				local var_167_7 = arg_164_1:FormatText(var_167_6.content)

				arg_164_1.text_.text = var_167_7

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_9 = 36 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 36)

				if (36 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 36)) > 0 and var_167_5 < var_167_9 then
					arg_164_1.talkMaxDuration = var_167_9

					if var_167_9 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_4
					end
				end

				arg_164_1.text_.text = var_167_7
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091040", "story_v_out_106091.awb") ~= 0 then
					local var_167_10 = manager.audio:GetVoiceLength("story_v_out_106091", "106091040", "story_v_out_106091.awb") / 1000

					if var_167_10 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_4
					end

					if var_167_6.prefab_name ~= "" and arg_164_1.actors_[var_167_6.prefab_name] ~= nil then
						local var_167_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_6.prefab_name].transform, "story_v_out_106091", "106091040", "story_v_out_106091.awb")

						arg_164_1:RecordAudio("106091040", var_167_11)
						arg_164_1:RecordAudio("106091040", var_167_11)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_106091", "106091040", "story_v_out_106091.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_106091", "106091040", "story_v_out_106091.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_12 = math.max(var_167_5, arg_164_1.talkMaxDuration)

			if var_167_4 <= arg_164_1.time_ and arg_164_1.time_ < var_167_4 + var_167_12 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_4) / var_167_12

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_4 + var_167_12 and arg_164_1.time_ < var_167_4 + var_167_12 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {}

		arg_164_1:InitPlayNodeList()
	end,
	Play106091041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 106091041
		arg_168_1.duration_ = 3

		local var_168_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 3,
			en = 1.999999999999
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
				arg_168_0:Play106091042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(arg_168_1.actors_["4014_tpose"]) and arg_168_1.var_.characterEffect4014_tpose == nil then
				arg_168_1.var_.characterEffect4014_tpose = arg_168_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_0 = 0.1

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 and not isNil(arg_168_1.actors_["4014_tpose"]) then
				if arg_168_1.var_.characterEffect4014_tpose and not isNil(arg_168_1.actors_["4014_tpose"]) then
					arg_168_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_168_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_168_1.time_ - 0) / var_171_0)
				end
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 and not isNil(arg_168_1.actors_["4014_tpose"]) and arg_168_1.var_.characterEffect4014_tpose then
				arg_168_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_168_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_171_1 = arg_168_1.actors_["10004ui_story"]

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect10004ui_story == nil then
				arg_168_1.var_.characterEffect10004ui_story = var_171_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_171_2 = 0.1

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 and not isNil(var_171_1) then
				if arg_168_1.var_.characterEffect10004ui_story and not isNil(var_171_1) then
					arg_168_1.var_.characterEffect10004ui_story.fillFlat = false
				end
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 and not isNil(var_171_1) and arg_168_1.var_.characterEffect10004ui_story then
				arg_168_1.var_.characterEffect10004ui_story.fillFlat = false
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/story10004/story10004action/10004action5_2")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_171_4 = 0
			local var_171_5 = 0.15

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_4 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_6 = arg_168_1:GetWordFromCfg(106091041)
				local var_171_7 = arg_168_1:FormatText(var_171_6.content)

				arg_168_1.text_.text = var_171_7

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_9 = 6 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 6)

				if (6 <= 0 and var_171_5 or var_171_5 * (utf8.len(var_171_7) / 6)) > 0 and var_171_5 < var_171_9 then
					arg_168_1.talkMaxDuration = var_171_9

					if var_171_9 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_9 + var_171_4
					end
				end

				arg_168_1.text_.text = var_171_7
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091041", "story_v_out_106091.awb") ~= 0 then
					local var_171_10 = manager.audio:GetVoiceLength("story_v_out_106091", "106091041", "story_v_out_106091.awb") / 1000

					if var_171_10 + var_171_4 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_10 + var_171_4
					end

					if var_171_6.prefab_name ~= "" and arg_168_1.actors_[var_171_6.prefab_name] ~= nil then
						local var_171_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_6.prefab_name].transform, "story_v_out_106091", "106091041", "story_v_out_106091.awb")

						arg_168_1:RecordAudio("106091041", var_171_11)
						arg_168_1:RecordAudio("106091041", var_171_11)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_106091", "106091041", "story_v_out_106091.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_106091", "106091041", "story_v_out_106091.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_12 = math.max(var_171_5, arg_168_1.talkMaxDuration)

			if var_171_4 <= arg_168_1.time_ and arg_168_1.time_ < var_171_4 + var_171_12 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_4) / var_171_12

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_4 + var_171_12 and arg_168_1.time_ < var_171_4 + var_171_12 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play106091042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 106091042
		arg_172_1.duration_ = 6.13

		local var_172_0 = {
			ja = 2.3,
			ko = 5.066,
			zh = 6.133,
			en = 4.066
		}
		local var_172_1 = manager.audio:GetLocalizationFlag()

		if var_172_0[var_172_1] ~= nil then
			arg_172_1.duration_ = var_172_0[var_172_1]
		end

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
			arg_172_1.auto_ = false
		end

		function arg_172_1.playNext_(arg_174_0)
			arg_172_1.onStoryFinished_()
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1:PlayTimeline("10004ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_175_0 = 0
			local var_175_1 = 0.55

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_0 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[80].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_2 = arg_172_1:GetWordFromCfg(106091042)
				local var_175_3 = arg_172_1:FormatText(var_175_2.content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 22 <= 0 and var_175_1 or var_175_1 * (utf8.len(var_175_3) / 22)

				if (22 <= 0 and var_175_1 or var_175_1 * (utf8.len(var_175_3) / 22)) > 0 and var_175_1 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_0
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_106091", "106091042", "story_v_out_106091.awb") ~= 0 then
					local var_175_6 = manager.audio:GetVoiceLength("story_v_out_106091", "106091042", "story_v_out_106091.awb") / 1000

					if var_175_6 + var_175_0 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_6 + var_175_0
					end

					if var_175_2.prefab_name ~= "" and arg_172_1.actors_[var_175_2.prefab_name] ~= nil then
						local var_175_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_2.prefab_name].transform, "story_v_out_106091", "106091042", "story_v_out_106091.awb")

						arg_172_1:RecordAudio("106091042", var_175_7)
						arg_172_1:RecordAudio("106091042", var_175_7)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_106091", "106091042", "story_v_out_106091.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_106091", "106091042", "story_v_out_106091.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_8 = math.max(var_175_1, arg_172_1.talkMaxDuration)

			if var_175_0 <= arg_172_1.time_ and arg_172_1.time_ < var_175_0 + var_175_8 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_0) / var_175_8

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_0 + var_175_8 and arg_172_1.time_ < var_175_0 + var_175_8 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/C05b"
	},
	voices = {
		"story_v_out_106091.awb"
	}
}
