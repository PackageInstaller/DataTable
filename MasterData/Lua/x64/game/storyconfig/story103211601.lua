return {
	Play321161001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 321161001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play321161002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.L08g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L08g")
				var_4_0.name = "L08g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.L08g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.L08g

				arg_1_1.bgs_.L08g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "L08g" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_0_story_shashvat_sewer", "bgm_activity_4_0_story_shashvat_sewer")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_drain", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_16 = 2
			local var_4_17 = 0.125

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_18 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_18:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_19 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(321161001).content)

				arg_1_1.text_.text = var_4_19

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_21 = 5 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 5)

				if (5 <= 0 and var_4_17 or var_4_17 * (utf8.len(var_4_19) / 5)) > 0 and var_4_17 < var_4_21 then
					arg_1_1.talkMaxDuration = var_4_21
					var_4_16 = var_4_16 + 0.3

					if var_4_21 + var_4_16 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_21 + var_4_16
					end
				end

				arg_1_1.text_.text = var_4_19
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_22 = var_4_16 + 0.3
			local var_4_23 = math.max(var_4_17, arg_1_1.talkMaxDuration)

			if var_4_16 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_22 + var_4_23 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_22) / var_4_23

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_22 + var_4_23 and arg_1_1.time_ < var_4_22 + var_4_23 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play321161002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 321161002
		arg_9_1.duration_ = 3.57

		local var_9_0 = {
			zh = 2.4,
			ja = 3.566
		}
		local var_9_1 = manager.audio:GetLocalizationFlag()

		if var_9_0[var_9_1] ~= nil then
			arg_9_1.duration_ = var_9_0[var_9_1]
		end

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play321161003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10104ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10104ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10104ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10104ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10104ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10104ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10104ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10104ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10104ui_story == nil then
				arg_9_1.var_.characterEffect10104ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10104ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10104ui_story then
				arg_9_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_12_8 = 0
			local var_12_9 = 0.225

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(321161002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 9 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 9)

				if (9 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 9)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161002", "story_v_out_321161.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_321161", "321161002", "story_v_out_321161.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_321161", "321161002", "story_v_out_321161.awb")

						arg_9_1:RecordAudio("321161002", var_12_15)
						arg_9_1:RecordAudio("321161002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_321161", "321161002", "story_v_out_321161.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_321161", "321161002", "story_v_out_321161.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play321161003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 321161003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play321161004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10104ui_story = arg_13_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_16_0 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 then
				arg_13_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_13_1.time_ - 0) / var_16_0)
				arg_13_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10104ui_story"].transform.position).z)
				arg_13_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10104ui_story"].transform.localEulerAngles = arg_13_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 then
				arg_13_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_13_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_13_1.actors_["10104ui_story"].transform.position).z)
				arg_13_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_13_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_13_1.actors_["10104ui_story"].transform.localEulerAngles = arg_13_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_16_1 = arg_13_1.actors_["10104ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10104ui_story == nil then
				arg_13_1.var_.characterEffect10104ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect10104ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_2)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10104ui_story then
				arg_13_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_16_3 = 0
			local var_16_4 = 1.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_3 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_5 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(321161003).content)

				arg_13_1.text_.text = var_16_5

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_7 = 52 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 52)

				if (52 <= 0 and var_16_4 or var_16_4 * (utf8.len(var_16_5) / 52)) > 0 and var_16_4 < var_16_7 then
					arg_13_1.talkMaxDuration = var_16_7

					if var_16_7 + var_16_3 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_7 + var_16_3
					end
				end

				arg_13_1.text_.text = var_16_5
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_4, arg_13_1.talkMaxDuration)

			if var_16_3 <= arg_13_1.time_ and arg_13_1.time_ < var_16_3 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_3) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_3 + var_16_8 and arg_13_1.time_ < var_16_3 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_13_1:InitPlayNodeList()
	end,
	Play321161004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 321161004
		arg_17_1.duration_ = 7.23

		local var_17_0 = {
			zh = 4.9,
			ja = 7.233
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play321161005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10104ui_story = arg_17_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10104ui_story"].transform.position).z)
				arg_17_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10104ui_story"].transform.localEulerAngles = arg_17_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_17_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10104ui_story"].transform.position).z)
				arg_17_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10104ui_story"].transform.localEulerAngles = arg_17_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["10104ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10104ui_story == nil then
				arg_17_1.var_.characterEffect10104ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect10104ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect10104ui_story then
				arg_17_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_20_4 = 0
			local var_20_5 = 0.675

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(321161004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 27 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 27)

				if (27 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 27)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161004", "story_v_out_321161.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161004", "story_v_out_321161.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_321161", "321161004", "story_v_out_321161.awb")

						arg_17_1:RecordAudio("321161004", var_20_11)
						arg_17_1:RecordAudio("321161004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_321161", "321161004", "story_v_out_321161.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_321161", "321161004", "story_v_out_321161.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play321161005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 321161005
		arg_21_1.duration_ = 6.5

		local var_21_0 = {
			zh = 6.5,
			ja = 6.366
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play321161006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			local var_24_0 = 0.875

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_1 = arg_21_1:GetWordFromCfg(321161005)
				local var_24_2 = arg_21_1:FormatText(var_24_1.content)

				arg_21_1.text_.text = var_24_2

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_4 = 35 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 35)

				if (35 <= 0 and var_24_0 or var_24_0 * (utf8.len(var_24_2) / 35)) > 0 and var_24_0 < var_24_4 then
					arg_21_1.talkMaxDuration = var_24_4

					if var_24_4 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_4 + 0
					end
				end

				arg_21_1.text_.text = var_24_2
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161005", "story_v_out_321161.awb") ~= 0 then
					local var_24_5 = manager.audio:GetVoiceLength("story_v_out_321161", "321161005", "story_v_out_321161.awb") / 1000

					if var_24_5 + 0 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_5 + 0
					end

					if var_24_1.prefab_name ~= "" and arg_21_1.actors_[var_24_1.prefab_name] ~= nil then
						local var_24_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_1.prefab_name].transform, "story_v_out_321161", "321161005", "story_v_out_321161.awb")

						arg_21_1:RecordAudio("321161005", var_24_6)
						arg_21_1:RecordAudio("321161005", var_24_6)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_321161", "321161005", "story_v_out_321161.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_321161", "321161005", "story_v_out_321161.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_0, arg_21_1.talkMaxDuration)

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - 0) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= 0 + var_24_7 and arg_21_1.time_ < 0 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play321161006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 321161006
		arg_25_1.duration_ = 9.47

		local var_25_0 = {
			zh = 5.8,
			ja = 9.466
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play321161007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10104ui_story = arg_25_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).z)
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles = arg_25_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_25_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10104ui_story"].transform.position).z)
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10104ui_story"].transform.localEulerAngles = arg_25_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			local var_28_1 = 0
			local var_28_2 = 0.675

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_3 = arg_25_1:GetWordFromCfg(321161006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 27 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 27)

				if (27 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 27)) > 0 and var_28_2 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161006", "story_v_out_321161.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_321161", "321161006", "story_v_out_321161.awb") / 1000

					if var_28_7 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_1
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_321161", "321161006", "story_v_out_321161.awb")

						arg_25_1:RecordAudio("321161006", var_28_8)
						arg_25_1:RecordAudio("321161006", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_321161", "321161006", "story_v_out_321161.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_321161", "321161006", "story_v_out_321161.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_9 and arg_25_1.time_ < var_28_1 + var_28_9 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_25_1:InitPlayNodeList()
	end,
	Play321161007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 321161007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play321161008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["10104ui_story"]) and arg_29_1.var_.characterEffect10104ui_story == nil then
				arg_29_1.var_.characterEffect10104ui_story = arg_29_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["10104ui_story"]) then
				if arg_29_1.var_.characterEffect10104ui_story and not isNil(arg_29_1.actors_["10104ui_story"]) then
					arg_29_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["10104ui_story"]) and arg_29_1.var_.characterEffect10104ui_story then
				arg_29_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_32_1 = 0
			local var_32_2 = 0.975

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_1 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_3 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(321161007).content)

				arg_29_1.text_.text = var_32_3

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_5 = 39 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 39)

				if (39 <= 0 and var_32_2 or var_32_2 * (utf8.len(var_32_3) / 39)) > 0 and var_32_2 < var_32_5 then
					arg_29_1.talkMaxDuration = var_32_5

					if var_32_5 + var_32_1 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + var_32_1
					end
				end

				arg_29_1.text_.text = var_32_3
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_6 = math.max(var_32_2, arg_29_1.talkMaxDuration)

			if var_32_1 <= arg_29_1.time_ and arg_29_1.time_ < var_32_1 + var_32_6 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_1) / var_32_6

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_1 + var_32_6 and arg_29_1.time_ < var_32_1 + var_32_6 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play321161008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 321161008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play321161009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 0.1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(321161008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 4 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 4)

				if (4 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 4)) > 0 and var_36_0 < var_36_3 then
					arg_33_1.talkMaxDuration = var_36_3

					if var_36_3 + 0 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_3 + 0
					end
				end

				arg_33_1.text_.text = var_36_1
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_4 = math.max(var_36_0, arg_33_1.talkMaxDuration)

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - 0) / var_36_4

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play321161009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 321161009
		arg_37_1.duration_ = 4.34

		local var_37_0 = {
			zh = 2.675,
			ja = 4.341
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play321161010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10104ui_story = arg_37_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10104ui_story"].transform.position).z)
				arg_37_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10104ui_story"].transform.localEulerAngles = arg_37_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_37_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10104ui_story"].transform.position).z)
				arg_37_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10104ui_story"].transform.localEulerAngles = arg_37_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10104ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10104ui_story == nil then
				arg_37_1.var_.characterEffect10104ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10104ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10104ui_story then
				arg_37_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action5_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_4 = 0.775
			local var_40_5 = 0.225

			if 0.775 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_6 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_6:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(321161009)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 9 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_8) / 9)

				if (9 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_8) / 9)) > 0 and var_40_5 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10
					var_40_4 = var_40_4 + 0.3

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161009", "story_v_out_321161.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_321161", "321161009", "story_v_out_321161.awb") / 1000

					if var_40_11 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_4
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_321161", "321161009", "story_v_out_321161.awb")

						arg_37_1:RecordAudio("321161009", var_40_12)
						arg_37_1:RecordAudio("321161009", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_321161", "321161009", "story_v_out_321161.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_321161", "321161009", "story_v_out_321161.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_13 = var_40_4 + 0.3
			local var_40_14 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_13 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_13) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_13 + var_40_14 and arg_37_1.time_ < var_40_13 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play321161010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 321161010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play321161011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["10104ui_story"]) and arg_43_1.var_.characterEffect10104ui_story == nil then
				arg_43_1.var_.characterEffect10104ui_story = arg_43_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["10104ui_story"]) then
				if arg_43_1.var_.characterEffect10104ui_story and not isNil(arg_43_1.actors_["10104ui_story"]) then
					arg_43_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_43_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["10104ui_story"]) and arg_43_1.var_.characterEffect10104ui_story then
				arg_43_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_43_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_46_1 = 0
			local var_46_2 = 0.325

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_1 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, true)
				arg_43_1.iconController_:SetSelectedState("hero")

				arg_43_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_43_1.callingController_:SetSelectedState("normal")

				arg_43_1.keyicon_.color = Color.New(1, 1, 1)
				arg_43_1.icon_.color = Color.New(1, 1, 1)

				local var_46_3 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(321161010).content)

				arg_43_1.text_.text = var_46_3

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_5 = 13 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 13)

				if (13 <= 0 and var_46_2 or var_46_2 * (utf8.len(var_46_3) / 13)) > 0 and var_46_2 < var_46_5 then
					arg_43_1.talkMaxDuration = var_46_5

					if var_46_5 + var_46_1 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_5 + var_46_1
					end
				end

				arg_43_1.text_.text = var_46_3
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_6 = math.max(var_46_2, arg_43_1.talkMaxDuration)

			if var_46_1 <= arg_43_1.time_ and arg_43_1.time_ < var_46_1 + var_46_6 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_1) / var_46_6

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_1 + var_46_6 and arg_43_1.time_ < var_46_1 + var_46_6 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play321161011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 321161011
		arg_47_1.duration_ = 14.4

		local var_47_0 = {
			zh = 10.633,
			ja = 14.4
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play321161012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos10104ui_story = arg_47_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_50_0 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 then
				arg_47_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_47_1.time_ - 0) / var_50_0)
				arg_47_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10104ui_story"].transform.position).z)
				arg_47_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10104ui_story"].transform.localEulerAngles = arg_47_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 then
				arg_47_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_47_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_47_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_47_1.actors_["10104ui_story"].transform.position).z)
				arg_47_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_47_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_47_1.actors_["10104ui_story"].transform.localEulerAngles = arg_47_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_50_1 = arg_47_1.actors_["10104ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10104ui_story == nil then
				arg_47_1.var_.characterEffect10104ui_story = var_50_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_2 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_2 and not isNil(var_50_1) then
				if arg_47_1.var_.characterEffect10104ui_story and not isNil(var_50_1) then
					arg_47_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_2 and arg_47_1.time_ < 0 + var_50_2 + arg_50_0 and not isNil(var_50_1) and arg_47_1.var_.characterEffect10104ui_story then
				arg_47_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action5_2")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_50_4 = 0
			local var_50_5 = 1.125

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(321161011)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 45 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 45)

				if (45 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 45)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161011", "story_v_out_321161.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161011", "story_v_out_321161.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_321161", "321161011", "story_v_out_321161.awb")

						arg_47_1:RecordAudio("321161011", var_50_11)
						arg_47_1:RecordAudio("321161011", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_321161", "321161011", "story_v_out_321161.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_321161", "321161011", "story_v_out_321161.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_12 and arg_47_1.time_ < var_50_4 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_47_1:InitPlayNodeList()
	end,
	Play321161012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 321161012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play321161013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10104ui_story"]) and arg_51_1.var_.characterEffect10104ui_story == nil then
				arg_51_1.var_.characterEffect10104ui_story = arg_51_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10104ui_story"]) then
				if arg_51_1.var_.characterEffect10104ui_story and not isNil(arg_51_1.actors_["10104ui_story"]) then
					arg_51_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_51_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_0)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10104ui_story"]) and arg_51_1.var_.characterEffect10104ui_story then
				arg_51_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_51_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_54_1 = 0
			local var_54_2 = 0.3

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_1 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_3 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(321161012).content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 12 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 12)

				if (12 <= 0 and var_54_2 or var_54_2 * (utf8.len(var_54_3) / 12)) > 0 and var_54_2 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_1 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_1
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_6 = math.max(var_54_2, arg_51_1.talkMaxDuration)

			if var_54_1 <= arg_51_1.time_ and arg_51_1.time_ < var_54_1 + var_54_6 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_1) / var_54_6

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_1 + var_54_6 and arg_51_1.time_ < var_54_1 + var_54_6 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play321161013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 321161013
		arg_55_1.duration_ = 2

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play321161014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10104ui_story = arg_55_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["10104ui_story"].transform.position).z)
				arg_55_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["10104ui_story"].transform.localEulerAngles = arg_55_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_55_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["10104ui_story"].transform.position).z)
				arg_55_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["10104ui_story"].transform.localEulerAngles = arg_55_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["10104ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect10104ui_story == nil then
				arg_55_1.var_.characterEffect10104ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect10104ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect10104ui_story then
				arg_55_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_58_4 = 0
			local var_58_5 = 0.125

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_6 = arg_55_1:GetWordFromCfg(321161013)
				local var_58_7 = arg_55_1:FormatText(var_58_6.content)

				arg_55_1.text_.text = var_58_7

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_9 = 5 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 5)

				if (5 <= 0 and var_58_5 or var_58_5 * (utf8.len(var_58_7) / 5)) > 0 and var_58_5 < var_58_9 then
					arg_55_1.talkMaxDuration = var_58_9

					if var_58_9 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_9 + var_58_4
					end
				end

				arg_55_1.text_.text = var_58_7
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161013", "story_v_out_321161.awb") ~= 0 then
					local var_58_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161013", "story_v_out_321161.awb") / 1000

					if var_58_10 + var_58_4 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_4
					end

					if var_58_6.prefab_name ~= "" and arg_55_1.actors_[var_58_6.prefab_name] ~= nil then
						local var_58_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_6.prefab_name].transform, "story_v_out_321161", "321161013", "story_v_out_321161.awb")

						arg_55_1:RecordAudio("321161013", var_58_11)
						arg_55_1:RecordAudio("321161013", var_58_11)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_321161", "321161013", "story_v_out_321161.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_321161", "321161013", "story_v_out_321161.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_12 = math.max(var_58_5, arg_55_1.talkMaxDuration)

			if var_58_4 <= arg_55_1.time_ and arg_55_1.time_ < var_58_4 + var_58_12 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_4) / var_58_12

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_4 + var_58_12 and arg_55_1.time_ < var_58_4 + var_58_12 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play321161014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 321161014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play321161015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["10104ui_story"]) and arg_59_1.var_.characterEffect10104ui_story == nil then
				arg_59_1.var_.characterEffect10104ui_story = arg_59_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["10104ui_story"]) then
				if arg_59_1.var_.characterEffect10104ui_story and not isNil(arg_59_1.actors_["10104ui_story"]) then
					arg_59_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["10104ui_story"]) and arg_59_1.var_.characterEffect10104ui_story then
				arg_59_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_62_1 = 0
			local var_62_2 = 0.5

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_1 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_3 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(321161014).content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_5 = 20 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 20)

				if (20 <= 0 and var_62_2 or var_62_2 * (utf8.len(var_62_3) / 20)) > 0 and var_62_2 < var_62_5 then
					arg_59_1.talkMaxDuration = var_62_5

					if var_62_5 + var_62_1 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + var_62_1
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_6 = math.max(var_62_2, arg_59_1.talkMaxDuration)

			if var_62_1 <= arg_59_1.time_ and arg_59_1.time_ < var_62_1 + var_62_6 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_1) / var_62_6

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_1 + var_62_6 and arg_59_1.time_ < var_62_1 + var_62_6 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play321161015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 321161015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play321161016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 1.375

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, false)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(321161015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 55 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 55)

				if (55 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 55)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play321161016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 321161016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play321161017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0.5

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_67_1.callingController_:SetSelectedState("normal")

				arg_67_1.keyicon_.color = Color.New(1, 1, 1)
				arg_67_1.icon_.color = Color.New(1, 1, 1)

				local var_70_1 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(321161016).content)

				arg_67_1.text_.text = var_70_1

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_3 = 20 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 20)

				if (20 <= 0 and var_70_0 or var_70_0 * (utf8.len(var_70_1) / 20)) > 0 and var_70_0 < var_70_3 then
					arg_67_1.talkMaxDuration = var_70_3

					if var_70_3 + 0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_3 + 0
					end
				end

				arg_67_1.text_.text = var_70_1
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_4 = math.max(var_70_0, arg_67_1.talkMaxDuration)

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - 0) / var_70_4

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play321161017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 321161017
		arg_71_1.duration_ = 13.17

		local var_71_0 = {
			zh = 8.533,
			ja = 13.166
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play321161018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10104ui_story = arg_71_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10104ui_story"].transform.position).z)
				arg_71_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10104ui_story"].transform.localEulerAngles = arg_71_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_71_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10104ui_story"].transform.position).z)
				arg_71_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10104ui_story"].transform.localEulerAngles = arg_71_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["10104ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10104ui_story == nil then
				arg_71_1.var_.characterEffect10104ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect10104ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10104ui_story then
				arg_71_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_74_4 = 0
			local var_74_5 = 1.05

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(321161017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 42 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 42)

				if (42 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 42)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161017", "story_v_out_321161.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161017", "story_v_out_321161.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_321161", "321161017", "story_v_out_321161.awb")

						arg_71_1:RecordAudio("321161017", var_74_11)
						arg_71_1:RecordAudio("321161017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_321161", "321161017", "story_v_out_321161.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_321161", "321161017", "story_v_out_321161.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play321161018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 321161018
		arg_75_1.duration_ = 6.77

		local var_75_0 = {
			zh = 4.066,
			ja = 6.766
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play321161019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0.6

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_1 = arg_75_1:GetWordFromCfg(321161018)
				local var_78_2 = arg_75_1:FormatText(var_78_1.content)

				arg_75_1.text_.text = var_78_2

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_4 = 24 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 24)

				if (24 <= 0 and var_78_0 or var_78_0 * (utf8.len(var_78_2) / 24)) > 0 and var_78_0 < var_78_4 then
					arg_75_1.talkMaxDuration = var_78_4

					if var_78_4 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_4 + 0
					end
				end

				arg_75_1.text_.text = var_78_2
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161018", "story_v_out_321161.awb") ~= 0 then
					local var_78_5 = manager.audio:GetVoiceLength("story_v_out_321161", "321161018", "story_v_out_321161.awb") / 1000

					if var_78_5 + 0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + 0
					end

					if var_78_1.prefab_name ~= "" and arg_75_1.actors_[var_78_1.prefab_name] ~= nil then
						local var_78_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_1.prefab_name].transform, "story_v_out_321161", "321161018", "story_v_out_321161.awb")

						arg_75_1:RecordAudio("321161018", var_78_6)
						arg_75_1:RecordAudio("321161018", var_78_6)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_321161", "321161018", "story_v_out_321161.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_321161", "321161018", "story_v_out_321161.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_7 = math.max(var_78_0, arg_75_1.talkMaxDuration)

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_7 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - 0) / var_78_7

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= 0 + var_78_7 and arg_75_1.time_ < 0 + var_78_7 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play321161019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 321161019
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play321161020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["10104ui_story"]) and arg_79_1.var_.characterEffect10104ui_story == nil then
				arg_79_1.var_.characterEffect10104ui_story = arg_79_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["10104ui_story"]) then
				if arg_79_1.var_.characterEffect10104ui_story and not isNil(arg_79_1.actors_["10104ui_story"]) then
					arg_79_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_0)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["10104ui_story"]) and arg_79_1.var_.characterEffect10104ui_story then
				arg_79_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_82_1 = 0
			local var_82_2 = 0.2

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, true)
				arg_79_1.iconController_:SetSelectedState("hero")

				arg_79_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_79_1.callingController_:SetSelectedState("normal")

				arg_79_1.keyicon_.color = Color.New(1, 1, 1)
				arg_79_1.icon_.color = Color.New(1, 1, 1)

				local var_82_3 = arg_79_1:FormatText(arg_79_1:GetWordFromCfg(321161019).content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 8 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 8)

				if (8 <= 0 and var_82_2 or var_82_2 * (utf8.len(var_82_3) / 8)) > 0 and var_82_2 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_1 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_1
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_6 = math.max(var_82_2, arg_79_1.talkMaxDuration)

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_6 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_1) / var_82_6

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_1 + var_82_6 and arg_79_1.time_ < var_82_1 + var_82_6 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play321161020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 321161020
		arg_83_1.duration_ = 10.6

		local var_83_0 = {
			zh = 6.9,
			ja = 10.6
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play321161021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["10104ui_story"]) and arg_83_1.var_.characterEffect10104ui_story == nil then
				arg_83_1.var_.characterEffect10104ui_story = arg_83_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["10104ui_story"]) then
				if arg_83_1.var_.characterEffect10104ui_story and not isNil(arg_83_1.actors_["10104ui_story"]) then
					arg_83_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["10104ui_story"]) and arg_83_1.var_.characterEffect10104ui_story then
				arg_83_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action3_2")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_86_2 = 0
			local var_86_3 = 0.825

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_2 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_4 = arg_83_1:GetWordFromCfg(321161020)
				local var_86_5 = arg_83_1:FormatText(var_86_4.content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 32 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 32)

				if (32 <= 0 and var_86_3 or var_86_3 * (utf8.len(var_86_5) / 32)) > 0 and var_86_3 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_2
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161020", "story_v_out_321161.awb") ~= 0 then
					local var_86_8 = manager.audio:GetVoiceLength("story_v_out_321161", "321161020", "story_v_out_321161.awb") / 1000

					if var_86_8 + var_86_2 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_8 + var_86_2
					end

					if var_86_4.prefab_name ~= "" and arg_83_1.actors_[var_86_4.prefab_name] ~= nil then
						local var_86_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_4.prefab_name].transform, "story_v_out_321161", "321161020", "story_v_out_321161.awb")

						arg_83_1:RecordAudio("321161020", var_86_9)
						arg_83_1:RecordAudio("321161020", var_86_9)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_321161", "321161020", "story_v_out_321161.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_321161", "321161020", "story_v_out_321161.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_10 = math.max(var_86_3, arg_83_1.talkMaxDuration)

			if var_86_2 <= arg_83_1.time_ and arg_83_1.time_ < var_86_2 + var_86_10 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_2) / var_86_10

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_2 + var_86_10 and arg_83_1.time_ < var_86_2 + var_86_10 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play321161021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 321161021
		arg_87_1.duration_ = 5

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play321161022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["10104ui_story"]) and arg_87_1.var_.characterEffect10104ui_story == nil then
				arg_87_1.var_.characterEffect10104ui_story = arg_87_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["10104ui_story"]) then
				if arg_87_1.var_.characterEffect10104ui_story and not isNil(arg_87_1.actors_["10104ui_story"]) then
					arg_87_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["10104ui_story"]) and arg_87_1.var_.characterEffect10104ui_story then
				arg_87_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_90_1 = 0
			local var_90_2 = 0.35

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_1 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, true)
				arg_87_1.iconController_:SetSelectedState("hero")

				arg_87_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_87_1.callingController_:SetSelectedState("normal")

				arg_87_1.keyicon_.color = Color.New(1, 1, 1)
				arg_87_1.icon_.color = Color.New(1, 1, 1)

				local var_90_3 = arg_87_1:FormatText(arg_87_1:GetWordFromCfg(321161021).content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 14 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 14)

				if (14 <= 0 and var_90_2 or var_90_2 * (utf8.len(var_90_3) / 14)) > 0 and var_90_2 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_1 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_1
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)
				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_6 = math.max(var_90_2, arg_87_1.talkMaxDuration)

			if var_90_1 <= arg_87_1.time_ and arg_87_1.time_ < var_90_1 + var_90_6 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_1) / var_90_6

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_1 + var_90_6 and arg_87_1.time_ < var_90_1 + var_90_6 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play321161022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 321161022
		arg_91_1.duration_ = 7.87

		local var_91_0 = {
			zh = 6.2,
			ja = 7.866
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play321161023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["10104ui_story"]) and arg_91_1.var_.characterEffect10104ui_story == nil then
				arg_91_1.var_.characterEffect10104ui_story = arg_91_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["10104ui_story"]) then
				if arg_91_1.var_.characterEffect10104ui_story and not isNil(arg_91_1.actors_["10104ui_story"]) then
					arg_91_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["10104ui_story"]) and arg_91_1.var_.characterEffect10104ui_story then
				arg_91_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_94_2 = 0
			local var_94_3 = 0.775

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_2 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_4 = arg_91_1:GetWordFromCfg(321161022)
				local var_94_5 = arg_91_1:FormatText(var_94_4.content)

				arg_91_1.text_.text = var_94_5

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_7 = 31 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 31)

				if (31 <= 0 and var_94_3 or var_94_3 * (utf8.len(var_94_5) / 31)) > 0 and var_94_3 < var_94_7 then
					arg_91_1.talkMaxDuration = var_94_7

					if var_94_7 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_7 + var_94_2
					end
				end

				arg_91_1.text_.text = var_94_5
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161022", "story_v_out_321161.awb") ~= 0 then
					local var_94_8 = manager.audio:GetVoiceLength("story_v_out_321161", "321161022", "story_v_out_321161.awb") / 1000

					if var_94_8 + var_94_2 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_8 + var_94_2
					end

					if var_94_4.prefab_name ~= "" and arg_91_1.actors_[var_94_4.prefab_name] ~= nil then
						local var_94_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_4.prefab_name].transform, "story_v_out_321161", "321161022", "story_v_out_321161.awb")

						arg_91_1:RecordAudio("321161022", var_94_9)
						arg_91_1:RecordAudio("321161022", var_94_9)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_321161", "321161022", "story_v_out_321161.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_321161", "321161022", "story_v_out_321161.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_10 = math.max(var_94_3, arg_91_1.talkMaxDuration)

			if var_94_2 <= arg_91_1.time_ and arg_91_1.time_ < var_94_2 + var_94_10 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_2) / var_94_10

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_2 + var_94_10 and arg_91_1.time_ < var_94_2 + var_94_10 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play321161023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 321161023
		arg_95_1.duration_ = 10.63

		local var_95_0 = {
			zh = 7.166,
			ja = 10.633
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play321161024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10104ui_story = arg_95_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10104ui_story"].transform.position).z)
				arg_95_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10104ui_story"].transform.localEulerAngles = arg_95_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_95_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10104ui_story"].transform.position).z)
				arg_95_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10104ui_story"].transform.localEulerAngles = arg_95_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_98_1 = 0
			local var_98_2 = 0.975

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_1 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_3 = arg_95_1:GetWordFromCfg(321161023)
				local var_98_4 = arg_95_1:FormatText(var_98_3.content)

				arg_95_1.text_.text = var_98_4

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_6 = 39 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_4) / 39)

				if (39 <= 0 and var_98_2 or var_98_2 * (utf8.len(var_98_4) / 39)) > 0 and var_98_2 < var_98_6 then
					arg_95_1.talkMaxDuration = var_98_6

					if var_98_6 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_1
					end
				end

				arg_95_1.text_.text = var_98_4
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161023", "story_v_out_321161.awb") ~= 0 then
					local var_98_7 = manager.audio:GetVoiceLength("story_v_out_321161", "321161023", "story_v_out_321161.awb") / 1000

					if var_98_7 + var_98_1 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_1
					end

					if var_98_3.prefab_name ~= "" and arg_95_1.actors_[var_98_3.prefab_name] ~= nil then
						local var_98_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_3.prefab_name].transform, "story_v_out_321161", "321161023", "story_v_out_321161.awb")

						arg_95_1:RecordAudio("321161023", var_98_8)
						arg_95_1:RecordAudio("321161023", var_98_8)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_321161", "321161023", "story_v_out_321161.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_321161", "321161023", "story_v_out_321161.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_9 = math.max(var_98_2, arg_95_1.talkMaxDuration)

			if var_98_1 <= arg_95_1.time_ and arg_95_1.time_ < var_98_1 + var_98_9 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_1) / var_98_9

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_1 + var_98_9 and arg_95_1.time_ < var_98_1 + var_98_9 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_95_1:InitPlayNodeList()
	end,
	Play321161024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 321161024
		arg_99_1.duration_ = 5.67

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play321161025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10104ui_story = arg_99_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).z)
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles = arg_99_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10104ui_story"].transform.position).z)
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10104ui_story"].transform.localEulerAngles = arg_99_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["10104ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10104ui_story == nil then
				arg_99_1.var_.characterEffect10104ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect10104ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_99_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_2)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10104ui_story then
				arg_99_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_99_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_99_1.time_ and arg_99_1.time_ <= 0.034000001847744 + arg_102_0 then
				arg_99_1:AudioAction("play", "effect", "se_story_140", "se_story_140_metaldoor", "")
			end

			local var_102_4 = manager.ui.mainCamera.transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.shakeOldPos = var_102_4.localPosition
			end

			local var_102_5 = 0.533333333333333

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_5 then
				local var_102_6, var_102_7 = math.modf((arg_99_1.time_ - 0) / 0.066)

				var_102_4.localPosition = Vector3.New(var_102_7 * 0.13, var_102_7 * 0.13, var_102_7 * 0.13) + arg_99_1.var_.shakeOldPos
			end

			if arg_99_1.time_ >= 0 + var_102_5 and arg_99_1.time_ < 0 + var_102_5 + arg_102_0 then
				var_102_4.localPosition = arg_99_1.var_.shakeOldPos
			end

			local var_102_8 = 0

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_8 + arg_102_0 then
				arg_99_1.allBtn_.enabled = false
			end

			if arg_99_1.time_ >= var_102_8 + 0.833333333333333 and arg_99_1.time_ < var_102_8 + 0.833333333333333 + arg_102_0 then
				arg_99_1.allBtn_.enabled = true
			end

			if arg_99_1.frameCnt_ <= 1 then
				arg_99_1.dialog_:SetActive(false)
			end

			local var_102_9 = 0.666666666666667
			local var_102_10 = 0.5

			if 0.666666666666667 < arg_99_1.time_ and arg_99_1.time_ <= var_102_9 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0

				arg_99_1.dialog_:SetActive(true)

				arg_99_1.dialogCg_.alpha = 0

				local var_102_11 = LeanTween.value(arg_99_1.dialog_, 0, 1, 0.3)

				var_102_11:setOnUpdate(LuaHelper.FloatAction(function(arg_103_0)
					arg_99_1.dialogCg_.alpha = arg_103_0
				end))
				var_102_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_99_1.dialog_)
					var_102_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_99_1.duration_ = arg_99_1.duration_ + 0.3

				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_12 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(321161024).content)

				arg_99_1.text_.text = var_102_12

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_14 = 20 <= 0 and var_102_10 or var_102_10 * (utf8.len(var_102_12) / 20)

				if (20 <= 0 and var_102_10 or var_102_10 * (utf8.len(var_102_12) / 20)) > 0 and var_102_10 < var_102_14 then
					arg_99_1.talkMaxDuration = var_102_14
					var_102_9 = var_102_9 + 0.3

					if var_102_14 + var_102_9 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_14 + var_102_9
					end
				end

				arg_99_1.text_.text = var_102_12
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_15 = var_102_9 + 0.3
			local var_102_16 = math.max(var_102_10, arg_99_1.talkMaxDuration)

			if var_102_9 + 0.3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_15 + var_102_16 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_15) / var_102_16

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_15 + var_102_16 and arg_99_1.time_ < var_102_15 + var_102_16 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play321161025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 321161025
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play321161026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0.034000001847744 < arg_105_1.time_ and arg_105_1.time_ <= 0.034000001847744 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_side_1033", "se_story_1033_gun", "")
			end

			if 0.534 < arg_105_1.time_ and arg_105_1.time_ <= 0.534 + arg_108_0 then
				arg_105_1:AudioAction("play", "effect", "se_story_side_1028", "se_story_side_1028_door", "")
			end

			local var_108_2 = 0
			local var_108_3 = 1.4

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_4 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(321161025).content)

				arg_105_1.text_.text = var_108_4

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_6 = 56 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_4) / 56)

				if (56 <= 0 and var_108_3 or var_108_3 * (utf8.len(var_108_4) / 56)) > 0 and var_108_3 < var_108_6 then
					arg_105_1.talkMaxDuration = var_108_6

					if var_108_6 + var_108_2 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_6 + var_108_2
					end
				end

				arg_105_1.text_.text = var_108_4
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_3, arg_105_1.talkMaxDuration)

			if var_108_2 <= arg_105_1.time_ and arg_105_1.time_ < var_108_2 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_2) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_2 + var_108_7 and arg_105_1.time_ < var_108_2 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play321161026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 321161026
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play321161027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			local var_112_0 = 0.15

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, true)
				arg_109_1.iconController_:SetSelectedState("hero")

				arg_109_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_109_1.callingController_:SetSelectedState("normal")

				arg_109_1.keyicon_.color = Color.New(1, 1, 1)
				arg_109_1.icon_.color = Color.New(1, 1, 1)

				local var_112_1 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(321161026).content)

				arg_109_1.text_.text = var_112_1

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_3 = 6 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 6)

				if (6 <= 0 and var_112_0 or var_112_0 * (utf8.len(var_112_1) / 6)) > 0 and var_112_0 < var_112_3 then
					arg_109_1.talkMaxDuration = var_112_3

					if var_112_3 + 0 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_3 + 0
					end
				end

				arg_109_1.text_.text = var_112_1
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_4 = math.max(var_112_0, arg_109_1.talkMaxDuration)

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - 0) / var_112_4

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play321161027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 321161027
		arg_113_1.duration_ = 2

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play321161028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10104ui_story = arg_113_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).z)
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles = arg_113_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_113_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10104ui_story"].transform.position).z)
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10104ui_story"].transform.localEulerAngles = arg_113_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10104ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10104ui_story == nil then
				arg_113_1.var_.characterEffect10104ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10104ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10104ui_story then
				arg_113_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action7_1")
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_116_4 = 0
			local var_116_5 = 0.125

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(321161027)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 5 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 5)

				if (5 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 5)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161027", "story_v_out_321161.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161027", "story_v_out_321161.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_321161", "321161027", "story_v_out_321161.awb")

						arg_113_1:RecordAudio("321161027", var_116_11)
						arg_113_1:RecordAudio("321161027", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_321161", "321161027", "story_v_out_321161.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_321161", "321161027", "story_v_out_321161.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play321161028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 321161028
		arg_117_1.duration_ = 5.83

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play321161029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_9000

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos10104ui_story = arg_117_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).z)
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles = arg_117_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["10104ui_story"].transform.position).z)
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["10104ui_story"].transform.localEulerAngles = arg_117_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["10104ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10104ui_story == nil then
				arg_117_1.var_.characterEffect10104ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect10104ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_2)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect10104ui_story then
				arg_117_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				local var_120_3 = arg_117_1.var_.effectbishou1

				if not arg_117_1.var_.effectbishou1 then
					var_120_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_ui_slash_01"), manager.ui.mainCamera.transform)
					var_120_3.name = "bishou1"
					arg_117_1.var_.effectbishou1 = var_120_3
				else
					var_120_3.transform:SetParent(var_120_9000)
				end

				var_120_3.transform.localPosition = Vector3.New(0, 0, 0.4)
				var_120_3.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_120_5 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_120_0, iter_120_1 in ipairs((var_120_3.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_120_1.transform.localScale = Vector3.New(iter_120_1.transform.localScale.x / var_120_5 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_120_1.transform.localScale.y / var_120_5, iter_120_1.transform.localScale.z)
				end
			end

			local var_120_7 = 0

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_7 + arg_120_0 then
				arg_117_1.allBtn_.enabled = false
			end

			if arg_117_1.time_ >= var_120_7 + 1 and arg_117_1.time_ < var_120_7 + 1 + arg_120_0 then
				arg_117_1.allBtn_.enabled = true
			end

			local var_120_8 = manager.ui.mainCamera.transform

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.shakeOldPos = var_120_8.localPosition
			end

			local var_120_9 = 1

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_9 then
				local var_120_10, var_120_11 = math.modf((arg_117_1.time_ - 0) / 0.066)

				var_120_8.localPosition = Vector3.New(var_120_11 * 0.13, var_120_11 * 0.13, var_120_11 * 0.13) + arg_117_1.var_.shakeOldPos
			end

			if arg_117_1.time_ >= 0 + var_120_9 and arg_117_1.time_ < 0 + var_120_9 + arg_120_0 then
				var_120_8.localPosition = arg_117_1.var_.shakeOldPos
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:AudioAction("play", "effect", "se_story_140", "se_story_140_sword", "")
			end

			if arg_117_1.frameCnt_ <= 1 then
				arg_117_1.dialog_:SetActive(false)
			end

			local var_120_13 = 0.833333333333333
			local var_120_14 = 0.925

			if 0.833333333333333 < arg_117_1.time_ and arg_117_1.time_ <= var_120_13 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0

				arg_117_1.dialog_:SetActive(true)

				arg_117_1.dialogCg_.alpha = 0

				local var_120_15 = LeanTween.value(arg_117_1.dialog_, 0, 1, 0.3)

				var_120_15:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_117_1.dialogCg_.alpha = arg_121_0
				end))
				var_120_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_117_1.dialog_)
					var_120_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_117_1.duration_ = arg_117_1.duration_ + 0.3

				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_16 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(321161028).content)

				arg_117_1.text_.text = var_120_16

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_18 = 37 <= 0 and var_120_14 or var_120_14 * (utf8.len(var_120_16) / 37)

				if (37 <= 0 and var_120_14 or var_120_14 * (utf8.len(var_120_16) / 37)) > 0 and var_120_14 < var_120_18 then
					arg_117_1.talkMaxDuration = var_120_18
					var_120_13 = var_120_13 + 0.3

					if var_120_18 + var_120_13 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_18 + var_120_13
					end
				end

				arg_117_1.text_.text = var_120_16
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_19 = var_120_13 + 0.3
			local var_120_20 = math.max(var_120_14, arg_117_1.talkMaxDuration)

			if var_120_13 + 0.3 <= arg_117_1.time_ and arg_117_1.time_ < var_120_19 + var_120_20 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_19) / var_120_20

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_19 + var_120_20 and arg_117_1.time_ < var_120_19 + var_120_20 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_117_1:InitPlayNodeList()
	end,
	Play321161029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 321161029
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play321161030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0.9

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_1 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(321161029).content)

				arg_123_1.text_.text = var_126_1

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_3 = 36 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 36)

				if (36 <= 0 and var_126_0 or var_126_0 * (utf8.len(var_126_1) / 36)) > 0 and var_126_0 < var_126_3 then
					arg_123_1.talkMaxDuration = var_126_3

					if var_126_3 + 0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_3 + 0
					end
				end

				arg_123_1.text_.text = var_126_1
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_4 = math.max(var_126_0, arg_123_1.talkMaxDuration)

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - 0) / var_126_4

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play321161030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 321161030
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play321161031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = 1.175

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_1 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(321161030).content)

				arg_127_1.text_.text = var_130_1

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_3 = 47 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 47)

				if (47 <= 0 and var_130_0 or var_130_0 * (utf8.len(var_130_1) / 47)) > 0 and var_130_0 < var_130_3 then
					arg_127_1.talkMaxDuration = var_130_3

					if var_130_3 + 0 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_3 + 0
					end
				end

				arg_127_1.text_.text = var_130_1
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_4 = math.max(var_130_0, arg_127_1.talkMaxDuration)

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - 0) / var_130_4

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play321161031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 321161031
		arg_131_1.duration_ = 2

		local var_131_0 = {
			zh = 1.6,
			ja = 2
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play321161032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.2

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, true)
				arg_131_1.iconController_:SetSelectedState("hero")

				arg_131_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_131_1.callingController_:SetSelectedState("normal")

				arg_131_1.keyicon_.color = Color.New(1, 1, 1)
				arg_131_1.icon_.color = Color.New(1, 1, 1)

				local var_134_1 = arg_131_1:GetWordFromCfg(321161031)
				local var_134_2 = arg_131_1:FormatText(var_134_1.content)

				arg_131_1.text_.text = var_134_2

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_4 = 8 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 8)

				if (8 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_2) / 8)) > 0 and var_134_0 < var_134_4 then
					arg_131_1.talkMaxDuration = var_134_4

					if var_134_4 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_4 + 0
					end
				end

				arg_131_1.text_.text = var_134_2
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161031", "story_v_out_321161.awb") ~= 0 then
					local var_134_5 = manager.audio:GetVoiceLength("story_v_out_321161", "321161031", "story_v_out_321161.awb") / 1000

					if var_134_5 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + 0
					end

					if var_134_1.prefab_name ~= "" and arg_131_1.actors_[var_134_1.prefab_name] ~= nil then
						local var_134_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_1.prefab_name].transform, "story_v_out_321161", "321161031", "story_v_out_321161.awb")

						arg_131_1:RecordAudio("321161031", var_134_6)
						arg_131_1:RecordAudio("321161031", var_134_6)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_321161", "321161031", "story_v_out_321161.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_321161", "321161031", "story_v_out_321161.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_7 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_7 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_7

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_7 and arg_131_1.time_ < 0 + var_134_7 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play321161032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 321161032
		arg_135_1.duration_ = 4.9

		local var_135_0 = {
			zh = 4.066,
			ja = 4.9
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play321161033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10104ui_story = arg_135_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).z)
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles = arg_135_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_135_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10104ui_story"].transform.position).z)
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10104ui_story"].transform.localEulerAngles = arg_135_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["10104ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10104ui_story == nil then
				arg_135_1.var_.characterEffect10104ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect10104ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10104ui_story then
				arg_135_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action7_2")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_138_4 = 0
			local var_138_5 = 0.575

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_4 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_6 = arg_135_1:GetWordFromCfg(321161032)
				local var_138_7 = arg_135_1:FormatText(var_138_6.content)

				arg_135_1.text_.text = var_138_7

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_9 = 23 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 23)

				if (23 <= 0 and var_138_5 or var_138_5 * (utf8.len(var_138_7) / 23)) > 0 and var_138_5 < var_138_9 then
					arg_135_1.talkMaxDuration = var_138_9

					if var_138_9 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_4
					end
				end

				arg_135_1.text_.text = var_138_7
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161032", "story_v_out_321161.awb") ~= 0 then
					local var_138_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161032", "story_v_out_321161.awb") / 1000

					if var_138_10 + var_138_4 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_10 + var_138_4
					end

					if var_138_6.prefab_name ~= "" and arg_135_1.actors_[var_138_6.prefab_name] ~= nil then
						local var_138_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_6.prefab_name].transform, "story_v_out_321161", "321161032", "story_v_out_321161.awb")

						arg_135_1:RecordAudio("321161032", var_138_11)
						arg_135_1:RecordAudio("321161032", var_138_11)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_321161", "321161032", "story_v_out_321161.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_321161", "321161032", "story_v_out_321161.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_12 = math.max(var_138_5, arg_135_1.talkMaxDuration)

			if var_138_4 <= arg_135_1.time_ and arg_135_1.time_ < var_138_4 + var_138_12 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_4) / var_138_12

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_4 + var_138_12 and arg_135_1.time_ < var_138_4 + var_138_12 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play321161033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 321161033
		arg_139_1.duration_ = 13.87

		local var_139_0 = {
			zh = 10.5,
			ja = 13.866
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play321161034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10104ui_story = arg_139_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10104ui_story"].transform.position).z)
				arg_139_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10104ui_story"].transform.localEulerAngles = arg_139_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_139_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10104ui_story"].transform.position).z)
				arg_139_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10104ui_story"].transform.localEulerAngles = arg_139_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_142_1 = 0
			local var_142_2 = 1.325

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_3 = arg_139_1:GetWordFromCfg(321161033)
				local var_142_4 = arg_139_1:FormatText(var_142_3.content)

				arg_139_1.text_.text = var_142_4

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_6 = 53 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 53)

				if (53 <= 0 and var_142_2 or var_142_2 * (utf8.len(var_142_4) / 53)) > 0 and var_142_2 < var_142_6 then
					arg_139_1.talkMaxDuration = var_142_6

					if var_142_6 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_6 + var_142_1
					end
				end

				arg_139_1.text_.text = var_142_4
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161033", "story_v_out_321161.awb") ~= 0 then
					local var_142_7 = manager.audio:GetVoiceLength("story_v_out_321161", "321161033", "story_v_out_321161.awb") / 1000

					if var_142_7 + var_142_1 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_1
					end

					if var_142_3.prefab_name ~= "" and arg_139_1.actors_[var_142_3.prefab_name] ~= nil then
						local var_142_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_3.prefab_name].transform, "story_v_out_321161", "321161033", "story_v_out_321161.awb")

						arg_139_1:RecordAudio("321161033", var_142_8)
						arg_139_1:RecordAudio("321161033", var_142_8)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_321161", "321161033", "story_v_out_321161.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_321161", "321161033", "story_v_out_321161.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_9 = math.max(var_142_2, arg_139_1.talkMaxDuration)

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_9 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_1) / var_142_9

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_1 + var_142_9 and arg_139_1.time_ < var_142_1 + var_142_9 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play321161034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 321161034
		arg_143_1.duration_ = 10.7

		local var_143_0 = {
			zh = 5.866,
			ja = 10.7
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play321161035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10104ui_story"]) and arg_143_1.var_.characterEffect10104ui_story == nil then
				arg_143_1.var_.characterEffect10104ui_story = arg_143_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10104ui_story"]) then
				if arg_143_1.var_.characterEffect10104ui_story and not isNil(arg_143_1.actors_["10104ui_story"]) then
					arg_143_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10104ui_story"]) and arg_143_1.var_.characterEffect10104ui_story then
				arg_143_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.85

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, true)
				arg_143_1.iconController_:SetSelectedState("hero")

				arg_143_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_143_1.callingController_:SetSelectedState("normal")

				arg_143_1.keyicon_.color = Color.New(1, 1, 1)
				arg_143_1.icon_.color = Color.New(1, 1, 1)

				local var_146_3 = arg_143_1:GetWordFromCfg(321161034)
				local var_146_4 = arg_143_1:FormatText(var_146_3.content)

				arg_143_1.text_.text = var_146_4

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 34 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 34)

				if (34 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_4) / 34)) > 0 and var_146_2 < var_146_6 then
					arg_143_1.talkMaxDuration = var_146_6

					if var_146_6 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_6 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_4
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161034", "story_v_out_321161.awb") ~= 0 then
					local var_146_7 = manager.audio:GetVoiceLength("story_v_out_321161", "321161034", "story_v_out_321161.awb") / 1000

					if var_146_7 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_1
					end

					if var_146_3.prefab_name ~= "" and arg_143_1.actors_[var_146_3.prefab_name] ~= nil then
						local var_146_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_3.prefab_name].transform, "story_v_out_321161", "321161034", "story_v_out_321161.awb")

						arg_143_1:RecordAudio("321161034", var_146_8)
						arg_143_1:RecordAudio("321161034", var_146_8)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_321161", "321161034", "story_v_out_321161.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_321161", "321161034", "story_v_out_321161.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_9 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_9 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_9

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_9 and arg_143_1.time_ < var_146_1 + var_146_9 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play321161035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 321161035
		arg_147_1.duration_ = 10.53

		local var_147_0 = {
			zh = 6.266,
			ja = 10.533
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play321161036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10104ui_story = arg_147_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10104ui_story"].transform.position).z)
				arg_147_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["10104ui_story"].transform.localEulerAngles = arg_147_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_147_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10104ui_story"].transform.position).z)
				arg_147_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["10104ui_story"].transform.localEulerAngles = arg_147_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["10104ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect10104ui_story == nil then
				arg_147_1.var_.characterEffect10104ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect10104ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect10104ui_story then
				arg_147_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_150_4 = 0
			local var_150_5 = 0.8

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(321161035)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 32 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 32)

				if (32 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 32)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161035", "story_v_out_321161.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161035", "story_v_out_321161.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_321161", "321161035", "story_v_out_321161.awb")

						arg_147_1:RecordAudio("321161035", var_150_11)
						arg_147_1:RecordAudio("321161035", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_321161", "321161035", "story_v_out_321161.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_321161", "321161035", "story_v_out_321161.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play321161036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 321161036
		arg_151_1.duration_ = 2

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play321161037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10104ui_story = arg_151_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10104ui_story"].transform.position).z)
				arg_151_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10104ui_story"].transform.localEulerAngles = arg_151_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_151_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10104ui_story"].transform.position).z)
				arg_151_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10104ui_story"].transform.localEulerAngles = arg_151_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_154_1 = 0
			local var_154_2 = 0.225

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:GetWordFromCfg(321161036)
				local var_154_4 = arg_151_1:FormatText(var_154_3.content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_6 = 9 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_4) / 9)

				if (9 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_4) / 9)) > 0 and var_154_2 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161036", "story_v_out_321161.awb") ~= 0 then
					local var_154_7 = manager.audio:GetVoiceLength("story_v_out_321161", "321161036", "story_v_out_321161.awb") / 1000

					if var_154_7 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_7 + var_154_1
					end

					if var_154_3.prefab_name ~= "" and arg_151_1.actors_[var_154_3.prefab_name] ~= nil then
						local var_154_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_3.prefab_name].transform, "story_v_out_321161", "321161036", "story_v_out_321161.awb")

						arg_151_1:RecordAudio("321161036", var_154_8)
						arg_151_1:RecordAudio("321161036", var_154_8)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_321161", "321161036", "story_v_out_321161.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_321161", "321161036", "story_v_out_321161.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_9 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_9 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_9

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_9 and arg_151_1.time_ < var_154_1 + var_154_9 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play321161037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 321161037
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play321161038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10104ui_story"]) and arg_155_1.var_.characterEffect10104ui_story == nil then
				arg_155_1.var_.characterEffect10104ui_story = arg_155_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_0 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10104ui_story"]) then
				if arg_155_1.var_.characterEffect10104ui_story and not isNil(arg_155_1.actors_["10104ui_story"]) then
					arg_155_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_0)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10104ui_story"]) and arg_155_1.var_.characterEffect10104ui_story then
				arg_155_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 1 < arg_155_1.time_ and arg_155_1.time_ <= 1 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk", "")
			end

			if 0.633333333333333 < arg_155_1.time_ and arg_155_1.time_ <= 0.633333333333333 + arg_158_0 then
				arg_155_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_ui", "")
			end

			local var_158_3 = 0
			local var_158_4 = 1.2

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_5 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(321161037).content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 48 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_5) / 48)

				if (48 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_5) / 48)) > 0 and var_158_4 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_3
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_4, arg_155_1.talkMaxDuration)

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_3) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_3 + var_158_8 and arg_155_1.time_ < var_158_3 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play321161038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 321161038
		arg_159_1.duration_ = 9.17

		local var_159_0 = {
			zh = 9.166,
			ja = 9
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play321161039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.15

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, true)
				arg_159_1.iconController_:SetSelectedState("hero")

				arg_159_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_159_1.callingController_:SetSelectedState("normal")

				arg_159_1.keyicon_.color = Color.New(1, 1, 1)
				arg_159_1.icon_.color = Color.New(1, 1, 1)

				local var_162_1 = arg_159_1:GetWordFromCfg(321161038)
				local var_162_2 = arg_159_1:FormatText(var_162_1.content)

				arg_159_1.text_.text = var_162_2

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_4 = 46 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 46)

				if (46 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_2) / 46)) > 0 and var_162_0 < var_162_4 then
					arg_159_1.talkMaxDuration = var_162_4

					if var_162_4 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_4 + 0
					end
				end

				arg_159_1.text_.text = var_162_2
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161038", "story_v_out_321161.awb") ~= 0 then
					local var_162_5 = manager.audio:GetVoiceLength("story_v_out_321161", "321161038", "story_v_out_321161.awb") / 1000

					if var_162_5 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_5 + 0
					end

					if var_162_1.prefab_name ~= "" and arg_159_1.actors_[var_162_1.prefab_name] ~= nil then
						local var_162_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_1.prefab_name].transform, "story_v_out_321161", "321161038", "story_v_out_321161.awb")

						arg_159_1:RecordAudio("321161038", var_162_6)
						arg_159_1:RecordAudio("321161038", var_162_6)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_321161", "321161038", "story_v_out_321161.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_321161", "321161038", "story_v_out_321161.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_7 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_7

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play321161039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 321161039
		arg_163_1.duration_ = 13.77

		local var_163_0 = {
			zh = 10.3,
			ja = 13.766
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play321161040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = 1.2

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, true)
				arg_163_1.iconController_:SetSelectedState("hero")

				arg_163_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_163_1.callingController_:SetSelectedState("normal")

				arg_163_1.keyicon_.color = Color.New(1, 1, 1)
				arg_163_1.icon_.color = Color.New(1, 1, 1)

				local var_166_1 = arg_163_1:GetWordFromCfg(321161039)
				local var_166_2 = arg_163_1:FormatText(var_166_1.content)

				arg_163_1.text_.text = var_166_2

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_4 = 48 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 48)

				if (48 <= 0 and var_166_0 or var_166_0 * (utf8.len(var_166_2) / 48)) > 0 and var_166_0 < var_166_4 then
					arg_163_1.talkMaxDuration = var_166_4

					if var_166_4 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_4 + 0
					end
				end

				arg_163_1.text_.text = var_166_2
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161039", "story_v_out_321161.awb") ~= 0 then
					local var_166_5 = manager.audio:GetVoiceLength("story_v_out_321161", "321161039", "story_v_out_321161.awb") / 1000

					if var_166_5 + 0 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_5 + 0
					end

					if var_166_1.prefab_name ~= "" and arg_163_1.actors_[var_166_1.prefab_name] ~= nil then
						local var_166_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_1.prefab_name].transform, "story_v_out_321161", "321161039", "story_v_out_321161.awb")

						arg_163_1:RecordAudio("321161039", var_166_6)
						arg_163_1:RecordAudio("321161039", var_166_6)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_321161", "321161039", "story_v_out_321161.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_321161", "321161039", "story_v_out_321161.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_7 = math.max(var_166_0, arg_163_1.talkMaxDuration)

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_7 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - 0) / var_166_7

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= 0 + var_166_7 and arg_163_1.time_ < 0 + var_166_7 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play321161040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 321161040
		arg_167_1.duration_ = 8.63

		local var_167_0 = {
			zh = 6.8,
			ja = 8.633
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play321161041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 0.85

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, true)
				arg_167_1.iconController_:SetSelectedState("hero")

				arg_167_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_167_1.callingController_:SetSelectedState("normal")

				arg_167_1.keyicon_.color = Color.New(1, 1, 1)
				arg_167_1.icon_.color = Color.New(1, 1, 1)

				local var_170_1 = arg_167_1:GetWordFromCfg(321161040)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 34 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 34)

				if (34 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 34)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161040", "story_v_out_321161.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_321161", "321161040", "story_v_out_321161.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_321161", "321161040", "story_v_out_321161.awb")

						arg_167_1:RecordAudio("321161040", var_170_6)
						arg_167_1:RecordAudio("321161040", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_321161", "321161040", "story_v_out_321161.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_321161", "321161040", "story_v_out_321161.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play321161041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 321161041
		arg_171_1.duration_ = 8.97

		local var_171_0 = {
			zh = 5.733,
			ja = 8.966
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play321161042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			local var_174_0 = 0
			local var_174_1 = 0.675

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, true)
				arg_171_1.iconController_:SetSelectedState("hero")

				arg_171_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_171_1.callingController_:SetSelectedState("normal")

				arg_171_1.keyicon_.color = Color.New(1, 1, 1)
				arg_171_1.icon_.color = Color.New(1, 1, 1)

				local var_174_2 = arg_171_1:GetWordFromCfg(321161041)
				local var_174_3 = arg_171_1:FormatText(var_174_2.content)

				arg_171_1.text_.text = var_174_3

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 27 <= 0 and var_174_1 or var_174_1 * (utf8.len(var_174_3) / 27)

				if (27 <= 0 and var_174_1 or var_174_1 * (utf8.len(var_174_3) / 27)) > 0 and var_174_1 < var_174_5 then
					arg_171_1.talkMaxDuration = var_174_5

					if var_174_5 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_5 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_3
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161041", "story_v_out_321161.awb") ~= 0 then
					local var_174_6 = manager.audio:GetVoiceLength("story_v_out_321161", "321161041", "story_v_out_321161.awb") / 1000

					if var_174_6 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_6 + var_174_0
					end

					if var_174_2.prefab_name ~= "" and arg_171_1.actors_[var_174_2.prefab_name] ~= nil then
						local var_174_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_2.prefab_name].transform, "story_v_out_321161", "321161041", "story_v_out_321161.awb")

						arg_171_1:RecordAudio("321161041", var_174_7)
						arg_171_1:RecordAudio("321161041", var_174_7)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_321161", "321161041", "story_v_out_321161.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_321161", "321161041", "story_v_out_321161.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_8 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_8 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_8

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_8 and arg_171_1.time_ < var_174_0 + var_174_8 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play321161042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 321161042
		arg_175_1.duration_ = 8.17

		local var_175_0 = {
			zh = 7.5,
			ja = 8.166
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play321161043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.95

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, true)
				arg_175_1.iconController_:SetSelectedState("hero")

				arg_175_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_175_1.callingController_:SetSelectedState("normal")

				arg_175_1.keyicon_.color = Color.New(1, 1, 1)
				arg_175_1.icon_.color = Color.New(1, 1, 1)

				local var_178_1 = arg_175_1:GetWordFromCfg(321161042)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 38 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 38)

				if (38 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 38)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161042", "story_v_out_321161.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_321161", "321161042", "story_v_out_321161.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_321161", "321161042", "story_v_out_321161.awb")

						arg_175_1:RecordAudio("321161042", var_178_6)
						arg_175_1:RecordAudio("321161042", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_321161", "321161042", "story_v_out_321161.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_321161", "321161042", "story_v_out_321161.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_7 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_7 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_7

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_7 and arg_175_1.time_ < 0 + var_178_7 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play321161043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 321161043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play321161044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 1.4

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(321161043).content)

				arg_179_1.text_.text = var_182_1

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_3 = 56 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 56)

				if (56 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_1) / 56)) > 0 and var_182_0 < var_182_3 then
					arg_179_1.talkMaxDuration = var_182_3

					if var_182_3 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_3 + 0
					end
				end

				arg_179_1.text_.text = var_182_1
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_4 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_4 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_4

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_4 and arg_179_1.time_ < 0 + var_182_4 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play321161044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 321161044
		arg_183_1.duration_ = 2

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play321161045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10104ui_story = arg_183_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_186_0 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				arg_183_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_183_1.time_ - 0) / var_186_0)
				arg_183_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).z)
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles = arg_183_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				arg_183_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_183_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_183_1.actors_["10104ui_story"].transform.position).z)
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_183_1.actors_["10104ui_story"].transform.localEulerAngles = arg_183_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_186_1 = arg_183_1.actors_["10104ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect10104ui_story == nil then
				arg_183_1.var_.characterEffect10104ui_story = var_186_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_2 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 and not isNil(var_186_1) then
				if arg_183_1.var_.characterEffect10104ui_story and not isNil(var_186_1) then
					arg_183_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 and not isNil(var_186_1) and arg_183_1.var_.characterEffect10104ui_story then
				arg_183_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_186_4 = 0
			local var_186_5 = 0.1

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(321161044)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 4 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 4)

				if (4 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 4)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161044", "story_v_out_321161.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161044", "story_v_out_321161.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_321161", "321161044", "story_v_out_321161.awb")

						arg_183_1:RecordAudio("321161044", var_186_11)
						arg_183_1:RecordAudio("321161044", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_321161", "321161044", "story_v_out_321161.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_321161", "321161044", "story_v_out_321161.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_183_1:InitPlayNodeList()
	end,
	Play321161045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 321161045
		arg_187_1.duration_ = 1

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"

			SetActive(arg_187_1.choicesGo_, true)

			for iter_188_0, iter_188_1 in ipairs(arg_187_1.choices_) do
				SetActive(iter_188_1.go, iter_188_0 <= 2)
			end

			arg_187_1.choices_[1].txt.text = arg_187_1:FormatText(StoryChoiceCfg[1266].name)
			arg_187_1.choices_[2].txt.text = arg_187_1:FormatText(StoryChoiceCfg[1267].name)
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play321161046(arg_187_1)
			end

			if arg_189_0 == 2 then
				arg_187_0:Play321161046(arg_187_1)
			end

			arg_187_1:RecordChoiceLog(321161045, 1266, 1267)
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["10104ui_story"]) and arg_187_1.var_.characterEffect10104ui_story == nil then
				arg_187_1.var_.characterEffect10104ui_story = arg_187_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["10104ui_story"]) then
				if arg_187_1.var_.characterEffect10104ui_story and not isNil(arg_187_1.actors_["10104ui_story"]) then
					arg_187_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_0)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["10104ui_story"]) and arg_187_1.var_.characterEffect10104ui_story then
				arg_187_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_190_1 = 0

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			if arg_187_1.time_ >= var_190_1 + 0.6 and arg_187_1.time_ < var_190_1 + 0.6 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play321161046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 321161046
		arg_191_1.duration_ = 7.87

		local var_191_0 = {
			zh = 2.533,
			ja = 7.866
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play321161047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10104ui_story = arg_191_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).z)
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles = arg_191_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_191_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["10104ui_story"].transform.position).z)
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["10104ui_story"].transform.localEulerAngles = arg_191_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["10104ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10104ui_story == nil then
				arg_191_1.var_.characterEffect10104ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect10104ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10104ui_story then
				arg_191_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_194_4 = "10104ui_story"

			if arg_191_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_194_5 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_191_1.stage_.transform)

				var_194_5.name = var_194_4
				var_194_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.actors_[var_194_4] = var_194_5

				local var_194_6 = var_194_5:GetComponentInChildren(typeof(CharacterEffect))

				var_194_6.enabled = true

				local var_194_7 = GameObjectTools.GetOrAddComponent(var_194_5, typeof(DynamicBoneHelper))

				if var_194_7 then
					var_194_7:EnableDynamicBone(false)
				end

				arg_191_1:ShowWeapon(var_194_6.transform, false)

				arg_191_1.var_[var_194_4 .. "Animator"] = var_194_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_191_1.var_[var_194_4 .. "Animator"].applyRootMotion = true
				arg_191_1.var_[var_194_4 .. "LipSync"] = var_194_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_1")
			end

			local var_194_8 = "10104ui_story"

			if arg_191_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_194_9 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_191_1.stage_.transform)

				var_194_9.name = var_194_8
				var_194_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_191_1.actors_[var_194_8] = var_194_9

				local var_194_10 = var_194_9:GetComponentInChildren(typeof(CharacterEffect))

				var_194_10.enabled = true

				local var_194_11 = GameObjectTools.GetOrAddComponent(var_194_9, typeof(DynamicBoneHelper))

				if var_194_11 then
					var_194_11:EnableDynamicBone(false)
				end

				arg_191_1:ShowWeapon(var_194_10.transform, false)

				arg_191_1.var_[var_194_8 .. "Animator"] = var_194_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_191_1.var_[var_194_8 .. "Animator"].applyRootMotion = true
				arg_191_1.var_[var_194_8 .. "LipSync"] = var_194_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_zhushiA", "EmotionTimelineAnimator")
			end

			local var_194_12 = 0
			local var_194_13 = 0.35

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_12 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_14 = arg_191_1:GetWordFromCfg(321161046)
				local var_194_15 = arg_191_1:FormatText(var_194_14.content)

				arg_191_1.text_.text = var_194_15

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_17 = 14 <= 0 and var_194_13 or var_194_13 * (utf8.len(var_194_15) / 14)

				if (14 <= 0 and var_194_13 or var_194_13 * (utf8.len(var_194_15) / 14)) > 0 and var_194_13 < var_194_17 then
					arg_191_1.talkMaxDuration = var_194_17

					if var_194_17 + var_194_12 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_17 + var_194_12
					end
				end

				arg_191_1.text_.text = var_194_15
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161046", "story_v_out_321161.awb") ~= 0 then
					local var_194_18 = manager.audio:GetVoiceLength("story_v_out_321161", "321161046", "story_v_out_321161.awb") / 1000

					if var_194_18 + var_194_12 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_18 + var_194_12
					end

					if var_194_14.prefab_name ~= "" and arg_191_1.actors_[var_194_14.prefab_name] ~= nil then
						local var_194_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_14.prefab_name].transform, "story_v_out_321161", "321161046", "story_v_out_321161.awb")

						arg_191_1:RecordAudio("321161046", var_194_19)
						arg_191_1:RecordAudio("321161046", var_194_19)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_321161", "321161046", "story_v_out_321161.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_321161", "321161046", "story_v_out_321161.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_20 = math.max(var_194_13, arg_191_1.talkMaxDuration)

			if var_194_12 <= arg_191_1.time_ and arg_191_1.time_ < var_194_12 + var_194_20 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_12) / var_194_20

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_12 + var_194_20 and arg_191_1.time_ < var_194_12 + var_194_20 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_191_1:InitPlayNodeList()
	end,
	Play321161047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 321161047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play321161048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10104ui_story = arg_195_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_198_0 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 then
				arg_195_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_195_1.time_ - 0) / var_198_0)
				arg_195_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10104ui_story"].transform.position).z)
				arg_195_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10104ui_story"].transform.localEulerAngles = arg_195_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 then
				arg_195_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_195_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_195_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_195_1.actors_["10104ui_story"].transform.position).z)
				arg_195_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_195_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_195_1.actors_["10104ui_story"].transform.localEulerAngles = arg_195_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_198_1 = arg_195_1.actors_["10104ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10104ui_story == nil then
				arg_195_1.var_.characterEffect10104ui_story = var_198_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 and not isNil(var_198_1) then
				if arg_195_1.var_.characterEffect10104ui_story and not isNil(var_198_1) then
					arg_195_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_2)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 and not isNil(var_198_1) and arg_195_1.var_.characterEffect10104ui_story then
				arg_195_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_198_3 = 0
			local var_198_4 = 0.85

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_3 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, false)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_5 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(321161047).content)

				arg_195_1.text_.text = var_198_5

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_7 = 34 <= 0 and var_198_4 or var_198_4 * (utf8.len(var_198_5) / 34)

				if (34 <= 0 and var_198_4 or var_198_4 * (utf8.len(var_198_5) / 34)) > 0 and var_198_4 < var_198_7 then
					arg_195_1.talkMaxDuration = var_198_7

					if var_198_7 + var_198_3 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_7 + var_198_3
					end
				end

				arg_195_1.text_.text = var_198_5
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_8 = math.max(var_198_4, arg_195_1.talkMaxDuration)

			if var_198_3 <= arg_195_1.time_ and arg_195_1.time_ < var_198_3 + var_198_8 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_3) / var_198_8

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_3 + var_198_8 and arg_195_1.time_ < var_198_3 + var_198_8 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play321161048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 321161048
		arg_199_1.duration_ = 7.8

		local var_199_0 = {
			zh = 5.7,
			ja = 7.8
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play321161049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["10104ui_story"]) and arg_199_1.var_.characterEffect10104ui_story == nil then
				arg_199_1.var_.characterEffect10104ui_story = arg_199_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["10104ui_story"]) then
				if arg_199_1.var_.characterEffect10104ui_story and not isNil(arg_199_1.actors_["10104ui_story"]) then
					arg_199_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["10104ui_story"]) and arg_199_1.var_.characterEffect10104ui_story then
				arg_199_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_202_2 = arg_199_1.actors_["10104ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos10104ui_story = var_202_2.localPosition
			end

			local var_202_3 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_3 then
				var_202_2.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_199_1.time_ - 0) / var_202_3)
				var_202_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_2.position).x, (manager.ui.mainCamera.transform.position - var_202_2.position).y, (manager.ui.mainCamera.transform.position - var_202_2.position).z)
				var_202_2.localEulerAngles.z = 0
				var_202_2.localEulerAngles.x = 0
				var_202_2.localEulerAngles = var_202_2.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_3 and arg_199_1.time_ < 0 + var_202_3 + arg_202_0 then
				var_202_2.localPosition = Vector3.New(0.02, -1.12, -5.99)
				var_202_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_2.position).x, (manager.ui.mainCamera.transform.position - var_202_2.position).y, (manager.ui.mainCamera.transform.position - var_202_2.position).z)
				var_202_2.localEulerAngles.z = 0
				var_202_2.localEulerAngles.x = 0
				var_202_2.localEulerAngles = var_202_2.localEulerAngles
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action6_2")
			end

			local var_202_4 = 0
			local var_202_5 = 0.825

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_4 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_6 = arg_199_1:GetWordFromCfg(321161048)
				local var_202_7 = arg_199_1:FormatText(var_202_6.content)

				arg_199_1.text_.text = var_202_7

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_9 = 33 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 33)

				if (33 <= 0 and var_202_5 or var_202_5 * (utf8.len(var_202_7) / 33)) > 0 and var_202_5 < var_202_9 then
					arg_199_1.talkMaxDuration = var_202_9

					if var_202_9 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_9 + var_202_4
					end
				end

				arg_199_1.text_.text = var_202_7
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161048", "story_v_out_321161.awb") ~= 0 then
					local var_202_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161048", "story_v_out_321161.awb") / 1000

					if var_202_10 + var_202_4 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_10 + var_202_4
					end

					if var_202_6.prefab_name ~= "" and arg_199_1.actors_[var_202_6.prefab_name] ~= nil then
						local var_202_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_6.prefab_name].transform, "story_v_out_321161", "321161048", "story_v_out_321161.awb")

						arg_199_1:RecordAudio("321161048", var_202_11)
						arg_199_1:RecordAudio("321161048", var_202_11)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_321161", "321161048", "story_v_out_321161.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_321161", "321161048", "story_v_out_321161.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_12 = math.max(var_202_5, arg_199_1.talkMaxDuration)

			if var_202_4 <= arg_199_1.time_ and arg_199_1.time_ < var_202_4 + var_202_12 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_4) / var_202_12

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_4 + var_202_12 and arg_199_1.time_ < var_202_4 + var_202_12 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play321161049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 321161049
		arg_203_1.duration_ = 8.4

		local var_203_0 = {
			zh = 7.3,
			ja = 8.4
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play321161050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(arg_203_1.actors_["10104ui_story"]) and arg_203_1.var_.characterEffect10104ui_story == nil then
				arg_203_1.var_.characterEffect10104ui_story = arg_203_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_0 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 and not isNil(arg_203_1.actors_["10104ui_story"]) then
				if arg_203_1.var_.characterEffect10104ui_story and not isNil(arg_203_1.actors_["10104ui_story"]) then
					arg_203_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_0)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 and not isNil(arg_203_1.actors_["10104ui_story"]) and arg_203_1.var_.characterEffect10104ui_story then
				arg_203_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_206_1 = 0
			local var_206_2 = 0.825

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_1 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_3 = arg_203_1:GetWordFromCfg(321161049)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_6 = 33 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_4) / 33)

				if (33 <= 0 and var_206_2 or var_206_2 * (utf8.len(var_206_4) / 33)) > 0 and var_206_2 < var_206_6 then
					arg_203_1.talkMaxDuration = var_206_6

					if var_206_6 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_1
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161049", "story_v_out_321161.awb") ~= 0 then
					local var_206_7 = manager.audio:GetVoiceLength("story_v_out_321161", "321161049", "story_v_out_321161.awb") / 1000

					if var_206_7 + var_206_1 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_1
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_321161", "321161049", "story_v_out_321161.awb")

						arg_203_1:RecordAudio("321161049", var_206_8)
						arg_203_1:RecordAudio("321161049", var_206_8)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_321161", "321161049", "story_v_out_321161.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_321161", "321161049", "story_v_out_321161.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_9 = math.max(var_206_2, arg_203_1.talkMaxDuration)

			if var_206_1 <= arg_203_1.time_ and arg_203_1.time_ < var_206_1 + var_206_9 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_1) / var_206_9

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_1 + var_206_9 and arg_203_1.time_ < var_206_1 + var_206_9 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play321161050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 321161050
		arg_207_1.duration_ = 4.6

		local var_207_0 = {
			zh = 2.466,
			ja = 4.6
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play321161051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["10104ui_story"]) and arg_207_1.var_.characterEffect10104ui_story == nil then
				arg_207_1.var_.characterEffect10104ui_story = arg_207_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["10104ui_story"]) then
				if arg_207_1.var_.characterEffect10104ui_story and not isNil(arg_207_1.actors_["10104ui_story"]) then
					arg_207_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["10104ui_story"]) and arg_207_1.var_.characterEffect10104ui_story then
				arg_207_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_210_2 = 0
			local var_210_3 = 0.225

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_4 = arg_207_1:GetWordFromCfg(321161050)
				local var_210_5 = arg_207_1:FormatText(var_210_4.content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 9 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 9)

				if (9 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 9)) > 0 and var_210_3 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_2
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161050", "story_v_out_321161.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_321161", "321161050", "story_v_out_321161.awb") / 1000

					if var_210_8 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_2
					end

					if var_210_4.prefab_name ~= "" and arg_207_1.actors_[var_210_4.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_4.prefab_name].transform, "story_v_out_321161", "321161050", "story_v_out_321161.awb")

						arg_207_1:RecordAudio("321161050", var_210_9)
						arg_207_1:RecordAudio("321161050", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_321161", "321161050", "story_v_out_321161.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_321161", "321161050", "story_v_out_321161.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_3, arg_207_1.talkMaxDuration)

			if var_210_2 <= arg_207_1.time_ and arg_207_1.time_ < var_210_2 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_2) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_2 + var_210_10 and arg_207_1.time_ < var_210_2 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play321161051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 321161051
		arg_211_1.duration_ = 5.53

		local var_211_0 = {
			zh = 5.533,
			ja = 4.5
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play321161052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action4_1")
			end

			local var_214_0 = 0
			local var_214_1 = 0.575

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_0 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_2 = arg_211_1:GetWordFromCfg(321161051)
				local var_214_3 = arg_211_1:FormatText(var_214_2.content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 23 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 23)

				if (23 <= 0 and var_214_1 or var_214_1 * (utf8.len(var_214_3) / 23)) > 0 and var_214_1 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_0
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161051", "story_v_out_321161.awb") ~= 0 then
					local var_214_6 = manager.audio:GetVoiceLength("story_v_out_321161", "321161051", "story_v_out_321161.awb") / 1000

					if var_214_6 + var_214_0 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_6 + var_214_0
					end

					if var_214_2.prefab_name ~= "" and arg_211_1.actors_[var_214_2.prefab_name] ~= nil then
						local var_214_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_2.prefab_name].transform, "story_v_out_321161", "321161051", "story_v_out_321161.awb")

						arg_211_1:RecordAudio("321161051", var_214_7)
						arg_211_1:RecordAudio("321161051", var_214_7)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_321161", "321161051", "story_v_out_321161.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_321161", "321161051", "story_v_out_321161.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_8 = math.max(var_214_1, arg_211_1.talkMaxDuration)

			if var_214_0 <= arg_211_1.time_ and arg_211_1.time_ < var_214_0 + var_214_8 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_0) / var_214_8

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_0 + var_214_8 and arg_211_1.time_ < var_214_0 + var_214_8 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play321161052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 321161052
		arg_215_1.duration_ = 9

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play321161053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if arg_215_1.bgs_.L14f == nil then
				local var_218_0 = Object.Instantiate(arg_215_1.paintGo_)

				var_218_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "L14f")
				var_218_0.name = "L14f"
				var_218_0.transform.parent = arg_215_1.stage_.transform
				var_218_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_215_1.bgs_.L14f = var_218_0
			end

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= 2 + arg_218_0 then
				local var_218_1 = arg_215_1.bgs_.L14f

				arg_215_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_218_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_218_2 = var_218_1:GetComponent("SpriteRenderer")

				if var_218_2 and var_218_2.sprite then
					local var_218_3 = 2 * (var_218_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_218_1.transform.localScale = Vector3.New(var_218_3 / var_218_2.sprite.bounds.size.y < var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x and var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x or var_218_3 / var_218_2.sprite.bounds.size.y, var_218_3 / var_218_2.sprite.bounds.size.y < var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x and var_218_3 * manager.ui.mainCameraCom_.aspect / var_218_2.sprite.bounds.size.x or var_218_3 / var_218_2.sprite.bounds.size.y, 0)
				end

				for iter_218_0, iter_218_1 in pairs(arg_215_1.bgs_) do
					if iter_218_0 ~= "L14f" then
						iter_218_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_218_4 = 4

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_4 + arg_218_0 then
				arg_215_1.allBtn_.enabled = false
			end

			if arg_215_1.time_ >= var_218_4 + 0.3 and arg_215_1.time_ < var_218_4 + 0.3 + arg_218_0 then
				arg_215_1.allBtn_.enabled = true
			end

			local var_218_5 = 0

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_6 = 2

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_6 then
				local var_218_7 = Color.New(0, 0, 0)

				var_218_7.a = Mathf.Lerp(0, 1, (arg_215_1.time_ - var_218_5) / var_218_6)
				arg_215_1.mask_.color = var_218_7
			end

			if arg_215_1.time_ >= var_218_5 + var_218_6 and arg_215_1.time_ < var_218_5 + var_218_6 + arg_218_0 then
				local var_218_8 = Color.New(0, 0, 0)

				var_218_8.a = 1
				arg_215_1.mask_.color = var_218_8
			end

			local var_218_9 = 2

			if 2 < arg_215_1.time_ and arg_215_1.time_ <= var_218_9 + arg_218_0 then
				arg_215_1.mask_.enabled = true
				arg_215_1.mask_.raycastTarget = true

				arg_215_1:SetGaussion(false)
			end

			local var_218_10 = 2

			if var_218_9 <= arg_215_1.time_ and arg_215_1.time_ < var_218_9 + var_218_10 then
				local var_218_11 = Color.New(0, 0, 0)

				var_218_11.a = Mathf.Lerp(1, 0, (arg_215_1.time_ - var_218_9) / var_218_10)
				arg_215_1.mask_.color = var_218_11
			end

			if arg_215_1.time_ >= var_218_9 + var_218_10 and arg_215_1.time_ < var_218_9 + var_218_10 + arg_218_0 then
				local var_218_12 = Color.New(0, 0, 0)

				arg_215_1.mask_.enabled = false
				var_218_12.a = 0
				arg_215_1.mask_.color = var_218_12
			end

			local var_218_13 = arg_215_1.actors_["10104ui_story"].transform

			if 1.96599999815226 < arg_215_1.time_ and arg_215_1.time_ <= 1.96599999815226 + arg_218_0 then
				arg_215_1.var_.moveOldPos10104ui_story = var_218_13.localPosition
			end

			local var_218_14 = 0.001

			if 1.96599999815226 <= arg_215_1.time_ and arg_215_1.time_ < 1.96599999815226 + var_218_14 then
				var_218_13.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_215_1.time_ - 1.96599999815226) / var_218_14)
				var_218_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_13.position).x, (manager.ui.mainCamera.transform.position - var_218_13.position).y, (manager.ui.mainCamera.transform.position - var_218_13.position).z)
				var_218_13.localEulerAngles.z = 0
				var_218_13.localEulerAngles.x = 0
				var_218_13.localEulerAngles = var_218_13.localEulerAngles
			end

			if arg_215_1.time_ >= 1.96599999815226 + var_218_14 and arg_215_1.time_ < 1.96599999815226 + var_218_14 + arg_218_0 then
				var_218_13.localPosition = Vector3.New(0, 100, 0)
				var_218_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_218_13.position).x, (manager.ui.mainCamera.transform.position - var_218_13.position).y, (manager.ui.mainCamera.transform.position - var_218_13.position).z)
				var_218_13.localEulerAngles.z = 0
				var_218_13.localEulerAngles.x = 0
				var_218_13.localEulerAngles = var_218_13.localEulerAngles
			end

			local var_218_15 = arg_215_1.actors_["10104ui_story"]

			if 1.96599999815226 < arg_215_1.time_ and arg_215_1.time_ <= 1.96599999815226 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.characterEffect10104ui_story == nil then
				arg_215_1.var_.characterEffect10104ui_story = var_218_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_16 = 0.034000001847744

			if 1.96599999815226 <= arg_215_1.time_ and arg_215_1.time_ < 1.96599999815226 + var_218_16 and not isNil(var_218_15) then
				if arg_215_1.var_.characterEffect10104ui_story and not isNil(var_218_15) then
					arg_215_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 1.96599999815226) / var_218_16)
				end
			end

			if arg_215_1.time_ >= 1.96599999815226 + var_218_16 and arg_215_1.time_ < 1.96599999815226 + var_218_16 + arg_218_0 and not isNil(var_218_15) and arg_215_1.var_.characterEffect10104ui_story then
				arg_215_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if arg_215_1.frameCnt_ <= 1 then
				arg_215_1.dialog_:SetActive(false)
			end

			local var_218_17 = 4
			local var_218_18 = 1.7

			if 4 < arg_215_1.time_ and arg_215_1.time_ <= var_218_17 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0

				arg_215_1.dialog_:SetActive(true)

				arg_215_1.dialogCg_.alpha = 0

				local var_218_19 = LeanTween.value(arg_215_1.dialog_, 0, 1, 0.3)

				var_218_19:setOnUpdate(LuaHelper.FloatAction(function(arg_219_0)
					arg_215_1.dialogCg_.alpha = arg_219_0
				end))
				var_218_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_215_1.dialog_)
					var_218_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_215_1.duration_ = arg_215_1.duration_ + 0.3

				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_20 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(321161052).content)

				arg_215_1.text_.text = var_218_20

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_22 = 68 <= 0 and var_218_18 or var_218_18 * (utf8.len(var_218_20) / 68)

				if (68 <= 0 and var_218_18 or var_218_18 * (utf8.len(var_218_20) / 68)) > 0 and var_218_18 < var_218_22 then
					arg_215_1.talkMaxDuration = var_218_22
					var_218_17 = var_218_17 + 0.3

					if var_218_22 + var_218_17 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_22 + var_218_17
					end
				end

				arg_215_1.text_.text = var_218_20
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_23 = var_218_17 + 0.3
			local var_218_24 = math.max(var_218_18, arg_215_1.talkMaxDuration)

			if var_218_17 + 0.3 <= arg_215_1.time_ and arg_215_1.time_ < var_218_23 + var_218_24 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_23) / var_218_24

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_23 + var_218_24 and arg_215_1.time_ < var_218_23 + var_218_24 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play321161053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 321161053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play321161054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 1.375

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_1 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(321161053).content)

				arg_221_1.text_.text = var_224_1

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_3 = 55 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 55)

				if (55 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_1) / 55)) > 0 and var_224_0 < var_224_3 then
					arg_221_1.talkMaxDuration = var_224_3

					if var_224_3 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_3 + 0
					end
				end

				arg_221_1.text_.text = var_224_1
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_4 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_4 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_4

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_4 and arg_221_1.time_ < 0 + var_224_4 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play321161054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 321161054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play321161055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0.034000001847744 < arg_225_1.time_ and arg_225_1.time_ <= 0.034000001847744 + arg_228_0 then
				arg_225_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_door", "")
			end

			local var_228_1 = 0
			local var_228_2 = 1.475

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(321161054).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 59 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 59)

				if (59 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 59)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play321161055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 321161055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play321161056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			local var_232_0 = 1

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_1 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(321161055).content)

				arg_229_1.text_.text = var_232_1

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_3 = 40 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 40)

				if (40 <= 0 and var_232_0 or var_232_0 * (utf8.len(var_232_1) / 40)) > 0 and var_232_0 < var_232_3 then
					arg_229_1.talkMaxDuration = var_232_3

					if var_232_3 + 0 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_3 + 0
					end
				end

				arg_229_1.text_.text = var_232_1
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_4 = math.max(var_232_0, arg_229_1.talkMaxDuration)

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_4 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - 0) / var_232_4

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= 0 + var_232_4 and arg_229_1.time_ < 0 + var_232_4 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play321161056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 321161056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play321161057(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_0 = 0.175

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, true)
				arg_233_1.iconController_:SetSelectedState("hero")

				arg_233_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_233_1.callingController_:SetSelectedState("normal")

				arg_233_1.keyicon_.color = Color.New(1, 1, 1)
				arg_233_1.icon_.color = Color.New(1, 1, 1)

				local var_236_1 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(321161056).content)

				arg_233_1.text_.text = var_236_1

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_3 = 7 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 7)

				if (7 <= 0 and var_236_0 or var_236_0 * (utf8.len(var_236_1) / 7)) > 0 and var_236_0 < var_236_3 then
					arg_233_1.talkMaxDuration = var_236_3

					if var_236_3 + 0 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_3 + 0
					end
				end

				arg_233_1.text_.text = var_236_1
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_4 = math.max(var_236_0, arg_233_1.talkMaxDuration)

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_4 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - 0) / var_236_4

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= 0 + var_236_4 and arg_233_1.time_ < 0 + var_236_4 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play321161057 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 321161057
		arg_237_1.duration_ = 6.47

		local var_237_0 = {
			zh = 5,
			ja = 6.466
		}
		local var_237_1 = manager.audio:GetLocalizationFlag()

		if var_237_0[var_237_1] ~= nil then
			arg_237_1.duration_ = var_237_0[var_237_1]
		end

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play321161058(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1.var_.moveOldPos10104ui_story = arg_237_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_240_0 = 0.001

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 then
				arg_237_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_237_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_237_1.time_ - 0) / var_240_0)
				arg_237_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10104ui_story"].transform.position).z)
				arg_237_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["10104ui_story"].transform.localEulerAngles = arg_237_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 then
				arg_237_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_237_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_237_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_237_1.actors_["10104ui_story"].transform.position).z)
				arg_237_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_237_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_237_1.actors_["10104ui_story"].transform.localEulerAngles = arg_237_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_240_1 = arg_237_1.actors_["10104ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect10104ui_story == nil then
				arg_237_1.var_.characterEffect10104ui_story = var_240_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_2 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_2 and not isNil(var_240_1) then
				if arg_237_1.var_.characterEffect10104ui_story and not isNil(var_240_1) then
					arg_237_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_2 and arg_237_1.time_ < 0 + var_240_2 + arg_240_0 and not isNil(var_240_1) and arg_237_1.var_.characterEffect10104ui_story then
				arg_237_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action1_1")
			end

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 then
				arg_237_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_240_4 = 0
			local var_240_5 = 0.675

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:GetWordFromCfg(321161057)
				local var_240_7 = arg_237_1:FormatText(var_240_6.content)

				arg_237_1.text_.text = var_240_7

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_9 = 27 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 27)

				if (27 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_7) / 27)) > 0 and var_240_5 < var_240_9 then
					arg_237_1.talkMaxDuration = var_240_9

					if var_240_9 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_9 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_7
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161057", "story_v_out_321161.awb") ~= 0 then
					local var_240_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161057", "story_v_out_321161.awb") / 1000

					if var_240_10 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_10 + var_240_4
					end

					if var_240_6.prefab_name ~= "" and arg_237_1.actors_[var_240_6.prefab_name] ~= nil then
						local var_240_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_237_1.actors_[var_240_6.prefab_name].transform, "story_v_out_321161", "321161057", "story_v_out_321161.awb")

						arg_237_1:RecordAudio("321161057", var_240_11)
						arg_237_1:RecordAudio("321161057", var_240_11)
					else
						arg_237_1:AudioAction("play", "voice", "story_v_out_321161", "321161057", "story_v_out_321161.awb")
					end

					arg_237_1:RecordHistoryTalkVoice("story_v_out_321161", "321161057", "story_v_out_321161.awb")
				end

				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_12 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_12 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_12

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_12 and arg_237_1.time_ < var_240_4 + var_240_12 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_237_1:InitPlayNodeList()
	end,
	Play321161058 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 321161058
		arg_241_1.duration_ = 13.87

		local var_241_0 = {
			zh = 9.233,
			ja = 13.866
		}
		local var_241_1 = manager.audio:GetLocalizationFlag()

		if var_241_0[var_241_1] ~= nil then
			arg_241_1.duration_ = var_241_0[var_241_1]
		end

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play321161059(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1.var_.moveOldPos10104ui_story = arg_241_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_244_0 = 0.001

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 then
				arg_241_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_241_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_241_1.time_ - 0) / var_244_0)
				arg_241_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10104ui_story"].transform.position).z)
				arg_241_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["10104ui_story"].transform.localEulerAngles = arg_241_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 then
				arg_241_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_241_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_241_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_241_1.actors_["10104ui_story"].transform.position).z)
				arg_241_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_241_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_241_1.actors_["10104ui_story"].transform.localEulerAngles = arg_241_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_244_1 = 0
			local var_244_2 = 1.025

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_1 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_3 = arg_241_1:GetWordFromCfg(321161058)
				local var_244_4 = arg_241_1:FormatText(var_244_3.content)

				arg_241_1.text_.text = var_244_4

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_6 = 41 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 41)

				if (41 <= 0 and var_244_2 or var_244_2 * (utf8.len(var_244_4) / 41)) > 0 and var_244_2 < var_244_6 then
					arg_241_1.talkMaxDuration = var_244_6

					if var_244_6 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_6 + var_244_1
					end
				end

				arg_241_1.text_.text = var_244_4
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161058", "story_v_out_321161.awb") ~= 0 then
					local var_244_7 = manager.audio:GetVoiceLength("story_v_out_321161", "321161058", "story_v_out_321161.awb") / 1000

					if var_244_7 + var_244_1 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_7 + var_244_1
					end

					if var_244_3.prefab_name ~= "" and arg_241_1.actors_[var_244_3.prefab_name] ~= nil then
						local var_244_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_241_1.actors_[var_244_3.prefab_name].transform, "story_v_out_321161", "321161058", "story_v_out_321161.awb")

						arg_241_1:RecordAudio("321161058", var_244_8)
						arg_241_1:RecordAudio("321161058", var_244_8)
					else
						arg_241_1:AudioAction("play", "voice", "story_v_out_321161", "321161058", "story_v_out_321161.awb")
					end

					arg_241_1:RecordHistoryTalkVoice("story_v_out_321161", "321161058", "story_v_out_321161.awb")
				end

				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_9 = math.max(var_244_2, arg_241_1.talkMaxDuration)

			if var_244_1 <= arg_241_1.time_ and arg_241_1.time_ < var_244_1 + var_244_9 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_1) / var_244_9

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_1 + var_244_9 and arg_241_1.time_ < var_244_1 + var_244_9 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_241_1:InitPlayNodeList()
	end,
	Play321161059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 321161059
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play321161060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["10104ui_story"]) and arg_245_1.var_.characterEffect10104ui_story == nil then
				arg_245_1.var_.characterEffect10104ui_story = arg_245_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["10104ui_story"]) then
				if arg_245_1.var_.characterEffect10104ui_story and not isNil(arg_245_1.actors_["10104ui_story"]) then
					arg_245_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_245_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["10104ui_story"]) and arg_245_1.var_.characterEffect10104ui_story then
				arg_245_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_245_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 0.034000001847744 < arg_245_1.time_ and arg_245_1.time_ <= 0.034000001847744 + arg_248_0 then
				arg_245_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_tip", "")
			end

			local var_248_2 = 0
			local var_248_3 = 1.55

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_2 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_4 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(321161059).content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 62 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 62)

				if (62 <= 0 and var_248_3 or var_248_3 * (utf8.len(var_248_4) / 62)) > 0 and var_248_3 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_2 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_2
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_7 = math.max(var_248_3, arg_245_1.talkMaxDuration)

			if var_248_2 <= arg_245_1.time_ and arg_245_1.time_ < var_248_2 + var_248_7 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_2) / var_248_7

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_2 + var_248_7 and arg_245_1.time_ < var_248_2 + var_248_7 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play321161060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 321161060
		arg_249_1.duration_ = 1

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"

			SetActive(arg_249_1.choicesGo_, true)

			for iter_250_0, iter_250_1 in ipairs(arg_249_1.choices_) do
				SetActive(iter_250_1.go, iter_250_0 <= 2)
			end

			arg_249_1.choices_[1].txt.text = arg_249_1:FormatText(StoryChoiceCfg[1268].name)
			arg_249_1.choices_[2].txt.text = arg_249_1:FormatText(StoryChoiceCfg[1269].name)
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play321161061(arg_249_1)
			end

			if arg_251_0 == 2 then
				arg_249_0:Play321161061(arg_249_1)
			end

			arg_249_1:RecordChoiceLog(321161060, 1268, 1269)
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.allBtn_.enabled = false
			end

			if arg_249_1.time_ >= 0 + 0.6 and arg_249_1.time_ < 0 + 0.6 + arg_252_0 then
				arg_249_1.allBtn_.enabled = true
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play321161061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 321161061
		arg_253_1.duration_ = 7.4

		local var_253_0 = {
			zh = 5.7,
			ja = 7.4
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play321161062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10104ui_story = arg_253_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_256_0 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_0 then
				arg_253_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_253_1.time_ - 0) / var_256_0)
				arg_253_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).z)
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles = arg_253_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_0 and arg_253_1.time_ < 0 + var_256_0 + arg_256_0 then
				arg_253_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_253_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_253_1.actors_["10104ui_story"].transform.position).z)
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_253_1.actors_["10104ui_story"].transform.localEulerAngles = arg_253_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_256_1 = arg_253_1.actors_["10104ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect10104ui_story == nil then
				arg_253_1.var_.characterEffect10104ui_story = var_256_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_2 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_2 and not isNil(var_256_1) then
				if arg_253_1.var_.characterEffect10104ui_story and not isNil(var_256_1) then
					arg_253_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_253_1.time_ >= 0 + var_256_2 and arg_253_1.time_ < 0 + var_256_2 + arg_256_0 and not isNil(var_256_1) and arg_253_1.var_.characterEffect10104ui_story then
				arg_253_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_256_4 = "10104ui_story"

			if arg_253_1.actors_["10104ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10104ui_story"))) then
				local var_256_5 = Object.Instantiate(Asset.Load("Char/" .. "10104ui_story"), arg_253_1.stage_.transform)

				var_256_5.name = var_256_4
				var_256_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.actors_[var_256_4] = var_256_5

				local var_256_6 = var_256_5:GetComponentInChildren(typeof(CharacterEffect))

				var_256_6.enabled = true

				local var_256_7 = GameObjectTools.GetOrAddComponent(var_256_5, typeof(DynamicBoneHelper))

				if var_256_7 then
					var_256_7:EnableDynamicBone(false)
				end

				arg_253_1:ShowWeapon(var_256_6.transform, false)

				arg_253_1.var_[var_256_4 .. "Animator"] = var_256_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_253_1.var_[var_256_4 .. "Animator"].applyRootMotion = true
				arg_253_1.var_[var_256_4 .. "LipSync"] = var_256_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_1")
			end

			local var_256_8 = 0
			local var_256_9 = 0.75

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_8 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_10 = arg_253_1:GetWordFromCfg(321161061)
				local var_256_11 = arg_253_1:FormatText(var_256_10.content)

				arg_253_1.text_.text = var_256_11

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_13 = 30 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 30)

				if (30 <= 0 and var_256_9 or var_256_9 * (utf8.len(var_256_11) / 30)) > 0 and var_256_9 < var_256_13 then
					arg_253_1.talkMaxDuration = var_256_13

					if var_256_13 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_13 + var_256_8
					end
				end

				arg_253_1.text_.text = var_256_11
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161061", "story_v_out_321161.awb") ~= 0 then
					local var_256_14 = manager.audio:GetVoiceLength("story_v_out_321161", "321161061", "story_v_out_321161.awb") / 1000

					if var_256_14 + var_256_8 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_14 + var_256_8
					end

					if var_256_10.prefab_name ~= "" and arg_253_1.actors_[var_256_10.prefab_name] ~= nil then
						local var_256_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_10.prefab_name].transform, "story_v_out_321161", "321161061", "story_v_out_321161.awb")

						arg_253_1:RecordAudio("321161061", var_256_15)
						arg_253_1:RecordAudio("321161061", var_256_15)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_321161", "321161061", "story_v_out_321161.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_321161", "321161061", "story_v_out_321161.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_16 = math.max(var_256_9, arg_253_1.talkMaxDuration)

			if var_256_8 <= arg_253_1.time_ and arg_253_1.time_ < var_256_8 + var_256_16 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_8) / var_256_16

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_8 + var_256_16 and arg_253_1.time_ < var_256_8 + var_256_16 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_253_1:InitPlayNodeList()
	end,
	Play321161062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 321161062
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play321161063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["10104ui_story"]) and arg_257_1.var_.characterEffect10104ui_story == nil then
				arg_257_1.var_.characterEffect10104ui_story = arg_257_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["10104ui_story"]) then
				if arg_257_1.var_.characterEffect10104ui_story and not isNil(arg_257_1.actors_["10104ui_story"]) then
					arg_257_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_257_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_0)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["10104ui_story"]) and arg_257_1.var_.characterEffect10104ui_story then
				arg_257_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_257_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_260_1 = 0
			local var_260_2 = 1.2

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_1 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_3 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(321161062).content)

				arg_257_1.text_.text = var_260_3

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_5 = 48 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 48)

				if (48 <= 0 and var_260_2 or var_260_2 * (utf8.len(var_260_3) / 48)) > 0 and var_260_2 < var_260_5 then
					arg_257_1.talkMaxDuration = var_260_5

					if var_260_5 + var_260_1 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + var_260_1
					end
				end

				arg_257_1.text_.text = var_260_3
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_6 = math.max(var_260_2, arg_257_1.talkMaxDuration)

			if var_260_1 <= arg_257_1.time_ and arg_257_1.time_ < var_260_1 + var_260_6 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_1) / var_260_6

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_1 + var_260_6 and arg_257_1.time_ < var_260_1 + var_260_6 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play321161063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 321161063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play321161064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 0.45

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_1 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(321161063).content)

				arg_261_1.text_.text = var_264_1

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_3 = 18 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 18)

				if (18 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_1) / 18)) > 0 and var_264_0 < var_264_3 then
					arg_261_1.talkMaxDuration = var_264_3

					if var_264_3 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_3 + 0
					end
				end

				arg_261_1.text_.text = var_264_1
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_4 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_4 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_4

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_4 and arg_261_1.time_ < 0 + var_264_4 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play321161064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 321161064
		arg_265_1.duration_ = 6.03

		local var_265_0 = {
			zh = 4.5,
			ja = 6.033
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play321161065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos10104ui_story = arg_265_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10104ui_story"].transform.position).z)
				arg_265_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10104ui_story"].transform.localEulerAngles = arg_265_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_265_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["10104ui_story"].transform.position).z)
				arg_265_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["10104ui_story"].transform.localEulerAngles = arg_265_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["10104ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect10104ui_story == nil then
				arg_265_1.var_.characterEffect10104ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect10104ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect10104ui_story then
				arg_265_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_268_4 = 0
			local var_268_5 = 0.6

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(321161064)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 24 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 24)

				if (24 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 24)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161064", "story_v_out_321161.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161064", "story_v_out_321161.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_321161", "321161064", "story_v_out_321161.awb")

						arg_265_1:RecordAudio("321161064", var_268_11)
						arg_265_1:RecordAudio("321161064", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_321161", "321161064", "story_v_out_321161.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_321161", "321161064", "story_v_out_321161.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_265_1:InitPlayNodeList()
	end,
	Play321161065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 321161065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play321161066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["10104ui_story"]) and arg_269_1.var_.characterEffect10104ui_story == nil then
				arg_269_1.var_.characterEffect10104ui_story = arg_269_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["10104ui_story"]) then
				if arg_269_1.var_.characterEffect10104ui_story and not isNil(arg_269_1.actors_["10104ui_story"]) then
					arg_269_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_269_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["10104ui_story"]) and arg_269_1.var_.characterEffect10104ui_story then
				arg_269_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_269_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_272_1 = 0
			local var_272_2 = 0.375

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(321161065).content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 15 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 15)

				if (15 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 15)) > 0 and var_272_2 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_1
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_6 = math.max(var_272_2, arg_269_1.talkMaxDuration)

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_6 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_1) / var_272_6

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_1 + var_272_6 and arg_269_1.time_ < var_272_1 + var_272_6 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play321161066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 321161066
		arg_273_1.duration_ = 4.8

		local var_273_0 = {
			zh = 3.066,
			ja = 4.8
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play321161067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos10104ui_story = arg_273_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).z)
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles = arg_273_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_273_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["10104ui_story"].transform.position).z)
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["10104ui_story"].transform.localEulerAngles = arg_273_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_276_1 = arg_273_1.actors_["10104ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10104ui_story == nil then
				arg_273_1.var_.characterEffect10104ui_story = var_276_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_2 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_2 and not isNil(var_276_1) then
				if arg_273_1.var_.characterEffect10104ui_story and not isNil(var_276_1) then
					arg_273_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_2 and arg_273_1.time_ < 0 + var_276_2 + arg_276_0 and not isNil(var_276_1) and arg_273_1.var_.characterEffect10104ui_story then
				arg_273_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action2_2")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_276_4 = 0
			local var_276_5 = 0.3

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:GetWordFromCfg(321161066)
				local var_276_7 = arg_273_1:FormatText(var_276_6.content)

				arg_273_1.text_.text = var_276_7

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_9 = 12 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 12)

				if (12 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_7) / 12)) > 0 and var_276_5 < var_276_9 then
					arg_273_1.talkMaxDuration = var_276_9

					if var_276_9 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_9 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_7
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161066", "story_v_out_321161.awb") ~= 0 then
					local var_276_10 = manager.audio:GetVoiceLength("story_v_out_321161", "321161066", "story_v_out_321161.awb") / 1000

					if var_276_10 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_10 + var_276_4
					end

					if var_276_6.prefab_name ~= "" and arg_273_1.actors_[var_276_6.prefab_name] ~= nil then
						local var_276_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_6.prefab_name].transform, "story_v_out_321161", "321161066", "story_v_out_321161.awb")

						arg_273_1:RecordAudio("321161066", var_276_11)
						arg_273_1:RecordAudio("321161066", var_276_11)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_321161", "321161066", "story_v_out_321161.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_321161", "321161066", "story_v_out_321161.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_12 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_12 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_12

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_12 and arg_273_1.time_ < var_276_4 + var_276_12 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_273_1:InitPlayNodeList()
	end,
	Play321161067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 321161067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play321161068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["10104ui_story"]) and arg_277_1.var_.characterEffect10104ui_story == nil then
				arg_277_1.var_.characterEffect10104ui_story = arg_277_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["10104ui_story"]) then
				if arg_277_1.var_.characterEffect10104ui_story and not isNil(arg_277_1.actors_["10104ui_story"]) then
					arg_277_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_0)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["10104ui_story"]) and arg_277_1.var_.characterEffect10104ui_story then
				arg_277_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_280_1 = 0
			local var_280_2 = 1.475

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(321161067).content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 59 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 59)

				if (59 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 59)) > 0 and var_280_2 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_1
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_6 = math.max(var_280_2, arg_277_1.talkMaxDuration)

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_6 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_1) / var_280_6

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_1 + var_280_6 and arg_277_1.time_ < var_280_1 + var_280_6 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play321161068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 321161068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play321161069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.175

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_1 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(321161068).content)

				arg_281_1.text_.text = var_284_1

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_3 = 7 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 7)

				if (7 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 7)) > 0 and var_284_0 < var_284_3 then
					arg_281_1.talkMaxDuration = var_284_3

					if var_284_3 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_3 + 0
					end
				end

				arg_281_1.text_.text = var_284_1
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_4 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_4

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play321161069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 321161069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play321161070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.6

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(321161069).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 24 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 24)

				if (24 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 24)) > 0 and var_288_0 < var_288_3 then
					arg_285_1.talkMaxDuration = var_288_3

					if var_288_3 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_3 + 0
					end
				end

				arg_285_1.text_.text = var_288_1
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_4 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_4

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play321161070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 321161070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play321161071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.var_.moveOldPos10104ui_story = arg_289_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_292_0 = 0.001

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 then
				arg_289_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_289_1.time_ - 0) / var_292_0)
				arg_289_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).z)
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles = arg_289_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 then
				arg_289_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_289_1.actors_["10104ui_story"].transform.position).z)
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_289_1.actors_["10104ui_story"].transform.localEulerAngles = arg_289_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_292_1 = 0
			local var_292_2 = 1.4

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_1 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, false)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_3 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(321161070).content)

				arg_289_1.text_.text = var_292_3

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_5 = 56 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 56)

				if (56 <= 0 and var_292_2 or var_292_2 * (utf8.len(var_292_3) / 56)) > 0 and var_292_2 < var_292_5 then
					arg_289_1.talkMaxDuration = var_292_5

					if var_292_5 + var_292_1 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + var_292_1
					end
				end

				arg_289_1.text_.text = var_292_3
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_6 = math.max(var_292_2, arg_289_1.talkMaxDuration)

			if var_292_1 <= arg_289_1.time_ and arg_289_1.time_ < var_292_1 + var_292_6 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_1) / var_292_6

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_1 + var_292_6 and arg_289_1.time_ < var_292_1 + var_292_6 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_289_1:InitPlayNodeList()
	end,
	Play321161071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 321161071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play321161072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				local var_296_0 = arg_293_1.var_.effectjinglingdazuo

				if not arg_293_1.var_.effectjinglingdazuo then
					var_296_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_296_0.name = "jinglingdazuo"
					arg_293_1.var_.effectjinglingdazuo = var_296_0
				else
					var_296_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_296_0.transform.localPosition = Vector3.New(0, 0, -2)
				var_296_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_296_0.transform.localScale = Vector3.New(var_296_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_296_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_296_0.transform.localScale.z)
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_alarm", "")
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_296_5 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_293_1.bgmTxt_.text ~= var_296_5 and arg_293_1.bgmTxt_.text ~= "" then
						if arg_293_1.bgmTxt2_.text ~= "" then
							arg_293_1.bgmTxt_.text = arg_293_1.bgmTxt2_.text
						end

						arg_293_1.bgmTxt2_.text = var_296_5

						arg_293_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_293_1.bgmTxt_.text = var_296_5
						arg_293_1.bgmTxt2_.text = var_296_5
					end

					if arg_293_1.bgmTimer then
						arg_293_1.bgmTimer:Stop()

						arg_293_1.bgmTimer = nil
					end

					if arg_293_1.settingData.show_music_name == 1 then
						arg_293_1.musicController:SetSelectedState("show")
						arg_293_1.musicAnimator_:Play("open", 0, 0)

						if arg_293_1.settingData.music_time ~= 0 then
							arg_293_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_293_1.settingData.music_time), function()
								if arg_293_1 == nil or isNil(arg_293_1.bgmTxt_) then
									return
								end

								arg_293_1.musicController:SetSelectedState("hide")
								arg_293_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_296_6 = 0
			local var_296_7 = 0.45

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_6 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, false)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_8 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(321161071).content)

				arg_293_1.text_.text = var_296_8

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_10 = 18 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_8) / 18)

				if (18 <= 0 and var_296_7 or var_296_7 * (utf8.len(var_296_8) / 18)) > 0 and var_296_7 < var_296_10 then
					arg_293_1.talkMaxDuration = var_296_10

					if var_296_10 + var_296_6 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_10 + var_296_6
					end
				end

				arg_293_1.text_.text = var_296_8
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_11 = math.max(var_296_7, arg_293_1.talkMaxDuration)

			if var_296_6 <= arg_293_1.time_ and arg_293_1.time_ < var_296_6 + var_296_11 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_6) / var_296_11

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_6 + var_296_11 and arg_293_1.time_ < var_296_6 + var_296_11 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play321161072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 321161072
		arg_298_1.duration_ = 11.5

		local var_298_0 = {
			zh = 5.3,
			ja = 11.5
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play321161073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_301_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_298_1.bgmTxt_.text ~= var_301_2 and arg_298_1.bgmTxt_.text ~= "" then
						if arg_298_1.bgmTxt2_.text ~= "" then
							arg_298_1.bgmTxt_.text = arg_298_1.bgmTxt2_.text
						end

						arg_298_1.bgmTxt2_.text = var_301_2

						arg_298_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_298_1.bgmTxt_.text = var_301_2
						arg_298_1.bgmTxt2_.text = var_301_2
					end

					if arg_298_1.bgmTimer then
						arg_298_1.bgmTimer:Stop()

						arg_298_1.bgmTimer = nil
					end

					if arg_298_1.settingData.show_music_name == 1 then
						arg_298_1.musicController:SetSelectedState("show")
						arg_298_1.musicAnimator_:Play("open", 0, 0)

						if arg_298_1.settingData.music_time ~= 0 then
							arg_298_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_298_1.settingData.music_time), function()
								if arg_298_1 == nil or isNil(arg_298_1.bgmTxt_) then
									return
								end

								arg_298_1.musicController:SetSelectedState("hide")
								arg_298_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.3 < arg_298_1.time_ and arg_298_1.time_ <= 0.3 + arg_301_0 then
				arg_298_1:AudioAction("play", "music", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle.awb")

				local var_301_5 = manager.audio:GetAudioName("bgm_activity_4_0_story_quake_battle", "bgm_activity_4_0_story_quake_battle")

				if "" ~= "" then
					if arg_298_1.bgmTxt_.text ~= var_301_5 and arg_298_1.bgmTxt_.text ~= "" then
						if arg_298_1.bgmTxt2_.text ~= "" then
							arg_298_1.bgmTxt_.text = arg_298_1.bgmTxt2_.text
						end

						arg_298_1.bgmTxt2_.text = var_301_5

						arg_298_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_298_1.bgmTxt_.text = var_301_5
						arg_298_1.bgmTxt2_.text = var_301_5
					end

					if arg_298_1.bgmTimer then
						arg_298_1.bgmTimer:Stop()

						arg_298_1.bgmTimer = nil
					end

					if arg_298_1.settingData.show_music_name == 1 then
						arg_298_1.musicController:SetSelectedState("show")
						arg_298_1.musicAnimator_:Play("open", 0, 0)

						if arg_298_1.settingData.music_time ~= 0 then
							arg_298_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_298_1.settingData.music_time), function()
								if arg_298_1 == nil or isNil(arg_298_1.bgmTxt_) then
									return
								end

								arg_298_1.musicController:SetSelectedState("hide")
								arg_298_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_301_6 = 0
			local var_301_7 = 0.575

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_6 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[672].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_8 = arg_298_1:GetWordFromCfg(321161072)
				local var_301_9 = arg_298_1:FormatText(var_301_8.content)

				arg_298_1.text_.text = var_301_9

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_11 = 23 <= 0 and var_301_7 or var_301_7 * (utf8.len(var_301_9) / 23)

				if (23 <= 0 and var_301_7 or var_301_7 * (utf8.len(var_301_9) / 23)) > 0 and var_301_7 < var_301_11 then
					arg_298_1.talkMaxDuration = var_301_11

					if var_301_11 + var_301_6 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_11 + var_301_6
					end
				end

				arg_298_1.text_.text = var_301_9
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161072", "story_v_out_321161.awb") ~= 0 then
					local var_301_12 = manager.audio:GetVoiceLength("story_v_out_321161", "321161072", "story_v_out_321161.awb") / 1000

					if var_301_12 + var_301_6 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_12 + var_301_6
					end

					if var_301_8.prefab_name ~= "" and arg_298_1.actors_[var_301_8.prefab_name] ~= nil then
						local var_301_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_8.prefab_name].transform, "story_v_out_321161", "321161072", "story_v_out_321161.awb")

						arg_298_1:RecordAudio("321161072", var_301_13)
						arg_298_1:RecordAudio("321161072", var_301_13)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_321161", "321161072", "story_v_out_321161.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_321161", "321161072", "story_v_out_321161.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_14 = math.max(var_301_7, arg_298_1.talkMaxDuration)

			if var_301_6 <= arg_298_1.time_ and arg_298_1.time_ < var_301_6 + var_301_14 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_6) / var_301_14

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_6 + var_301_14 and arg_298_1.time_ < var_301_6 + var_301_14 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play321161073 = function(arg_304_0, arg_304_1)
		arg_304_1.time_ = 0
		arg_304_1.frameCnt_ = 0
		arg_304_1.state_ = "playing"
		arg_304_1.curTalkId_ = 321161073
		arg_304_1.duration_ = 6.8

		SetActive(arg_304_1.tipsGo_, false)

		function arg_304_1.onSingleLineFinish_()
			arg_304_1.onSingleLineUpdate_ = nil
			arg_304_1.onSingleLineFinish_ = nil
			arg_304_1.state_ = "waiting"
		end

		function arg_304_1.playNext_(arg_306_0)
			if arg_306_0 == 1 then
				arg_304_0:Play321161074(arg_304_1)
			end
		end

		function arg_304_1.onSingleLineUpdate_(arg_307_0)
			local var_307_9000

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				if arg_304_1.var_.effectjinglingdazuo then
					Object.Destroy(arg_304_1.var_.effectjinglingdazuo)

					arg_304_1.var_.effectjinglingdazuo = nil
				end
			end

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= 0 + arg_307_0 then
				local var_307_1 = arg_304_1.var_.effectbaozha1

				if not arg_304_1.var_.effectbaozha1 then
					var_307_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heibaishan"), manager.ui.mainCamera.transform)
					var_307_1.name = "baozha1"
					arg_304_1.var_.effectbaozha1 = var_307_1
				else
					var_307_1.transform:SetParent(var_307_9000)
				end

				var_307_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_307_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_307_3 = manager.ui.mainCamera.transform

			if 0.8 < arg_304_1.time_ and arg_304_1.time_ <= 0.8 + arg_307_0 then
				arg_304_1.var_.shakeOldPos = var_307_3.localPosition
			end

			local var_307_4 = 1

			if 0.8 <= arg_304_1.time_ and arg_304_1.time_ < 0.8 + var_307_4 then
				local var_307_5, var_307_6 = math.modf((arg_304_1.time_ - 0.8) / 0.066)

				var_307_3.localPosition = Vector3.New(var_307_6 * 0.13, var_307_6 * 0.13, var_307_6 * 0.13) + arg_304_1.var_.shakeOldPos
			end

			if arg_304_1.time_ >= 0.8 + var_307_4 and arg_304_1.time_ < 0.8 + var_307_4 + arg_307_0 then
				var_307_3.localPosition = arg_304_1.var_.shakeOldPos
			end

			local var_307_7 = 0

			if 0 < arg_304_1.time_ and arg_304_1.time_ <= var_307_7 + arg_307_0 then
				arg_304_1.allBtn_.enabled = false
			end

			if arg_304_1.time_ >= var_307_7 + 2 and arg_304_1.time_ < var_307_7 + 2 + arg_307_0 then
				arg_304_1.allBtn_.enabled = true
			end

			if 0.034000001847744 < arg_304_1.time_ and arg_304_1.time_ <= 0.034000001847744 + arg_307_0 then
				arg_304_1:AudioAction("stop", "effect", "se_story_1311", "se_story_1311_alarm", "")
			end

			if 0.034000001847744 < arg_304_1.time_ and arg_304_1.time_ <= 0.034000001847744 + arg_307_0 then
				arg_304_1:AudioAction("play", "effect", "se_story_140", "se_story_140_microphone", "")
			end

			if arg_304_1.frameCnt_ <= 1 then
				arg_304_1.dialog_:SetActive(false)
			end

			local var_307_10 = 1.8
			local var_307_11 = 1.275

			if 1.8 < arg_304_1.time_ and arg_304_1.time_ <= var_307_10 + arg_307_0 then
				arg_304_1.talkMaxDuration = 0

				arg_304_1.dialog_:SetActive(true)

				arg_304_1.dialogCg_.alpha = 0

				local var_307_12 = LeanTween.value(arg_304_1.dialog_, 0, 1, 0.3)

				var_307_12:setOnUpdate(LuaHelper.FloatAction(function(arg_308_0)
					arg_304_1.dialogCg_.alpha = arg_308_0
				end))
				var_307_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_304_1.dialog_)
					var_307_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_304_1.duration_ = arg_304_1.duration_ + 0.3

				SetActive(arg_304_1.leftNameGo_, false)

				arg_304_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_304_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_304_1:RecordName(arg_304_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_304_1.iconTrs_.gameObject, false)
				arg_304_1.callingController_:SetSelectedState("normal")

				local var_307_13 = arg_304_1:FormatText(arg_304_1:GetWordFromCfg(321161073).content)

				arg_304_1.text_.text = var_307_13

				LuaForUtil.ClearLinePrefixSymbol(arg_304_1.text_)

				local var_307_15 = 51 <= 0 and var_307_11 or var_307_11 * (utf8.len(var_307_13) / 51)

				if (51 <= 0 and var_307_11 or var_307_11 * (utf8.len(var_307_13) / 51)) > 0 and var_307_11 < var_307_15 then
					arg_304_1.talkMaxDuration = var_307_15
					var_307_10 = var_307_10 + 0.3

					if var_307_15 + var_307_10 > arg_304_1.duration_ then
						arg_304_1.duration_ = var_307_15 + var_307_10
					end
				end

				arg_304_1.text_.text = var_307_13
				arg_304_1.typewritter.percent = 0

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(false)
				arg_304_1:RecordContent(arg_304_1.text_.text)
			end

			local var_307_16 = var_307_10 + 0.3
			local var_307_17 = math.max(var_307_11, arg_304_1.talkMaxDuration)

			if var_307_10 + 0.3 <= arg_304_1.time_ and arg_304_1.time_ < var_307_16 + var_307_17 then
				arg_304_1.typewritter.percent = (arg_304_1.time_ - var_307_16) / var_307_17

				arg_304_1.typewritter:SetDirty()
			end

			if arg_304_1.time_ >= var_307_16 + var_307_17 and arg_304_1.time_ < var_307_16 + var_307_17 + arg_307_0 then
				arg_304_1.typewritter.percent = 1

				arg_304_1.typewritter:SetDirty()
				arg_304_1:ShowNextGo(true)
			end
		end

		arg_304_1.nodeConfigList_ = {}

		arg_304_1:InitPlayNodeList()
	end,
	Play321161074 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 321161074
		arg_310_1.duration_ = 6.17

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play321161075(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_9000

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.allBtn_.enabled = false
			end

			if arg_310_1.time_ >= 0 + 1.3 and arg_310_1.time_ < 0 + 1.3 + arg_313_0 then
				arg_310_1.allBtn_.enabled = true
			end

			local var_313_0 = manager.ui.mainCamera.transform

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.var_.shakeOldPos = var_313_0.localPosition
			end

			local var_313_1 = 1

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_1 then
				local var_313_2, var_313_3 = math.modf((arg_310_1.time_ - 0) / 0.066)

				var_313_0.localPosition = Vector3.New(var_313_3 * 0.13, var_313_3 * 0.13, var_313_3 * 0.13) + arg_310_1.var_.shakeOldPos
			end

			if arg_310_1.time_ >= 0 + var_313_1 and arg_310_1.time_ < 0 + var_313_1 + arg_313_0 then
				var_313_0.localPosition = arg_310_1.var_.shakeOldPos
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				if arg_310_1.var_.effect115 then
					Object.Destroy(arg_310_1.var_.effect115)

					arg_310_1.var_.effect115 = nil
				end
			end

			local var_313_5 = 0

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_5 + arg_313_0 then
				arg_310_1.mask_.enabled = true
				arg_310_1.mask_.raycastTarget = true

				arg_310_1:SetGaussion(false)
			end

			local var_313_6 = 0.333333333333333

			if var_313_5 <= arg_310_1.time_ and arg_310_1.time_ < var_313_5 + var_313_6 then
				local var_313_7 = Color.New(1, 1, 1)

				var_313_7.a = Mathf.Lerp(1, 0, (arg_310_1.time_ - var_313_5) / var_313_6)
				arg_310_1.mask_.color = var_313_7
			end

			if arg_310_1.time_ >= var_313_5 + var_313_6 and arg_310_1.time_ < var_313_5 + var_313_6 + arg_313_0 then
				local var_313_8 = Color.New(1, 1, 1)

				arg_310_1.mask_.enabled = false
				var_313_8.a = 0
				arg_310_1.mask_.color = var_313_8
			end

			local var_313_9 = 0.333333333333333

			if 0.333333333333333 < arg_310_1.time_ and arg_310_1.time_ <= var_313_9 + arg_313_0 then
				arg_310_1.mask_.enabled = true
				arg_310_1.mask_.raycastTarget = true

				arg_310_1:SetGaussion(false)
			end

			local var_313_10 = 0.333333333333333

			if var_313_9 <= arg_310_1.time_ and arg_310_1.time_ < var_313_9 + var_313_10 then
				local var_313_11 = Color.New(1, 1, 1)

				var_313_11.a = Mathf.Lerp(1, 0, (arg_310_1.time_ - var_313_9) / var_313_10)
				arg_310_1.mask_.color = var_313_11
			end

			if arg_310_1.time_ >= var_313_9 + var_313_10 and arg_310_1.time_ < var_313_9 + var_313_10 + arg_313_0 then
				local var_313_12 = Color.New(1, 1, 1)

				arg_310_1.mask_.enabled = false
				var_313_12.a = 0
				arg_310_1.mask_.color = var_313_12
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				if arg_310_1.var_.effect685 then
					Object.Destroy(arg_310_1.var_.effect685)

					arg_310_1.var_.effect685 = nil
				end
			end

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion02", "")
			end

			if 0.766666666666667 < arg_310_1.time_ and arg_310_1.time_ <= 0.766666666666667 + arg_313_0 then
				local var_313_15 = arg_310_1.var_.effect7892

				if not arg_310_1.var_.effect7892 then
					var_313_15 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_313_15.name = "7892"
					arg_310_1.var_.effect7892 = var_313_15
				else
					var_313_15.transform:SetParent(var_313_9000)
				end

				var_313_15.transform.localPosition = Vector3.New(0, -0.74, 0)
				var_313_15.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_313_17 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_313_0, iter_313_1 in ipairs((var_313_15.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_313_1.transform.localScale = Vector3.New(iter_313_1.transform.localScale.x / var_313_17 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_313_1.transform.localScale.y / var_313_17, iter_313_1.transform.localScale.z)
				end
			end

			if arg_310_1.frameCnt_ <= 1 then
				arg_310_1.dialog_:SetActive(false)
			end

			local var_313_19 = 1.16666666666667
			local var_313_20 = 1.425

			if 1.16666666666667 < arg_310_1.time_ and arg_310_1.time_ <= var_313_19 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0

				arg_310_1.dialog_:SetActive(true)

				arg_310_1.dialogCg_.alpha = 0

				local var_313_21 = LeanTween.value(arg_310_1.dialog_, 0, 1, 0.3)

				var_313_21:setOnUpdate(LuaHelper.FloatAction(function(arg_314_0)
					arg_310_1.dialogCg_.alpha = arg_314_0
				end))
				var_313_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_310_1.dialog_)
					var_313_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_310_1.duration_ = arg_310_1.duration_ + 0.3

				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_22 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(321161074).content)

				arg_310_1.text_.text = var_313_22

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_24 = 57 <= 0 and var_313_20 or var_313_20 * (utf8.len(var_313_22) / 57)

				if (57 <= 0 and var_313_20 or var_313_20 * (utf8.len(var_313_22) / 57)) > 0 and var_313_20 < var_313_24 then
					arg_310_1.talkMaxDuration = var_313_24
					var_313_19 = var_313_19 + 0.3

					if var_313_24 + var_313_19 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_24 + var_313_19
					end
				end

				arg_310_1.text_.text = var_313_22
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_25 = var_313_19 + 0.3
			local var_313_26 = math.max(var_313_20, arg_310_1.talkMaxDuration)

			if var_313_19 + 0.3 <= arg_310_1.time_ and arg_310_1.time_ < var_313_25 + var_313_26 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_25) / var_313_26

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_25 + var_313_26 and arg_310_1.time_ < var_313_25 + var_313_26 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play321161075 = function(arg_316_0, arg_316_1)
		arg_316_1.time_ = 0
		arg_316_1.frameCnt_ = 0
		arg_316_1.state_ = "playing"
		arg_316_1.curTalkId_ = 321161075
		arg_316_1.duration_ = 2.4

		local var_316_0 = {
			zh = 1.666,
			ja = 2.4
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
				arg_316_0:Play321161076(arg_316_1)
			end
		end

		function arg_316_1.onSingleLineUpdate_(arg_319_0)
			local var_319_0 = 0.225

			if 0 < arg_316_1.time_ and arg_316_1.time_ <= 0 + arg_319_0 then
				arg_316_1.talkMaxDuration = 0
				arg_316_1.dialogCg_.alpha = 1

				arg_316_1.dialog_:SetActive(true)
				SetActive(arg_316_1.leftNameGo_, true)

				arg_316_1.leftNameTxt_.text = arg_316_1:FormatText(StoryNameCfg[1167].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_316_1.leftNameTxt_.transform)

				arg_316_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_316_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_316_1:RecordName(arg_316_1.leftNameTxt_.text)
				SetActive(arg_316_1.iconTrs_.gameObject, true)
				arg_316_1.iconController_:SetSelectedState("hero")

				arg_316_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Indiaconsul")

				arg_316_1.callingController_:SetSelectedState("normal")

				arg_316_1.keyicon_.color = Color.New(1, 1, 1)
				arg_316_1.icon_.color = Color.New(1, 1, 1)

				local var_319_1 = arg_316_1:GetWordFromCfg(321161075)
				local var_319_2 = arg_316_1:FormatText(var_319_1.content)

				arg_316_1.text_.text = var_319_2

				LuaForUtil.ClearLinePrefixSymbol(arg_316_1.text_)

				local var_319_4 = 9 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 9)

				if (9 <= 0 and var_319_0 or var_319_0 * (utf8.len(var_319_2) / 9)) > 0 and var_319_0 < var_319_4 then
					arg_316_1.talkMaxDuration = var_319_4

					if var_319_4 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_4 + 0
					end
				end

				arg_316_1.text_.text = var_319_2
				arg_316_1.typewritter.percent = 0

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161075", "story_v_out_321161.awb") ~= 0 then
					local var_319_5 = manager.audio:GetVoiceLength("story_v_out_321161", "321161075", "story_v_out_321161.awb") / 1000

					if var_319_5 + 0 > arg_316_1.duration_ then
						arg_316_1.duration_ = var_319_5 + 0
					end

					if var_319_1.prefab_name ~= "" and arg_316_1.actors_[var_319_1.prefab_name] ~= nil then
						local var_319_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_316_1.actors_[var_319_1.prefab_name].transform, "story_v_out_321161", "321161075", "story_v_out_321161.awb")

						arg_316_1:RecordAudio("321161075", var_319_6)
						arg_316_1:RecordAudio("321161075", var_319_6)
					else
						arg_316_1:AudioAction("play", "voice", "story_v_out_321161", "321161075", "story_v_out_321161.awb")
					end

					arg_316_1:RecordHistoryTalkVoice("story_v_out_321161", "321161075", "story_v_out_321161.awb")
				end

				arg_316_1:RecordContent(arg_316_1.text_.text)
			end

			local var_319_7 = math.max(var_319_0, arg_316_1.talkMaxDuration)

			if 0 <= arg_316_1.time_ and arg_316_1.time_ < 0 + var_319_7 then
				arg_316_1.typewritter.percent = (arg_316_1.time_ - 0) / var_319_7

				arg_316_1.typewritter:SetDirty()
			end

			if arg_316_1.time_ >= 0 + var_319_7 and arg_316_1.time_ < 0 + var_319_7 + arg_319_0 then
				arg_316_1.typewritter.percent = 1

				arg_316_1.typewritter:SetDirty()
				arg_316_1:ShowNextGo(true)
			end
		end

		arg_316_1.nodeConfigList_ = {}

		arg_316_1:InitPlayNodeList()
	end,
	Play321161076 = function(arg_320_0, arg_320_1)
		arg_320_1.time_ = 0
		arg_320_1.frameCnt_ = 0
		arg_320_1.state_ = "playing"
		arg_320_1.curTalkId_ = 321161076
		arg_320_1.duration_ = 1.5

		local var_320_0 = {
			zh = 1.033333333332,
			ja = 1.5
		}
		local var_320_1 = manager.audio:GetLocalizationFlag()

		if var_320_0[var_320_1] ~= nil then
			arg_320_1.duration_ = var_320_0[var_320_1]
		end

		SetActive(arg_320_1.tipsGo_, false)

		function arg_320_1.onSingleLineFinish_()
			arg_320_1.onSingleLineUpdate_ = nil
			arg_320_1.onSingleLineFinish_ = nil
			arg_320_1.state_ = "waiting"
		end

		function arg_320_1.playNext_(arg_322_0)
			if arg_322_0 == 1 then
				arg_320_0:Play321161077(arg_320_1)
			end
		end

		function arg_320_1.onSingleLineUpdate_(arg_323_0)
			if 0 < arg_320_1.time_ and arg_320_1.time_ <= 0 + arg_323_0 then
				if arg_320_1.var_.effect7892 then
					Object.Destroy(arg_320_1.var_.effect7892)

					arg_320_1.var_.effect7892 = nil
				end
			end

			local var_323_1 = 0
			local var_323_2 = 0.125

			if 0 < arg_320_1.time_ and arg_320_1.time_ <= var_323_1 + arg_323_0 then
				arg_320_1.talkMaxDuration = 0
				arg_320_1.dialogCg_.alpha = 1

				arg_320_1.dialog_:SetActive(true)
				SetActive(arg_320_1.leftNameGo_, true)

				arg_320_1.leftNameTxt_.text = arg_320_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_320_1.leftNameTxt_.transform)

				arg_320_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_320_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_320_1:RecordName(arg_320_1.leftNameTxt_.text)
				SetActive(arg_320_1.iconTrs_.gameObject, true)
				arg_320_1.iconController_:SetSelectedState("hero")

				arg_320_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_320_1.callingController_:SetSelectedState("normal")

				arg_320_1.keyicon_.color = Color.New(1, 1, 1)
				arg_320_1.icon_.color = Color.New(1, 1, 1)

				local var_323_3 = arg_320_1:GetWordFromCfg(321161076)
				local var_323_4 = arg_320_1:FormatText(var_323_3.content)

				arg_320_1.text_.text = var_323_4

				LuaForUtil.ClearLinePrefixSymbol(arg_320_1.text_)

				local var_323_6 = 5 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_4) / 5)

				if (5 <= 0 and var_323_2 or var_323_2 * (utf8.len(var_323_4) / 5)) > 0 and var_323_2 < var_323_6 then
					arg_320_1.talkMaxDuration = var_323_6

					if var_323_6 + var_323_1 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_6 + var_323_1
					end
				end

				arg_320_1.text_.text = var_323_4
				arg_320_1.typewritter.percent = 0

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161076", "story_v_out_321161.awb") ~= 0 then
					local var_323_7 = manager.audio:GetVoiceLength("story_v_out_321161", "321161076", "story_v_out_321161.awb") / 1000

					if var_323_7 + var_323_1 > arg_320_1.duration_ then
						arg_320_1.duration_ = var_323_7 + var_323_1
					end

					if var_323_3.prefab_name ~= "" and arg_320_1.actors_[var_323_3.prefab_name] ~= nil then
						local var_323_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_320_1.actors_[var_323_3.prefab_name].transform, "story_v_out_321161", "321161076", "story_v_out_321161.awb")

						arg_320_1:RecordAudio("321161076", var_323_8)
						arg_320_1:RecordAudio("321161076", var_323_8)
					else
						arg_320_1:AudioAction("play", "voice", "story_v_out_321161", "321161076", "story_v_out_321161.awb")
					end

					arg_320_1:RecordHistoryTalkVoice("story_v_out_321161", "321161076", "story_v_out_321161.awb")
				end

				arg_320_1:RecordContent(arg_320_1.text_.text)
			end

			local var_323_9 = math.max(var_323_2, arg_320_1.talkMaxDuration)

			if var_323_1 <= arg_320_1.time_ and arg_320_1.time_ < var_323_1 + var_323_9 then
				arg_320_1.typewritter.percent = (arg_320_1.time_ - var_323_1) / var_323_9

				arg_320_1.typewritter:SetDirty()
			end

			if arg_320_1.time_ >= var_323_1 + var_323_9 and arg_320_1.time_ < var_323_1 + var_323_9 + arg_323_0 then
				arg_320_1.typewritter.percent = 1

				arg_320_1.typewritter:SetDirty()
				arg_320_1:ShowNextGo(true)
			end
		end

		arg_320_1.nodeConfigList_ = {}

		arg_320_1:InitPlayNodeList()
	end,
	Play321161077 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 321161077
		arg_324_1.duration_ = 9

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play321161078(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			if 2 < arg_324_1.time_ and arg_324_1.time_ <= 2 + arg_327_0 then
				local var_327_0 = arg_324_1.bgs_.L14f

				arg_324_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_327_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_327_1 = var_327_0:GetComponent("SpriteRenderer")

				if var_327_1 and var_327_1.sprite then
					local var_327_2 = 2 * (var_327_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_327_0.transform.localScale = Vector3.New(var_327_2 / var_327_1.sprite.bounds.size.y < var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x and var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x or var_327_2 / var_327_1.sprite.bounds.size.y, var_327_2 / var_327_1.sprite.bounds.size.y < var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x and var_327_2 * manager.ui.mainCameraCom_.aspect / var_327_1.sprite.bounds.size.x or var_327_2 / var_327_1.sprite.bounds.size.y, 0)
				end

				for iter_327_0, iter_327_1 in pairs(arg_324_1.bgs_) do
					if iter_327_0 ~= "L14f" then
						iter_327_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_327_3 = 4

			if 4 < arg_324_1.time_ and arg_324_1.time_ <= var_327_3 + arg_327_0 then
				arg_324_1.allBtn_.enabled = false
			end

			if arg_324_1.time_ >= var_327_3 + 0.3 and arg_324_1.time_ < var_327_3 + 0.3 + arg_327_0 then
				arg_324_1.allBtn_.enabled = true
			end

			local var_327_4 = 0

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= var_327_4 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_5 = 2

			if var_327_4 <= arg_324_1.time_ and arg_324_1.time_ < var_327_4 + var_327_5 then
				local var_327_6 = Color.New(0, 0, 0)

				var_327_6.a = Mathf.Lerp(0, 1, (arg_324_1.time_ - var_327_4) / var_327_5)
				arg_324_1.mask_.color = var_327_6
			end

			if arg_324_1.time_ >= var_327_4 + var_327_5 and arg_324_1.time_ < var_327_4 + var_327_5 + arg_327_0 then
				local var_327_7 = Color.New(0, 0, 0)

				var_327_7.a = 1
				arg_324_1.mask_.color = var_327_7
			end

			local var_327_8 = 2

			if 2 < arg_324_1.time_ and arg_324_1.time_ <= var_327_8 + arg_327_0 then
				arg_324_1.mask_.enabled = true
				arg_324_1.mask_.raycastTarget = true

				arg_324_1:SetGaussion(false)
			end

			local var_327_9 = 2

			if var_327_8 <= arg_324_1.time_ and arg_324_1.time_ < var_327_8 + var_327_9 then
				local var_327_10 = Color.New(0, 0, 0)

				var_327_10.a = Mathf.Lerp(1, 0, (arg_324_1.time_ - var_327_8) / var_327_9)
				arg_324_1.mask_.color = var_327_10
			end

			if arg_324_1.time_ >= var_327_8 + var_327_9 and arg_324_1.time_ < var_327_8 + var_327_9 + arg_327_0 then
				local var_327_11 = Color.New(0, 0, 0)

				arg_324_1.mask_.enabled = false
				var_327_11.a = 0
				arg_324_1.mask_.color = var_327_11
			end

			local var_327_12 = arg_324_1.actors_["10104ui_story"].transform

			if 1.96599999815226 < arg_324_1.time_ and arg_324_1.time_ <= 1.96599999815226 + arg_327_0 then
				arg_324_1.var_.moveOldPos10104ui_story = var_327_12.localPosition
			end

			local var_327_13 = 0.001

			if 1.96599999815226 <= arg_324_1.time_ and arg_324_1.time_ < 1.96599999815226 + var_327_13 then
				var_327_12.localPosition = Vector3.Lerp(arg_324_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_324_1.time_ - 1.96599999815226) / var_327_13)
				var_327_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_12.position).x, (manager.ui.mainCamera.transform.position - var_327_12.position).y, (manager.ui.mainCamera.transform.position - var_327_12.position).z)
				var_327_12.localEulerAngles.z = 0
				var_327_12.localEulerAngles.x = 0
				var_327_12.localEulerAngles = var_327_12.localEulerAngles
			end

			if arg_324_1.time_ >= 1.96599999815226 + var_327_13 and arg_324_1.time_ < 1.96599999815226 + var_327_13 + arg_327_0 then
				var_327_12.localPosition = Vector3.New(0, 100, 0)
				var_327_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_327_12.position).x, (manager.ui.mainCamera.transform.position - var_327_12.position).y, (manager.ui.mainCamera.transform.position - var_327_12.position).z)
				var_327_12.localEulerAngles.z = 0
				var_327_12.localEulerAngles.x = 0
				var_327_12.localEulerAngles = var_327_12.localEulerAngles
			end

			local var_327_14 = arg_324_1.actors_["10104ui_story"]

			if 1.96599999815226 < arg_324_1.time_ and arg_324_1.time_ <= 1.96599999815226 + arg_327_0 and not isNil(var_327_14) and arg_324_1.var_.characterEffect10104ui_story == nil then
				arg_324_1.var_.characterEffect10104ui_story = var_327_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_327_15 = 0.034000001847744

			if 1.96599999815226 <= arg_324_1.time_ and arg_324_1.time_ < 1.96599999815226 + var_327_15 and not isNil(var_327_14) then
				if arg_324_1.var_.characterEffect10104ui_story and not isNil(var_327_14) then
					arg_324_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_324_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_324_1.time_ - 1.96599999815226) / var_327_15)
				end
			end

			if arg_324_1.time_ >= 1.96599999815226 + var_327_15 and arg_324_1.time_ < 1.96599999815226 + var_327_15 + arg_327_0 and not isNil(var_327_14) and arg_324_1.var_.characterEffect10104ui_story then
				arg_324_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_324_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 4.3 < arg_324_1.time_ and arg_324_1.time_ <= 4.3 + arg_327_0 then
				arg_324_1:AudioAction("play", "effect", "se_story_140", "se_story_140_monster", "")
			end

			if arg_324_1.frameCnt_ <= 1 then
				arg_324_1.dialog_:SetActive(false)
			end

			local var_327_17 = 4
			local var_327_18 = 1.1

			if 4 < arg_324_1.time_ and arg_324_1.time_ <= var_327_17 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0

				arg_324_1.dialog_:SetActive(true)

				arg_324_1.dialogCg_.alpha = 0

				local var_327_19 = LeanTween.value(arg_324_1.dialog_, 0, 1, 0.3)

				var_327_19:setOnUpdate(LuaHelper.FloatAction(function(arg_328_0)
					arg_324_1.dialogCg_.alpha = arg_328_0
				end))
				var_327_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_324_1.dialog_)
					var_327_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_324_1.duration_ = arg_324_1.duration_ + 0.3

				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_20 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(321161077).content)

				arg_324_1.text_.text = var_327_20

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_22 = 44 <= 0 and var_327_18 or var_327_18 * (utf8.len(var_327_20) / 44)

				if (44 <= 0 and var_327_18 or var_327_18 * (utf8.len(var_327_20) / 44)) > 0 and var_327_18 < var_327_22 then
					arg_324_1.talkMaxDuration = var_327_22
					var_327_17 = var_327_17 + 0.3

					if var_327_22 + var_327_17 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_22 + var_327_17
					end
				end

				arg_324_1.text_.text = var_327_20
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_23 = var_327_17 + 0.3
			local var_327_24 = math.max(var_327_18, arg_324_1.talkMaxDuration)

			if var_327_17 + 0.3 <= arg_324_1.time_ and arg_324_1.time_ < var_327_23 + var_327_24 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - var_327_23) / var_327_24

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= var_327_23 + var_327_24 and arg_324_1.time_ < var_327_23 + var_327_24 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_324_1:InitPlayNodeList()
	end,
	Play321161078 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 321161078
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play321161079(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			if 0.034000001847744 < arg_330_1.time_ and arg_330_1.time_ <= 0.034000001847744 + arg_333_0 then
				arg_330_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_battle monster", "")
			end

			local var_333_1 = 0
			local var_333_2 = 0.8

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= var_333_1 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_3 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(321161078).content)

				arg_330_1.text_.text = var_333_3

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_5 = 32 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 32)

				if (32 <= 0 and var_333_2 or var_333_2 * (utf8.len(var_333_3) / 32)) > 0 and var_333_2 < var_333_5 then
					arg_330_1.talkMaxDuration = var_333_5

					if var_333_5 + var_333_1 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_5 + var_333_1
					end
				end

				arg_330_1.text_.text = var_333_3
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_6 = math.max(var_333_2, arg_330_1.talkMaxDuration)

			if var_333_1 <= arg_330_1.time_ and arg_330_1.time_ < var_333_1 + var_333_6 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - var_333_1) / var_333_6

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= var_333_1 + var_333_6 and arg_330_1.time_ < var_333_1 + var_333_6 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play321161079 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 321161079
		arg_334_1.duration_ = 4.67

		local var_334_0 = {
			zh = 3.533,
			ja = 4.666
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play321161080(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos10104ui_story = arg_334_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_337_0 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_0 then
				arg_334_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10104ui_story, Vector3.New(0.02, -1.12, -5.99), (arg_334_1.time_ - 0) / var_337_0)
				arg_334_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10104ui_story"].transform.position).z)
				arg_334_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["10104ui_story"].transform.localEulerAngles = arg_334_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_0 and arg_334_1.time_ < 0 + var_337_0 + arg_337_0 then
				arg_334_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0.02, -1.12, -5.99)
				arg_334_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_334_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_334_1.actors_["10104ui_story"].transform.position).z)
				arg_334_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_334_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_334_1.actors_["10104ui_story"].transform.localEulerAngles = arg_334_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_337_1 = arg_334_1.actors_["10104ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect10104ui_story == nil then
				arg_334_1.var_.characterEffect10104ui_story = var_337_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_2 = 0.200000002980232

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_2 and not isNil(var_337_1) then
				if arg_334_1.var_.characterEffect10104ui_story and not isNil(var_337_1) then
					arg_334_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_2 and arg_334_1.time_ < 0 + var_337_2 + arg_337_0 and not isNil(var_337_1) and arg_334_1.var_.characterEffect10104ui_story then
				arg_334_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/story10104/story10104action/10104action7_1")
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1:PlayTimeline("10104ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0.034000001847744 < arg_334_1.time_ and arg_334_1.time_ <= 0.034000001847744 + arg_337_0 then
				arg_334_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_surround", "")
			end

			local var_337_5 = 0
			local var_337_6 = 0.425

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0
				arg_334_1.dialogCg_.alpha = 1

				arg_334_1.dialog_:SetActive(true)
				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_7 = arg_334_1:GetWordFromCfg(321161079)
				local var_337_8 = arg_334_1:FormatText(var_337_7.content)

				arg_334_1.text_.text = var_337_8

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_10 = 17 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_8) / 17)

				if (17 <= 0 and var_337_6 or var_337_6 * (utf8.len(var_337_8) / 17)) > 0 and var_337_6 < var_337_10 then
					arg_334_1.talkMaxDuration = var_337_10

					if var_337_10 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_10 + var_337_5
					end
				end

				arg_334_1.text_.text = var_337_8
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161079", "story_v_out_321161.awb") ~= 0 then
					local var_337_11 = manager.audio:GetVoiceLength("story_v_out_321161", "321161079", "story_v_out_321161.awb") / 1000

					if var_337_11 + var_337_5 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_11 + var_337_5
					end

					if var_337_7.prefab_name ~= "" and arg_334_1.actors_[var_337_7.prefab_name] ~= nil then
						local var_337_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_7.prefab_name].transform, "story_v_out_321161", "321161079", "story_v_out_321161.awb")

						arg_334_1:RecordAudio("321161079", var_337_12)
						arg_334_1:RecordAudio("321161079", var_337_12)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_321161", "321161079", "story_v_out_321161.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_321161", "321161079", "story_v_out_321161.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_13 = math.max(var_337_6, arg_334_1.talkMaxDuration)

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_13 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_5) / var_337_13

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_5 + var_337_13 and arg_334_1.time_ < var_337_5 + var_337_13 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
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
	Play321161080 = function(arg_338_0, arg_338_1)
		arg_338_1.time_ = 0
		arg_338_1.frameCnt_ = 0
		arg_338_1.state_ = "playing"
		arg_338_1.curTalkId_ = 321161080
		arg_338_1.duration_ = 5

		SetActive(arg_338_1.tipsGo_, false)

		function arg_338_1.onSingleLineFinish_()
			arg_338_1.onSingleLineUpdate_ = nil
			arg_338_1.onSingleLineFinish_ = nil
			arg_338_1.state_ = "waiting"
		end

		function arg_338_1.playNext_(arg_340_0)
			if arg_340_0 == 1 then
				arg_338_0:Play321161081(arg_338_1)
			end
		end

		function arg_338_1.onSingleLineUpdate_(arg_341_0)
			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 then
				arg_338_1.var_.moveOldPos10104ui_story = arg_338_1.actors_["10104ui_story"].transform.localPosition
			end

			local var_341_0 = 0.001

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_0 then
				arg_338_1.actors_["10104ui_story"].transform.localPosition = Vector3.Lerp(arg_338_1.var_.moveOldPos10104ui_story, Vector3.New(0, 100, 0), (arg_338_1.time_ - 0) / var_341_0)
				arg_338_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["10104ui_story"].transform.position).z)
				arg_338_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["10104ui_story"].transform.localEulerAngles = arg_338_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			if arg_338_1.time_ >= 0 + var_341_0 and arg_338_1.time_ < 0 + var_341_0 + arg_341_0 then
				arg_338_1.actors_["10104ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_338_1.actors_["10104ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_338_1.actors_["10104ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["10104ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_338_1.actors_["10104ui_story"].transform.position).z)
				arg_338_1.actors_["10104ui_story"].transform.localEulerAngles.z = 0
				arg_338_1.actors_["10104ui_story"].transform.localEulerAngles.x = 0
				arg_338_1.actors_["10104ui_story"].transform.localEulerAngles = arg_338_1.actors_["10104ui_story"].transform.localEulerAngles
			end

			local var_341_1 = arg_338_1.actors_["10104ui_story"]

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= 0 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect10104ui_story == nil then
				arg_338_1.var_.characterEffect10104ui_story = var_341_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_341_2 = 0.200000002980232

			if 0 <= arg_338_1.time_ and arg_338_1.time_ < 0 + var_341_2 and not isNil(var_341_1) then
				if arg_338_1.var_.characterEffect10104ui_story and not isNil(var_341_1) then
					arg_338_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_338_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_338_1.time_ - 0) / var_341_2)
				end
			end

			if arg_338_1.time_ >= 0 + var_341_2 and arg_338_1.time_ < 0 + var_341_2 + arg_341_0 and not isNil(var_341_1) and arg_338_1.var_.characterEffect10104ui_story then
				arg_338_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_338_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			if 1.36666666666667 < arg_338_1.time_ and arg_338_1.time_ <= 1.36666666666667 + arg_341_0 then
				arg_338_1:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_whoosh", "")
			end

			local var_341_4 = 0
			local var_341_5 = 1.55

			if 0 < arg_338_1.time_ and arg_338_1.time_ <= var_341_4 + arg_341_0 then
				arg_338_1.talkMaxDuration = 0
				arg_338_1.dialogCg_.alpha = 1

				arg_338_1.dialog_:SetActive(true)
				SetActive(arg_338_1.leftNameGo_, false)

				arg_338_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_338_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_338_1:RecordName(arg_338_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_338_1.iconTrs_.gameObject, false)
				arg_338_1.callingController_:SetSelectedState("normal")

				local var_341_6 = arg_338_1:FormatText(arg_338_1:GetWordFromCfg(321161080).content)

				arg_338_1.text_.text = var_341_6

				LuaForUtil.ClearLinePrefixSymbol(arg_338_1.text_)

				local var_341_8 = 62 <= 0 and var_341_5 or var_341_5 * (utf8.len(var_341_6) / 62)

				if (62 <= 0 and var_341_5 or var_341_5 * (utf8.len(var_341_6) / 62)) > 0 and var_341_5 < var_341_8 then
					arg_338_1.talkMaxDuration = var_341_8

					if var_341_8 + var_341_4 > arg_338_1.duration_ then
						arg_338_1.duration_ = var_341_8 + var_341_4
					end
				end

				arg_338_1.text_.text = var_341_6
				arg_338_1.typewritter.percent = 0

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(false)
				arg_338_1:RecordContent(arg_338_1.text_.text)
			end

			local var_341_9 = math.max(var_341_5, arg_338_1.talkMaxDuration)

			if var_341_4 <= arg_338_1.time_ and arg_338_1.time_ < var_341_4 + var_341_9 then
				arg_338_1.typewritter.percent = (arg_338_1.time_ - var_341_4) / var_341_9

				arg_338_1.typewritter:SetDirty()
			end

			if arg_338_1.time_ >= var_341_4 + var_341_9 and arg_338_1.time_ < var_341_4 + var_341_9 + arg_341_0 then
				arg_338_1.typewritter.percent = 1

				arg_338_1.typewritter:SetDirty()
				arg_338_1:ShowNextGo(true)
			end
		end

		arg_338_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10104ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_338_1:InitPlayNodeList()
	end,
	Play321161081 = function(arg_342_0, arg_342_1)
		arg_342_1.time_ = 0
		arg_342_1.frameCnt_ = 0
		arg_342_1.state_ = "playing"
		arg_342_1.curTalkId_ = 321161081
		arg_342_1.duration_ = 5

		SetActive(arg_342_1.tipsGo_, false)

		function arg_342_1.onSingleLineFinish_()
			arg_342_1.onSingleLineUpdate_ = nil
			arg_342_1.onSingleLineFinish_ = nil
			arg_342_1.state_ = "waiting"
		end

		function arg_342_1.playNext_(arg_344_0)
			if arg_344_0 == 1 then
				arg_342_0:Play321161082(arg_342_1)
			end
		end

		function arg_342_1.onSingleLineUpdate_(arg_345_0)
			local var_345_0 = 0.05

			if 0 < arg_342_1.time_ and arg_342_1.time_ <= 0 + arg_345_0 then
				arg_342_1.talkMaxDuration = 0
				arg_342_1.dialogCg_.alpha = 1

				arg_342_1.dialog_:SetActive(true)
				SetActive(arg_342_1.leftNameGo_, true)

				arg_342_1.leftNameTxt_.text = arg_342_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_342_1.leftNameTxt_.transform)

				arg_342_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_342_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_342_1:RecordName(arg_342_1.leftNameTxt_.text)
				SetActive(arg_342_1.iconTrs_.gameObject, true)
				arg_342_1.iconController_:SetSelectedState("hero")

				arg_342_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_342_1.callingController_:SetSelectedState("normal")

				arg_342_1.keyicon_.color = Color.New(1, 1, 1)
				arg_342_1.icon_.color = Color.New(1, 1, 1)

				local var_345_1 = arg_342_1:FormatText(arg_342_1:GetWordFromCfg(321161081).content)

				arg_342_1.text_.text = var_345_1

				LuaForUtil.ClearLinePrefixSymbol(arg_342_1.text_)

				local var_345_3 = 2 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 2)

				if (2 <= 0 and var_345_0 or var_345_0 * (utf8.len(var_345_1) / 2)) > 0 and var_345_0 < var_345_3 then
					arg_342_1.talkMaxDuration = var_345_3

					if var_345_3 + 0 > arg_342_1.duration_ then
						arg_342_1.duration_ = var_345_3 + 0
					end
				end

				arg_342_1.text_.text = var_345_1
				arg_342_1.typewritter.percent = 0

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(false)
				arg_342_1:RecordContent(arg_342_1.text_.text)
			end

			local var_345_4 = math.max(var_345_0, arg_342_1.talkMaxDuration)

			if 0 <= arg_342_1.time_ and arg_342_1.time_ < 0 + var_345_4 then
				arg_342_1.typewritter.percent = (arg_342_1.time_ - 0) / var_345_4

				arg_342_1.typewritter:SetDirty()
			end

			if arg_342_1.time_ >= 0 + var_345_4 and arg_342_1.time_ < 0 + var_345_4 + arg_345_0 then
				arg_342_1.typewritter.percent = 1

				arg_342_1.typewritter:SetDirty()
				arg_342_1:ShowNextGo(true)
			end
		end

		arg_342_1.nodeConfigList_ = {}

		arg_342_1:InitPlayNodeList()
	end,
	Play321161082 = function(arg_346_0, arg_346_1)
		arg_346_1.time_ = 0
		arg_346_1.frameCnt_ = 0
		arg_346_1.state_ = "playing"
		arg_346_1.curTalkId_ = 321161082
		arg_346_1.duration_ = 5.5

		SetActive(arg_346_1.tipsGo_, false)

		function arg_346_1.onSingleLineFinish_()
			arg_346_1.onSingleLineUpdate_ = nil
			arg_346_1.onSingleLineFinish_ = nil
			arg_346_1.state_ = "waiting"
		end

		function arg_346_1.playNext_(arg_348_0)
			if arg_348_0 == 1 then
				arg_346_0:Play321161083(arg_346_1)
			end
		end

		function arg_346_1.onSingleLineUpdate_(arg_349_0)
			local var_349_9000

			if arg_346_1.bgs_.MS2105 == nil then
				local var_349_0 = Object.Instantiate(arg_346_1.paintGo_)

				var_349_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2105")
				var_349_0.name = "MS2105"
				var_349_0.transform.parent = arg_346_1.stage_.transform
				var_349_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_346_1.bgs_.MS2105 = var_349_0
			end

			if 0.5 < arg_346_1.time_ and arg_346_1.time_ <= 0.5 + arg_349_0 then
				local var_349_1 = arg_346_1.bgs_.MS2105

				arg_346_1.bgs_.MS2105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_349_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_349_2 = var_349_1:GetComponent("SpriteRenderer")

				if var_349_2 and var_349_2.sprite then
					local var_349_3 = 2 * (var_349_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_349_1.transform.localScale = Vector3.New(var_349_3 / var_349_2.sprite.bounds.size.y < var_349_3 * manager.ui.mainCameraCom_.aspect / var_349_2.sprite.bounds.size.x and var_349_3 * manager.ui.mainCameraCom_.aspect / var_349_2.sprite.bounds.size.x or var_349_3 / var_349_2.sprite.bounds.size.y, var_349_3 / var_349_2.sprite.bounds.size.y < var_349_3 * manager.ui.mainCameraCom_.aspect / var_349_2.sprite.bounds.size.x and var_349_3 * manager.ui.mainCameraCom_.aspect / var_349_2.sprite.bounds.size.x or var_349_3 / var_349_2.sprite.bounds.size.y, 0)
				end

				for iter_349_0, iter_349_1 in pairs(arg_346_1.bgs_) do
					if iter_349_0 ~= "MS2105" then
						iter_349_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_349_4 = 0

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_4 + arg_349_0 then
				arg_346_1.allBtn_.enabled = false
			end

			if arg_346_1.time_ >= var_349_4 + 0.5 and arg_346_1.time_ < var_349_4 + 0.5 + arg_349_0 then
				arg_346_1.allBtn_.enabled = true
			end

			local var_349_5 = 0

			if 0 < arg_346_1.time_ and arg_346_1.time_ <= var_349_5 + arg_349_0 then
				arg_346_1.mask_.enabled = true
				arg_346_1.mask_.raycastTarget = true

				arg_346_1:SetGaussion(false)
			end

			local var_349_6 = 1.03333333333333

			if var_349_5 <= arg_346_1.time_ and arg_346_1.time_ < var_349_5 + var_349_6 then
				local var_349_7 = Color.New(1, 1, 1)

				var_349_7.a = Mathf.Lerp(1, 0, (arg_346_1.time_ - var_349_5) / var_349_6)
				arg_346_1.mask_.color = var_349_7
			end

			if arg_346_1.time_ >= var_349_5 + var_349_6 and arg_346_1.time_ < var_349_5 + var_349_6 + arg_349_0 then
				local var_349_8 = Color.New(1, 1, 1)

				arg_346_1.mask_.enabled = false
				var_349_8.a = 0
				arg_346_1.mask_.color = var_349_8
			end

			if 0.5 < arg_346_1.time_ and arg_346_1.time_ <= 0.5 + arg_349_0 then
				local var_349_9 = arg_346_1.var_.effectluobona1

				if not arg_346_1.var_.effectluobona1 then
					var_349_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_suduxian02_in_keep"), manager.ui.mainCamera.transform)
					var_349_9.name = "luobona1"
					arg_346_1.var_.effectluobona1 = var_349_9
				else
					var_349_9.transform:SetParent(var_349_9000)
				end

				var_349_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_349_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_349_11 = arg_346_1.bgs_.MS2105.transform

			if 0.5 < arg_346_1.time_ and arg_346_1.time_ <= 0.5 + arg_349_0 then
				arg_346_1.var_.moveOldPosMS2105 = var_349_11.localPosition
			end

			local var_349_12 = 0.1

			if 0.5 <= arg_346_1.time_ and arg_346_1.time_ < 0.5 + var_349_12 then
				var_349_11.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPosMS2105, Vector3.New(0, 0, -5), (arg_346_1.time_ - 0.5) / var_349_12)
			end

			if arg_346_1.time_ >= 0.5 + var_349_12 and arg_346_1.time_ < 0.5 + var_349_12 + arg_349_0 then
				var_349_11.localPosition = Vector3.New(0, 0, -5)
			end

			local var_349_13 = arg_346_1.bgs_.MS2105.transform

			if 0.6 < arg_346_1.time_ and arg_346_1.time_ <= 0.6 + arg_349_0 then
				arg_346_1.var_.moveOldPosMS2105 = var_349_13.localPosition
			end

			local var_349_14 = 0.25

			if 0.6 <= arg_346_1.time_ and arg_346_1.time_ < 0.6 + var_349_14 then
				var_349_13.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPosMS2105, Vector3.New(0, 1, 9), (arg_346_1.time_ - 0.6) / var_349_14)
			end

			if arg_346_1.time_ >= 0.6 + var_349_14 and arg_346_1.time_ < 0.6 + var_349_14 + arg_349_0 then
				var_349_13.localPosition = Vector3.New(0, 1, 9)
			end

			local var_349_15 = arg_346_1.bgs_.MS2105.transform

			if 0.85 < arg_346_1.time_ and arg_346_1.time_ <= 0.85 + arg_349_0 then
				arg_346_1.var_.moveOldPosMS2105 = var_349_15.localPosition
			end

			local var_349_16 = 4

			if 0.85 <= arg_346_1.time_ and arg_346_1.time_ < 0.85 + var_349_16 then
				var_349_15.localPosition = Vector3.Lerp(arg_346_1.var_.moveOldPosMS2105, Vector3.New(0, 1, 9.5), (arg_346_1.time_ - 0.85) / var_349_16)
			end

			if arg_346_1.time_ >= 0.85 + var_349_16 and arg_346_1.time_ < 0.85 + var_349_16 + arg_349_0 then
				var_349_15.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 0.4 < arg_346_1.time_ and arg_346_1.time_ <= 0.4 + arg_349_0 then
				arg_346_1:AudioAction("play", "effect", "se_story_140", "se_story_140_attack", "")
			end

			local var_349_18 = 1.1

			if 1.1 < arg_346_1.time_ and arg_346_1.time_ <= var_349_18 + arg_349_0 then
				arg_346_1.allBtn_.enabled = false
			end

			if arg_346_1.time_ >= var_349_18 + 2.16666666666667 and arg_346_1.time_ < var_349_18 + 2.16666666666667 + arg_349_0 then
				arg_346_1.allBtn_.enabled = true
			end

			if arg_346_1.frameCnt_ <= 1 then
				arg_346_1.dialog_:SetActive(false)
			end

			local var_349_19 = 1.8
			local var_349_20 = 0.225

			if 1.8 < arg_346_1.time_ and arg_346_1.time_ <= var_349_19 + arg_349_0 then
				arg_346_1.talkMaxDuration = 0

				arg_346_1.dialog_:SetActive(true)

				arg_346_1.dialogCg_.alpha = 0

				local var_349_21 = LeanTween.value(arg_346_1.dialog_, 0, 1, 0.3)

				var_349_21:setOnUpdate(LuaHelper.FloatAction(function(arg_350_0)
					arg_346_1.dialogCg_.alpha = arg_350_0
				end))
				var_349_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_346_1.dialog_)
					var_349_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_346_1.duration_ = arg_346_1.duration_ + 0.3

				SetActive(arg_346_1.leftNameGo_, true)

				arg_346_1.leftNameTxt_.text = arg_346_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_346_1.leftNameTxt_.transform)

				arg_346_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_346_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_346_1:RecordName(arg_346_1.leftNameTxt_.text)
				SetActive(arg_346_1.iconTrs_.gameObject, false)
				arg_346_1.callingController_:SetSelectedState("normal")

				local var_349_22 = arg_346_1:GetWordFromCfg(321161082)
				local var_349_23 = arg_346_1:FormatText(var_349_22.content)

				arg_346_1.text_.text = var_349_23

				LuaForUtil.ClearLinePrefixSymbol(arg_346_1.text_)

				local var_349_25 = 9 <= 0 and var_349_20 or var_349_20 * (utf8.len(var_349_23) / 9)

				if (9 <= 0 and var_349_20 or var_349_20 * (utf8.len(var_349_23) / 9)) > 0 and var_349_20 < var_349_25 then
					arg_346_1.talkMaxDuration = var_349_25
					var_349_19 = var_349_19 + 0.3

					if var_349_25 + var_349_19 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_25 + var_349_19
					end
				end

				arg_346_1.text_.text = var_349_23
				arg_346_1.typewritter.percent = 0

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161082", "story_v_out_321161.awb") ~= 0 then
					local var_349_26 = manager.audio:GetVoiceLength("story_v_out_321161", "321161082", "story_v_out_321161.awb") / 1000

					if var_349_26 + var_349_19 > arg_346_1.duration_ then
						arg_346_1.duration_ = var_349_26 + var_349_19
					end

					if var_349_22.prefab_name ~= "" and arg_346_1.actors_[var_349_22.prefab_name] ~= nil then
						local var_349_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_346_1.actors_[var_349_22.prefab_name].transform, "story_v_out_321161", "321161082", "story_v_out_321161.awb")

						arg_346_1:RecordAudio("321161082", var_349_27)
						arg_346_1:RecordAudio("321161082", var_349_27)
					else
						arg_346_1:AudioAction("play", "voice", "story_v_out_321161", "321161082", "story_v_out_321161.awb")
					end

					arg_346_1:RecordHistoryTalkVoice("story_v_out_321161", "321161082", "story_v_out_321161.awb")
				end

				arg_346_1:RecordContent(arg_346_1.text_.text)
			end

			local var_349_28 = var_349_19 + 0.3
			local var_349_29 = math.max(var_349_20, arg_346_1.talkMaxDuration)

			if var_349_19 + 0.3 <= arg_346_1.time_ and arg_346_1.time_ < var_349_28 + var_349_29 then
				arg_346_1.typewritter.percent = (arg_346_1.time_ - var_349_28) / var_349_29

				arg_346_1.typewritter:SetDirty()
			end

			if arg_346_1.time_ >= var_349_28 + var_349_29 and arg_346_1.time_ < var_349_28 + var_349_29 + arg_349_0 then
				arg_346_1.typewritter.percent = 1

				arg_346_1.typewritter:SetDirty()
				arg_346_1:ShowNextGo(true)
			end
		end

		arg_346_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.25,
				className = "StoryMoveNode",
				startTime = 0.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4,
				className = "StoryMoveNode",
				startTime = 0.85,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_346_1:InitPlayNodeList()
	end,
	Play321161083 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 321161083
		arg_352_1.duration_ = 5

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play321161084(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			if 0.034000001847744 < arg_352_1.time_ and arg_352_1.time_ <= 0.034000001847744 + arg_355_0 then
				arg_352_1:AudioAction("play", "effect", "se_story_140", "se_story_140_monster02", "")
			end

			local var_355_1 = 0
			local var_355_2 = 1.275

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= var_355_1 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, false)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_3 = arg_352_1:FormatText(arg_352_1:GetWordFromCfg(321161083).content)

				arg_352_1.text_.text = var_355_3

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_5 = 51 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 51)

				if (51 <= 0 and var_355_2 or var_355_2 * (utf8.len(var_355_3) / 51)) > 0 and var_355_2 < var_355_5 then
					arg_352_1.talkMaxDuration = var_355_5

					if var_355_5 + var_355_1 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + var_355_1
					end
				end

				arg_352_1.text_.text = var_355_3
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)
				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_6 = math.max(var_355_2, arg_352_1.talkMaxDuration)

			if var_355_1 <= arg_352_1.time_ and arg_352_1.time_ < var_355_1 + var_355_6 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - var_355_1) / var_355_6

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= var_355_1 + var_355_6 and arg_352_1.time_ < var_355_1 + var_355_6 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play321161084 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 321161084
		arg_356_1.duration_ = 5.83

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play321161085(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.var_.moveOldPosMS2105 = arg_356_1.bgs_.MS2105.transform.localPosition
			end

			local var_359_0 = 0.001

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_0 then
				arg_356_1.bgs_.MS2105.transform.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPosMS2105, Vector3.New(0, 1, 10), (arg_356_1.time_ - 0) / var_359_0)
			end

			if arg_356_1.time_ >= 0 + var_359_0 and arg_356_1.time_ < 0 + var_359_0 + arg_359_0 then
				arg_356_1.bgs_.MS2105.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_359_1 = arg_356_1.bgs_.MS2105.transform

			if 0.0166666666666667 < arg_356_1.time_ and arg_356_1.time_ <= 0.0166666666666667 + arg_359_0 then
				arg_356_1.var_.moveOldPosMS2105 = var_359_1.localPosition
			end

			local var_359_2 = 1.18333333333333

			if 0.0166666666666667 <= arg_356_1.time_ and arg_356_1.time_ < 0.0166666666666667 + var_359_2 then
				var_359_1.localPosition = Vector3.Lerp(arg_356_1.var_.moveOldPosMS2105, Vector3.New(0, 1, 8.16), (arg_356_1.time_ - 0.0166666666666667) / var_359_2)
			end

			if arg_356_1.time_ >= 0.0166666666666667 + var_359_2 and arg_356_1.time_ < 0.0166666666666667 + var_359_2 + arg_359_0 then
				var_359_1.localPosition = Vector3.New(0, 1, 8.16)
			end

			local var_359_3 = 0

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= var_359_3 + arg_359_0 then
				arg_356_1.allBtn_.enabled = false
			end

			if arg_356_1.time_ >= var_359_3 + 1.2 and arg_356_1.time_ < var_359_3 + 1.2 + arg_359_0 then
				arg_356_1.allBtn_.enabled = true
			end

			if 0.983333333332 < arg_356_1.time_ and arg_356_1.time_ <= 0.983333333332 + arg_359_0 then
				arg_356_1:AudioAction("play", "effect", "se_story_140", "se_story_140_gun04", "")
			end

			if arg_356_1.frameCnt_ <= 1 then
				arg_356_1.dialog_:SetActive(false)
			end

			local var_359_5 = 0.833333333333333
			local var_359_6 = 1.15

			if 0.833333333333333 < arg_356_1.time_ and arg_356_1.time_ <= var_359_5 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0

				arg_356_1.dialog_:SetActive(true)

				arg_356_1.dialogCg_.alpha = 0

				local var_359_7 = LeanTween.value(arg_356_1.dialog_, 0, 1, 0.3)

				var_359_7:setOnUpdate(LuaHelper.FloatAction(function(arg_360_0)
					arg_356_1.dialogCg_.alpha = arg_360_0
				end))
				var_359_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_356_1.dialog_)
					var_359_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_356_1.duration_ = arg_356_1.duration_ + 0.3

				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_8 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(321161084).content)

				arg_356_1.text_.text = var_359_8

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_10 = 46 <= 0 and var_359_6 or var_359_6 * (utf8.len(var_359_8) / 46)

				if (46 <= 0 and var_359_6 or var_359_6 * (utf8.len(var_359_8) / 46)) > 0 and var_359_6 < var_359_10 then
					arg_356_1.talkMaxDuration = var_359_10
					var_359_5 = var_359_5 + 0.3

					if var_359_10 + var_359_5 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_10 + var_359_5
					end
				end

				arg_356_1.text_.text = var_359_8
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_11 = var_359_5 + 0.3
			local var_359_12 = math.max(var_359_6, arg_356_1.talkMaxDuration)

			if var_359_5 + 0.3 <= arg_356_1.time_ and arg_356_1.time_ < var_359_11 + var_359_12 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - var_359_11) / var_359_12

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= var_359_11 + var_359_12 and arg_356_1.time_ < var_359_11 + var_359_12 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "MS2105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "MS2105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.18333333333333,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_356_1:InitPlayNodeList()
	end,
	Play321161085 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 321161085
		arg_362_1.duration_ = 1.33

		local var_362_0 = {
			zh = 0.999999999999,
			ja = 1.333
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
				arg_362_0:Play321161086(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 and not isNil(arg_362_1.actors_["10104ui_story"]) and arg_362_1.var_.characterEffect10104ui_story == nil then
				arg_362_1.var_.characterEffect10104ui_story = arg_362_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_365_0 = 0.200000002980232

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_0 and not isNil(arg_362_1.actors_["10104ui_story"]) then
				if arg_362_1.var_.characterEffect10104ui_story and not isNil(arg_362_1.actors_["10104ui_story"]) then
					arg_362_1.var_.characterEffect10104ui_story.fillFlat = false
				end
			end

			if arg_362_1.time_ >= 0 + var_365_0 and arg_362_1.time_ < 0 + var_365_0 + arg_365_0 and not isNil(arg_362_1.actors_["10104ui_story"]) and arg_362_1.var_.characterEffect10104ui_story then
				arg_362_1.var_.characterEffect10104ui_story.fillFlat = false
			end

			local var_365_2 = 0
			local var_365_3 = 0.1

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= var_365_2 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[1030].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, true)
				arg_362_1.iconController_:SetSelectedState("hero")

				arg_362_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10104")

				arg_362_1.callingController_:SetSelectedState("normal")

				arg_362_1.keyicon_.color = Color.New(1, 1, 1)
				arg_362_1.icon_.color = Color.New(1, 1, 1)

				local var_365_4 = arg_362_1:GetWordFromCfg(321161085)
				local var_365_5 = arg_362_1:FormatText(var_365_4.content)

				arg_362_1.text_.text = var_365_5

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_7 = 4 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_5) / 4)

				if (4 <= 0 and var_365_3 or var_365_3 * (utf8.len(var_365_5) / 4)) > 0 and var_365_3 < var_365_7 then
					arg_362_1.talkMaxDuration = var_365_7

					if var_365_7 + var_365_2 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_7 + var_365_2
					end
				end

				arg_362_1.text_.text = var_365_5
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161085", "story_v_out_321161.awb") ~= 0 then
					local var_365_8 = manager.audio:GetVoiceLength("story_v_out_321161", "321161085", "story_v_out_321161.awb") / 1000

					if var_365_8 + var_365_2 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_8 + var_365_2
					end

					if var_365_4.prefab_name ~= "" and arg_362_1.actors_[var_365_4.prefab_name] ~= nil then
						local var_365_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_4.prefab_name].transform, "story_v_out_321161", "321161085", "story_v_out_321161.awb")

						arg_362_1:RecordAudio("321161085", var_365_9)
						arg_362_1:RecordAudio("321161085", var_365_9)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_321161", "321161085", "story_v_out_321161.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_321161", "321161085", "story_v_out_321161.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_10 = math.max(var_365_3, arg_362_1.talkMaxDuration)

			if var_365_2 <= arg_362_1.time_ and arg_362_1.time_ < var_365_2 + var_365_10 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - var_365_2) / var_365_10

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= var_365_2 + var_365_10 and arg_362_1.time_ < var_365_2 + var_365_10 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play321161086 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 321161086
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play321161087(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 and not isNil(arg_366_1.actors_["10104ui_story"]) and arg_366_1.var_.characterEffect10104ui_story == nil then
				arg_366_1.var_.characterEffect10104ui_story = arg_366_1.actors_["10104ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_369_0 = 0.200000002980232

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_0 and not isNil(arg_366_1.actors_["10104ui_story"]) then
				if arg_366_1.var_.characterEffect10104ui_story and not isNil(arg_366_1.actors_["10104ui_story"]) then
					arg_366_1.var_.characterEffect10104ui_story.fillFlat = true
					arg_366_1.var_.characterEffect10104ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_366_1.time_ - 0) / var_369_0)
				end
			end

			if arg_366_1.time_ >= 0 + var_369_0 and arg_366_1.time_ < 0 + var_369_0 + arg_369_0 and not isNil(arg_366_1.actors_["10104ui_story"]) and arg_366_1.var_.characterEffect10104ui_story then
				arg_366_1.var_.characterEffect10104ui_story.fillFlat = true
				arg_366_1.var_.characterEffect10104ui_story.fillRatio = 0.5
			end

			local var_369_1 = 0
			local var_369_2 = 0.95

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= var_369_1 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_3 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(321161086).content)

				arg_366_1.text_.text = var_369_3

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_5 = 38 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_3) / 38)

				if (38 <= 0 and var_369_2 or var_369_2 * (utf8.len(var_369_3) / 38)) > 0 and var_369_2 < var_369_5 then
					arg_366_1.talkMaxDuration = var_369_5

					if var_369_5 + var_369_1 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_5 + var_369_1
					end
				end

				arg_366_1.text_.text = var_369_3
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_6 = math.max(var_369_2, arg_366_1.talkMaxDuration)

			if var_369_1 <= arg_366_1.time_ and arg_366_1.time_ < var_369_1 + var_369_6 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - var_369_1) / var_369_6

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= var_369_1 + var_369_6 and arg_366_1.time_ < var_369_1 + var_369_6 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play321161087 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 321161087
		arg_370_1.duration_ = 8.37

		local var_370_0 = {
			zh = 4.8,
			ja = 8.366
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
				arg_370_0:Play321161088(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 0.525

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, true)

				arg_370_1.leftNameTxt_.text = arg_370_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_370_1.leftNameTxt_.transform)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1.leftNameTxt_.text)
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_1 = arg_370_1:GetWordFromCfg(321161087)
				local var_373_2 = arg_370_1:FormatText(var_373_1.content)

				arg_370_1.text_.text = var_373_2

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_4 = 21 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 21)

				if (21 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_2) / 21)) > 0 and var_373_0 < var_373_4 then
					arg_370_1.talkMaxDuration = var_373_4

					if var_373_4 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_4 + 0
					end
				end

				arg_370_1.text_.text = var_373_2
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161087", "story_v_out_321161.awb") ~= 0 then
					local var_373_5 = manager.audio:GetVoiceLength("story_v_out_321161", "321161087", "story_v_out_321161.awb") / 1000

					if var_373_5 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_5 + 0
					end

					if var_373_1.prefab_name ~= "" and arg_370_1.actors_[var_373_1.prefab_name] ~= nil then
						local var_373_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_370_1.actors_[var_373_1.prefab_name].transform, "story_v_out_321161", "321161087", "story_v_out_321161.awb")

						arg_370_1:RecordAudio("321161087", var_373_6)
						arg_370_1:RecordAudio("321161087", var_373_6)
					else
						arg_370_1:AudioAction("play", "voice", "story_v_out_321161", "321161087", "story_v_out_321161.awb")
					end

					arg_370_1:RecordHistoryTalkVoice("story_v_out_321161", "321161087", "story_v_out_321161.awb")
				end

				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_7 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_7 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_7

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_7 and arg_370_1.time_ < 0 + var_373_7 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play321161088 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 321161088
		arg_374_1.duration_ = 7

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play321161089(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_9000

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				local var_377_0 = arg_374_1.bgs_.L14f

				arg_374_1.bgs_.L14f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_377_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_377_1 = var_377_0:GetComponent("SpriteRenderer")

				if var_377_1 and var_377_1.sprite then
					local var_377_2 = 2 * (var_377_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_377_0.transform.localScale = Vector3.New(var_377_2 / var_377_1.sprite.bounds.size.y < var_377_2 * manager.ui.mainCameraCom_.aspect / var_377_1.sprite.bounds.size.x and var_377_2 * manager.ui.mainCameraCom_.aspect / var_377_1.sprite.bounds.size.x or var_377_2 / var_377_1.sprite.bounds.size.y, var_377_2 / var_377_1.sprite.bounds.size.y < var_377_2 * manager.ui.mainCameraCom_.aspect / var_377_1.sprite.bounds.size.x and var_377_2 * manager.ui.mainCameraCom_.aspect / var_377_1.sprite.bounds.size.x or var_377_2 / var_377_1.sprite.bounds.size.y, 0)
				end

				for iter_377_0, iter_377_1 in pairs(arg_374_1.bgs_) do
					if iter_377_0 ~= "L14f" then
						iter_377_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_377_3 = 2

			if 2 < arg_374_1.time_ and arg_374_1.time_ <= var_377_3 + arg_377_0 then
				arg_374_1.allBtn_.enabled = false
			end

			if arg_374_1.time_ >= var_377_3 + 0.3 and arg_374_1.time_ < var_377_3 + 0.3 + arg_377_0 then
				arg_374_1.allBtn_.enabled = true
			end

			local var_377_4 = 0

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= var_377_4 + arg_377_0 then
				arg_374_1.mask_.enabled = true
				arg_374_1.mask_.raycastTarget = true

				arg_374_1:SetGaussion(false)
			end

			local var_377_5 = 1.23333333333333

			if var_377_4 <= arg_374_1.time_ and arg_374_1.time_ < var_377_4 + var_377_5 then
				local var_377_6 = Color.New(1, 1, 1)

				var_377_6.a = Mathf.Lerp(1, 0, (arg_374_1.time_ - var_377_4) / var_377_5)
				arg_374_1.mask_.color = var_377_6
			end

			if arg_374_1.time_ >= var_377_4 + var_377_5 and arg_374_1.time_ < var_377_4 + var_377_5 + arg_377_0 then
				local var_377_7 = Color.New(1, 1, 1)

				arg_374_1.mask_.enabled = false
				var_377_7.a = 0
				arg_374_1.mask_.color = var_377_7
			end

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				if arg_374_1.var_.effectluobona1 then
					Object.Destroy(arg_374_1.var_.effectluobona1)

					arg_374_1.var_.effectluobona1 = nil
				end
			end

			if 0.866666666666667 < arg_374_1.time_ and arg_374_1.time_ <= 0.866666666666667 + arg_377_0 then
				local var_377_9 = arg_374_1.var_.effectxuli1

				if not arg_374_1.var_.effectxuli1 then
					var_377_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_hit"), manager.ui.mainCamera.transform)
					var_377_9.name = "xuli1"
					arg_374_1.var_.effectxuli1 = var_377_9
				else
					var_377_9.transform:SetParent(var_377_9000)
				end

				var_377_9.transform.localPosition = Vector3.New(0, -0.16, -1.61)
				var_377_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.7 < arg_374_1.time_ and arg_374_1.time_ <= 0.7 + arg_377_0 then
				arg_374_1:AudioAction("play", "effect", "se_story_140", "se_story_140_laser", "")
			end

			local var_377_12 = 1.1

			if 1.1 < arg_374_1.time_ and arg_374_1.time_ <= var_377_12 + arg_377_0 then
				arg_374_1.allBtn_.enabled = false
			end

			if arg_374_1.time_ >= var_377_12 + 1.06666666666667 and arg_374_1.time_ < var_377_12 + 1.06666666666667 + arg_377_0 then
				arg_374_1.allBtn_.enabled = true
			end

			if arg_374_1.frameCnt_ <= 1 then
				arg_374_1.dialog_:SetActive(false)
			end

			local var_377_13 = 2
			local var_377_14 = 1.425

			if 2 < arg_374_1.time_ and arg_374_1.time_ <= var_377_13 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0

				arg_374_1.dialog_:SetActive(true)

				arg_374_1.dialogCg_.alpha = 0

				local var_377_15 = LeanTween.value(arg_374_1.dialog_, 0, 1, 0.3)

				var_377_15:setOnUpdate(LuaHelper.FloatAction(function(arg_378_0)
					arg_374_1.dialogCg_.alpha = arg_378_0
				end))
				var_377_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_374_1.dialog_)
					var_377_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_374_1.duration_ = arg_374_1.duration_ + 0.3

				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_16 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(321161088).content)

				arg_374_1.text_.text = var_377_16

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_18 = 57 <= 0 and var_377_14 or var_377_14 * (utf8.len(var_377_16) / 57)

				if (57 <= 0 and var_377_14 or var_377_14 * (utf8.len(var_377_16) / 57)) > 0 and var_377_14 < var_377_18 then
					arg_374_1.talkMaxDuration = var_377_18
					var_377_13 = var_377_13 + 0.3

					if var_377_18 + var_377_13 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_18 + var_377_13
					end
				end

				arg_374_1.text_.text = var_377_16
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_19 = var_377_13 + 0.3
			local var_377_20 = math.max(var_377_14, arg_374_1.talkMaxDuration)

			if var_377_13 + 0.3 <= arg_374_1.time_ and arg_374_1.time_ < var_377_19 + var_377_20 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - var_377_19) / var_377_20

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= var_377_19 + var_377_20 and arg_374_1.time_ < var_377_19 + var_377_20 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play321161089 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 321161089
		arg_380_1.duration_ = 5.57

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play321161090(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				local var_383_0 = arg_380_1.var_.effect498

				if not arg_380_1.var_.effect498 then
					var_383_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_383_0.name = "498"
					arg_380_1.var_.effect498 = var_383_0
				else
					var_383_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_383_0.transform.localPosition = Vector3.New(0, 0, 0.66)
				var_383_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_383_2 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_383_0, iter_383_1 in ipairs((var_383_0.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_383_1.transform.localScale = Vector3.New(iter_383_1.transform.localScale.x / var_383_2 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_383_1.transform.localScale.y / var_383_2, iter_383_1.transform.localScale.z)
				end
			end

			if 1.26666666666667 < arg_380_1.time_ and arg_380_1.time_ <= 1.26666666666667 + arg_383_0 then
				if arg_380_1.var_.effect498 then
					Object.Destroy(arg_380_1.var_.effect498)

					arg_380_1.var_.effect498 = nil
				end
			end

			if 0.034000001847744 < arg_380_1.time_ and arg_380_1.time_ <= 0.034000001847744 + arg_383_0 then
				arg_380_1:AudioAction("play", "effect", "se_story_140", "se_story_140_laser02", "")
			end

			local var_383_6 = manager.ui.mainCamera.transform

			if 0.366666666666666 < arg_380_1.time_ and arg_380_1.time_ <= 0.366666666666666 + arg_383_0 then
				arg_380_1.var_.shakeOldPos = var_383_6.localPosition
			end

			local var_383_7 = 0.667333335181078

			if 0.366666666666666 <= arg_380_1.time_ and arg_380_1.time_ < 0.366666666666666 + var_383_7 then
				local var_383_8, var_383_9 = math.modf((arg_380_1.time_ - 0.366666666666666) / 0.066)

				var_383_6.localPosition = Vector3.New(var_383_9 * 0.13, var_383_9 * 0.13, var_383_9 * 0.13) + arg_380_1.var_.shakeOldPos
			end

			if arg_380_1.time_ >= 0.366666666666666 + var_383_7 and arg_380_1.time_ < 0.366666666666666 + var_383_7 + arg_383_0 then
				var_383_6.localPosition = arg_380_1.var_.shakeOldPos
			end

			if arg_380_1.frameCnt_ <= 1 then
				arg_380_1.dialog_:SetActive(false)
			end

			local var_383_10 = 0.566666666666667
			local var_383_11 = 1.3

			if 0.566666666666667 < arg_380_1.time_ and arg_380_1.time_ <= var_383_10 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0

				arg_380_1.dialog_:SetActive(true)

				arg_380_1.dialogCg_.alpha = 0

				local var_383_12 = LeanTween.value(arg_380_1.dialog_, 0, 1, 0.3)

				var_383_12:setOnUpdate(LuaHelper.FloatAction(function(arg_384_0)
					arg_380_1.dialogCg_.alpha = arg_384_0
				end))
				var_383_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_380_1.dialog_)
					var_383_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_380_1.duration_ = arg_380_1.duration_ + 0.3

				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_13 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(321161089).content)

				arg_380_1.text_.text = var_383_13

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_15 = 52 <= 0 and var_383_11 or var_383_11 * (utf8.len(var_383_13) / 52)

				if (52 <= 0 and var_383_11 or var_383_11 * (utf8.len(var_383_13) / 52)) > 0 and var_383_11 < var_383_15 then
					arg_380_1.talkMaxDuration = var_383_15
					var_383_10 = var_383_10 + 0.3

					if var_383_15 + var_383_10 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_15 + var_383_10
					end
				end

				arg_380_1.text_.text = var_383_13
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_16 = var_383_10 + 0.3
			local var_383_17 = math.max(var_383_11, arg_380_1.talkMaxDuration)

			if var_383_10 + 0.3 <= arg_380_1.time_ and arg_380_1.time_ < var_383_16 + var_383_17 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - var_383_16) / var_383_17

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= var_383_16 + var_383_17 and arg_380_1.time_ < var_383_16 + var_383_17 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play321161090 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 321161090
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play321161091(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			if 0.366666666666667 < arg_386_1.time_ and arg_386_1.time_ <= 0.366666666666667 + arg_389_0 then
				arg_386_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion05", "")
			end

			local var_389_1 = 0
			local var_389_2 = 1.05

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= var_389_1 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_3 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(321161090).content)

				arg_386_1.text_.text = var_389_3

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_5 = 42 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 42)

				if (42 <= 0 and var_389_2 or var_389_2 * (utf8.len(var_389_3) / 42)) > 0 and var_389_2 < var_389_5 then
					arg_386_1.talkMaxDuration = var_389_5

					if var_389_5 + var_389_1 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_5 + var_389_1
					end
				end

				arg_386_1.text_.text = var_389_3
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_6 = math.max(var_389_2, arg_386_1.talkMaxDuration)

			if var_389_1 <= arg_386_1.time_ and arg_386_1.time_ < var_389_1 + var_389_6 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - var_389_1) / var_389_6

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= var_389_1 + var_389_6 and arg_386_1.time_ < var_389_1 + var_389_6 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play321161091 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 321161091
		arg_390_1.duration_ = 2.33

		local var_390_0 = {
			zh = 1.233,
			ja = 2.333
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
				arg_390_0:Play321161092(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.15

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, true)

				arg_390_1.leftNameTxt_.text = arg_390_1:FormatText(StoryNameCfg[600].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_390_1.leftNameTxt_.transform)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1.leftNameTxt_.text)
				SetActive(arg_390_1.iconTrs_.gameObject, true)
				arg_390_1.iconController_:SetSelectedState("hero")

				arg_390_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_4032")

				arg_390_1.callingController_:SetSelectedState("normal")

				arg_390_1.keyicon_.color = Color.New(1, 1, 1)
				arg_390_1.icon_.color = Color.New(1, 1, 1)

				local var_393_1 = arg_390_1:GetWordFromCfg(321161091)
				local var_393_2 = arg_390_1:FormatText(var_393_1.content)

				arg_390_1.text_.text = var_393_2

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_4 = 6 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 6)

				if (6 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_2) / 6)) > 0 and var_393_0 < var_393_4 then
					arg_390_1.talkMaxDuration = var_393_4

					if var_393_4 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_4 + 0
					end
				end

				arg_390_1.text_.text = var_393_2
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161091", "story_v_out_321161.awb") ~= 0 then
					local var_393_5 = manager.audio:GetVoiceLength("story_v_out_321161", "321161091", "story_v_out_321161.awb") / 1000

					if var_393_5 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_5 + 0
					end

					if var_393_1.prefab_name ~= "" and arg_390_1.actors_[var_393_1.prefab_name] ~= nil then
						local var_393_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_390_1.actors_[var_393_1.prefab_name].transform, "story_v_out_321161", "321161091", "story_v_out_321161.awb")

						arg_390_1:RecordAudio("321161091", var_393_6)
						arg_390_1:RecordAudio("321161091", var_393_6)
					else
						arg_390_1:AudioAction("play", "voice", "story_v_out_321161", "321161091", "story_v_out_321161.awb")
					end

					arg_390_1:RecordHistoryTalkVoice("story_v_out_321161", "321161091", "story_v_out_321161.awb")
				end

				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_7 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_7 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_7

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_7 and arg_390_1.time_ < 0 + var_393_7 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play321161092 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 321161092
		arg_394_1.duration_ = 5

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play321161093(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 1.65

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, false)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:FormatText(arg_394_1:GetWordFromCfg(321161092).content)

				arg_394_1.text_.text = var_397_1

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_3 = 66 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 66)

				if (66 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_1) / 66)) > 0 and var_397_0 < var_397_3 then
					arg_394_1.talkMaxDuration = var_397_3

					if var_397_3 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_3 + 0
					end
				end

				arg_394_1.text_.text = var_397_1
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)
				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_4 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_4 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_4

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_4 and arg_394_1.time_ < 0 + var_397_4 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play321161093 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 321161093
		arg_398_1.duration_ = 5

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play321161094(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			local var_401_0 = 1.2

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= 0 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0
				arg_398_1.dialogCg_.alpha = 1

				arg_398_1.dialog_:SetActive(true)
				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_1 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(321161093).content)

				arg_398_1.text_.text = var_401_1

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_3 = 48 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 48)

				if (48 <= 0 and var_401_0 or var_401_0 * (utf8.len(var_401_1) / 48)) > 0 and var_401_0 < var_401_3 then
					arg_398_1.talkMaxDuration = var_401_3

					if var_401_3 + 0 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_3 + 0
					end
				end

				arg_398_1.text_.text = var_401_1
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_4 = math.max(var_401_0, arg_398_1.talkMaxDuration)

			if 0 <= arg_398_1.time_ and arg_398_1.time_ < 0 + var_401_4 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - 0) / var_401_4

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= 0 + var_401_4 and arg_398_1.time_ < 0 + var_401_4 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play321161094 = function(arg_402_0, arg_402_1)
		arg_402_1.time_ = 0
		arg_402_1.frameCnt_ = 0
		arg_402_1.state_ = "playing"
		arg_402_1.curTalkId_ = 321161094
		arg_402_1.duration_ = 5

		SetActive(arg_402_1.tipsGo_, false)

		function arg_402_1.onSingleLineFinish_()
			arg_402_1.onSingleLineUpdate_ = nil
			arg_402_1.onSingleLineFinish_ = nil
			arg_402_1.state_ = "waiting"
		end

		function arg_402_1.playNext_(arg_404_0)
			if arg_404_0 == 1 then
				arg_402_0:Play321161095(arg_402_1)
			end
		end

		function arg_402_1.onSingleLineUpdate_(arg_405_0)
			local var_405_0 = 0.075

			if 0 < arg_402_1.time_ and arg_402_1.time_ <= 0 + arg_405_0 then
				arg_402_1.talkMaxDuration = 0
				arg_402_1.dialogCg_.alpha = 1

				arg_402_1.dialog_:SetActive(true)
				SetActive(arg_402_1.leftNameGo_, true)

				arg_402_1.leftNameTxt_.text = arg_402_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_402_1.leftNameTxt_.transform)

				arg_402_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_402_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_402_1:RecordName(arg_402_1.leftNameTxt_.text)
				SetActive(arg_402_1.iconTrs_.gameObject, true)
				arg_402_1.iconController_:SetSelectedState("hero")

				arg_402_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_402_1.callingController_:SetSelectedState("normal")

				arg_402_1.keyicon_.color = Color.New(1, 1, 1)
				arg_402_1.icon_.color = Color.New(1, 1, 1)

				local var_405_1 = arg_402_1:FormatText(arg_402_1:GetWordFromCfg(321161094).content)

				arg_402_1.text_.text = var_405_1

				LuaForUtil.ClearLinePrefixSymbol(arg_402_1.text_)

				local var_405_3 = 3 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 3)

				if (3 <= 0 and var_405_0 or var_405_0 * (utf8.len(var_405_1) / 3)) > 0 and var_405_0 < var_405_3 then
					arg_402_1.talkMaxDuration = var_405_3

					if var_405_3 + 0 > arg_402_1.duration_ then
						arg_402_1.duration_ = var_405_3 + 0
					end
				end

				arg_402_1.text_.text = var_405_1
				arg_402_1.typewritter.percent = 0

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(false)
				arg_402_1:RecordContent(arg_402_1.text_.text)
			end

			local var_405_4 = math.max(var_405_0, arg_402_1.talkMaxDuration)

			if 0 <= arg_402_1.time_ and arg_402_1.time_ < 0 + var_405_4 then
				arg_402_1.typewritter.percent = (arg_402_1.time_ - 0) / var_405_4

				arg_402_1.typewritter:SetDirty()
			end

			if arg_402_1.time_ >= 0 + var_405_4 and arg_402_1.time_ < 0 + var_405_4 + arg_405_0 then
				arg_402_1.typewritter.percent = 1

				arg_402_1.typewritter:SetDirty()
				arg_402_1:ShowNextGo(true)
			end
		end

		arg_402_1.nodeConfigList_ = {}

		arg_402_1:InitPlayNodeList()
	end,
	Play321161095 = function(arg_406_0, arg_406_1)
		arg_406_1.time_ = 0
		arg_406_1.frameCnt_ = 0
		arg_406_1.state_ = "playing"
		arg_406_1.curTalkId_ = 321161095
		arg_406_1.duration_ = 4.57

		local var_406_0 = {
			zh = 2.7,
			ja = 4.566
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
			arg_406_1.auto_ = false
		end

		function arg_406_1.playNext_(arg_408_0)
			arg_406_1.onStoryFinished_()
		end

		function arg_406_1.onSingleLineUpdate_(arg_409_0)
			local var_409_0 = 0.275

			if 0 < arg_406_1.time_ and arg_406_1.time_ <= 0 + arg_409_0 then
				arg_406_1.talkMaxDuration = 0
				arg_406_1.dialogCg_.alpha = 1

				arg_406_1.dialog_:SetActive(true)
				SetActive(arg_406_1.leftNameGo_, true)

				arg_406_1.leftNameTxt_.text = arg_406_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_406_1.leftNameTxt_.transform)

				arg_406_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_406_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_406_1:RecordName(arg_406_1.leftNameTxt_.text)
				SetActive(arg_406_1.iconTrs_.gameObject, true)
				arg_406_1.iconController_:SetSelectedState("hero")

				arg_406_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1284")

				arg_406_1.callingController_:SetSelectedState("normal")

				arg_406_1.keyicon_.color = Color.New(1, 1, 1)
				arg_406_1.icon_.color = Color.New(1, 1, 1)

				local var_409_1 = arg_406_1:GetWordFromCfg(321161095)
				local var_409_2 = arg_406_1:FormatText(var_409_1.content)

				arg_406_1.text_.text = var_409_2

				LuaForUtil.ClearLinePrefixSymbol(arg_406_1.text_)

				local var_409_4 = 11 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 11)

				if (11 <= 0 and var_409_0 or var_409_0 * (utf8.len(var_409_2) / 11)) > 0 and var_409_0 < var_409_4 then
					arg_406_1.talkMaxDuration = var_409_4

					if var_409_4 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_4 + 0
					end
				end

				arg_406_1.text_.text = var_409_2
				arg_406_1.typewritter.percent = 0

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_321161", "321161095", "story_v_out_321161.awb") ~= 0 then
					local var_409_5 = manager.audio:GetVoiceLength("story_v_out_321161", "321161095", "story_v_out_321161.awb") / 1000

					if var_409_5 + 0 > arg_406_1.duration_ then
						arg_406_1.duration_ = var_409_5 + 0
					end

					if var_409_1.prefab_name ~= "" and arg_406_1.actors_[var_409_1.prefab_name] ~= nil then
						local var_409_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_406_1.actors_[var_409_1.prefab_name].transform, "story_v_out_321161", "321161095", "story_v_out_321161.awb")

						arg_406_1:RecordAudio("321161095", var_409_6)
						arg_406_1:RecordAudio("321161095", var_409_6)
					else
						arg_406_1:AudioAction("play", "voice", "story_v_out_321161", "321161095", "story_v_out_321161.awb")
					end

					arg_406_1:RecordHistoryTalkVoice("story_v_out_321161", "321161095", "story_v_out_321161.awb")
				end

				arg_406_1:RecordContent(arg_406_1.text_.text)
			end

			local var_409_7 = math.max(var_409_0, arg_406_1.talkMaxDuration)

			if 0 <= arg_406_1.time_ and arg_406_1.time_ < 0 + var_409_7 then
				arg_406_1.typewritter.percent = (arg_406_1.time_ - 0) / var_409_7

				arg_406_1.typewritter:SetDirty()
			end

			if arg_406_1.time_ >= 0 + var_409_7 and arg_406_1.time_ < 0 + var_409_7 + arg_409_0 then
				arg_406_1.typewritter.percent = 1

				arg_406_1.typewritter:SetDirty()
				arg_406_1:ShowNextGo(true)
			end
		end

		arg_406_1.nodeConfigList_ = {}

		arg_406_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/L08g",
		"TextureConfig/Background/L14f",
		"TextureConfig/Background/MS2105"
	},
	voices = {
		"story_v_out_321161.awb"
	}
}
