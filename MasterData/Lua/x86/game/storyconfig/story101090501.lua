return {
	Play109051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 109051001
		arg_1_1.duration_ = 4.33

		local var_1_0 = {
			ja = 4.233,
			ko = 3.9,
			zh = 4.333,
			en = 3.566
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
				arg_1_0:Play109051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.C04a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "C04a")
				var_4_0.name = "C04a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.C04a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.C04a

				arg_1_1.bgs_.C04a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "C04a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_4 = arg_1_1.bgs_.C04a:GetComponent("SpriteRenderer")

				if var_4_4 then
					arg_1_1.var_.alphaOldValueC04a = var_4_4.color.a
					arg_1_1.var_.alphaMatValueC04a = var_4_4
				end

				arg_1_1.var_.alphaOldValueC04a = 0
			end

			local var_4_5 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_5 then
				if arg_1_1.var_.alphaMatValueC04a then
					arg_1_1.var_.alphaMatValueC04a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueC04a, 1, (arg_1_1.time_ - 0) / var_4_5)
					arg_1_1.var_.alphaMatValueC04a.color = arg_1_1.var_.alphaMatValueC04a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_5 and arg_1_1.time_ < 0 + var_4_5 + arg_4_0 and arg_1_1.var_.alphaMatValueC04a then
				arg_1_1.var_.alphaMatValueC04a.color.a = 1
				arg_1_1.var_.alphaMatValueC04a.color = arg_1_1.var_.alphaMatValueC04a.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")

				local var_4_8 = manager.audio:GetAudioName("bgm_story_scheme", "bgm_story_scheme")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_8 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_8

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_8
						arg_1_1.bgmTxt2_.text = var_4_8
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

			local var_4_9 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_9 + 2 and arg_1_1.time_ < var_4_9 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_10 = 2
			local var_4_11 = 0.175

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_10 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_12 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_12:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_12:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_13 = arg_1_1:GetWordFromCfg(109051001)
				local var_4_14 = arg_1_1:FormatText(var_4_13.content)

				arg_1_1.text_.text = var_4_14

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_16 = 7 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_14) / 7)

				if (7 <= 0 and var_4_11 or var_4_11 * (utf8.len(var_4_14) / 7)) > 0 and var_4_11 < var_4_16 then
					arg_1_1.talkMaxDuration = var_4_16
					var_4_10 = var_4_10 + 0.3

					if var_4_16 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_16 + var_4_10
					end
				end

				arg_1_1.text_.text = var_4_14
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051001", "story_v_out_109051.awb") ~= 0 then
					local var_4_17 = manager.audio:GetVoiceLength("story_v_out_109051", "109051001", "story_v_out_109051.awb") / 1000

					if var_4_17 + var_4_10 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_17 + var_4_10
					end

					if var_4_13.prefab_name ~= "" and arg_1_1.actors_[var_4_13.prefab_name] ~= nil then
						local var_4_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_13.prefab_name].transform, "story_v_out_109051", "109051001", "story_v_out_109051.awb")

						arg_1_1:RecordAudio("109051001", var_4_18)
						arg_1_1:RecordAudio("109051001", var_4_18)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_109051", "109051001", "story_v_out_109051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_109051", "109051001", "story_v_out_109051.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_19 = var_4_10 + 0.3
			local var_4_20 = math.max(var_4_11, arg_1_1.talkMaxDuration)

			if var_4_10 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_19 + var_4_20 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_19) / var_4_20

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_19 + var_4_20 and arg_1_1.time_ < var_4_19 + var_4_20 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play109051002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 109051002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play109051003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:AudioAction("play", "effect", "se_story_9", "se_story_9_jump", "")
			end

			local var_11_1 = 0
			local var_11_2 = 0.95

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

				local var_11_3 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(109051002).content)

				arg_8_1.text_.text = var_11_3

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_5 = 38 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 38)

				if (38 <= 0 and var_11_2 or var_11_2 * (utf8.len(var_11_3) / 38)) > 0 and var_11_2 < var_11_5 then
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
	Play109051003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 109051003
		arg_12_1.duration_ = 6.53

		local var_12_0 = {
			ja = 2.6,
			ko = 5.033,
			zh = 4.7,
			en = 6.533
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
				arg_12_0:Play109051004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["3004_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3004_tpose"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "3004_tpose"), arg_12_1.stage_.transform)

				var_15_0.name = "3004_tpose"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["3004_tpose"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["3004_tpose" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["3004_tpose" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["3004_tpose" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["3004_tpose"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos3004_tpose = var_15_3.localPosition

				local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_3.gameObject, typeof(DynamicBoneHelper))

				if var_15_4 then
					var_15_4:EnableDynamicBone(false)
				end
			end

			local var_15_5 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_5 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_12_1.time_ - 0) / var_15_5)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_5 and arg_12_1.time_ < 0 + var_15_5 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, -2.22, -3.1)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles

				local var_15_6 = GameObjectTools.GetOrAddComponent(var_15_3.gameObject, typeof(DynamicBoneHelper))

				if var_15_6 then
					var_15_6:EnableDynamicBone(true)
				end
			end

			local var_15_7 = arg_12_1.actors_["3004_tpose"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_7) and arg_12_1.var_.characterEffect3004_tpose == nil then
				arg_12_1.var_.characterEffect3004_tpose = var_15_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_8 = 0.2

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_8 and not isNil(var_15_7) then
				if arg_12_1.var_.characterEffect3004_tpose and not isNil(var_15_7) then
					arg_12_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_8 and arg_12_1.time_ < 0 + var_15_8 + arg_15_0 and not isNil(var_15_7) and arg_12_1.var_.characterEffect3004_tpose then
				arg_12_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_15_10 = 0
			local var_15_11 = 0.525

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(109051003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 21 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 21)

				if (21 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 21)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051003", "story_v_out_109051.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_109051", "109051003", "story_v_out_109051.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_109051", "109051003", "story_v_out_109051.awb")

						arg_12_1:RecordAudio("109051003", var_15_17)
						arg_12_1:RecordAudio("109051003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_109051", "109051003", "story_v_out_109051.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_109051", "109051003", "story_v_out_109051.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_18 and arg_12_1.time_ < var_15_10 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play109051004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 109051004
		arg_16_1.duration_ = 2.07

		local var_16_0 = {
			ja = 1.333,
			ko = 1.7,
			zh = 1.433,
			en = 2.066
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
				arg_16_0:Play109051005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos3004_tpose = arg_16_1.actors_["3004_tpose"].transform.localPosition

				local var_19_0 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_0 then
					var_19_0:EnableDynamicBone(false)
				end
			end

			local var_19_1 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_1 then
				arg_16_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_1)
				arg_16_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).z)
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles = arg_16_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_1 and arg_16_1.time_ < 0 + var_19_1 + arg_19_0 then
				arg_16_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_16_1.actors_["3004_tpose"].transform.position).z)
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_16_1.actors_["3004_tpose"].transform.localEulerAngles = arg_16_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_19_2 = GameObjectTools.GetOrAddComponent(arg_16_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(true)
				end
			end

			local var_19_3 = 0
			local var_19_4 = 0.1

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, true)
				arg_16_1.iconController_:SetSelectedState("hero")

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_5 = arg_16_1:GetWordFromCfg(109051004)
				local var_19_6 = arg_16_1:FormatText(var_19_5.content)

				arg_16_1.text_.text = var_19_6

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_8 = 4 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_6) / 4)

				if (4 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_6) / 4)) > 0 and var_19_4 < var_19_8 then
					arg_16_1.talkMaxDuration = var_19_8

					if var_19_8 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_3
					end
				end

				arg_16_1.text_.text = var_19_6
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051004", "story_v_out_109051.awb") ~= 0 then
					local var_19_9 = manager.audio:GetVoiceLength("story_v_out_109051", "109051004", "story_v_out_109051.awb") / 1000

					if var_19_9 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_3
					end

					if var_19_5.prefab_name ~= "" and arg_16_1.actors_[var_19_5.prefab_name] ~= nil then
						local var_19_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_5.prefab_name].transform, "story_v_out_109051", "109051004", "story_v_out_109051.awb")

						arg_16_1:RecordAudio("109051004", var_19_10)
						arg_16_1:RecordAudio("109051004", var_19_10)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_109051", "109051004", "story_v_out_109051.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_109051", "109051004", "story_v_out_109051.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_4, arg_16_1.talkMaxDuration)

			if var_19_3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_3 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_3) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_3 + var_19_11 and arg_16_1.time_ < var_19_3 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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

		arg_16_1:InitPlayNodeList()
	end,
	Play109051005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 109051005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play109051006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.875

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(109051005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 35 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 35)

				if (35 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 35)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play109051006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 109051006
		arg_24_1.duration_ = 7.67

		local var_24_0 = {
			ja = 7.366,
			ko = 4.533,
			zh = 7.666,
			en = 4.8
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
				arg_24_0:Play109051007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.725

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(109051006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 29 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 29)

				if (29 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 29)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051006", "story_v_out_109051.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_109051", "109051006", "story_v_out_109051.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_109051", "109051006", "story_v_out_109051.awb")

						arg_24_1:RecordAudio("109051006", var_27_6)
						arg_24_1:RecordAudio("109051006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_109051", "109051006", "story_v_out_109051.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_109051", "109051006", "story_v_out_109051.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play109051007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 109051007
		arg_28_1.duration_ = 7.13

		local var_28_0 = {
			ja = 7.133,
			ko = 5,
			zh = 6.7,
			en = 6.3
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
				arg_28_0:Play109051008(arg_28_1)
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
				arg_28_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_28_1.time_ - 0) / var_31_1)
				arg_28_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).z)
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles = arg_28_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_1 and arg_28_1.time_ < 0 + var_31_1 + arg_31_0 then
				arg_28_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, -2.22, -3.1)
				arg_28_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["3004_tpose"].transform.position).z)
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["3004_tpose"].transform.localEulerAngles = arg_28_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_31_2 = GameObjectTools.GetOrAddComponent(arg_28_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(true)
				end
			end

			local var_31_3 = arg_28_1.actors_["3004_tpose"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect3004_tpose == nil then
				arg_28_1.var_.characterEffect3004_tpose = var_31_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_4 = 0.2

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 and not isNil(var_31_3) then
				if arg_28_1.var_.characterEffect3004_tpose and not isNil(var_31_3) then
					arg_28_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect3004_tpose then
				arg_28_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_31_6 = 0
			local var_31_7 = 0.575

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_6 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[158].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_8 = arg_28_1:GetWordFromCfg(109051007)
				local var_31_9 = arg_28_1:FormatText(var_31_8.content)

				arg_28_1.text_.text = var_31_9

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_11 = 23 <= 0 and var_31_7 or var_31_7 * (utf8.len(var_31_9) / 23)

				if (23 <= 0 and var_31_7 or var_31_7 * (utf8.len(var_31_9) / 23)) > 0 and var_31_7 < var_31_11 then
					arg_28_1.talkMaxDuration = var_31_11

					if var_31_11 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_11 + var_31_6
					end
				end

				arg_28_1.text_.text = var_31_9
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051007", "story_v_out_109051.awb") ~= 0 then
					local var_31_12 = manager.audio:GetVoiceLength("story_v_out_109051", "109051007", "story_v_out_109051.awb") / 1000

					if var_31_12 + var_31_6 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_12 + var_31_6
					end

					if var_31_8.prefab_name ~= "" and arg_28_1.actors_[var_31_8.prefab_name] ~= nil then
						local var_31_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_8.prefab_name].transform, "story_v_out_109051", "109051007", "story_v_out_109051.awb")

						arg_28_1:RecordAudio("109051007", var_31_13)
						arg_28_1:RecordAudio("109051007", var_31_13)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_109051", "109051007", "story_v_out_109051.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_109051", "109051007", "story_v_out_109051.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_14 = math.max(var_31_7, arg_28_1.talkMaxDuration)

			if var_31_6 <= arg_28_1.time_ and arg_28_1.time_ < var_31_6 + var_31_14 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_6) / var_31_14

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_6 + var_31_14 and arg_28_1.time_ < var_31_6 + var_31_14 + arg_31_0 then
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
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play109051008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 109051008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play109051009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos3004_tpose = arg_32_1.actors_["3004_tpose"].transform.localPosition

				local var_35_0 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_0 then
					var_35_0:EnableDynamicBone(false)
				end
			end

			local var_35_1 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_1 then
				arg_32_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_1)
				arg_32_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["3004_tpose"].transform.position).z)
				arg_32_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["3004_tpose"].transform.localEulerAngles = arg_32_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_1 and arg_32_1.time_ < 0 + var_35_1 + arg_35_0 then
				arg_32_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["3004_tpose"].transform.position).z)
				arg_32_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["3004_tpose"].transform.localEulerAngles = arg_32_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_35_2 = GameObjectTools.GetOrAddComponent(arg_32_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(true)
				end
			end

			local var_35_3 = 0
			local var_35_4 = 0.4

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_3 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_5 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(109051008).content)

				arg_32_1.text_.text = var_35_5

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_7 = 16 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_5) / 16)

				if (16 <= 0 and var_35_4 or var_35_4 * (utf8.len(var_35_5) / 16)) > 0 and var_35_4 < var_35_7 then
					arg_32_1.talkMaxDuration = var_35_7

					if var_35_7 + var_35_3 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_3
					end
				end

				arg_32_1.text_.text = var_35_5
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_8 = math.max(var_35_4, arg_32_1.talkMaxDuration)

			if var_35_3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_3 + var_35_8 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_3) / var_35_8

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_3 + var_35_8 and arg_32_1.time_ < var_35_3 + var_35_8 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play109051009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 109051009
		arg_36_1.duration_ = 5.5

		local var_36_0 = {
			ja = 5.5,
			ko = 4,
			zh = 4.633,
			en = 3.933
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
				arg_36_0:Play109051010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			local var_39_0 = 0.375

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_1 = arg_36_1:GetWordFromCfg(109051009)
				local var_39_2 = arg_36_1:FormatText(var_39_1.content)

				arg_36_1.text_.text = var_39_2

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_4 = 15 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 15)

				if (15 <= 0 and var_39_0 or var_39_0 * (utf8.len(var_39_2) / 15)) > 0 and var_39_0 < var_39_4 then
					arg_36_1.talkMaxDuration = var_39_4

					if var_39_4 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_4 + 0
					end
				end

				arg_36_1.text_.text = var_39_2
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051009", "story_v_out_109051.awb") ~= 0 then
					local var_39_5 = manager.audio:GetVoiceLength("story_v_out_109051", "109051009", "story_v_out_109051.awb") / 1000

					if var_39_5 + 0 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + 0
					end

					if var_39_1.prefab_name ~= "" and arg_36_1.actors_[var_39_1.prefab_name] ~= nil then
						local var_39_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_1.prefab_name].transform, "story_v_out_109051", "109051009", "story_v_out_109051.awb")

						arg_36_1:RecordAudio("109051009", var_39_6)
						arg_36_1:RecordAudio("109051009", var_39_6)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_109051", "109051009", "story_v_out_109051.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_109051", "109051009", "story_v_out_109051.awb")
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
	Play109051010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 109051010
		arg_40_1.duration_ = 29.1

		local var_40_0 = {
			ja = 29.1,
			ko = 7.6,
			zh = 13.6,
			en = 12.133
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
				arg_40_0:Play109051011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if arg_40_1.actors_["3007_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3007_tpose"))) then
				local var_43_0 = Object.Instantiate(Asset.Load("Char/" .. "3007_tpose"), arg_40_1.stage_.transform)

				var_43_0.name = "3007_tpose"
				var_43_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["3007_tpose"] = var_43_0

				local var_43_1 = var_43_0:GetComponentInChildren(typeof(CharacterEffect))

				var_43_1.enabled = true

				local var_43_2 = GameObjectTools.GetOrAddComponent(var_43_0, typeof(DynamicBoneHelper))

				if var_43_2 then
					var_43_2:EnableDynamicBone(false)
				end

				arg_40_1:ShowWeapon(var_43_1.transform, false)

				arg_40_1.var_["3007_tpose" .. "Animator"] = var_43_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_40_1.var_["3007_tpose" .. "Animator"].applyRootMotion = true
				arg_40_1.var_["3007_tpose" .. "LipSync"] = var_43_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_43_3 = arg_40_1.actors_["3007_tpose"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos3007_tpose = var_43_3.localPosition

				local var_43_4 = GameObjectTools.GetOrAddComponent(var_43_3.gameObject, typeof(DynamicBoneHelper))

				if var_43_4 then
					var_43_4:EnableDynamicBone(false)
				end
			end

			local var_43_5 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_5 then
				var_43_3.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos3007_tpose, Vector3.New(0, -2.25, -1.9), (arg_40_1.time_ - 0) / var_43_5)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_5 and arg_40_1.time_ < 0 + var_43_5 + arg_43_0 then
				var_43_3.localPosition = Vector3.New(0, -2.25, -1.9)
				var_43_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_3.position).x, (manager.ui.mainCamera.transform.position - var_43_3.position).y, (manager.ui.mainCamera.transform.position - var_43_3.position).z)
				var_43_3.localEulerAngles.z = 0
				var_43_3.localEulerAngles.x = 0
				var_43_3.localEulerAngles = var_43_3.localEulerAngles

				local var_43_6 = GameObjectTools.GetOrAddComponent(var_43_3.gameObject, typeof(DynamicBoneHelper))

				if var_43_6 then
					var_43_6:EnableDynamicBone(true)
				end
			end

			local var_43_7 = arg_40_1.actors_["3007_tpose"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect3007_tpose == nil then
				arg_40_1.var_.characterEffect3007_tpose = var_43_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_8 = 0.2

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_8 and not isNil(var_43_7) then
				if arg_40_1.var_.characterEffect3007_tpose and not isNil(var_43_7) then
					arg_40_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_8 and arg_40_1.time_ < 0 + var_43_8 + arg_43_0 and not isNil(var_43_7) and arg_40_1.var_.characterEffect3007_tpose then
				arg_40_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_43_10 = 0
			local var_43_11 = 0.65

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_10 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[158].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_12 = arg_40_1:GetWordFromCfg(109051010)
				local var_43_13 = arg_40_1:FormatText(var_43_12.content)

				arg_40_1.text_.text = var_43_13

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_15 = 26 <= 0 and var_43_11 or var_43_11 * (utf8.len(var_43_13) / 26)

				if (26 <= 0 and var_43_11 or var_43_11 * (utf8.len(var_43_13) / 26)) > 0 and var_43_11 < var_43_15 then
					arg_40_1.talkMaxDuration = var_43_15

					if var_43_15 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_15 + var_43_10
					end
				end

				arg_40_1.text_.text = var_43_13
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051010", "story_v_out_109051.awb") ~= 0 then
					local var_43_16 = manager.audio:GetVoiceLength("story_v_out_109051", "109051010", "story_v_out_109051.awb") / 1000

					if var_43_16 + var_43_10 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_16 + var_43_10
					end

					if var_43_12.prefab_name ~= "" and arg_40_1.actors_[var_43_12.prefab_name] ~= nil then
						local var_43_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_12.prefab_name].transform, "story_v_out_109051", "109051010", "story_v_out_109051.awb")

						arg_40_1:RecordAudio("109051010", var_43_17)
						arg_40_1:RecordAudio("109051010", var_43_17)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_109051", "109051010", "story_v_out_109051.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_109051", "109051010", "story_v_out_109051.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_18 = math.max(var_43_11, arg_40_1.talkMaxDuration)

			if var_43_10 <= arg_40_1.time_ and arg_40_1.time_ < var_43_10 + var_43_18 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_10) / var_43_18

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_10 + var_43_18 and arg_40_1.time_ < var_43_10 + var_43_18 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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

		arg_40_1:InitPlayNodeList()
	end,
	Play109051011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 109051011
		arg_44_1.duration_ = 7.6

		local var_44_0 = {
			ja = 7,
			ko = 1.4,
			zh = 7.6,
			en = 2.5
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
				arg_44_0:Play109051012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["3007_tpose"]) and arg_44_1.var_.characterEffect3007_tpose == nil then
				arg_44_1.var_.characterEffect3007_tpose = arg_44_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.2

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["3007_tpose"]) then
				if arg_44_1.var_.characterEffect3007_tpose and not isNil(arg_44_1.actors_["3007_tpose"]) then
					arg_44_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_44_1.var_.characterEffect3007_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_0)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["3007_tpose"]) and arg_44_1.var_.characterEffect3007_tpose then
				arg_44_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_44_1.var_.characterEffect3007_tpose.fillRatio = 0.5
			end

			local var_47_1 = 0
			local var_47_2 = 0.3

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_1 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_3 = arg_44_1:GetWordFromCfg(109051011)
				local var_47_4 = arg_44_1:FormatText(var_47_3.content)

				arg_44_1.text_.text = var_47_4

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_6 = 9 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_4) / 9)

				if (9 <= 0 and var_47_2 or var_47_2 * (utf8.len(var_47_4) / 9)) > 0 and var_47_2 < var_47_6 then
					arg_44_1.talkMaxDuration = var_47_6

					if var_47_6 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_1
					end
				end

				arg_44_1.text_.text = var_47_4
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051011", "story_v_out_109051.awb") ~= 0 then
					local var_47_7 = manager.audio:GetVoiceLength("story_v_out_109051", "109051011", "story_v_out_109051.awb") / 1000

					if var_47_7 + var_47_1 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_1
					end

					if var_47_3.prefab_name ~= "" and arg_44_1.actors_[var_47_3.prefab_name] ~= nil then
						local var_47_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_3.prefab_name].transform, "story_v_out_109051", "109051011", "story_v_out_109051.awb")

						arg_44_1:RecordAudio("109051011", var_47_8)
						arg_44_1:RecordAudio("109051011", var_47_8)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_109051", "109051011", "story_v_out_109051.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_109051", "109051011", "story_v_out_109051.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_9 = math.max(var_47_2, arg_44_1.talkMaxDuration)

			if var_47_1 <= arg_44_1.time_ and arg_44_1.time_ < var_47_1 + var_47_9 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_1) / var_47_9

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_1 + var_47_9 and arg_44_1.time_ < var_47_1 + var_47_9 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play109051012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 109051012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play109051013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			local var_51_0 = 0.5

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_1 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(109051012).content)

				arg_48_1.text_.text = var_51_1

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_3 = 20 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 20)

				if (20 <= 0 and var_51_0 or var_51_0 * (utf8.len(var_51_1) / 20)) > 0 and var_51_0 < var_51_3 then
					arg_48_1.talkMaxDuration = var_51_3

					if var_51_3 + 0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_3 + 0
					end
				end

				arg_48_1.text_.text = var_51_1
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_4 = math.max(var_51_0, arg_48_1.talkMaxDuration)

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_4 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - 0) / var_51_4

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= 0 + var_51_4 and arg_48_1.time_ < 0 + var_51_4 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play109051013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 109051013
		arg_52_1.duration_ = 5

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play109051014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			local var_55_0 = 1.3

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, false)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_1 = arg_52_1:FormatText(arg_52_1:GetWordFromCfg(109051013).content)

				arg_52_1.text_.text = var_55_1

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_3 = 52 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 52)

				if (52 <= 0 and var_55_0 or var_55_0 * (utf8.len(var_55_1) / 52)) > 0 and var_55_0 < var_55_3 then
					arg_52_1.talkMaxDuration = var_55_3

					if var_55_3 + 0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_3 + 0
					end
				end

				arg_52_1.text_.text = var_55_1
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)
				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_4 = math.max(var_55_0, arg_52_1.talkMaxDuration)

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - 0) / var_55_4

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play109051014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 109051014
		arg_56_1.duration_ = 11.7

		local var_56_0 = {
			ja = 10.2,
			ko = 8.266,
			zh = 10.4,
			en = 11.7
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
				arg_56_0:Play109051015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.775

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:GetWordFromCfg(109051014)
				local var_59_2 = arg_56_1:FormatText(var_59_1.content)

				arg_56_1.text_.text = var_59_2

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_4 = 31 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 31)

				if (31 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_2) / 31)) > 0 and var_59_0 < var_59_4 then
					arg_56_1.talkMaxDuration = var_59_4

					if var_59_4 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_4 + 0
					end
				end

				arg_56_1.text_.text = var_59_2
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051014", "story_v_out_109051.awb") ~= 0 then
					local var_59_5 = manager.audio:GetVoiceLength("story_v_out_109051", "109051014", "story_v_out_109051.awb") / 1000

					if var_59_5 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + 0
					end

					if var_59_1.prefab_name ~= "" and arg_56_1.actors_[var_59_1.prefab_name] ~= nil then
						local var_59_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_1.prefab_name].transform, "story_v_out_109051", "109051014", "story_v_out_109051.awb")

						arg_56_1:RecordAudio("109051014", var_59_6)
						arg_56_1:RecordAudio("109051014", var_59_6)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_109051", "109051014", "story_v_out_109051.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_109051", "109051014", "story_v_out_109051.awb")
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
	Play109051015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 109051015
		arg_60_1.duration_ = 9.37

		local var_60_0 = {
			ja = 8.066,
			ko = 8.766,
			zh = 9.366,
			en = 8.266
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
				arg_60_0:Play109051016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			local var_63_0 = 0.975

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, true)
				arg_60_1.iconController_:SetSelectedState("hero")

				arg_60_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_60_1.callingController_:SetSelectedState("normal")

				arg_60_1.keyicon_.color = Color.New(1, 1, 1)
				arg_60_1.icon_.color = Color.New(1, 1, 1)

				local var_63_1 = arg_60_1:GetWordFromCfg(109051015)
				local var_63_2 = arg_60_1:FormatText(var_63_1.content)

				arg_60_1.text_.text = var_63_2

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_4 = 39 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 39)

				if (39 <= 0 and var_63_0 or var_63_0 * (utf8.len(var_63_2) / 39)) > 0 and var_63_0 < var_63_4 then
					arg_60_1.talkMaxDuration = var_63_4

					if var_63_4 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_4 + 0
					end
				end

				arg_60_1.text_.text = var_63_2
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051015", "story_v_out_109051.awb") ~= 0 then
					local var_63_5 = manager.audio:GetVoiceLength("story_v_out_109051", "109051015", "story_v_out_109051.awb") / 1000

					if var_63_5 + 0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + 0
					end

					if var_63_1.prefab_name ~= "" and arg_60_1.actors_[var_63_1.prefab_name] ~= nil then
						local var_63_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_1.prefab_name].transform, "story_v_out_109051", "109051015", "story_v_out_109051.awb")

						arg_60_1:RecordAudio("109051015", var_63_6)
						arg_60_1:RecordAudio("109051015", var_63_6)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_109051", "109051015", "story_v_out_109051.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_109051", "109051015", "story_v_out_109051.awb")
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
	Play109051016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 109051016
		arg_64_1.duration_ = 4.6

		local var_64_0 = {
			ja = 4.6,
			ko = 1.666,
			zh = 1.933,
			en = 2.566
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
				arg_64_0:Play109051017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["3007_tpose"]) and arg_64_1.var_.characterEffect3007_tpose == nil then
				arg_64_1.var_.characterEffect3007_tpose = arg_64_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.2

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["3007_tpose"]) then
				if arg_64_1.var_.characterEffect3007_tpose and not isNil(arg_64_1.actors_["3007_tpose"]) then
					arg_64_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["3007_tpose"]) and arg_64_1.var_.characterEffect3007_tpose then
				arg_64_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_67_2 = 0
			local var_67_3 = 0.1

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_2 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[158].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_4 = arg_64_1:GetWordFromCfg(109051016)
				local var_67_5 = arg_64_1:FormatText(var_67_4.content)

				arg_64_1.text_.text = var_67_5

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_7 = 4 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 4)

				if (4 <= 0 and var_67_3 or var_67_3 * (utf8.len(var_67_5) / 4)) > 0 and var_67_3 < var_67_7 then
					arg_64_1.talkMaxDuration = var_67_7

					if var_67_7 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_2
					end
				end

				arg_64_1.text_.text = var_67_5
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051016", "story_v_out_109051.awb") ~= 0 then
					local var_67_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051016", "story_v_out_109051.awb") / 1000

					if var_67_8 + var_67_2 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_8 + var_67_2
					end

					if var_67_4.prefab_name ~= "" and arg_64_1.actors_[var_67_4.prefab_name] ~= nil then
						local var_67_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_4.prefab_name].transform, "story_v_out_109051", "109051016", "story_v_out_109051.awb")

						arg_64_1:RecordAudio("109051016", var_67_9)
						arg_64_1:RecordAudio("109051016", var_67_9)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_109051", "109051016", "story_v_out_109051.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_109051", "109051016", "story_v_out_109051.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_10 = math.max(var_67_3, arg_64_1.talkMaxDuration)

			if var_67_2 <= arg_64_1.time_ and arg_64_1.time_ < var_67_2 + var_67_10 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_2) / var_67_10

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_2 + var_67_10 and arg_64_1.time_ < var_67_2 + var_67_10 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play109051017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 109051017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play109051018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["3007_tpose"]) and arg_68_1.var_.characterEffect3007_tpose == nil then
				arg_68_1.var_.characterEffect3007_tpose = arg_68_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.2

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["3007_tpose"]) then
				if arg_68_1.var_.characterEffect3007_tpose and not isNil(arg_68_1.actors_["3007_tpose"]) then
					arg_68_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_68_1.var_.characterEffect3007_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["3007_tpose"]) and arg_68_1.var_.characterEffect3007_tpose then
				arg_68_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_68_1.var_.characterEffect3007_tpose.fillRatio = 0.5
			end

			local var_71_1 = 0
			local var_71_2 = 0.75

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, false)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_3 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(109051017).content)

				arg_68_1.text_.text = var_71_3

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_5 = 30 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 30)

				if (30 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_3) / 30)) > 0 and var_71_2 < var_71_5 then
					arg_68_1.talkMaxDuration = var_71_5

					if var_71_5 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_5 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_3
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_6 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_6 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_6

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_6 and arg_68_1.time_ < var_71_1 + var_71_6 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play109051018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 109051018
		arg_72_1.duration_ = 2.73

		local var_72_0 = {
			ja = 2.733,
			ko = 1.2,
			zh = 2.1,
			en = 1.233
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
				arg_72_0:Play109051019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			local var_75_0 = 0.1

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_1 = arg_72_1:GetWordFromCfg(109051018)
				local var_75_2 = arg_72_1:FormatText(var_75_1.content)

				arg_72_1.text_.text = var_75_2

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_4 = 4 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 4)

				if (4 <= 0 and var_75_0 or var_75_0 * (utf8.len(var_75_2) / 4)) > 0 and var_75_0 < var_75_4 then
					arg_72_1.talkMaxDuration = var_75_4

					if var_75_4 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_4 + 0
					end
				end

				arg_72_1.text_.text = var_75_2
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051018", "story_v_out_109051.awb") ~= 0 then
					local var_75_5 = manager.audio:GetVoiceLength("story_v_out_109051", "109051018", "story_v_out_109051.awb") / 1000

					if var_75_5 + 0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + 0
					end

					if var_75_1.prefab_name ~= "" and arg_72_1.actors_[var_75_1.prefab_name] ~= nil then
						local var_75_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_1.prefab_name].transform, "story_v_out_109051", "109051018", "story_v_out_109051.awb")

						arg_72_1:RecordAudio("109051018", var_75_6)
						arg_72_1:RecordAudio("109051018", var_75_6)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_109051", "109051018", "story_v_out_109051.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_109051", "109051018", "story_v_out_109051.awb")
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
	Play109051019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 109051019
		arg_76_1.duration_ = 3.73

		local var_76_0 = {
			ja = 3.733,
			ko = 1.066,
			zh = 1.366,
			en = 3.633
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
				arg_76_0:Play109051020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["3007_tpose"]) and arg_76_1.var_.characterEffect3007_tpose == nil then
				arg_76_1.var_.characterEffect3007_tpose = arg_76_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.2

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["3007_tpose"]) then
				if arg_76_1.var_.characterEffect3007_tpose and not isNil(arg_76_1.actors_["3007_tpose"]) then
					arg_76_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["3007_tpose"]) and arg_76_1.var_.characterEffect3007_tpose then
				arg_76_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			local var_79_2 = 0
			local var_79_3 = 0.05

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_2 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[158].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_4 = arg_76_1:GetWordFromCfg(109051019)
				local var_79_5 = arg_76_1:FormatText(var_79_4.content)

				arg_76_1.text_.text = var_79_5

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_7 = 2 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 2)

				if (2 <= 0 and var_79_3 or var_79_3 * (utf8.len(var_79_5) / 2)) > 0 and var_79_3 < var_79_7 then
					arg_76_1.talkMaxDuration = var_79_7

					if var_79_7 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_7 + var_79_2
					end
				end

				arg_76_1.text_.text = var_79_5
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051019", "story_v_out_109051.awb") ~= 0 then
					local var_79_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051019", "story_v_out_109051.awb") / 1000

					if var_79_8 + var_79_2 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_8 + var_79_2
					end

					if var_79_4.prefab_name ~= "" and arg_76_1.actors_[var_79_4.prefab_name] ~= nil then
						local var_79_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_4.prefab_name].transform, "story_v_out_109051", "109051019", "story_v_out_109051.awb")

						arg_76_1:RecordAudio("109051019", var_79_9)
						arg_76_1:RecordAudio("109051019", var_79_9)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_109051", "109051019", "story_v_out_109051.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_109051", "109051019", "story_v_out_109051.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_10 = math.max(var_79_3, arg_76_1.talkMaxDuration)

			if var_79_2 <= arg_76_1.time_ and arg_76_1.time_ < var_79_2 + var_79_10 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_2) / var_79_10

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_2 + var_79_10 and arg_76_1.time_ < var_79_2 + var_79_10 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play109051020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 109051020
		arg_80_1.duration_ = 5.7

		local var_80_0 = {
			ja = 5.7,
			ko = 4.2,
			zh = 4.066,
			en = 3.933
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
				arg_80_0:Play109051021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["3007_tpose"]) and arg_80_1.var_.characterEffect3007_tpose == nil then
				arg_80_1.var_.characterEffect3007_tpose = arg_80_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.2

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["3007_tpose"]) then
				if arg_80_1.var_.characterEffect3007_tpose and not isNil(arg_80_1.actors_["3007_tpose"]) then
					arg_80_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_80_1.var_.characterEffect3007_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["3007_tpose"]) and arg_80_1.var_.characterEffect3007_tpose then
				arg_80_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_80_1.var_.characterEffect3007_tpose.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.35

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4014")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(109051020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 14 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 14)

				if (14 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 14)) > 0 and var_83_2 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051020", "story_v_out_109051.awb") ~= 0 then
					local var_83_7 = manager.audio:GetVoiceLength("story_v_out_109051", "109051020", "story_v_out_109051.awb") / 1000

					if var_83_7 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_1
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_109051", "109051020", "story_v_out_109051.awb")

						arg_80_1:RecordAudio("109051020", var_83_8)
						arg_80_1:RecordAudio("109051020", var_83_8)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_109051", "109051020", "story_v_out_109051.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_109051", "109051020", "story_v_out_109051.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_9 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_9 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_9

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_9 and arg_80_1.time_ < var_83_1 + var_83_9 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play109051021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 109051021
		arg_84_1.duration_ = 3.2

		local var_84_0 = {
			ja = 3.2,
			ko = 2.3,
			zh = 2.733,
			en = 1.733
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
				arg_84_0:Play109051022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.25

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:GetWordFromCfg(109051021)
				local var_87_2 = arg_84_1:FormatText(var_87_1.content)

				arg_84_1.text_.text = var_87_2

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_4 = 10 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 10)

				if (10 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_2) / 10)) > 0 and var_87_0 < var_87_4 then
					arg_84_1.talkMaxDuration = var_87_4

					if var_87_4 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_4 + 0
					end
				end

				arg_84_1.text_.text = var_87_2
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051021", "story_v_out_109051.awb") ~= 0 then
					local var_87_5 = manager.audio:GetVoiceLength("story_v_out_109051", "109051021", "story_v_out_109051.awb") / 1000

					if var_87_5 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + 0
					end

					if var_87_1.prefab_name ~= "" and arg_84_1.actors_[var_87_1.prefab_name] ~= nil then
						local var_87_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_1.prefab_name].transform, "story_v_out_109051", "109051021", "story_v_out_109051.awb")

						arg_84_1:RecordAudio("109051021", var_87_6)
						arg_84_1:RecordAudio("109051021", var_87_6)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_109051", "109051021", "story_v_out_109051.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_109051", "109051021", "story_v_out_109051.awb")
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
	Play109051022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 109051022
		arg_88_1.duration_ = 11.57

		local var_88_0 = {
			ja = 11.566,
			ko = 7.633,
			zh = 10.033,
			en = 10.666
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play109051023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos3007_tpose = arg_88_1.actors_["3007_tpose"].transform.localPosition

				local var_91_0 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_0 then
					var_91_0:EnableDynamicBone(false)
				end
			end

			local var_91_1 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 then
				arg_88_1.actors_["3007_tpose"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos3007_tpose, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_1)
				arg_88_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).z)
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles = arg_88_1.actors_["3007_tpose"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 then
				arg_88_1.actors_["3007_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["3007_tpose"].transform.position).z)
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["3007_tpose"].transform.localEulerAngles = arg_88_1.actors_["3007_tpose"].transform.localEulerAngles

				local var_91_2 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(true)
				end
			end

			local var_91_3 = "4014_tpose"

			if arg_88_1.actors_["4014_tpose"] == nil and not isNil((Asset.Load("Char/" .. "4014_tpose"))) then
				local var_91_4 = Object.Instantiate(Asset.Load("Char/" .. "4014_tpose"), arg_88_1.stage_.transform)

				var_91_4.name = var_91_3
				var_91_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_[var_91_3] = var_91_4

				local var_91_5 = var_91_4:GetComponentInChildren(typeof(CharacterEffect))

				var_91_5.enabled = true

				local var_91_6 = GameObjectTools.GetOrAddComponent(var_91_4, typeof(DynamicBoneHelper))

				if var_91_6 then
					var_91_6:EnableDynamicBone(false)
				end

				arg_88_1:ShowWeapon(var_91_5.transform, false)

				arg_88_1.var_[var_91_3 .. "Animator"] = var_91_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_88_1.var_[var_91_3 .. "Animator"].applyRootMotion = true
				arg_88_1.var_[var_91_3 .. "LipSync"] = var_91_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_91_7 = arg_88_1.actors_["4014_tpose"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos4014_tpose = var_91_7.localPosition

				local var_91_8 = GameObjectTools.GetOrAddComponent(var_91_7.gameObject, typeof(DynamicBoneHelper))

				if var_91_8 then
					var_91_8:EnableDynamicBone(false)
				end
			end

			local var_91_9 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_9 then
				var_91_7.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_88_1.time_ - 0) / var_91_9)
				var_91_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_7.position).x, (manager.ui.mainCamera.transform.position - var_91_7.position).y, (manager.ui.mainCamera.transform.position - var_91_7.position).z)
				var_91_7.localEulerAngles.z = 0
				var_91_7.localEulerAngles.x = 0
				var_91_7.localEulerAngles = var_91_7.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_9 and arg_88_1.time_ < 0 + var_91_9 + arg_91_0 then
				var_91_7.localPosition = Vector3.New(0, -1.95, -4.2)
				var_91_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_7.position).x, (manager.ui.mainCamera.transform.position - var_91_7.position).y, (manager.ui.mainCamera.transform.position - var_91_7.position).z)
				var_91_7.localEulerAngles.z = 0
				var_91_7.localEulerAngles.x = 0
				var_91_7.localEulerAngles = var_91_7.localEulerAngles

				local var_91_10 = GameObjectTools.GetOrAddComponent(var_91_7.gameObject, typeof(DynamicBoneHelper))

				if var_91_10 then
					var_91_10:EnableDynamicBone(true)
				end
			end

			local var_91_11 = arg_88_1.actors_["4014_tpose"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_11) and arg_88_1.var_.characterEffect4014_tpose == nil then
				arg_88_1.var_.characterEffect4014_tpose = var_91_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_12 = 0.2

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_12 and not isNil(var_91_11) then
				if arg_88_1.var_.characterEffect4014_tpose and not isNil(var_91_11) then
					arg_88_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_12 and arg_88_1.time_ < 0 + var_91_12 + arg_91_0 and not isNil(var_91_11) and arg_88_1.var_.characterEffect4014_tpose then
				arg_88_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_91_14 = 0
			local var_91_15 = 0.85

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_14 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_16 = arg_88_1:GetWordFromCfg(109051022)
				local var_91_17 = arg_88_1:FormatText(var_91_16.content)

				arg_88_1.text_.text = var_91_17

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_19 = 34 <= 0 and var_91_15 or var_91_15 * (utf8.len(var_91_17) / 34)

				if (34 <= 0 and var_91_15 or var_91_15 * (utf8.len(var_91_17) / 34)) > 0 and var_91_15 < var_91_19 then
					arg_88_1.talkMaxDuration = var_91_19

					if var_91_19 + var_91_14 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_19 + var_91_14
					end
				end

				arg_88_1.text_.text = var_91_17
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051022", "story_v_out_109051.awb") ~= 0 then
					local var_91_20 = manager.audio:GetVoiceLength("story_v_out_109051", "109051022", "story_v_out_109051.awb") / 1000

					if var_91_20 + var_91_14 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_20 + var_91_14
					end

					if var_91_16.prefab_name ~= "" and arg_88_1.actors_[var_91_16.prefab_name] ~= nil then
						local var_91_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_16.prefab_name].transform, "story_v_out_109051", "109051022", "story_v_out_109051.awb")

						arg_88_1:RecordAudio("109051022", var_91_21)
						arg_88_1:RecordAudio("109051022", var_91_21)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_109051", "109051022", "story_v_out_109051.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_109051", "109051022", "story_v_out_109051.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_22 = math.max(var_91_15, arg_88_1.talkMaxDuration)

			if var_91_14 <= arg_88_1.time_ and arg_88_1.time_ < var_91_14 + var_91_22 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_14) / var_91_22

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_14 + var_91_22 and arg_88_1.time_ < var_91_14 + var_91_22 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play109051023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 109051023
		arg_92_1.duration_ = 8.97

		local var_92_0 = {
			ja = 8.966,
			ko = 5.8,
			zh = 4.566,
			en = 4.866
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
				arg_92_0:Play109051024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["4014_tpose"]) and arg_92_1.var_.characterEffect4014_tpose == nil then
				arg_92_1.var_.characterEffect4014_tpose = arg_92_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.2

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["4014_tpose"]) then
				if arg_92_1.var_.characterEffect4014_tpose and not isNil(arg_92_1.actors_["4014_tpose"]) then
					arg_92_1.var_.characterEffect4014_tpose.fillFlat = true
					arg_92_1.var_.characterEffect4014_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["4014_tpose"]) and arg_92_1.var_.characterEffect4014_tpose then
				arg_92_1.var_.characterEffect4014_tpose.fillFlat = true
				arg_92_1.var_.characterEffect4014_tpose.fillRatio = 0.5
			end

			local var_95_1 = 0
			local var_95_2 = 0.525

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:GetWordFromCfg(109051023)
				local var_95_4 = arg_92_1:FormatText(var_95_3.content)

				arg_92_1.text_.text = var_95_4

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_6 = 21 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_4) / 21)

				if (21 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_4) / 21)) > 0 and var_95_2 < var_95_6 then
					arg_92_1.talkMaxDuration = var_95_6

					if var_95_6 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_4
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051023", "story_v_out_109051.awb") ~= 0 then
					local var_95_7 = manager.audio:GetVoiceLength("story_v_out_109051", "109051023", "story_v_out_109051.awb") / 1000

					if var_95_7 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_1
					end

					if var_95_3.prefab_name ~= "" and arg_92_1.actors_[var_95_3.prefab_name] ~= nil then
						local var_95_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_3.prefab_name].transform, "story_v_out_109051", "109051023", "story_v_out_109051.awb")

						arg_92_1:RecordAudio("109051023", var_95_8)
						arg_92_1:RecordAudio("109051023", var_95_8)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_109051", "109051023", "story_v_out_109051.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_109051", "109051023", "story_v_out_109051.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_9 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_9 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_9

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_9 and arg_92_1.time_ < var_95_1 + var_95_9 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play109051024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 109051024
		arg_96_1.duration_ = 17.53

		local var_96_0 = {
			ja = 13.633,
			ko = 11.666,
			zh = 10.266,
			en = 17.533
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
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play109051025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["4014_tpose"]) and arg_96_1.var_.characterEffect4014_tpose == nil then
				arg_96_1.var_.characterEffect4014_tpose = arg_96_1.actors_["4014_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.2

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["4014_tpose"]) then
				if arg_96_1.var_.characterEffect4014_tpose and not isNil(arg_96_1.actors_["4014_tpose"]) then
					arg_96_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["4014_tpose"]) and arg_96_1.var_.characterEffect4014_tpose then
				arg_96_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			local var_99_2 = 0
			local var_99_3 = 0.8

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_2 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_4 = arg_96_1:GetWordFromCfg(109051024)
				local var_99_5 = arg_96_1:FormatText(var_99_4.content)

				arg_96_1.text_.text = var_99_5

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_7 = 32 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 32)

				if (32 <= 0 and var_99_3 or var_99_3 * (utf8.len(var_99_5) / 32)) > 0 and var_99_3 < var_99_7 then
					arg_96_1.talkMaxDuration = var_99_7

					if var_99_7 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_7 + var_99_2
					end
				end

				arg_96_1.text_.text = var_99_5
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051024", "story_v_out_109051.awb") ~= 0 then
					local var_99_8 = manager.audio:GetVoiceLength("story_v_out_109051", "109051024", "story_v_out_109051.awb") / 1000

					if var_99_8 + var_99_2 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_8 + var_99_2
					end

					if var_99_4.prefab_name ~= "" and arg_96_1.actors_[var_99_4.prefab_name] ~= nil then
						local var_99_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_4.prefab_name].transform, "story_v_out_109051", "109051024", "story_v_out_109051.awb")

						arg_96_1:RecordAudio("109051024", var_99_9)
						arg_96_1:RecordAudio("109051024", var_99_9)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_109051", "109051024", "story_v_out_109051.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_109051", "109051024", "story_v_out_109051.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_10 = math.max(var_99_3, arg_96_1.talkMaxDuration)

			if var_99_2 <= arg_96_1.time_ and arg_96_1.time_ < var_99_2 + var_99_10 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_2) / var_99_10

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_2 + var_99_10 and arg_96_1.time_ < var_99_2 + var_99_10 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play109051025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 109051025
		arg_100_1.duration_ = 19.1

		local var_100_0 = {
			ja = 19.1,
			ko = 6.9,
			zh = 9.866,
			en = 14.7
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play109051026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos4014_tpose = arg_100_1.actors_["4014_tpose"].transform.localPosition

				local var_103_0 = GameObjectTools.GetOrAddComponent(arg_100_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_103_0 then
					var_103_0:EnableDynamicBone(false)
				end
			end

			local var_103_1 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_1 then
				arg_100_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_100_1.time_ - 0) / var_103_1)
				arg_100_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["4014_tpose"].transform.position).z)
				arg_100_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["4014_tpose"].transform.localEulerAngles = arg_100_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_1 and arg_100_1.time_ < 0 + var_103_1 + arg_103_0 then
				arg_100_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_100_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_100_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_100_1.actors_["4014_tpose"].transform.position).z)
				arg_100_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_100_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_100_1.actors_["4014_tpose"].transform.localEulerAngles = arg_100_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_103_2 = GameObjectTools.GetOrAddComponent(arg_100_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_103_2 then
					var_103_2:EnableDynamicBone(true)
				end
			end

			local var_103_3 = arg_100_1.actors_["3007_tpose"].transform

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.var_.moveOldPos3007_tpose = var_103_3.localPosition

				local var_103_4 = GameObjectTools.GetOrAddComponent(var_103_3.gameObject, typeof(DynamicBoneHelper))

				if var_103_4 then
					var_103_4:EnableDynamicBone(false)
				end
			end

			local var_103_5 = 0.001

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_5 then
				var_103_3.localPosition = Vector3.Lerp(arg_100_1.var_.moveOldPos3007_tpose, Vector3.New(0, -2.25, -1.9), (arg_100_1.time_ - 0) / var_103_5)
				var_103_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_3.position).x, (manager.ui.mainCamera.transform.position - var_103_3.position).y, (manager.ui.mainCamera.transform.position - var_103_3.position).z)
				var_103_3.localEulerAngles.z = 0
				var_103_3.localEulerAngles.x = 0
				var_103_3.localEulerAngles = var_103_3.localEulerAngles
			end

			if arg_100_1.time_ >= 0 + var_103_5 and arg_100_1.time_ < 0 + var_103_5 + arg_103_0 then
				var_103_3.localPosition = Vector3.New(0, -2.25, -1.9)
				var_103_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_103_3.position).x, (manager.ui.mainCamera.transform.position - var_103_3.position).y, (manager.ui.mainCamera.transform.position - var_103_3.position).z)
				var_103_3.localEulerAngles.z = 0
				var_103_3.localEulerAngles.x = 0
				var_103_3.localEulerAngles = var_103_3.localEulerAngles

				local var_103_6 = GameObjectTools.GetOrAddComponent(var_103_3.gameObject, typeof(DynamicBoneHelper))

				if var_103_6 then
					var_103_6:EnableDynamicBone(true)
				end
			end

			local var_103_7 = arg_100_1.actors_["3007_tpose"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_7) and arg_100_1.var_.characterEffect3007_tpose == nil then
				arg_100_1.var_.characterEffect3007_tpose = var_103_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_8 = 0.2

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_8 and not isNil(var_103_7) then
				if arg_100_1.var_.characterEffect3007_tpose and not isNil(var_103_7) then
					arg_100_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_8 and arg_100_1.time_ < 0 + var_103_8 + arg_103_0 and not isNil(var_103_7) and arg_100_1.var_.characterEffect3007_tpose then
				arg_100_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_103_10 = 0
			local var_103_11 = 0.575

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_10 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[158].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_12 = arg_100_1:GetWordFromCfg(109051025)
				local var_103_13 = arg_100_1:FormatText(var_103_12.content)

				arg_100_1.text_.text = var_103_13

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_15 = 23 <= 0 and var_103_11 or var_103_11 * (utf8.len(var_103_13) / 23)

				if (23 <= 0 and var_103_11 or var_103_11 * (utf8.len(var_103_13) / 23)) > 0 and var_103_11 < var_103_15 then
					arg_100_1.talkMaxDuration = var_103_15

					if var_103_15 + var_103_10 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_15 + var_103_10
					end
				end

				arg_100_1.text_.text = var_103_13
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051025", "story_v_out_109051.awb") ~= 0 then
					local var_103_16 = manager.audio:GetVoiceLength("story_v_out_109051", "109051025", "story_v_out_109051.awb") / 1000

					if var_103_16 + var_103_10 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_16 + var_103_10
					end

					if var_103_12.prefab_name ~= "" and arg_100_1.actors_[var_103_12.prefab_name] ~= nil then
						local var_103_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_12.prefab_name].transform, "story_v_out_109051", "109051025", "story_v_out_109051.awb")

						arg_100_1:RecordAudio("109051025", var_103_17)
						arg_100_1:RecordAudio("109051025", var_103_17)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_109051", "109051025", "story_v_out_109051.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_109051", "109051025", "story_v_out_109051.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_18 = math.max(var_103_11, arg_100_1.talkMaxDuration)

			if var_103_10 <= arg_100_1.time_ and arg_100_1.time_ < var_103_10 + var_103_18 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_10) / var_103_18

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_10 + var_103_18 and arg_100_1.time_ < var_103_10 + var_103_18 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {
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

		arg_100_1:InitPlayNodeList()
	end,
	Play109051026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 109051026
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play109051027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["3007_tpose"]) and arg_104_1.var_.characterEffect3007_tpose == nil then
				arg_104_1.var_.characterEffect3007_tpose = arg_104_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.2

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["3007_tpose"]) then
				if arg_104_1.var_.characterEffect3007_tpose and not isNil(arg_104_1.actors_["3007_tpose"]) then
					arg_104_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_104_1.var_.characterEffect3007_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_0)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["3007_tpose"]) and arg_104_1.var_.characterEffect3007_tpose then
				arg_104_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_104_1.var_.characterEffect3007_tpose.fillRatio = 0.5
			end

			local var_107_1 = arg_104_1.actors_["3007_tpose"].transform

			if 0.566666666666667 < arg_104_1.time_ and arg_104_1.time_ <= 0.566666666666667 + arg_107_0 then
				arg_104_1.var_.shakeOldPos3007_tpose = var_107_1.localPosition
			end

			local var_107_2 = 0.2

			if 0.566666666666667 <= arg_104_1.time_ and arg_104_1.time_ < 0.566666666666667 + var_107_2 then
				local var_107_3, var_107_4 = math.modf((arg_104_1.time_ - 0.566666666666667) / 0.066)

				var_107_1.localPosition = Vector3.New(var_107_4 * 0.15, var_107_4 * 0.15, var_107_4 * 0) + arg_104_1.var_.shakeOldPos3007_tpose
			end

			if arg_104_1.time_ >= 0.566666666666667 + var_107_2 and arg_104_1.time_ < 0.566666666666667 + var_107_2 + arg_107_0 then
				var_107_1.localPosition = arg_104_1.var_.shakeOldPos3007_tpose
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:AudioAction("play", "effect", "se_story_9", "se_story_9_smash02", "")
			end

			local var_107_6 = 0
			local var_107_7 = 1.1

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_6 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, false)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_8 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(109051026).content)

				arg_104_1.text_.text = var_107_8

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_10 = 44 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_8) / 44)

				if (44 <= 0 and var_107_7 or var_107_7 * (utf8.len(var_107_8) / 44)) > 0 and var_107_7 < var_107_10 then
					arg_104_1.talkMaxDuration = var_107_10

					if var_107_10 + var_107_6 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_6
					end
				end

				arg_104_1.text_.text = var_107_8
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_11 = math.max(var_107_7, arg_104_1.talkMaxDuration)

			if var_107_6 <= arg_104_1.time_ and arg_104_1.time_ < var_107_6 + var_107_11 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_6) / var_107_11

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_6 + var_107_11 and arg_104_1.time_ < var_107_6 + var_107_11 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play109051027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 109051027
		arg_108_1.duration_ = 6.8

		local var_108_0 = {
			ja = 6.8,
			ko = 4.166,
			zh = 3.3,
			en = 6.5
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play109051028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos3007_tpose = arg_108_1.actors_["3007_tpose"].transform.localPosition

				local var_111_0 = GameObjectTools.GetOrAddComponent(arg_108_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_111_0 then
					var_111_0:EnableDynamicBone(false)
				end
			end

			local var_111_1 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_1 then
				arg_108_1.actors_["3007_tpose"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos3007_tpose, Vector3.New(0, 100, 0), (arg_108_1.time_ - 0) / var_111_1)
				arg_108_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["3007_tpose"].transform.position).z)
				arg_108_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["3007_tpose"].transform.localEulerAngles = arg_108_1.actors_["3007_tpose"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_1 and arg_108_1.time_ < 0 + var_111_1 + arg_111_0 then
				arg_108_1.actors_["3007_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_108_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["3007_tpose"].transform.position).z)
				arg_108_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["3007_tpose"].transform.localEulerAngles = arg_108_1.actors_["3007_tpose"].transform.localEulerAngles

				local var_111_2 = GameObjectTools.GetOrAddComponent(arg_108_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_111_2 then
					var_111_2:EnableDynamicBone(true)
				end
			end

			local var_111_3 = arg_108_1.actors_["4014_tpose"].transform

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos4014_tpose = var_111_3.localPosition

				local var_111_4 = GameObjectTools.GetOrAddComponent(var_111_3.gameObject, typeof(DynamicBoneHelper))

				if var_111_4 then
					var_111_4:EnableDynamicBone(false)
				end
			end

			local var_111_5 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_5 then
				var_111_3.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos4014_tpose, Vector3.New(0, -1.95, -4.2), (arg_108_1.time_ - 0) / var_111_5)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_5 and arg_108_1.time_ < 0 + var_111_5 + arg_111_0 then
				var_111_3.localPosition = Vector3.New(0, -1.95, -4.2)
				var_111_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_111_3.position).x, (manager.ui.mainCamera.transform.position - var_111_3.position).y, (manager.ui.mainCamera.transform.position - var_111_3.position).z)
				var_111_3.localEulerAngles.z = 0
				var_111_3.localEulerAngles.x = 0
				var_111_3.localEulerAngles = var_111_3.localEulerAngles

				local var_111_6 = GameObjectTools.GetOrAddComponent(var_111_3.gameObject, typeof(DynamicBoneHelper))

				if var_111_6 then
					var_111_6:EnableDynamicBone(true)
				end
			end

			local var_111_7 = arg_108_1.actors_["4014_tpose"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_7) and arg_108_1.var_.characterEffect4014_tpose == nil then
				arg_108_1.var_.characterEffect4014_tpose = var_111_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_8 = 0.2

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_8 and not isNil(var_111_7) then
				if arg_108_1.var_.characterEffect4014_tpose and not isNil(var_111_7) then
					arg_108_1.var_.characterEffect4014_tpose.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_8 and arg_108_1.time_ < 0 + var_111_8 + arg_111_0 and not isNil(var_111_7) and arg_108_1.var_.characterEffect4014_tpose then
				arg_108_1.var_.characterEffect4014_tpose.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("4014_tpose", "StoryTimeline/CharAction/story4014/story4014action/4014action1_1")
			end

			local var_111_10 = 0
			local var_111_11 = 0.325

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_10 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_12 = arg_108_1:GetWordFromCfg(109051027)
				local var_111_13 = arg_108_1:FormatText(var_111_12.content)

				arg_108_1.text_.text = var_111_13

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_15 = 13 <= 0 and var_111_11 or var_111_11 * (utf8.len(var_111_13) / 13)

				if (13 <= 0 and var_111_11 or var_111_11 * (utf8.len(var_111_13) / 13)) > 0 and var_111_11 < var_111_15 then
					arg_108_1.talkMaxDuration = var_111_15

					if var_111_15 + var_111_10 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_15 + var_111_10
					end
				end

				arg_108_1.text_.text = var_111_13
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051027", "story_v_out_109051.awb") ~= 0 then
					local var_111_16 = manager.audio:GetVoiceLength("story_v_out_109051", "109051027", "story_v_out_109051.awb") / 1000

					if var_111_16 + var_111_10 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_16 + var_111_10
					end

					if var_111_12.prefab_name ~= "" and arg_108_1.actors_[var_111_12.prefab_name] ~= nil then
						local var_111_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_12.prefab_name].transform, "story_v_out_109051", "109051027", "story_v_out_109051.awb")

						arg_108_1:RecordAudio("109051027", var_111_17)
						arg_108_1:RecordAudio("109051027", var_111_17)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_109051", "109051027", "story_v_out_109051.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_109051", "109051027", "story_v_out_109051.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_18 = math.max(var_111_11, arg_108_1.talkMaxDuration)

			if var_111_10 <= arg_108_1.time_ and arg_108_1.time_ < var_111_10 + var_111_18 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_10) / var_111_18

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_10 + var_111_18 and arg_108_1.time_ < var_111_10 + var_111_18 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play109051028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 109051028
		arg_112_1.duration_ = 8

		local var_112_0 = {
			ja = 6,
			ko = 8,
			zh = 6.766,
			en = 7.266
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play109051029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.625

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:GetWordFromCfg(109051028)
				local var_115_2 = arg_112_1:FormatText(var_115_1.content)

				arg_112_1.text_.text = var_115_2

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_4 = 25 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 25)

				if (25 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_2) / 25)) > 0 and var_115_0 < var_115_4 then
					arg_112_1.talkMaxDuration = var_115_4

					if var_115_4 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_4 + 0
					end
				end

				arg_112_1.text_.text = var_115_2
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051028", "story_v_out_109051.awb") ~= 0 then
					local var_115_5 = manager.audio:GetVoiceLength("story_v_out_109051", "109051028", "story_v_out_109051.awb") / 1000

					if var_115_5 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_5 + 0
					end

					if var_115_1.prefab_name ~= "" and arg_112_1.actors_[var_115_1.prefab_name] ~= nil then
						local var_115_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_1.prefab_name].transform, "story_v_out_109051", "109051028", "story_v_out_109051.awb")

						arg_112_1:RecordAudio("109051028", var_115_6)
						arg_112_1:RecordAudio("109051028", var_115_6)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_109051", "109051028", "story_v_out_109051.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_109051", "109051028", "story_v_out_109051.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_7 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_7

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play109051029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 109051029
		arg_116_1.duration_ = 15.1

		local var_116_0 = {
			ja = 11.433,
			ko = 14.533,
			zh = 13.433,
			en = 15.1
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play109051030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 1.4

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[87].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:GetWordFromCfg(109051029)
				local var_119_2 = arg_116_1:FormatText(var_119_1.content)

				arg_116_1.text_.text = var_119_2

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_4 = 56 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 56)

				if (56 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_2) / 56)) > 0 and var_119_0 < var_119_4 then
					arg_116_1.talkMaxDuration = var_119_4

					if var_119_4 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_4 + 0
					end
				end

				arg_116_1.text_.text = var_119_2
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051029", "story_v_out_109051.awb") ~= 0 then
					local var_119_5 = manager.audio:GetVoiceLength("story_v_out_109051", "109051029", "story_v_out_109051.awb") / 1000

					if var_119_5 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_5 + 0
					end

					if var_119_1.prefab_name ~= "" and arg_116_1.actors_[var_119_1.prefab_name] ~= nil then
						local var_119_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_1.prefab_name].transform, "story_v_out_109051", "109051029", "story_v_out_109051.awb")

						arg_116_1:RecordAudio("109051029", var_119_6)
						arg_116_1:RecordAudio("109051029", var_119_6)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_109051", "109051029", "story_v_out_109051.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_109051", "109051029", "story_v_out_109051.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_7 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_7

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play109051030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 109051030
		arg_120_1.duration_ = 3.07

		local var_120_0 = {
			ja = 2.3,
			ko = 3.066,
			zh = 2.166,
			en = 2.5
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play109051031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos4014_tpose = arg_120_1.actors_["4014_tpose"].transform.localPosition

				local var_123_0 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_0 then
					var_123_0:EnableDynamicBone(false)
				end
			end

			local var_123_1 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_1 then
				arg_120_1.actors_["4014_tpose"].transform.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos4014_tpose, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_1)
				arg_120_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["4014_tpose"].transform.position).z)
				arg_120_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["4014_tpose"].transform.localEulerAngles = arg_120_1.actors_["4014_tpose"].transform.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_1 and arg_120_1.time_ < 0 + var_123_1 + arg_123_0 then
				arg_120_1.actors_["4014_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.actors_["4014_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_120_1.actors_["4014_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["4014_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_120_1.actors_["4014_tpose"].transform.position).z)
				arg_120_1.actors_["4014_tpose"].transform.localEulerAngles.z = 0
				arg_120_1.actors_["4014_tpose"].transform.localEulerAngles.x = 0
				arg_120_1.actors_["4014_tpose"].transform.localEulerAngles = arg_120_1.actors_["4014_tpose"].transform.localEulerAngles

				local var_123_2 = GameObjectTools.GetOrAddComponent(arg_120_1.actors_["4014_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(true)
				end
			end

			local var_123_3 = 0
			local var_123_4 = 0.275

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_3 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_5 = arg_120_1:GetWordFromCfg(109051030)
				local var_123_6 = arg_120_1:FormatText(var_123_5.content)

				arg_120_1.text_.text = var_123_6

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_8 = 11 <= 0 and var_123_4 or var_123_4 * (utf8.len(var_123_6) / 11)

				if (11 <= 0 and var_123_4 or var_123_4 * (utf8.len(var_123_6) / 11)) > 0 and var_123_4 < var_123_8 then
					arg_120_1.talkMaxDuration = var_123_8

					if var_123_8 + var_123_3 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_3
					end
				end

				arg_120_1.text_.text = var_123_6
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051030", "story_v_out_109051.awb") ~= 0 then
					local var_123_9 = manager.audio:GetVoiceLength("story_v_out_109051", "109051030", "story_v_out_109051.awb") / 1000

					if var_123_9 + var_123_3 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_9 + var_123_3
					end

					if var_123_5.prefab_name ~= "" and arg_120_1.actors_[var_123_5.prefab_name] ~= nil then
						local var_123_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_5.prefab_name].transform, "story_v_out_109051", "109051030", "story_v_out_109051.awb")

						arg_120_1:RecordAudio("109051030", var_123_10)
						arg_120_1:RecordAudio("109051030", var_123_10)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_109051", "109051030", "story_v_out_109051.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_109051", "109051030", "story_v_out_109051.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_11 = math.max(var_123_4, arg_120_1.talkMaxDuration)

			if var_123_3 <= arg_120_1.time_ and arg_120_1.time_ < var_123_3 + var_123_11 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_3) / var_123_11

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_3 + var_123_11 and arg_120_1.time_ < var_123_3 + var_123_11 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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

		arg_120_1:InitPlayNodeList()
	end,
	Play109051031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 109051031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play109051032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:AudioAction("play", "effect", "se_story_9", "se_story_9_long_knife", "")
			end

			local var_127_1 = 0
			local var_127_2 = 1.025

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_1 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_3 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(109051031).content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 41 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 41)

				if (41 <= 0 and var_127_2 or var_127_2 * (utf8.len(var_127_3) / 41)) > 0 and var_127_2 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_1 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_1
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_6 = math.max(var_127_2, arg_124_1.talkMaxDuration)

			if var_127_1 <= arg_124_1.time_ and arg_124_1.time_ < var_127_1 + var_127_6 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_1) / var_127_6

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_1 + var_127_6 and arg_124_1.time_ < var_127_1 + var_127_6 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play109051032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 109051032
		arg_128_1.duration_ = 7.7

		local var_128_0 = {
			ja = 5.933,
			ko = 7.466,
			zh = 7.7,
			en = 6.333
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
				arg_128_0:Play109051033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos3004_tpose = arg_128_1.actors_["3004_tpose"].transform.localPosition

				local var_131_0 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_0 then
					var_131_0:EnableDynamicBone(false)
				end
			end

			local var_131_1 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_1 then
				arg_128_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_128_1.time_ - 0) / var_131_1)
				arg_128_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["3004_tpose"].transform.position).z)
				arg_128_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["3004_tpose"].transform.localEulerAngles = arg_128_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_1 and arg_128_1.time_ < 0 + var_131_1 + arg_131_0 then
				arg_128_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, -2.22, -3.1)
				arg_128_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["3004_tpose"].transform.position).z)
				arg_128_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["3004_tpose"].transform.localEulerAngles = arg_128_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_131_2 = GameObjectTools.GetOrAddComponent(arg_128_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(true)
				end
			end

			local var_131_3 = arg_128_1.actors_["3004_tpose"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect3004_tpose == nil then
				arg_128_1.var_.characterEffect3004_tpose = var_131_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.2

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 and not isNil(var_131_3) then
				if arg_128_1.var_.characterEffect3004_tpose and not isNil(var_131_3) then
					arg_128_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect3004_tpose then
				arg_128_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_131_6 = 0
			local var_131_7 = 0.625

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_6 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_8 = arg_128_1:GetWordFromCfg(109051032)
				local var_131_9 = arg_128_1:FormatText(var_131_8.content)

				arg_128_1.text_.text = var_131_9

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_11 = 25 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 25)

				if (25 <= 0 and var_131_7 or var_131_7 * (utf8.len(var_131_9) / 25)) > 0 and var_131_7 < var_131_11 then
					arg_128_1.talkMaxDuration = var_131_11

					if var_131_11 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_11 + var_131_6
					end
				end

				arg_128_1.text_.text = var_131_9
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051032", "story_v_out_109051.awb") ~= 0 then
					local var_131_12 = manager.audio:GetVoiceLength("story_v_out_109051", "109051032", "story_v_out_109051.awb") / 1000

					if var_131_12 + var_131_6 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_12 + var_131_6
					end

					if var_131_8.prefab_name ~= "" and arg_128_1.actors_[var_131_8.prefab_name] ~= nil then
						local var_131_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_8.prefab_name].transform, "story_v_out_109051", "109051032", "story_v_out_109051.awb")

						arg_128_1:RecordAudio("109051032", var_131_13)
						arg_128_1:RecordAudio("109051032", var_131_13)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_109051", "109051032", "story_v_out_109051.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_109051", "109051032", "story_v_out_109051.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_14 = math.max(var_131_7, arg_128_1.talkMaxDuration)

			if var_131_6 <= arg_128_1.time_ and arg_128_1.time_ < var_131_6 + var_131_14 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_6) / var_131_14

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_6 + var_131_14 and arg_128_1.time_ < var_131_6 + var_131_14 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	Play109051033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 109051033
		arg_132_1.duration_ = 8.73

		local var_132_0 = {
			ja = 8.733,
			ko = 8.2,
			zh = 8,
			en = 5.633
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
				arg_132_0:Play109051034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.725

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:GetWordFromCfg(109051033)
				local var_135_2 = arg_132_1:FormatText(var_135_1.content)

				arg_132_1.text_.text = var_135_2

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_4 = 29 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 29)

				if (29 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_2) / 29)) > 0 and var_135_0 < var_135_4 then
					arg_132_1.talkMaxDuration = var_135_4

					if var_135_4 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_4 + 0
					end
				end

				arg_132_1.text_.text = var_135_2
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051033", "story_v_out_109051.awb") ~= 0 then
					local var_135_5 = manager.audio:GetVoiceLength("story_v_out_109051", "109051033", "story_v_out_109051.awb") / 1000

					if var_135_5 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_5 + 0
					end

					if var_135_1.prefab_name ~= "" and arg_132_1.actors_[var_135_1.prefab_name] ~= nil then
						local var_135_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_1.prefab_name].transform, "story_v_out_109051", "109051033", "story_v_out_109051.awb")

						arg_132_1:RecordAudio("109051033", var_135_6)
						arg_132_1:RecordAudio("109051033", var_135_6)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_109051", "109051033", "story_v_out_109051.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_109051", "109051033", "story_v_out_109051.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_7 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_7 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_7

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_7 and arg_132_1.time_ < 0 + var_135_7 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play109051034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 109051034
		arg_136_1.duration_ = 23.1

		local var_136_0 = {
			ja = 23.1,
			ko = 6.1,
			zh = 10.466,
			en = 14.3
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
				arg_136_0:Play109051035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos3004_tpose = arg_136_1.actors_["3004_tpose"].transform.localPosition

				local var_139_0 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_0 then
					var_139_0:EnableDynamicBone(false)
				end
			end

			local var_139_1 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_1 then
				arg_136_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_136_1.time_ - 0) / var_139_1)
				arg_136_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["3004_tpose"].transform.position).z)
				arg_136_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["3004_tpose"].transform.localEulerAngles = arg_136_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_1 and arg_136_1.time_ < 0 + var_139_1 + arg_139_0 then
				arg_136_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_136_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["3004_tpose"].transform.position).z)
				arg_136_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["3004_tpose"].transform.localEulerAngles = arg_136_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_139_2 = GameObjectTools.GetOrAddComponent(arg_136_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_139_2 then
					var_139_2:EnableDynamicBone(true)
				end
			end

			local var_139_3 = arg_136_1.actors_["3007_tpose"].transform

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos3007_tpose = var_139_3.localPosition

				local var_139_4 = GameObjectTools.GetOrAddComponent(var_139_3.gameObject, typeof(DynamicBoneHelper))

				if var_139_4 then
					var_139_4:EnableDynamicBone(false)
				end
			end

			local var_139_5 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_5 then
				var_139_3.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos3007_tpose, Vector3.New(0, -2.25, -1.9), (arg_136_1.time_ - 0) / var_139_5)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_5 and arg_136_1.time_ < 0 + var_139_5 + arg_139_0 then
				var_139_3.localPosition = Vector3.New(0, -2.25, -1.9)
				var_139_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_139_3.position).x, (manager.ui.mainCamera.transform.position - var_139_3.position).y, (manager.ui.mainCamera.transform.position - var_139_3.position).z)
				var_139_3.localEulerAngles.z = 0
				var_139_3.localEulerAngles.x = 0
				var_139_3.localEulerAngles = var_139_3.localEulerAngles

				local var_139_6 = GameObjectTools.GetOrAddComponent(var_139_3.gameObject, typeof(DynamicBoneHelper))

				if var_139_6 then
					var_139_6:EnableDynamicBone(true)
				end
			end

			local var_139_7 = arg_136_1.actors_["3007_tpose"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_7) and arg_136_1.var_.characterEffect3007_tpose == nil then
				arg_136_1.var_.characterEffect3007_tpose = var_139_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_8 = 0.2

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_8 and not isNil(var_139_7) then
				if arg_136_1.var_.characterEffect3007_tpose and not isNil(var_139_7) then
					arg_136_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_8 and arg_136_1.time_ < 0 + var_139_8 + arg_139_0 and not isNil(var_139_7) and arg_136_1.var_.characterEffect3007_tpose then
				arg_136_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_139_10 = 0
			local var_139_11 = 0.625

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_10 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[158].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_12 = arg_136_1:GetWordFromCfg(109051034)
				local var_139_13 = arg_136_1:FormatText(var_139_12.content)

				arg_136_1.text_.text = var_139_13

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_15 = 25 <= 0 and var_139_11 or var_139_11 * (utf8.len(var_139_13) / 25)

				if (25 <= 0 and var_139_11 or var_139_11 * (utf8.len(var_139_13) / 25)) > 0 and var_139_11 < var_139_15 then
					arg_136_1.talkMaxDuration = var_139_15

					if var_139_15 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_15 + var_139_10
					end
				end

				arg_136_1.text_.text = var_139_13
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051034", "story_v_out_109051.awb") ~= 0 then
					local var_139_16 = manager.audio:GetVoiceLength("story_v_out_109051", "109051034", "story_v_out_109051.awb") / 1000

					if var_139_16 + var_139_10 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_16 + var_139_10
					end

					if var_139_12.prefab_name ~= "" and arg_136_1.actors_[var_139_12.prefab_name] ~= nil then
						local var_139_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_12.prefab_name].transform, "story_v_out_109051", "109051034", "story_v_out_109051.awb")

						arg_136_1:RecordAudio("109051034", var_139_17)
						arg_136_1:RecordAudio("109051034", var_139_17)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_109051", "109051034", "story_v_out_109051.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_109051", "109051034", "story_v_out_109051.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_18 = math.max(var_139_11, arg_136_1.talkMaxDuration)

			if var_139_10 <= arg_136_1.time_ and arg_136_1.time_ < var_139_10 + var_139_18 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_10) / var_139_18

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_10 + var_139_18 and arg_136_1.time_ < var_139_10 + var_139_18 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {
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
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play109051035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 109051035
		arg_140_1.duration_ = 4.7

		local var_140_0 = {
			ja = 4.5,
			ko = 3.333,
			zh = 3.966,
			en = 4.7
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
				arg_140_0:Play109051036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["3007_tpose"]) and arg_140_1.var_.characterEffect3007_tpose == nil then
				arg_140_1.var_.characterEffect3007_tpose = arg_140_1.actors_["3007_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.2

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["3007_tpose"]) then
				if arg_140_1.var_.characterEffect3007_tpose and not isNil(arg_140_1.actors_["3007_tpose"]) then
					arg_140_1.var_.characterEffect3007_tpose.fillFlat = true
					arg_140_1.var_.characterEffect3007_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["3007_tpose"]) and arg_140_1.var_.characterEffect3007_tpose then
				arg_140_1.var_.characterEffect3007_tpose.fillFlat = true
				arg_140_1.var_.characterEffect3007_tpose.fillRatio = 0.5
			end

			local var_143_1 = 0
			local var_143_2 = 0.3

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[99].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_3 = arg_140_1:GetWordFromCfg(109051035)
				local var_143_4 = arg_140_1:FormatText(var_143_3.content)

				arg_140_1.text_.text = var_143_4

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_6 = 12 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_4) / 12)

				if (12 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_4) / 12)) > 0 and var_143_2 < var_143_6 then
					arg_140_1.talkMaxDuration = var_143_6

					if var_143_6 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_6 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_4
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051035", "story_v_out_109051.awb") ~= 0 then
					local var_143_7 = manager.audio:GetVoiceLength("story_v_out_109051", "109051035", "story_v_out_109051.awb") / 1000

					if var_143_7 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_1
					end

					if var_143_3.prefab_name ~= "" and arg_140_1.actors_[var_143_3.prefab_name] ~= nil then
						local var_143_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_3.prefab_name].transform, "story_v_out_109051", "109051035", "story_v_out_109051.awb")

						arg_140_1:RecordAudio("109051035", var_143_8)
						arg_140_1:RecordAudio("109051035", var_143_8)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_109051", "109051035", "story_v_out_109051.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_109051", "109051035", "story_v_out_109051.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_9 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_9 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_9

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_9 and arg_140_1.time_ < var_143_1 + var_143_9 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play109051036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 109051036
		arg_144_1.duration_ = 8.63

		local var_144_0 = {
			ja = 7.8,
			ko = 7,
			zh = 7.6,
			en = 8.633
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
				arg_144_0:Play109051037(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos3007_tpose = arg_144_1.actors_["3007_tpose"].transform.localPosition

				local var_147_0 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_0 then
					var_147_0:EnableDynamicBone(false)
				end
			end

			local var_147_1 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_1 then
				arg_144_1.actors_["3007_tpose"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos3007_tpose, Vector3.New(0, 100, 0), (arg_144_1.time_ - 0) / var_147_1)
				arg_144_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["3007_tpose"].transform.position).z)
				arg_144_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["3007_tpose"].transform.localEulerAngles = arg_144_1.actors_["3007_tpose"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_1 and arg_144_1.time_ < 0 + var_147_1 + arg_147_0 then
				arg_144_1.actors_["3007_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_144_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["3007_tpose"].transform.position).z)
				arg_144_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["3007_tpose"].transform.localEulerAngles = arg_144_1.actors_["3007_tpose"].transform.localEulerAngles

				local var_147_2 = GameObjectTools.GetOrAddComponent(arg_144_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_147_2 then
					var_147_2:EnableDynamicBone(true)
				end
			end

			local var_147_3 = arg_144_1.actors_["3004_tpose"].transform

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos3004_tpose = var_147_3.localPosition

				local var_147_4 = GameObjectTools.GetOrAddComponent(var_147_3.gameObject, typeof(DynamicBoneHelper))

				if var_147_4 then
					var_147_4:EnableDynamicBone(false)
				end
			end

			local var_147_5 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_5 then
				var_147_3.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_144_1.time_ - 0) / var_147_5)
				var_147_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_3.position).x, (manager.ui.mainCamera.transform.position - var_147_3.position).y, (manager.ui.mainCamera.transform.position - var_147_3.position).z)
				var_147_3.localEulerAngles.z = 0
				var_147_3.localEulerAngles.x = 0
				var_147_3.localEulerAngles = var_147_3.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_5 and arg_144_1.time_ < 0 + var_147_5 + arg_147_0 then
				var_147_3.localPosition = Vector3.New(0, -2.22, -3.1)
				var_147_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_147_3.position).x, (manager.ui.mainCamera.transform.position - var_147_3.position).y, (manager.ui.mainCamera.transform.position - var_147_3.position).z)
				var_147_3.localEulerAngles.z = 0
				var_147_3.localEulerAngles.x = 0
				var_147_3.localEulerAngles = var_147_3.localEulerAngles

				local var_147_6 = GameObjectTools.GetOrAddComponent(var_147_3.gameObject, typeof(DynamicBoneHelper))

				if var_147_6 then
					var_147_6:EnableDynamicBone(true)
				end
			end

			local var_147_7 = arg_144_1.actors_["3004_tpose"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_7) and arg_144_1.var_.characterEffect3004_tpose == nil then
				arg_144_1.var_.characterEffect3004_tpose = var_147_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_8 = 0.2

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_8 and not isNil(var_147_7) then
				if arg_144_1.var_.characterEffect3004_tpose and not isNil(var_147_7) then
					arg_144_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_8 and arg_144_1.time_ < 0 + var_147_8 + arg_147_0 and not isNil(var_147_7) and arg_144_1.var_.characterEffect3004_tpose then
				arg_144_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_147_10 = 0
			local var_147_11 = 0.65

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_10 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_12 = arg_144_1:GetWordFromCfg(109051036)
				local var_147_13 = arg_144_1:FormatText(var_147_12.content)

				arg_144_1.text_.text = var_147_13

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_15 = 26 <= 0 and var_147_11 or var_147_11 * (utf8.len(var_147_13) / 26)

				if (26 <= 0 and var_147_11 or var_147_11 * (utf8.len(var_147_13) / 26)) > 0 and var_147_11 < var_147_15 then
					arg_144_1.talkMaxDuration = var_147_15

					if var_147_15 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_15 + var_147_10
					end
				end

				arg_144_1.text_.text = var_147_13
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051036", "story_v_out_109051.awb") ~= 0 then
					local var_147_16 = manager.audio:GetVoiceLength("story_v_out_109051", "109051036", "story_v_out_109051.awb") / 1000

					if var_147_16 + var_147_10 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_16 + var_147_10
					end

					if var_147_12.prefab_name ~= "" and arg_144_1.actors_[var_147_12.prefab_name] ~= nil then
						local var_147_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_12.prefab_name].transform, "story_v_out_109051", "109051036", "story_v_out_109051.awb")

						arg_144_1:RecordAudio("109051036", var_147_17)
						arg_144_1:RecordAudio("109051036", var_147_17)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_109051", "109051036", "story_v_out_109051.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_109051", "109051036", "story_v_out_109051.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_18 = math.max(var_147_11, arg_144_1.talkMaxDuration)

			if var_147_10 <= arg_144_1.time_ and arg_144_1.time_ < var_147_10 + var_147_18 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_10) / var_147_18

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_10 + var_147_18 and arg_144_1.time_ < var_147_10 + var_147_18 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
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
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play109051037 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 109051037
		arg_148_1.duration_ = 9.9

		local var_148_0 = {
			ja = 5.866,
			ko = 4.166,
			zh = 6.9,
			en = 9.9
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
				arg_148_0:Play109051038(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos3004_tpose = arg_148_1.actors_["3004_tpose"].transform.localPosition

				local var_151_0 = GameObjectTools.GetOrAddComponent(arg_148_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_151_0 then
					var_151_0:EnableDynamicBone(false)
				end
			end

			local var_151_1 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_1 then
				arg_148_1.actors_["3004_tpose"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos3004_tpose, Vector3.New(0, 100, 0), (arg_148_1.time_ - 0) / var_151_1)
				arg_148_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["3004_tpose"].transform.position).z)
				arg_148_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["3004_tpose"].transform.localEulerAngles = arg_148_1.actors_["3004_tpose"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_1 and arg_148_1.time_ < 0 + var_151_1 + arg_151_0 then
				arg_148_1.actors_["3004_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_148_1.actors_["3004_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["3004_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["3004_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["3004_tpose"].transform.position).z)
				arg_148_1.actors_["3004_tpose"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["3004_tpose"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["3004_tpose"].transform.localEulerAngles = arg_148_1.actors_["3004_tpose"].transform.localEulerAngles

				local var_151_2 = GameObjectTools.GetOrAddComponent(arg_148_1.actors_["3004_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_151_2 then
					var_151_2:EnableDynamicBone(true)
				end
			end

			local var_151_3 = arg_148_1.actors_["3007_tpose"].transform

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos3007_tpose = var_151_3.localPosition

				local var_151_4 = GameObjectTools.GetOrAddComponent(var_151_3.gameObject, typeof(DynamicBoneHelper))

				if var_151_4 then
					var_151_4:EnableDynamicBone(false)
				end
			end

			local var_151_5 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_5 then
				var_151_3.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos3007_tpose, Vector3.New(0, -2.25, -1.9), (arg_148_1.time_ - 0) / var_151_5)
				var_151_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_3.position).x, (manager.ui.mainCamera.transform.position - var_151_3.position).y, (manager.ui.mainCamera.transform.position - var_151_3.position).z)
				var_151_3.localEulerAngles.z = 0
				var_151_3.localEulerAngles.x = 0
				var_151_3.localEulerAngles = var_151_3.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_5 and arg_148_1.time_ < 0 + var_151_5 + arg_151_0 then
				var_151_3.localPosition = Vector3.New(0, -2.25, -1.9)
				var_151_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_151_3.position).x, (manager.ui.mainCamera.transform.position - var_151_3.position).y, (manager.ui.mainCamera.transform.position - var_151_3.position).z)
				var_151_3.localEulerAngles.z = 0
				var_151_3.localEulerAngles.x = 0
				var_151_3.localEulerAngles = var_151_3.localEulerAngles

				local var_151_6 = GameObjectTools.GetOrAddComponent(var_151_3.gameObject, typeof(DynamicBoneHelper))

				if var_151_6 then
					var_151_6:EnableDynamicBone(true)
				end
			end

			local var_151_7 = arg_148_1.actors_["3007_tpose"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_7) and arg_148_1.var_.characterEffect3007_tpose == nil then
				arg_148_1.var_.characterEffect3007_tpose = var_151_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_8 = 0.2

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_8 and not isNil(var_151_7) then
				if arg_148_1.var_.characterEffect3007_tpose and not isNil(var_151_7) then
					arg_148_1.var_.characterEffect3007_tpose.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_8 and arg_148_1.time_ < 0 + var_151_8 + arg_151_0 and not isNil(var_151_7) and arg_148_1.var_.characterEffect3007_tpose then
				arg_148_1.var_.characterEffect3007_tpose.fillFlat = false
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("3007_tpose", "StoryTimeline/CharAction/story3007/story3007action/3007action1_1")
			end

			local var_151_10 = 0
			local var_151_11 = 0.375

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_10 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[158].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_12 = arg_148_1:GetWordFromCfg(109051037)
				local var_151_13 = arg_148_1:FormatText(var_151_12.content)

				arg_148_1.text_.text = var_151_13

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_15 = 15 <= 0 and var_151_11 or var_151_11 * (utf8.len(var_151_13) / 15)

				if (15 <= 0 and var_151_11 or var_151_11 * (utf8.len(var_151_13) / 15)) > 0 and var_151_11 < var_151_15 then
					arg_148_1.talkMaxDuration = var_151_15

					if var_151_15 + var_151_10 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_15 + var_151_10
					end
				end

				arg_148_1.text_.text = var_151_13
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051037", "story_v_out_109051.awb") ~= 0 then
					local var_151_16 = manager.audio:GetVoiceLength("story_v_out_109051", "109051037", "story_v_out_109051.awb") / 1000

					if var_151_16 + var_151_10 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_16 + var_151_10
					end

					if var_151_12.prefab_name ~= "" and arg_148_1.actors_[var_151_12.prefab_name] ~= nil then
						local var_151_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_12.prefab_name].transform, "story_v_out_109051", "109051037", "story_v_out_109051.awb")

						arg_148_1:RecordAudio("109051037", var_151_17)
						arg_148_1:RecordAudio("109051037", var_151_17)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_109051", "109051037", "story_v_out_109051.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_109051", "109051037", "story_v_out_109051.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_18 = math.max(var_151_11, arg_148_1.talkMaxDuration)

			if var_151_10 <= arg_148_1.time_ and arg_148_1.time_ < var_151_10 + var_151_18 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_10) / var_151_18

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_10 + var_151_18 and arg_148_1.time_ < var_151_10 + var_151_18 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
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
				actorName = "3007_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play109051038 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 109051038
		arg_152_1.duration_ = 7.33

		local var_152_0 = {
			ja = 7.1,
			ko = 3.666,
			zh = 5.4,
			en = 7.333
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
				arg_152_0:Play109051039(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos3007_tpose = arg_152_1.actors_["3007_tpose"].transform.localPosition

				local var_155_0 = GameObjectTools.GetOrAddComponent(arg_152_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_155_0 then
					var_155_0:EnableDynamicBone(false)
				end
			end

			local var_155_1 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_1 then
				arg_152_1.actors_["3007_tpose"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos3007_tpose, Vector3.New(0, 100, 0), (arg_152_1.time_ - 0) / var_155_1)
				arg_152_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["3007_tpose"].transform.position).z)
				arg_152_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["3007_tpose"].transform.localEulerAngles = arg_152_1.actors_["3007_tpose"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_1 and arg_152_1.time_ < 0 + var_155_1 + arg_155_0 then
				arg_152_1.actors_["3007_tpose"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_152_1.actors_["3007_tpose"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["3007_tpose"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["3007_tpose"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["3007_tpose"].transform.position).z)
				arg_152_1.actors_["3007_tpose"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["3007_tpose"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["3007_tpose"].transform.localEulerAngles = arg_152_1.actors_["3007_tpose"].transform.localEulerAngles

				local var_155_2 = GameObjectTools.GetOrAddComponent(arg_152_1.actors_["3007_tpose"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_155_2 then
					var_155_2:EnableDynamicBone(true)
				end
			end

			local var_155_3 = arg_152_1.actors_["3004_tpose"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos3004_tpose = var_155_3.localPosition

				local var_155_4 = GameObjectTools.GetOrAddComponent(var_155_3.gameObject, typeof(DynamicBoneHelper))

				if var_155_4 then
					var_155_4:EnableDynamicBone(false)
				end
			end

			local var_155_5 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_5 then
				var_155_3.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos3004_tpose, Vector3.New(0, -2.22, -3.1), (arg_152_1.time_ - 0) / var_155_5)
				var_155_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_3.position).x, (manager.ui.mainCamera.transform.position - var_155_3.position).y, (manager.ui.mainCamera.transform.position - var_155_3.position).z)
				var_155_3.localEulerAngles.z = 0
				var_155_3.localEulerAngles.x = 0
				var_155_3.localEulerAngles = var_155_3.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_5 and arg_152_1.time_ < 0 + var_155_5 + arg_155_0 then
				var_155_3.localPosition = Vector3.New(0, -2.22, -3.1)
				var_155_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_3.position).x, (manager.ui.mainCamera.transform.position - var_155_3.position).y, (manager.ui.mainCamera.transform.position - var_155_3.position).z)
				var_155_3.localEulerAngles.z = 0
				var_155_3.localEulerAngles.x = 0
				var_155_3.localEulerAngles = var_155_3.localEulerAngles

				local var_155_6 = GameObjectTools.GetOrAddComponent(var_155_3.gameObject, typeof(DynamicBoneHelper))

				if var_155_6 then
					var_155_6:EnableDynamicBone(true)
				end
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("3004_tpose", "StoryTimeline/CharAction/story3004/story3004action/3004action1_1")
			end

			local var_155_7 = arg_152_1.actors_["3004_tpose"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_7) and arg_152_1.var_.characterEffect3004_tpose == nil then
				arg_152_1.var_.characterEffect3004_tpose = var_155_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_8 = 0.2

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_8 and not isNil(var_155_7) then
				if arg_152_1.var_.characterEffect3004_tpose and not isNil(var_155_7) then
					arg_152_1.var_.characterEffect3004_tpose.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_8 and arg_152_1.time_ < 0 + var_155_8 + arg_155_0 and not isNil(var_155_7) and arg_152_1.var_.characterEffect3004_tpose then
				arg_152_1.var_.characterEffect3004_tpose.fillFlat = false
			end

			local var_155_10 = 0
			local var_155_11 = 0.475

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_10 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_12 = arg_152_1:GetWordFromCfg(109051038)
				local var_155_13 = arg_152_1:FormatText(var_155_12.content)

				arg_152_1.text_.text = var_155_13

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_15 = 19 <= 0 and var_155_11 or var_155_11 * (utf8.len(var_155_13) / 19)

				if (19 <= 0 and var_155_11 or var_155_11 * (utf8.len(var_155_13) / 19)) > 0 and var_155_11 < var_155_15 then
					arg_152_1.talkMaxDuration = var_155_15

					if var_155_15 + var_155_10 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_15 + var_155_10
					end
				end

				arg_152_1.text_.text = var_155_13
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051038", "story_v_out_109051.awb") ~= 0 then
					local var_155_16 = manager.audio:GetVoiceLength("story_v_out_109051", "109051038", "story_v_out_109051.awb") / 1000

					if var_155_16 + var_155_10 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_16 + var_155_10
					end

					if var_155_12.prefab_name ~= "" and arg_152_1.actors_[var_155_12.prefab_name] ~= nil then
						local var_155_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_12.prefab_name].transform, "story_v_out_109051", "109051038", "story_v_out_109051.awb")

						arg_152_1:RecordAudio("109051038", var_155_17)
						arg_152_1:RecordAudio("109051038", var_155_17)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_109051", "109051038", "story_v_out_109051.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_109051", "109051038", "story_v_out_109051.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_18 = math.max(var_155_11, arg_152_1.talkMaxDuration)

			if var_155_10 <= arg_152_1.time_ and arg_152_1.time_ < var_155_10 + var_155_18 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_10) / var_155_18

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_10 + var_155_18 and arg_152_1.time_ < var_155_10 + var_155_18 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
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
				actorName = "3004_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play109051039 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 109051039
		arg_156_1.duration_ = 9.43

		local var_156_0 = {
			ja = 9.433,
			ko = 9.1,
			zh = 9.266,
			en = 8.233
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
				arg_156_0:Play109051040(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			local var_159_0 = 0.8

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_1 = arg_156_1:GetWordFromCfg(109051039)
				local var_159_2 = arg_156_1:FormatText(var_159_1.content)

				arg_156_1.text_.text = var_159_2

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_4 = 32 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 32)

				if (32 <= 0 and var_159_0 or var_159_0 * (utf8.len(var_159_2) / 32)) > 0 and var_159_0 < var_159_4 then
					arg_156_1.talkMaxDuration = var_159_4

					if var_159_4 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_4 + 0
					end
				end

				arg_156_1.text_.text = var_159_2
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051039", "story_v_out_109051.awb") ~= 0 then
					local var_159_5 = manager.audio:GetVoiceLength("story_v_out_109051", "109051039", "story_v_out_109051.awb") / 1000

					if var_159_5 + 0 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + 0
					end

					if var_159_1.prefab_name ~= "" and arg_156_1.actors_[var_159_1.prefab_name] ~= nil then
						local var_159_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_1.prefab_name].transform, "story_v_out_109051", "109051039", "story_v_out_109051.awb")

						arg_156_1:RecordAudio("109051039", var_159_6)
						arg_156_1:RecordAudio("109051039", var_159_6)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_109051", "109051039", "story_v_out_109051.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_109051", "109051039", "story_v_out_109051.awb")
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
	Play109051040 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 109051040
		arg_160_1.duration_ = 8.67

		local var_160_0 = {
			ja = 7.2,
			ko = 7.6,
			zh = 8.666,
			en = 7.3
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
			arg_160_1.auto_ = false
		end

		function arg_160_1.playNext_(arg_162_0)
			arg_160_1.onStoryFinished_()
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			local var_163_0 = 0.625

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, true)

				arg_160_1.leftNameTxt_.text = arg_160_1:FormatText(StoryNameCfg[82].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_160_1.leftNameTxt_.transform)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1.leftNameTxt_.text)
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_1 = arg_160_1:GetWordFromCfg(109051040)
				local var_163_2 = arg_160_1:FormatText(var_163_1.content)

				arg_160_1.text_.text = var_163_2

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_4 = 25 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 25)

				if (25 <= 0 and var_163_0 or var_163_0 * (utf8.len(var_163_2) / 25)) > 0 and var_163_0 < var_163_4 then
					arg_160_1.talkMaxDuration = var_163_4

					if var_163_4 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_4 + 0
					end
				end

				arg_160_1.text_.text = var_163_2
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_109051", "109051040", "story_v_out_109051.awb") ~= 0 then
					local var_163_5 = manager.audio:GetVoiceLength("story_v_out_109051", "109051040", "story_v_out_109051.awb") / 1000

					if var_163_5 + 0 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_5 + 0
					end

					if var_163_1.prefab_name ~= "" and arg_160_1.actors_[var_163_1.prefab_name] ~= nil then
						local var_163_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_160_1.actors_[var_163_1.prefab_name].transform, "story_v_out_109051", "109051040", "story_v_out_109051.awb")

						arg_160_1:RecordAudio("109051040", var_163_6)
						arg_160_1:RecordAudio("109051040", var_163_6)
					else
						arg_160_1:AudioAction("play", "voice", "story_v_out_109051", "109051040", "story_v_out_109051.awb")
					end

					arg_160_1:RecordHistoryTalkVoice("story_v_out_109051", "109051040", "story_v_out_109051.awb")
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
	assets = {
		"TextureConfig/Background/C04a"
	},
	voices = {
		"story_v_out_109051.awb"
	}
}
