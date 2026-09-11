return {
	Play317282001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 317282001
		arg_1_1.duration_ = 4.57

		local var_1_0 = {
			zh = 4.566,
			ja = 3.999999999999
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
				arg_1_0:Play317282002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.K10f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K10f")
				var_4_0.name = "K10f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.K10f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.K10f

				arg_1_1.bgs_.K10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "K10f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_5 = 2

			if var_4_4 <= arg_1_1.time_ and arg_1_1.time_ < var_4_4 + var_4_5 then
				local var_4_6 = Color.New(0, 0, 0)

				var_4_6.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_4) / var_4_5)
				arg_1_1.mask_.color = var_4_6
			end

			if arg_1_1.time_ >= var_4_4 + var_4_5 and arg_1_1.time_ < var_4_4 + var_4_5 + arg_4_0 then
				local var_4_7 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_7.a = 0
				arg_1_1.mask_.color = var_4_7
			end

			local var_4_8 = "2079ui_story"

			if arg_1_1.actors_["2079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2079ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "2079ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["2079ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos2079ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.28, -5.6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["2079ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect2079ui_story == nil then
				arg_1_1.var_.characterEffect2079ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect2079ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect2079ui_story then
				arg_1_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_4_17 = "2078ui_story"

			if arg_1_1.actors_["2078ui_story"] == nil and not isNil((Asset.Load("Char/" .. "2078ui_story"))) then
				local var_4_18 = Object.Instantiate(Asset.Load("Char/" .. "2078ui_story"), arg_1_1.stage_.transform)

				var_4_18.name = var_4_17
				var_4_18.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_17] = var_4_18

				local var_4_19 = var_4_18:GetComponentInChildren(typeof(CharacterEffect))

				var_4_19.enabled = true

				local var_4_20 = GameObjectTools.GetOrAddComponent(var_4_18, typeof(DynamicBoneHelper))

				if var_4_20 then
					var_4_20:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_19.transform, false)

				arg_1_1.var_[var_4_17 .. "Animator"] = var_4_19.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_17 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_17 .. "LipSync"] = var_4_19.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_23 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_23 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_23

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_23
						arg_1_1.bgmTxt2_.text = var_4_23
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

			if 0.733333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.733333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden.awb")

				local var_4_26 = manager.audio:GetAudioName("bgm_activity_2_6_story_karasugo_garden", "bgm_activity_2_6_story_karasugo_garden")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_26 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_26

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_26
						arg_1_1.bgmTxt2_.text = var_4_26
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_27 = 2
			local var_4_28 = 0.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_27 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_29 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_29:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_29:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_29:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_30 = arg_1_1:GetWordFromCfg(317282001)
				local var_4_31 = arg_1_1:FormatText(var_4_30.content)

				arg_1_1.text_.text = var_4_31

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_33 = 12 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 12)

				if (12 <= 0 and var_4_28 or var_4_28 * (utf8.len(var_4_31) / 12)) > 0 and var_4_28 < var_4_33 then
					arg_1_1.talkMaxDuration = var_4_33
					var_4_27 = var_4_27 + 0.3

					if var_4_33 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_33 + var_4_27
					end
				end

				arg_1_1.text_.text = var_4_31
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282001", "story_v_out_317282.awb") ~= 0 then
					local var_4_34 = manager.audio:GetVoiceLength("story_v_out_317282", "317282001", "story_v_out_317282.awb") / 1000

					if var_4_34 + var_4_27 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_34 + var_4_27
					end

					if var_4_30.prefab_name ~= "" and arg_1_1.actors_[var_4_30.prefab_name] ~= nil then
						local var_4_35 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_30.prefab_name].transform, "story_v_out_317282", "317282001", "story_v_out_317282.awb")

						arg_1_1:RecordAudio("317282001", var_4_35)
						arg_1_1:RecordAudio("317282001", var_4_35)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_317282", "317282001", "story_v_out_317282.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_317282", "317282001", "story_v_out_317282.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_36 = var_4_27 + 0.3
			local var_4_37 = math.max(var_4_28, arg_1_1.talkMaxDuration)

			if var_4_27 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_36 + var_4_37 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_36) / var_4_37

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_36 + var_4_37 and arg_1_1.time_ < var_4_36 + var_4_37 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play317282002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 317282002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play317282003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos2079ui_story = arg_9_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).z)
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles = arg_9_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["2079ui_story"].transform.position).z)
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["2079ui_story"].transform.localEulerAngles = arg_9_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["2078ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect2078ui_story == nil then
				arg_9_1.var_.characterEffect2078ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect2078ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_9_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_2)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect2078ui_story then
				arg_9_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_9_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_12_3 = 0
			local var_12_4 = 0.65

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_3 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_5 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(317282002).content)

				arg_9_1.text_.text = var_12_5

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_7 = 26 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 26)

				if (26 <= 0 and var_12_4 or var_12_4 * (utf8.len(var_12_5) / 26)) > 0 and var_12_4 < var_12_7 then
					arg_9_1.talkMaxDuration = var_12_7

					if var_12_7 + var_12_3 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_7 + var_12_3
					end
				end

				arg_9_1.text_.text = var_12_5
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_8 = math.max(var_12_4, arg_9_1.talkMaxDuration)

			if var_12_3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_3 + var_12_8 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_3) / var_12_8

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_3 + var_12_8 and arg_9_1.time_ < var_12_3 + var_12_8 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317282003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 317282003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play317282004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 1.025

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(317282003).content)

				arg_13_1.text_.text = var_16_1

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_3 = 41 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 41)

				if (41 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_1) / 41)) > 0 and var_16_0 < var_16_3 then
					arg_13_1.talkMaxDuration = var_16_3

					if var_16_3 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_3 + 0
					end
				end

				arg_13_1.text_.text = var_16_1
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_4 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_4

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play317282004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 317282004
		arg_17_1.duration_ = 2

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play317282005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if arg_17_1.actors_["1093ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1093ui_story"))) then
				local var_20_0 = Object.Instantiate(Asset.Load("Char/" .. "1093ui_story"), arg_17_1.stage_.transform)

				var_20_0.name = "1093ui_story"
				var_20_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1093ui_story"] = var_20_0

				local var_20_1 = var_20_0:GetComponentInChildren(typeof(CharacterEffect))

				var_20_1.enabled = true

				local var_20_2 = GameObjectTools.GetOrAddComponent(var_20_0, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_1.transform, false)

				arg_17_1.var_["1093ui_story" .. "Animator"] = var_20_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_["1093ui_story" .. "Animator"].applyRootMotion = true
				arg_17_1.var_["1093ui_story" .. "LipSync"] = var_20_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_3 = arg_17_1.actors_["1093ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1093ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, -1.11, -5.88)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = arg_17_1.actors_["1093ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1093ui_story == nil then
				arg_17_1.var_.characterEffect1093ui_story = var_20_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_6 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_6 and not isNil(var_20_5) then
				if arg_17_1.var_.characterEffect1093ui_story and not isNil(var_20_5) then
					arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_6 and arg_17_1.time_ < 0 + var_20_6 + arg_20_0 and not isNil(var_20_5) and arg_17_1.var_.characterEffect1093ui_story then
				arg_17_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_20_8 = 0
			local var_20_9 = 0.225

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_8 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_10 = arg_17_1:GetWordFromCfg(317282004)
				local var_20_11 = arg_17_1:FormatText(var_20_10.content)

				arg_17_1.text_.text = var_20_11

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_13 = 9 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 9)

				if (9 <= 0 and var_20_9 or var_20_9 * (utf8.len(var_20_11) / 9)) > 0 and var_20_9 < var_20_13 then
					arg_17_1.talkMaxDuration = var_20_13

					if var_20_13 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_13 + var_20_8
					end
				end

				arg_17_1.text_.text = var_20_11
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282004", "story_v_out_317282.awb") ~= 0 then
					local var_20_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282004", "story_v_out_317282.awb") / 1000

					if var_20_14 + var_20_8 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_14 + var_20_8
					end

					if var_20_10.prefab_name ~= "" and arg_17_1.actors_[var_20_10.prefab_name] ~= nil then
						local var_20_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_10.prefab_name].transform, "story_v_out_317282", "317282004", "story_v_out_317282.awb")

						arg_17_1:RecordAudio("317282004", var_20_15)
						arg_17_1:RecordAudio("317282004", var_20_15)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_317282", "317282004", "story_v_out_317282.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_317282", "317282004", "story_v_out_317282.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_16 = math.max(var_20_9, arg_17_1.talkMaxDuration)

			if var_20_8 <= arg_17_1.time_ and arg_17_1.time_ < var_20_8 + var_20_16 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_8) / var_20_16

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_8 + var_20_16 and arg_17_1.time_ < var_20_8 + var_20_16 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play317282005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 317282005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play317282006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1093ui_story = arg_21_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).z)
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles = arg_21_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1093ui_story"].transform.position).z)
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1093ui_story"].transform.localEulerAngles = arg_21_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1093ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1093ui_story == nil then
				arg_21_1.var_.characterEffect1093ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1093ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_2)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1093ui_story then
				arg_21_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_24_3 = 0
			local var_24_4 = 1.275

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(317282005).content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 51 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 51)

				if (51 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 51)) > 0 and var_24_4 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_3) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_3 + var_24_8 and arg_21_1.time_ < var_24_3 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play317282006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 317282006
		arg_25_1.duration_ = 2

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play317282007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos2078ui_story = arg_25_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).z)
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles = arg_25_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_25_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["2078ui_story"].transform.position).z)
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["2078ui_story"].transform.localEulerAngles = arg_25_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["2078ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect2078ui_story == nil then
				arg_25_1.var_.characterEffect2078ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect2078ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect2078ui_story then
				arg_25_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_28_4 = 0
			local var_28_5 = 0.075

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(317282006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 3 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 3)

				if (3 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 3)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282006", "story_v_out_317282.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282006", "story_v_out_317282.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_317282", "317282006", "story_v_out_317282.awb")

						arg_25_1:RecordAudio("317282006", var_28_11)
						arg_25_1:RecordAudio("317282006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_317282", "317282006", "story_v_out_317282.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_317282", "317282006", "story_v_out_317282.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
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
	Play317282007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 317282007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play317282008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos2078ui_story = arg_29_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).z)
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles = arg_29_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["2078ui_story"].transform.position).z)
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["2078ui_story"].transform.localEulerAngles = arg_29_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["2078ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect2078ui_story == nil then
				arg_29_1.var_.characterEffect2078ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.166000001132488

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect2078ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_29_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_2)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect2078ui_story then
				arg_29_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_29_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:AudioAction("play", "effect", "se_story_120_00", "se_story_120_00_gunshot", "")
			end

			local var_32_4 = 0
			local var_32_5 = 1.425

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(317282007).content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 57 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 57)

				if (57 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 57)) > 0 and var_32_5 < var_32_8 then
					arg_29_1.talkMaxDuration = var_32_8

					if var_32_8 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_9 and arg_29_1.time_ < var_32_4 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play317282008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 317282008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play317282009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			local var_36_0 = 1.325

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_1 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(317282008).content)

				arg_33_1.text_.text = var_36_1

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_3 = 53 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 53)

				if (53 <= 0 and var_36_0 or var_36_0 * (utf8.len(var_36_1) / 53)) > 0 and var_36_0 < var_36_3 then
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
	Play317282009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 317282009
		arg_37_1.duration_ = 5.1

		local var_37_0 = {
			zh = 2.4,
			ja = 5.1
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
				arg_37_0:Play317282010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1093ui_story = arg_37_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).z)
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles = arg_37_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_37_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1093ui_story"].transform.position).z)
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1093ui_story"].transform.localEulerAngles = arg_37_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1093ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1093ui_story == nil then
				arg_37_1.var_.characterEffect1093ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1093ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1093ui_story then
				arg_37_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_2")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_40_4 = 0
			local var_40_5 = 0.275

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:GetWordFromCfg(317282009)
				local var_40_7 = arg_37_1:FormatText(var_40_6.content)

				arg_37_1.text_.text = var_40_7

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_9 = 11 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 11)

				if (11 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_7) / 11)) > 0 and var_40_5 < var_40_9 then
					arg_37_1.talkMaxDuration = var_40_9

					if var_40_9 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_9 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_7
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282009", "story_v_out_317282.awb") ~= 0 then
					local var_40_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282009", "story_v_out_317282.awb") / 1000

					if var_40_10 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_4
					end

					if var_40_6.prefab_name ~= "" and arg_37_1.actors_[var_40_6.prefab_name] ~= nil then
						local var_40_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_6.prefab_name].transform, "story_v_out_317282", "317282009", "story_v_out_317282.awb")

						arg_37_1:RecordAudio("317282009", var_40_11)
						arg_37_1:RecordAudio("317282009", var_40_11)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_317282", "317282009", "story_v_out_317282.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_317282", "317282009", "story_v_out_317282.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_12 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_12 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_12

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_12 and arg_37_1.time_ < var_40_4 + var_40_12 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
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
	Play317282010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 317282010
		arg_41_1.duration_ = 5.13

		local var_41_0 = {
			zh = 5.133,
			ja = 3.933
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play317282011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1093ui_story = arg_41_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).z)
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles = arg_41_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["1093ui_story"].transform.position).z)
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["1093ui_story"].transform.localEulerAngles = arg_41_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["1093ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1093ui_story == nil then
				arg_41_1.var_.characterEffect1093ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect1093ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_2)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect1093ui_story then
				arg_41_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_44_3 = arg_41_1.actors_["2079ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos2079ui_story = var_44_3.localPosition
			end

			local var_44_4 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_4 then
				var_44_3.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos2079ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_41_1.time_ - 0) / var_44_4)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_4 and arg_41_1.time_ < 0 + var_44_4 + arg_44_0 then
				var_44_3.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				var_44_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_3.position).x, (manager.ui.mainCamera.transform.position - var_44_3.position).y, (manager.ui.mainCamera.transform.position - var_44_3.position).z)
				var_44_3.localEulerAngles.z = 0
				var_44_3.localEulerAngles.x = 0
				var_44_3.localEulerAngles = var_44_3.localEulerAngles
			end

			local var_44_5 = arg_41_1.actors_["2079ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect2079ui_story == nil then
				arg_41_1.var_.characterEffect2079ui_story = var_44_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_6 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_6 and not isNil(var_44_5) then
				if arg_41_1.var_.characterEffect2079ui_story and not isNil(var_44_5) then
					arg_41_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_6 and arg_41_1.time_ < 0 + var_44_6 + arg_44_0 and not isNil(var_44_5) and arg_41_1.var_.characterEffect2079ui_story then
				arg_41_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_44_8 = arg_41_1.actors_["2078ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos2078ui_story = var_44_8.localPosition
			end

			local var_44_9 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_9 then
				var_44_8.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_41_1.time_ - 0) / var_44_9)
				var_44_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_8.position).x, (manager.ui.mainCamera.transform.position - var_44_8.position).y, (manager.ui.mainCamera.transform.position - var_44_8.position).z)
				var_44_8.localEulerAngles.z = 0
				var_44_8.localEulerAngles.x = 0
				var_44_8.localEulerAngles = var_44_8.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_9 and arg_41_1.time_ < 0 + var_44_9 + arg_44_0 then
				var_44_8.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_44_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_8.position).x, (manager.ui.mainCamera.transform.position - var_44_8.position).y, (manager.ui.mainCamera.transform.position - var_44_8.position).z)
				var_44_8.localEulerAngles.z = 0
				var_44_8.localEulerAngles.x = 0
				var_44_8.localEulerAngles = var_44_8.localEulerAngles
			end

			local var_44_10 = arg_41_1.actors_["2078ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_10) and arg_41_1.var_.characterEffect2078ui_story == nil then
				arg_41_1.var_.characterEffect2078ui_story = var_44_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_11 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_11 and not isNil(var_44_10) then
				if arg_41_1.var_.characterEffect2078ui_story and not isNil(var_44_10) then
					arg_41_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_41_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_11)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_11 and arg_41_1.time_ < 0 + var_44_11 + arg_44_0 and not isNil(var_44_10) and arg_41_1.var_.characterEffect2078ui_story then
				arg_41_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_41_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_44_12 = 0
			local var_44_13 = 0.3

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_12 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_14 = arg_41_1:GetWordFromCfg(317282010)
				local var_44_15 = arg_41_1:FormatText(var_44_14.content)

				arg_41_1.text_.text = var_44_15

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_17 = 12 <= 0 and var_44_13 or var_44_13 * (utf8.len(var_44_15) / 12)

				if (12 <= 0 and var_44_13 or var_44_13 * (utf8.len(var_44_15) / 12)) > 0 and var_44_13 < var_44_17 then
					arg_41_1.talkMaxDuration = var_44_17

					if var_44_17 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_17 + var_44_12
					end
				end

				arg_41_1.text_.text = var_44_15
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282010", "story_v_out_317282.awb") ~= 0 then
					local var_44_18 = manager.audio:GetVoiceLength("story_v_out_317282", "317282010", "story_v_out_317282.awb") / 1000

					if var_44_18 + var_44_12 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_18 + var_44_12
					end

					if var_44_14.prefab_name ~= "" and arg_41_1.actors_[var_44_14.prefab_name] ~= nil then
						local var_44_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_14.prefab_name].transform, "story_v_out_317282", "317282010", "story_v_out_317282.awb")

						arg_41_1:RecordAudio("317282010", var_44_19)
						arg_41_1:RecordAudio("317282010", var_44_19)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_317282", "317282010", "story_v_out_317282.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_317282", "317282010", "story_v_out_317282.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_20 = math.max(var_44_13, arg_41_1.talkMaxDuration)

			if var_44_12 <= arg_41_1.time_ and arg_41_1.time_ < var_44_12 + var_44_20 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_12) / var_44_20

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_12 + var_44_20 and arg_41_1.time_ < var_44_12 + var_44_20 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play317282011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 317282011
		arg_45_1.duration_ = 2.1

		local var_45_0 = {
			zh = 2.1,
			ja = 1.766
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play317282012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos2078ui_story = arg_45_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos2078ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).z)
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles = arg_45_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_45_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["2078ui_story"].transform.position).z)
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["2078ui_story"].transform.localEulerAngles = arg_45_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["2078ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect2078ui_story == nil then
				arg_45_1.var_.characterEffect2078ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect2078ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect2078ui_story then
				arg_45_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_48_4 = arg_45_1.actors_["2079ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect2079ui_story == nil then
				arg_45_1.var_.characterEffect2079ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_5 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and not isNil(var_48_4) then
				if arg_45_1.var_.characterEffect2079ui_story and not isNil(var_48_4) then
					arg_45_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_45_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_5)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect2079ui_story then
				arg_45_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_45_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_48_6 = 0
			local var_48_7 = 0.15

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(317282011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 6 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 6)

				if (6 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 6)) > 0 and var_48_7 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282011", "story_v_out_317282.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282011", "story_v_out_317282.awb") / 1000

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_317282", "317282011", "story_v_out_317282.awb")

						arg_45_1:RecordAudio("317282011", var_48_13)
						arg_45_1:RecordAudio("317282011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_317282", "317282011", "story_v_out_317282.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_317282", "317282011", "story_v_out_317282.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play317282012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 317282012
		arg_49_1.duration_ = 3.27

		local var_49_0 = {
			zh = 3.266,
			ja = 2.1
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play317282013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos2079ui_story = arg_49_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos2079ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).z)
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles = arg_49_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_49_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["2079ui_story"].transform.position).z)
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["2079ui_story"].transform.localEulerAngles = arg_49_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["2079ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect2079ui_story == nil then
				arg_49_1.var_.characterEffect2079ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect2079ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect2079ui_story then
				arg_49_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["2078ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect2078ui_story == nil then
				arg_49_1.var_.characterEffect2078ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_5 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 and not isNil(var_52_4) then
				if arg_49_1.var_.characterEffect2078ui_story and not isNil(var_52_4) then
					arg_49_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_49_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_5)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect2078ui_story then
				arg_49_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_49_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_52_6 = 0
			local var_52_7 = 0.25

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(317282012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 10 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 10)

				if (10 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 10)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282012", "story_v_out_317282.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282012", "story_v_out_317282.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_317282", "317282012", "story_v_out_317282.awb")

						arg_49_1:RecordAudio("317282012", var_52_13)
						arg_49_1:RecordAudio("317282012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_317282", "317282012", "story_v_out_317282.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_317282", "317282012", "story_v_out_317282.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play317282013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 317282013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play317282014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos2079ui_story = arg_53_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_56_0 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 then
				arg_53_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_0)
				arg_53_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).z)
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles = arg_53_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 then
				arg_53_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_53_1.actors_["2079ui_story"].transform.position).z)
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_53_1.actors_["2079ui_story"].transform.localEulerAngles = arg_53_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_56_1 = arg_53_1.actors_["2078ui_story"].transform

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.var_.moveOldPos2078ui_story = var_56_1.localPosition
			end

			local var_56_2 = 0.001

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_2 then
				var_56_1.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 0) / var_56_2)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			if arg_53_1.time_ >= 0 + var_56_2 and arg_53_1.time_ < 0 + var_56_2 + arg_56_0 then
				var_56_1.localPosition = Vector3.New(0, 100, 0)
				var_56_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_1.position).x, (manager.ui.mainCamera.transform.position - var_56_1.position).y, (manager.ui.mainCamera.transform.position - var_56_1.position).z)
				var_56_1.localEulerAngles.z = 0
				var_56_1.localEulerAngles.x = 0
				var_56_1.localEulerAngles = var_56_1.localEulerAngles
			end

			local var_56_3 = 0
			local var_56_4 = 0.275

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_3 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, false)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_5 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(317282013).content)

				arg_53_1.text_.text = var_56_5

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_7 = 11 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 11)

				if (11 <= 0 and var_56_4 or var_56_4 * (utf8.len(var_56_5) / 11)) > 0 and var_56_4 < var_56_7 then
					arg_53_1.talkMaxDuration = var_56_7

					if var_56_7 + var_56_3 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_7 + var_56_3
					end
				end

				arg_53_1.text_.text = var_56_5
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_8 = math.max(var_56_4, arg_53_1.talkMaxDuration)

			if var_56_3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_3 + var_56_8 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_3) / var_56_8

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_3 + var_56_8 and arg_53_1.time_ < var_56_3 + var_56_8 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play317282014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 317282014
		arg_57_1.duration_ = 3.7

		local var_57_0 = {
			zh = 3.1,
			ja = 3.7
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play317282015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if arg_57_1.actors_["1015ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1015ui_story"))) then
				local var_60_0 = Object.Instantiate(Asset.Load("Char/" .. "1015ui_story"), arg_57_1.stage_.transform)

				var_60_0.name = "1015ui_story"
				var_60_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_57_1.actors_["1015ui_story"] = var_60_0

				local var_60_1 = var_60_0:GetComponentInChildren(typeof(CharacterEffect))

				var_60_1.enabled = true

				local var_60_2 = GameObjectTools.GetOrAddComponent(var_60_0, typeof(DynamicBoneHelper))

				if var_60_2 then
					var_60_2:EnableDynamicBone(false)
				end

				arg_57_1:ShowWeapon(var_60_1.transform, false)

				arg_57_1.var_["1015ui_story" .. "Animator"] = var_60_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_57_1.var_["1015ui_story" .. "Animator"].applyRootMotion = true
				arg_57_1.var_["1015ui_story" .. "LipSync"] = var_60_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_60_3 = arg_57_1.actors_["1015ui_story"].transform

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos1015ui_story = var_60_3.localPosition
			end

			local var_60_4 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_4 then
				var_60_3.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_57_1.time_ - 0) / var_60_4)
				var_60_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_3.position).x, (manager.ui.mainCamera.transform.position - var_60_3.position).y, (manager.ui.mainCamera.transform.position - var_60_3.position).z)
				var_60_3.localEulerAngles.z = 0
				var_60_3.localEulerAngles.x = 0
				var_60_3.localEulerAngles = var_60_3.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_4 and arg_57_1.time_ < 0 + var_60_4 + arg_60_0 then
				var_60_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_60_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_60_3.position).x, (manager.ui.mainCamera.transform.position - var_60_3.position).y, (manager.ui.mainCamera.transform.position - var_60_3.position).z)
				var_60_3.localEulerAngles.z = 0
				var_60_3.localEulerAngles.x = 0
				var_60_3.localEulerAngles = var_60_3.localEulerAngles
			end

			local var_60_5 = arg_57_1.actors_["1015ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1015ui_story == nil then
				arg_57_1.var_.characterEffect1015ui_story = var_60_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_6 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_6 and not isNil(var_60_5) then
				if arg_57_1.var_.characterEffect1015ui_story and not isNil(var_60_5) then
					arg_57_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_6 and arg_57_1.time_ < 0 + var_60_6 + arg_60_0 and not isNil(var_60_5) and arg_57_1.var_.characterEffect1015ui_story then
				arg_57_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_60_8 = 0
			local var_60_9 = 0.35

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_8 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_10 = arg_57_1:GetWordFromCfg(317282014)
				local var_60_11 = arg_57_1:FormatText(var_60_10.content)

				arg_57_1.text_.text = var_60_11

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_13 = 14 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 14)

				if (14 <= 0 and var_60_9 or var_60_9 * (utf8.len(var_60_11) / 14)) > 0 and var_60_9 < var_60_13 then
					arg_57_1.talkMaxDuration = var_60_13

					if var_60_13 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_13 + var_60_8
					end
				end

				arg_57_1.text_.text = var_60_11
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282014", "story_v_out_317282.awb") ~= 0 then
					local var_60_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282014", "story_v_out_317282.awb") / 1000

					if var_60_14 + var_60_8 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_14 + var_60_8
					end

					if var_60_10.prefab_name ~= "" and arg_57_1.actors_[var_60_10.prefab_name] ~= nil then
						local var_60_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_10.prefab_name].transform, "story_v_out_317282", "317282014", "story_v_out_317282.awb")

						arg_57_1:RecordAudio("317282014", var_60_15)
						arg_57_1:RecordAudio("317282014", var_60_15)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_317282", "317282014", "story_v_out_317282.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_317282", "317282014", "story_v_out_317282.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_16 = math.max(var_60_9, arg_57_1.talkMaxDuration)

			if var_60_8 <= arg_57_1.time_ and arg_57_1.time_ < var_60_8 + var_60_16 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_8) / var_60_16

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_8 + var_60_16 and arg_57_1.time_ < var_60_8 + var_60_16 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_57_1:InitPlayNodeList()
	end,
	Play317282015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 317282015
		arg_61_1.duration_ = 3.7

		local var_61_0 = {
			zh = 2.7,
			ja = 3.7
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play317282016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos2079ui_story = arg_61_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["2079ui_story"].transform.position).z)
				arg_61_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["2079ui_story"].transform.localEulerAngles = arg_61_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_61_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["2079ui_story"].transform.position).z)
				arg_61_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["2079ui_story"].transform.localEulerAngles = arg_61_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["2079ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect2079ui_story == nil then
				arg_61_1.var_.characterEffect2079ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect2079ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect2079ui_story then
				arg_61_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_64_4 = arg_61_1.actors_["1015ui_story"].transform

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos1015ui_story = var_64_4.localPosition
			end

			local var_64_5 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 then
				var_64_4.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_61_1.time_ - 0) / var_64_5)
				var_64_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_4.position).x, (manager.ui.mainCamera.transform.position - var_64_4.position).y, (manager.ui.mainCamera.transform.position - var_64_4.position).z)
				var_64_4.localEulerAngles.z = 0
				var_64_4.localEulerAngles.x = 0
				var_64_4.localEulerAngles = var_64_4.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 then
				var_64_4.localPosition = Vector3.New(0, 100, 0)
				var_64_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_64_4.position).x, (manager.ui.mainCamera.transform.position - var_64_4.position).y, (manager.ui.mainCamera.transform.position - var_64_4.position).z)
				var_64_4.localEulerAngles.z = 0
				var_64_4.localEulerAngles.x = 0
				var_64_4.localEulerAngles = var_64_4.localEulerAngles
			end

			local var_64_6 = arg_61_1.actors_["1015ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1015ui_story == nil then
				arg_61_1.var_.characterEffect1015ui_story = var_64_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_7 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_7 and not isNil(var_64_6) then
				if arg_61_1.var_.characterEffect1015ui_story and not isNil(var_64_6) then
					arg_61_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_7)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_7 and arg_61_1.time_ < 0 + var_64_7 + arg_64_0 and not isNil(var_64_6) and arg_61_1.var_.characterEffect1015ui_story then
				arg_61_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_64_8 = 0
			local var_64_9 = 0.3

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_8 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_10 = arg_61_1:GetWordFromCfg(317282015)
				local var_64_11 = arg_61_1:FormatText(var_64_10.content)

				arg_61_1.text_.text = var_64_11

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_13 = 12 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 12)

				if (12 <= 0 and var_64_9 or var_64_9 * (utf8.len(var_64_11) / 12)) > 0 and var_64_9 < var_64_13 then
					arg_61_1.talkMaxDuration = var_64_13

					if var_64_13 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_13 + var_64_8
					end
				end

				arg_61_1.text_.text = var_64_11
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282015", "story_v_out_317282.awb") ~= 0 then
					local var_64_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282015", "story_v_out_317282.awb") / 1000

					if var_64_14 + var_64_8 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_14 + var_64_8
					end

					if var_64_10.prefab_name ~= "" and arg_61_1.actors_[var_64_10.prefab_name] ~= nil then
						local var_64_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_10.prefab_name].transform, "story_v_out_317282", "317282015", "story_v_out_317282.awb")

						arg_61_1:RecordAudio("317282015", var_64_15)
						arg_61_1:RecordAudio("317282015", var_64_15)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_317282", "317282015", "story_v_out_317282.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_317282", "317282015", "story_v_out_317282.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_16 = math.max(var_64_9, arg_61_1.talkMaxDuration)

			if var_64_8 <= arg_61_1.time_ and arg_61_1.time_ < var_64_8 + var_64_16 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_8) / var_64_16

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_8 + var_64_16 and arg_61_1.time_ < var_64_8 + var_64_16 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_61_1:InitPlayNodeList()
	end,
	Play317282016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 317282016
		arg_65_1.duration_ = 2

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play317282017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1015ui_story = arg_65_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1015ui_story"].transform.position).z)
				arg_65_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1015ui_story"].transform.localEulerAngles = arg_65_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_65_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1015ui_story"].transform.position).z)
				arg_65_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1015ui_story"].transform.localEulerAngles = arg_65_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1015ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1015ui_story == nil then
				arg_65_1.var_.characterEffect1015ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1015ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1015ui_story then
				arg_65_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_68_4 = arg_65_1.actors_["2079ui_story"].transform

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos2079ui_story = var_68_4.localPosition
			end

			local var_68_5 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 then
				var_68_4.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_65_1.time_ - 0) / var_68_5)
				var_68_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_4.position).x, (manager.ui.mainCamera.transform.position - var_68_4.position).y, (manager.ui.mainCamera.transform.position - var_68_4.position).z)
				var_68_4.localEulerAngles.z = 0
				var_68_4.localEulerAngles.x = 0
				var_68_4.localEulerAngles = var_68_4.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 then
				var_68_4.localPosition = Vector3.New(0, 100, 0)
				var_68_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_68_4.position).x, (manager.ui.mainCamera.transform.position - var_68_4.position).y, (manager.ui.mainCamera.transform.position - var_68_4.position).z)
				var_68_4.localEulerAngles.z = 0
				var_68_4.localEulerAngles.x = 0
				var_68_4.localEulerAngles = var_68_4.localEulerAngles
			end

			local var_68_6 = arg_65_1.actors_["2079ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect2079ui_story == nil then
				arg_65_1.var_.characterEffect2079ui_story = var_68_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_7 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_7 and not isNil(var_68_6) then
				if arg_65_1.var_.characterEffect2079ui_story and not isNil(var_68_6) then
					arg_65_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_65_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_7)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_7 and arg_65_1.time_ < 0 + var_68_7 + arg_68_0 and not isNil(var_68_6) and arg_65_1.var_.characterEffect2079ui_story then
				arg_65_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_65_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_68_8 = 0
			local var_68_9 = 0.1

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_8 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_10 = arg_65_1:GetWordFromCfg(317282016)
				local var_68_11 = arg_65_1:FormatText(var_68_10.content)

				arg_65_1.text_.text = var_68_11

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_13 = 4 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 4)

				if (4 <= 0 and var_68_9 or var_68_9 * (utf8.len(var_68_11) / 4)) > 0 and var_68_9 < var_68_13 then
					arg_65_1.talkMaxDuration = var_68_13

					if var_68_13 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_13 + var_68_8
					end
				end

				arg_65_1.text_.text = var_68_11
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282016", "story_v_out_317282.awb") ~= 0 then
					local var_68_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282016", "story_v_out_317282.awb") / 1000

					if var_68_14 + var_68_8 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_14 + var_68_8
					end

					if var_68_10.prefab_name ~= "" and arg_65_1.actors_[var_68_10.prefab_name] ~= nil then
						local var_68_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_10.prefab_name].transform, "story_v_out_317282", "317282016", "story_v_out_317282.awb")

						arg_65_1:RecordAudio("317282016", var_68_15)
						arg_65_1:RecordAudio("317282016", var_68_15)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_317282", "317282016", "story_v_out_317282.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_317282", "317282016", "story_v_out_317282.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_16 = math.max(var_68_9, arg_65_1.talkMaxDuration)

			if var_68_8 <= arg_65_1.time_ and arg_65_1.time_ < var_68_8 + var_68_16 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_8) / var_68_16

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_8 + var_68_16 and arg_65_1.time_ < var_68_8 + var_68_16 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_65_1:InitPlayNodeList()
	end,
	Play317282017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 317282017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play317282018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1015ui_story"]) and arg_69_1.var_.characterEffect1015ui_story == nil then
				arg_69_1.var_.characterEffect1015ui_story = arg_69_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1015ui_story"]) then
				if arg_69_1.var_.characterEffect1015ui_story and not isNil(arg_69_1.actors_["1015ui_story"]) then
					arg_69_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1015ui_story"]) and arg_69_1.var_.characterEffect1015ui_story then
				arg_69_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.625

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(317282017).content)

				arg_69_1.text_.text = var_72_3

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_5 = 25 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 25)

				if (25 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_3) / 25)) > 0 and var_72_2 < var_72_5 then
					arg_69_1.talkMaxDuration = var_72_5

					if var_72_5 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_5 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_3
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_6 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_6 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_6

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_6 and arg_69_1.time_ < var_72_1 + var_72_6 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play317282018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 317282018
		arg_73_1.duration_ = 6.7

		local var_73_0 = {
			zh = 5.233,
			ja = 6.7
		}
		local var_73_1 = manager.audio:GetLocalizationFlag()

		if var_73_0[var_73_1] ~= nil then
			arg_73_1.duration_ = var_73_0[var_73_1]
		end

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play317282019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1015ui_story"]) and arg_73_1.var_.characterEffect1015ui_story == nil then
				arg_73_1.var_.characterEffect1015ui_story = arg_73_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1015ui_story"]) then
				if arg_73_1.var_.characterEffect1015ui_story and not isNil(arg_73_1.actors_["1015ui_story"]) then
					arg_73_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1015ui_story"]) and arg_73_1.var_.characterEffect1015ui_story then
				arg_73_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			local var_76_2 = 0
			local var_76_3 = 0.725

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_2 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_4 = arg_73_1:GetWordFromCfg(317282018)
				local var_76_5 = arg_73_1:FormatText(var_76_4.content)

				arg_73_1.text_.text = var_76_5

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_7 = 29 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 29)

				if (29 <= 0 and var_76_3 or var_76_3 * (utf8.len(var_76_5) / 29)) > 0 and var_76_3 < var_76_7 then
					arg_73_1.talkMaxDuration = var_76_7

					if var_76_7 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_7 + var_76_2
					end
				end

				arg_73_1.text_.text = var_76_5
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282018", "story_v_out_317282.awb") ~= 0 then
					local var_76_8 = manager.audio:GetVoiceLength("story_v_out_317282", "317282018", "story_v_out_317282.awb") / 1000

					if var_76_8 + var_76_2 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_8 + var_76_2
					end

					if var_76_4.prefab_name ~= "" and arg_73_1.actors_[var_76_4.prefab_name] ~= nil then
						local var_76_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_4.prefab_name].transform, "story_v_out_317282", "317282018", "story_v_out_317282.awb")

						arg_73_1:RecordAudio("317282018", var_76_9)
						arg_73_1:RecordAudio("317282018", var_76_9)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_317282", "317282018", "story_v_out_317282.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_317282", "317282018", "story_v_out_317282.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_10 = math.max(var_76_3, arg_73_1.talkMaxDuration)

			if var_76_2 <= arg_73_1.time_ and arg_73_1.time_ < var_76_2 + var_76_10 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_2) / var_76_10

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_2 + var_76_10 and arg_73_1.time_ < var_76_2 + var_76_10 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play317282019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 317282019
		arg_77_1.duration_ = 2.87

		local var_77_0 = {
			zh = 2.866,
			ja = 2.3
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play317282020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1015ui_story = arg_77_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).z)
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles = arg_77_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1015ui_story"].transform.position).z)
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1015ui_story"].transform.localEulerAngles = arg_77_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1015ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1015ui_story == nil then
				arg_77_1.var_.characterEffect1015ui_story = var_80_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_2 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 and not isNil(var_80_1) then
				if arg_77_1.var_.characterEffect1015ui_story and not isNil(var_80_1) then
					arg_77_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_2)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 and not isNil(var_80_1) and arg_77_1.var_.characterEffect1015ui_story then
				arg_77_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_80_3 = arg_77_1.actors_["2079ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos2079ui_story = var_80_3.localPosition
			end

			local var_80_4 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_3.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_77_1.time_ - 0) / var_80_4)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_80_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_3.position).x, (manager.ui.mainCamera.transform.position - var_80_3.position).y, (manager.ui.mainCamera.transform.position - var_80_3.position).z)
				var_80_3.localEulerAngles.z = 0
				var_80_3.localEulerAngles.x = 0
				var_80_3.localEulerAngles = var_80_3.localEulerAngles
			end

			local var_80_5 = arg_77_1.actors_["2079ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect2079ui_story == nil then
				arg_77_1.var_.characterEffect2079ui_story = var_80_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_6 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 and not isNil(var_80_5) then
				if arg_77_1.var_.characterEffect2079ui_story and not isNil(var_80_5) then
					arg_77_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 and not isNil(var_80_5) and arg_77_1.var_.characterEffect2079ui_story then
				arg_77_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_80_8 = 0
			local var_80_9 = 0.25

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_8 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_10 = arg_77_1:GetWordFromCfg(317282019)
				local var_80_11 = arg_77_1:FormatText(var_80_10.content)

				arg_77_1.text_.text = var_80_11

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_13 = 10 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 10)

				if (10 <= 0 and var_80_9 or var_80_9 * (utf8.len(var_80_11) / 10)) > 0 and var_80_9 < var_80_13 then
					arg_77_1.talkMaxDuration = var_80_13

					if var_80_13 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_13 + var_80_8
					end
				end

				arg_77_1.text_.text = var_80_11
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282019", "story_v_out_317282.awb") ~= 0 then
					local var_80_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282019", "story_v_out_317282.awb") / 1000

					if var_80_14 + var_80_8 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_14 + var_80_8
					end

					if var_80_10.prefab_name ~= "" and arg_77_1.actors_[var_80_10.prefab_name] ~= nil then
						local var_80_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_10.prefab_name].transform, "story_v_out_317282", "317282019", "story_v_out_317282.awb")

						arg_77_1:RecordAudio("317282019", var_80_15)
						arg_77_1:RecordAudio("317282019", var_80_15)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_317282", "317282019", "story_v_out_317282.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_317282", "317282019", "story_v_out_317282.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_16 = math.max(var_80_9, arg_77_1.talkMaxDuration)

			if var_80_8 <= arg_77_1.time_ and arg_77_1.time_ < var_80_8 + var_80_16 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_8) / var_80_16

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_8 + var_80_16 and arg_77_1.time_ < var_80_8 + var_80_16 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play317282020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 317282020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play317282021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos2079ui_story = arg_81_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["2079ui_story"].transform.position).z)
				arg_81_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["2079ui_story"].transform.localEulerAngles = arg_81_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_81_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["2079ui_story"].transform.position).z)
				arg_81_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["2079ui_story"].transform.localEulerAngles = arg_81_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_84_1 = arg_81_1.actors_["2079ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect2079ui_story == nil then
				arg_81_1.var_.characterEffect2079ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect2079ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_81_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_2)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect2079ui_story then
				arg_81_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_81_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_84_3 = 0
			local var_84_4 = 1

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_5 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(317282020).content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 40 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 40)

				if (40 <= 0 and var_84_4 or var_84_4 * (utf8.len(var_84_5) / 40)) > 0 and var_84_4 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_3 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_3
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_8 = math.max(var_84_4, arg_81_1.talkMaxDuration)

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_8 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_3) / var_84_8

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_3 + var_84_8 and arg_81_1.time_ < var_84_3 + var_84_8 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play317282021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 317282021
		arg_85_1.duration_ = 3.33

		local var_85_0 = {
			zh = 3.333,
			ja = 3.2
		}
		local var_85_1 = manager.audio:GetLocalizationFlag()

		if var_85_0[var_85_1] ~= nil then
			arg_85_1.duration_ = var_85_0[var_85_1]
		end

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play317282022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos2078ui_story = arg_85_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_88_0 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 then
				arg_85_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_85_1.time_ - 0) / var_88_0)
				arg_85_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["2078ui_story"].transform.position).z)
				arg_85_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["2078ui_story"].transform.localEulerAngles = arg_85_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 then
				arg_85_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_85_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_85_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_85_1.actors_["2078ui_story"].transform.position).z)
				arg_85_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_85_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_85_1.actors_["2078ui_story"].transform.localEulerAngles = arg_85_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_88_1 = arg_85_1.actors_["2078ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect2078ui_story == nil then
				arg_85_1.var_.characterEffect2078ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect2078ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect2078ui_story then
				arg_85_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_88_4 = 0
			local var_88_5 = 0.275

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(317282021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 11 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 11)

				if (11 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 11)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282021", "story_v_out_317282.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282021", "story_v_out_317282.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_317282", "317282021", "story_v_out_317282.awb")

						arg_85_1:RecordAudio("317282021", var_88_11)
						arg_85_1:RecordAudio("317282021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_317282", "317282021", "story_v_out_317282.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_317282", "317282021", "story_v_out_317282.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play317282022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 317282022
		arg_89_1.duration_ = 5.83

		local var_89_0 = {
			zh = 4.6,
			ja = 5.833
		}
		local var_89_1 = manager.audio:GetLocalizationFlag()

		if var_89_0[var_89_1] ~= nil then
			arg_89_1.duration_ = var_89_0[var_89_1]
		end

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play317282023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos2079ui_story = arg_89_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).z)
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles = arg_89_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_89_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["2079ui_story"].transform.position).z)
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["2079ui_story"].transform.localEulerAngles = arg_89_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["2079ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect2079ui_story == nil then
				arg_89_1.var_.characterEffect2079ui_story = var_92_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_2 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 and not isNil(var_92_1) then
				if arg_89_1.var_.characterEffect2079ui_story and not isNil(var_92_1) then
					arg_89_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 and not isNil(var_92_1) and arg_89_1.var_.characterEffect2079ui_story then
				arg_89_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_92_4 = arg_89_1.actors_["2078ui_story"]

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect2078ui_story == nil then
				arg_89_1.var_.characterEffect2078ui_story = var_92_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_5 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_5 and not isNil(var_92_4) then
				if arg_89_1.var_.characterEffect2078ui_story and not isNil(var_92_4) then
					arg_89_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_89_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_5)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_5 and arg_89_1.time_ < 0 + var_92_5 + arg_92_0 and not isNil(var_92_4) and arg_89_1.var_.characterEffect2078ui_story then
				arg_89_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_89_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_92_6 = 0
			local var_92_7 = 0.125

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_6 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, true)

				arg_89_1.leftNameTxt_.text = arg_89_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_89_1.leftNameTxt_.transform)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1.leftNameTxt_.text)
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_8 = arg_89_1:GetWordFromCfg(317282022)
				local var_92_9 = arg_89_1:FormatText(var_92_8.content)

				arg_89_1.text_.text = var_92_9

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_11 = 5 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 5)

				if (5 <= 0 and var_92_7 or var_92_7 * (utf8.len(var_92_9) / 5)) > 0 and var_92_7 < var_92_11 then
					arg_89_1.talkMaxDuration = var_92_11

					if var_92_11 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_11 + var_92_6
					end
				end

				arg_89_1.text_.text = var_92_9
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282022", "story_v_out_317282.awb") ~= 0 then
					local var_92_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282022", "story_v_out_317282.awb") / 1000

					if var_92_12 + var_92_6 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_12 + var_92_6
					end

					if var_92_8.prefab_name ~= "" and arg_89_1.actors_[var_92_8.prefab_name] ~= nil then
						local var_92_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_89_1.actors_[var_92_8.prefab_name].transform, "story_v_out_317282", "317282022", "story_v_out_317282.awb")

						arg_89_1:RecordAudio("317282022", var_92_13)
						arg_89_1:RecordAudio("317282022", var_92_13)
					else
						arg_89_1:AudioAction("play", "voice", "story_v_out_317282", "317282022", "story_v_out_317282.awb")
					end

					arg_89_1:RecordHistoryTalkVoice("story_v_out_317282", "317282022", "story_v_out_317282.awb")
				end

				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_14 = math.max(var_92_7, arg_89_1.talkMaxDuration)

			if var_92_6 <= arg_89_1.time_ and arg_89_1.time_ < var_92_6 + var_92_14 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_6) / var_92_14

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_6 + var_92_14 and arg_89_1.time_ < var_92_6 + var_92_14 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	Play317282023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 317282023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play317282024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(arg_93_1.actors_["2079ui_story"]) and arg_93_1.var_.characterEffect2079ui_story == nil then
				arg_93_1.var_.characterEffect2079ui_story = arg_93_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_0 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 and not isNil(arg_93_1.actors_["2079ui_story"]) then
				if arg_93_1.var_.characterEffect2079ui_story and not isNil(arg_93_1.actors_["2079ui_story"]) then
					arg_93_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_93_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_0)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 and not isNil(arg_93_1.actors_["2079ui_story"]) and arg_93_1.var_.characterEffect2079ui_story then
				arg_93_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_93_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_96_1 = 0
			local var_96_2 = 0.325

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_3 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(317282023).content)

				arg_93_1.text_.text = var_96_3

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_5 = 13 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 13)

				if (13 <= 0 and var_96_2 or var_96_2 * (utf8.len(var_96_3) / 13)) > 0 and var_96_2 < var_96_5 then
					arg_93_1.talkMaxDuration = var_96_5

					if var_96_5 + var_96_1 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_5 + var_96_1
					end
				end

				arg_93_1.text_.text = var_96_3
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_6 = math.max(var_96_2, arg_93_1.talkMaxDuration)

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_6 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_1) / var_96_6

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_1 + var_96_6 and arg_93_1.time_ < var_96_1 + var_96_6 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play317282024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 317282024
		arg_97_1.duration_ = 7.23

		local var_97_0 = {
			zh = 5.6,
			ja = 7.233
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play317282025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos2078ui_story = arg_97_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["2078ui_story"].transform.position).z)
				arg_97_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["2078ui_story"].transform.localEulerAngles = arg_97_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_97_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["2078ui_story"].transform.position).z)
				arg_97_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["2078ui_story"].transform.localEulerAngles = arg_97_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_100_1 = arg_97_1.actors_["2078ui_story"]

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect2078ui_story == nil then
				arg_97_1.var_.characterEffect2078ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_2 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_2 and not isNil(var_100_1) then
				if arg_97_1.var_.characterEffect2078ui_story and not isNil(var_100_1) then
					arg_97_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_2 and arg_97_1.time_ < 0 + var_100_2 + arg_100_0 and not isNil(var_100_1) and arg_97_1.var_.characterEffect2078ui_story then
				arg_97_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_100_4 = 0
			local var_100_5 = 0.8

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_4 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_6 = arg_97_1:GetWordFromCfg(317282024)
				local var_100_7 = arg_97_1:FormatText(var_100_6.content)

				arg_97_1.text_.text = var_100_7

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_9 = 32 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 32)

				if (32 <= 0 and var_100_5 or var_100_5 * (utf8.len(var_100_7) / 32)) > 0 and var_100_5 < var_100_9 then
					arg_97_1.talkMaxDuration = var_100_9

					if var_100_9 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_9 + var_100_4
					end
				end

				arg_97_1.text_.text = var_100_7
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282024", "story_v_out_317282.awb") ~= 0 then
					local var_100_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282024", "story_v_out_317282.awb") / 1000

					if var_100_10 + var_100_4 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_10 + var_100_4
					end

					if var_100_6.prefab_name ~= "" and arg_97_1.actors_[var_100_6.prefab_name] ~= nil then
						local var_100_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_6.prefab_name].transform, "story_v_out_317282", "317282024", "story_v_out_317282.awb")

						arg_97_1:RecordAudio("317282024", var_100_11)
						arg_97_1:RecordAudio("317282024", var_100_11)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_317282", "317282024", "story_v_out_317282.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_317282", "317282024", "story_v_out_317282.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_12 = math.max(var_100_5, arg_97_1.talkMaxDuration)

			if var_100_4 <= arg_97_1.time_ and arg_97_1.time_ < var_100_4 + var_100_12 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_4) / var_100_12

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_4 + var_100_12 and arg_97_1.time_ < var_100_4 + var_100_12 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play317282025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 317282025
		arg_101_1.duration_ = 8.87

		local var_101_0 = {
			zh = 8.866,
			ja = 6.5
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play317282026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos2079ui_story = arg_101_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["2079ui_story"].transform.position).z)
				arg_101_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["2079ui_story"].transform.localEulerAngles = arg_101_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_101_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["2079ui_story"].transform.position).z)
				arg_101_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["2079ui_story"].transform.localEulerAngles = arg_101_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["2079ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect2079ui_story == nil then
				arg_101_1.var_.characterEffect2079ui_story = var_104_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 and not isNil(var_104_1) then
				if arg_101_1.var_.characterEffect2079ui_story and not isNil(var_104_1) then
					arg_101_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 and not isNil(var_104_1) and arg_101_1.var_.characterEffect2079ui_story then
				arg_101_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_104_4 = arg_101_1.actors_["2078ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect2078ui_story == nil then
				arg_101_1.var_.characterEffect2078ui_story = var_104_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_5 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_5 and not isNil(var_104_4) then
				if arg_101_1.var_.characterEffect2078ui_story and not isNil(var_104_4) then
					arg_101_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_101_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_5)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_5 and arg_101_1.time_ < 0 + var_104_5 + arg_104_0 and not isNil(var_104_4) and arg_101_1.var_.characterEffect2078ui_story then
				arg_101_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_101_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_104_6 = 0
			local var_104_7 = 0.7

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_6 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_8 = arg_101_1:GetWordFromCfg(317282025)
				local var_104_9 = arg_101_1:FormatText(var_104_8.content)

				arg_101_1.text_.text = var_104_9

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_11 = 28 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 28)

				if (28 <= 0 and var_104_7 or var_104_7 * (utf8.len(var_104_9) / 28)) > 0 and var_104_7 < var_104_11 then
					arg_101_1.talkMaxDuration = var_104_11

					if var_104_11 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_11 + var_104_6
					end
				end

				arg_101_1.text_.text = var_104_9
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282025", "story_v_out_317282.awb") ~= 0 then
					local var_104_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282025", "story_v_out_317282.awb") / 1000

					if var_104_12 + var_104_6 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_12 + var_104_6
					end

					if var_104_8.prefab_name ~= "" and arg_101_1.actors_[var_104_8.prefab_name] ~= nil then
						local var_104_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_8.prefab_name].transform, "story_v_out_317282", "317282025", "story_v_out_317282.awb")

						arg_101_1:RecordAudio("317282025", var_104_13)
						arg_101_1:RecordAudio("317282025", var_104_13)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_317282", "317282025", "story_v_out_317282.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_317282", "317282025", "story_v_out_317282.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_14 = math.max(var_104_7, arg_101_1.talkMaxDuration)

			if var_104_6 <= arg_101_1.time_ and arg_101_1.time_ < var_104_6 + var_104_14 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_6) / var_104_14

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_6 + var_104_14 and arg_101_1.time_ < var_104_6 + var_104_14 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play317282026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 317282026
		arg_105_1.duration_ = 3.97

		local var_105_0 = {
			zh = 2.633,
			ja = 3.966
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play317282027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos2078ui_story = arg_105_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["2078ui_story"].transform.position).z)
				arg_105_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["2078ui_story"].transform.localEulerAngles = arg_105_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["2078ui_story"].transform.position).z)
				arg_105_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["2078ui_story"].transform.localEulerAngles = arg_105_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["2078ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect2078ui_story == nil then
				arg_105_1.var_.characterEffect2078ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect2078ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_105_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_2)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect2078ui_story then
				arg_105_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_105_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_108_3 = arg_105_1.actors_["2079ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos2079ui_story = var_108_3.localPosition
			end

			local var_108_4 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_4 then
				var_108_3.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_105_1.time_ - 0) / var_108_4)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_4 and arg_105_1.time_ < 0 + var_108_4 + arg_108_0 then
				var_108_3.localPosition = Vector3.New(0, 100, 0)
				var_108_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_3.position).x, (manager.ui.mainCamera.transform.position - var_108_3.position).y, (manager.ui.mainCamera.transform.position - var_108_3.position).z)
				var_108_3.localEulerAngles.z = 0
				var_108_3.localEulerAngles.x = 0
				var_108_3.localEulerAngles = var_108_3.localEulerAngles
			end

			local var_108_5 = arg_105_1.actors_["2079ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect2079ui_story == nil then
				arg_105_1.var_.characterEffect2079ui_story = var_108_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_6 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_6 and not isNil(var_108_5) then
				if arg_105_1.var_.characterEffect2079ui_story and not isNil(var_108_5) then
					arg_105_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_105_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_6)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_6 and arg_105_1.time_ < 0 + var_108_6 + arg_108_0 and not isNil(var_108_5) and arg_105_1.var_.characterEffect2079ui_story then
				arg_105_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_105_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_108_7 = arg_105_1.actors_["1093ui_story"].transform

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos1093ui_story = var_108_7.localPosition
			end

			local var_108_8 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_8 then
				var_108_7.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_105_1.time_ - 0) / var_108_8)
				var_108_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_7.position).x, (manager.ui.mainCamera.transform.position - var_108_7.position).y, (manager.ui.mainCamera.transform.position - var_108_7.position).z)
				var_108_7.localEulerAngles.z = 0
				var_108_7.localEulerAngles.x = 0
				var_108_7.localEulerAngles = var_108_7.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_8 and arg_105_1.time_ < 0 + var_108_8 + arg_108_0 then
				var_108_7.localPosition = Vector3.New(0, -1.11, -5.88)
				var_108_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_108_7.position).x, (manager.ui.mainCamera.transform.position - var_108_7.position).y, (manager.ui.mainCamera.transform.position - var_108_7.position).z)
				var_108_7.localEulerAngles.z = 0
				var_108_7.localEulerAngles.x = 0
				var_108_7.localEulerAngles = var_108_7.localEulerAngles
			end

			local var_108_9 = arg_105_1.actors_["1093ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1093ui_story == nil then
				arg_105_1.var_.characterEffect1093ui_story = var_108_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_10 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_10 and not isNil(var_108_9) then
				if arg_105_1.var_.characterEffect1093ui_story and not isNil(var_108_9) then
					arg_105_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_10 and arg_105_1.time_ < 0 + var_108_10 + arg_108_0 and not isNil(var_108_9) and arg_105_1.var_.characterEffect1093ui_story then
				arg_105_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_108_12 = 0
			local var_108_13 = 0.35

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_12 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_14 = arg_105_1:GetWordFromCfg(317282026)
				local var_108_15 = arg_105_1:FormatText(var_108_14.content)

				arg_105_1.text_.text = var_108_15

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_17 = 14 <= 0 and var_108_13 or var_108_13 * (utf8.len(var_108_15) / 14)

				if (14 <= 0 and var_108_13 or var_108_13 * (utf8.len(var_108_15) / 14)) > 0 and var_108_13 < var_108_17 then
					arg_105_1.talkMaxDuration = var_108_17

					if var_108_17 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_17 + var_108_12
					end
				end

				arg_105_1.text_.text = var_108_15
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282026", "story_v_out_317282.awb") ~= 0 then
					local var_108_18 = manager.audio:GetVoiceLength("story_v_out_317282", "317282026", "story_v_out_317282.awb") / 1000

					if var_108_18 + var_108_12 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_18 + var_108_12
					end

					if var_108_14.prefab_name ~= "" and arg_105_1.actors_[var_108_14.prefab_name] ~= nil then
						local var_108_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_14.prefab_name].transform, "story_v_out_317282", "317282026", "story_v_out_317282.awb")

						arg_105_1:RecordAudio("317282026", var_108_19)
						arg_105_1:RecordAudio("317282026", var_108_19)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_317282", "317282026", "story_v_out_317282.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_317282", "317282026", "story_v_out_317282.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_20 = math.max(var_108_13, arg_105_1.talkMaxDuration)

			if var_108_12 <= arg_105_1.time_ and arg_105_1.time_ < var_108_12 + var_108_20 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_12) / var_108_20

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_12 + var_108_20 and arg_105_1.time_ < var_108_12 + var_108_20 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play317282027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 317282027
		arg_109_1.duration_ = 9.7

		local var_109_0 = {
			zh = 6.066,
			ja = 9.7
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play317282028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1093ui_story = arg_109_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).z)
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles = arg_109_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_109_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1093ui_story"].transform.position).z)
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1093ui_story"].transform.localEulerAngles = arg_109_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1093ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1093ui_story == nil then
				arg_109_1.var_.characterEffect1093ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1093ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1093ui_story then
				arg_109_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_112_3 = arg_109_1.actors_["1015ui_story"].transform

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1015ui_story = var_112_3.localPosition
			end

			local var_112_4 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_4 then
				var_112_3.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_109_1.time_ - 0) / var_112_4)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_4 and arg_109_1.time_ < 0 + var_112_4 + arg_112_0 then
				var_112_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_112_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_112_3.position).x, (manager.ui.mainCamera.transform.position - var_112_3.position).y, (manager.ui.mainCamera.transform.position - var_112_3.position).z)
				var_112_3.localEulerAngles.z = 0
				var_112_3.localEulerAngles.x = 0
				var_112_3.localEulerAngles = var_112_3.localEulerAngles
			end

			local var_112_5 = arg_109_1.actors_["1015ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1015ui_story == nil then
				arg_109_1.var_.characterEffect1015ui_story = var_112_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_6 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_6 and not isNil(var_112_5) then
				if arg_109_1.var_.characterEffect1015ui_story and not isNil(var_112_5) then
					arg_109_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_6 and arg_109_1.time_ < 0 + var_112_6 + arg_112_0 and not isNil(var_112_5) and arg_109_1.var_.characterEffect1015ui_story then
				arg_109_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_8 = 0
			local var_112_9 = 0.6

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_8 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_10 = arg_109_1:GetWordFromCfg(317282027)
				local var_112_11 = arg_109_1:FormatText(var_112_10.content)

				arg_109_1.text_.text = var_112_11

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_13 = 24 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 24)

				if (24 <= 0 and var_112_9 or var_112_9 * (utf8.len(var_112_11) / 24)) > 0 and var_112_9 < var_112_13 then
					arg_109_1.talkMaxDuration = var_112_13

					if var_112_13 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_13 + var_112_8
					end
				end

				arg_109_1.text_.text = var_112_11
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282027", "story_v_out_317282.awb") ~= 0 then
					local var_112_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282027", "story_v_out_317282.awb") / 1000

					if var_112_14 + var_112_8 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_14 + var_112_8
					end

					if var_112_10.prefab_name ~= "" and arg_109_1.actors_[var_112_10.prefab_name] ~= nil then
						local var_112_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_10.prefab_name].transform, "story_v_out_317282", "317282027", "story_v_out_317282.awb")

						arg_109_1:RecordAudio("317282027", var_112_15)
						arg_109_1:RecordAudio("317282027", var_112_15)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_317282", "317282027", "story_v_out_317282.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_317282", "317282027", "story_v_out_317282.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_16 = math.max(var_112_9, arg_109_1.talkMaxDuration)

			if var_112_8 <= arg_109_1.time_ and arg_109_1.time_ < var_112_8 + var_112_16 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_8) / var_112_16

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_8 + var_112_16 and arg_109_1.time_ < var_112_8 + var_112_16 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_109_1:InitPlayNodeList()
	end,
	Play317282028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 317282028
		arg_113_1.duration_ = 3.27

		local var_113_0 = {
			zh = 2.033,
			ja = 3.266
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play317282029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos1015ui_story = arg_113_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).z)
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles = arg_113_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_113_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["1015ui_story"].transform.position).z)
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["1015ui_story"].transform.localEulerAngles = arg_113_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["1015ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1015ui_story == nil then
				arg_113_1.var_.characterEffect1015ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect1015ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_2)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect1015ui_story then
				arg_113_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_116_3 = arg_113_1.actors_["2079ui_story"].transform

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos2079ui_story = var_116_3.localPosition
			end

			local var_116_4 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_4 then
				var_116_3.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_113_1.time_ - 0) / var_116_4)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_4 and arg_113_1.time_ < 0 + var_116_4 + arg_116_0 then
				var_116_3.localPosition = Vector3.New(0, -1.28, -5.6)
				var_116_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_116_3.position).x, (manager.ui.mainCamera.transform.position - var_116_3.position).y, (manager.ui.mainCamera.transform.position - var_116_3.position).z)
				var_116_3.localEulerAngles.z = 0
				var_116_3.localEulerAngles.x = 0
				var_116_3.localEulerAngles = var_116_3.localEulerAngles
			end

			local var_116_5 = arg_113_1.actors_["2079ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect2079ui_story == nil then
				arg_113_1.var_.characterEffect2079ui_story = var_116_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_6 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_6 and not isNil(var_116_5) then
				if arg_113_1.var_.characterEffect2079ui_story and not isNil(var_116_5) then
					arg_113_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_6 and arg_113_1.time_ < 0 + var_116_6 + arg_116_0 and not isNil(var_116_5) and arg_113_1.var_.characterEffect2079ui_story then
				arg_113_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_116_8 = 0
			local var_116_9 = 0.175

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_8 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_10 = arg_113_1:GetWordFromCfg(317282028)
				local var_116_11 = arg_113_1:FormatText(var_116_10.content)

				arg_113_1.text_.text = var_116_11

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_13 = 7 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 7)

				if (7 <= 0 and var_116_9 or var_116_9 * (utf8.len(var_116_11) / 7)) > 0 and var_116_9 < var_116_13 then
					arg_113_1.talkMaxDuration = var_116_13

					if var_116_13 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_13 + var_116_8
					end
				end

				arg_113_1.text_.text = var_116_11
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282028", "story_v_out_317282.awb") ~= 0 then
					local var_116_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282028", "story_v_out_317282.awb") / 1000

					if var_116_14 + var_116_8 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_14 + var_116_8
					end

					if var_116_10.prefab_name ~= "" and arg_113_1.actors_[var_116_10.prefab_name] ~= nil then
						local var_116_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_10.prefab_name].transform, "story_v_out_317282", "317282028", "story_v_out_317282.awb")

						arg_113_1:RecordAudio("317282028", var_116_15)
						arg_113_1:RecordAudio("317282028", var_116_15)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_317282", "317282028", "story_v_out_317282.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_317282", "317282028", "story_v_out_317282.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_16 = math.max(var_116_9, arg_113_1.talkMaxDuration)

			if var_116_8 <= arg_113_1.time_ and arg_113_1.time_ < var_116_8 + var_116_16 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_8) / var_116_16

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_8 + var_116_16 and arg_113_1.time_ < var_116_8 + var_116_16 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317282029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 317282029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play317282030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos2079ui_story = arg_117_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["2079ui_story"].transform.position).z)
				arg_117_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["2079ui_story"].transform.localEulerAngles = arg_117_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_117_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["2079ui_story"].transform.position).z)
				arg_117_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["2079ui_story"].transform.localEulerAngles = arg_117_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_120_1 = 0
			local var_120_2 = 0.8

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(317282029).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 32 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 32)

				if (32 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 32)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
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
	Play317282030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 317282030
		arg_121_1.duration_ = 3.93

		local var_121_0 = {
			zh = 3.666,
			ja = 3.933
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play317282031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1093ui_story = arg_121_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).z)
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles = arg_121_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_121_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1093ui_story"].transform.position).z)
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1093ui_story"].transform.localEulerAngles = arg_121_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_124_1 = arg_121_1.actors_["1093ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1093ui_story == nil then
				arg_121_1.var_.characterEffect1093ui_story = var_124_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_2 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_2 and not isNil(var_124_1) then
				if arg_121_1.var_.characterEffect1093ui_story and not isNil(var_124_1) then
					arg_121_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_2 and arg_121_1.time_ < 0 + var_124_2 + arg_124_0 and not isNil(var_124_1) and arg_121_1.var_.characterEffect1093ui_story then
				arg_121_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action1_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_124_4 = 0
			local var_124_5 = 0.4

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(317282030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 16 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 16)

				if (16 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 16)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282030", "story_v_out_317282.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282030", "story_v_out_317282.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_317282", "317282030", "story_v_out_317282.awb")

						arg_121_1:RecordAudio("317282030", var_124_11)
						arg_121_1:RecordAudio("317282030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_317282", "317282030", "story_v_out_317282.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_317282", "317282030", "story_v_out_317282.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play317282031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 317282031
		arg_125_1.duration_ = 6.97

		local var_125_0 = {
			zh = 4.2,
			ja = 6.966
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play317282032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1093ui_story = arg_125_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).z)
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles = arg_125_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_125_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["1093ui_story"].transform.position).z)
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["1093ui_story"].transform.localEulerAngles = arg_125_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["1093ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1093ui_story == nil then
				arg_125_1.var_.characterEffect1093ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect1093ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_2)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect1093ui_story then
				arg_125_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_128_3 = arg_125_1.actors_["1015ui_story"].transform

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos1015ui_story = var_128_3.localPosition
			end

			local var_128_4 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_4 then
				var_128_3.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1015ui_story, Vector3.New(0.7, -1.15, -6.2), (arg_125_1.time_ - 0) / var_128_4)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_4 and arg_125_1.time_ < 0 + var_128_4 + arg_128_0 then
				var_128_3.localPosition = Vector3.New(0.7, -1.15, -6.2)
				var_128_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_3.position).x, (manager.ui.mainCamera.transform.position - var_128_3.position).y, (manager.ui.mainCamera.transform.position - var_128_3.position).z)
				var_128_3.localEulerAngles.z = 0
				var_128_3.localEulerAngles.x = 0
				var_128_3.localEulerAngles = var_128_3.localEulerAngles
			end

			local var_128_5 = arg_125_1.actors_["1015ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1015ui_story == nil then
				arg_125_1.var_.characterEffect1015ui_story = var_128_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_6 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_6 and not isNil(var_128_5) then
				if arg_125_1.var_.characterEffect1015ui_story and not isNil(var_128_5) then
					arg_125_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_6 and arg_125_1.time_ < 0 + var_128_6 + arg_128_0 and not isNil(var_128_5) and arg_125_1.var_.characterEffect1015ui_story then
				arg_125_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_128_8 = 0
			local var_128_9 = 0.45

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_8 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_10 = arg_125_1:GetWordFromCfg(317282031)
				local var_128_11 = arg_125_1:FormatText(var_128_10.content)

				arg_125_1.text_.text = var_128_11

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_13 = 18 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 18)

				if (18 <= 0 and var_128_9 or var_128_9 * (utf8.len(var_128_11) / 18)) > 0 and var_128_9 < var_128_13 then
					arg_125_1.talkMaxDuration = var_128_13

					if var_128_13 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_13 + var_128_8
					end
				end

				arg_125_1.text_.text = var_128_11
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282031", "story_v_out_317282.awb") ~= 0 then
					local var_128_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282031", "story_v_out_317282.awb") / 1000

					if var_128_14 + var_128_8 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_14 + var_128_8
					end

					if var_128_10.prefab_name ~= "" and arg_125_1.actors_[var_128_10.prefab_name] ~= nil then
						local var_128_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_10.prefab_name].transform, "story_v_out_317282", "317282031", "story_v_out_317282.awb")

						arg_125_1:RecordAudio("317282031", var_128_15)
						arg_125_1:RecordAudio("317282031", var_128_15)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_317282", "317282031", "story_v_out_317282.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_317282", "317282031", "story_v_out_317282.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_16 = math.max(var_128_9, arg_125_1.talkMaxDuration)

			if var_128_8 <= arg_125_1.time_ and arg_125_1.time_ < var_128_8 + var_128_16 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_8) / var_128_16

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_8 + var_128_16 and arg_125_1.time_ < var_128_8 + var_128_16 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play317282032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 317282032
		arg_129_1.duration_ = 3.47

		local var_129_0 = {
			zh = 1.999999999999,
			ja = 3.466
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play317282033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1093ui_story = arg_129_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1093ui_story, Vector3.New(-0.7, -1.11, -5.88), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).z)
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles = arg_129_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.88)
				arg_129_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1093ui_story"].transform.position).z)
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1093ui_story"].transform.localEulerAngles = arg_129_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1093ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1093ui_story == nil then
				arg_129_1.var_.characterEffect1093ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1093ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1093ui_story then
				arg_129_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action6_1")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_132_4 = arg_129_1.actors_["1015ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect1015ui_story == nil then
				arg_129_1.var_.characterEffect1015ui_story = var_132_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_5 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 and not isNil(var_132_4) then
				if arg_129_1.var_.characterEffect1015ui_story and not isNil(var_132_4) then
					arg_129_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_5)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect1015ui_story then
				arg_129_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_132_6 = 0
			local var_132_7 = 0.175

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(317282032)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 7 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 7)

				if (7 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 7)) > 0 and var_132_7 < var_132_11 then
					arg_129_1.talkMaxDuration = var_132_11

					if var_132_11 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282032", "story_v_out_317282.awb") ~= 0 then
					local var_132_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282032", "story_v_out_317282.awb") / 1000

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end

					if var_132_8.prefab_name ~= "" and arg_129_1.actors_[var_132_8.prefab_name] ~= nil then
						local var_132_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_8.prefab_name].transform, "story_v_out_317282", "317282032", "story_v_out_317282.awb")

						arg_129_1:RecordAudio("317282032", var_132_13)
						arg_129_1:RecordAudio("317282032", var_132_13)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_317282", "317282032", "story_v_out_317282.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_317282", "317282032", "story_v_out_317282.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play317282033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 317282033
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play317282034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1093ui_story = arg_133_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1093ui_story"].transform.position).z)
				arg_133_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1093ui_story"].transform.localEulerAngles = arg_133_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1093ui_story"].transform.position).z)
				arg_133_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1093ui_story"].transform.localEulerAngles = arg_133_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1015ui_story"].transform

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1015ui_story = var_136_1.localPosition
			end

			local var_136_2 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 then
				var_136_1.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_2)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 then
				var_136_1.localPosition = Vector3.New(0, 100, 0)
				var_136_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_1.position).x, (manager.ui.mainCamera.transform.position - var_136_1.position).y, (manager.ui.mainCamera.transform.position - var_136_1.position).z)
				var_136_1.localEulerAngles.z = 0
				var_136_1.localEulerAngles.x = 0
				var_136_1.localEulerAngles = var_136_1.localEulerAngles
			end

			local var_136_3 = 0
			local var_136_4 = 1.025

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, false)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_5 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(317282033).content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 41 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 41)

				if (41 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 41)) > 0 and var_136_4 < var_136_7 then
					arg_133_1.talkMaxDuration = var_136_7

					if var_136_7 + var_136_3 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_7 + var_136_3
					end
				end

				arg_133_1.text_.text = var_136_5
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_8 = math.max(var_136_4, arg_133_1.talkMaxDuration)

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_8 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_3) / var_136_8

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_3 + var_136_8 and arg_133_1.time_ < var_136_3 + var_136_8 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play317282034 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 317282034
		arg_137_1.duration_ = 2

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play317282035(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos2078ui_story = arg_137_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2078ui_story"].transform.position).z)
				arg_137_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["2078ui_story"].transform.localEulerAngles = arg_137_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_137_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["2078ui_story"].transform.position).z)
				arg_137_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["2078ui_story"].transform.localEulerAngles = arg_137_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["2078ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect2078ui_story == nil then
				arg_137_1.var_.characterEffect2078ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect2078ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect2078ui_story then
				arg_137_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_140_4 = 0
			local var_140_5 = 0.175

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:GetWordFromCfg(317282034)
				local var_140_7 = arg_137_1:FormatText(var_140_6.content)

				arg_137_1.text_.text = var_140_7

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_9 = 7 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 7)

				if (7 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_7) / 7)) > 0 and var_140_5 < var_140_9 then
					arg_137_1.talkMaxDuration = var_140_9

					if var_140_9 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_9 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_7
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282034", "story_v_out_317282.awb") ~= 0 then
					local var_140_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282034", "story_v_out_317282.awb") / 1000

					if var_140_10 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_10 + var_140_4
					end

					if var_140_6.prefab_name ~= "" and arg_137_1.actors_[var_140_6.prefab_name] ~= nil then
						local var_140_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_6.prefab_name].transform, "story_v_out_317282", "317282034", "story_v_out_317282.awb")

						arg_137_1:RecordAudio("317282034", var_140_11)
						arg_137_1:RecordAudio("317282034", var_140_11)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_317282", "317282034", "story_v_out_317282.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_317282", "317282034", "story_v_out_317282.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_12 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_12 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_12

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_12 and arg_137_1.time_ < var_140_4 + var_140_12 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_137_1:InitPlayNodeList()
	end,
	Play317282035 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 317282035
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play317282036(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos2078ui_story = arg_141_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["2078ui_story"].transform.position).z)
				arg_141_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["2078ui_story"].transform.localEulerAngles = arg_141_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_141_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["2078ui_story"].transform.position).z)
				arg_141_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["2078ui_story"].transform.localEulerAngles = arg_141_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_144_1 = 0
			local var_144_2 = 1.35

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, false)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(317282035).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 54 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 54)

				if (54 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 54)) > 0 and var_144_2 < var_144_5 then
					arg_141_1.talkMaxDuration = var_144_5

					if var_144_5 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_5 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_3
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)
				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_6 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_6 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_6

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_6 and arg_141_1.time_ < var_144_1 + var_144_6 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_141_1:InitPlayNodeList()
	end,
	Play317282036 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 317282036
		arg_145_1.duration_ = 5.93

		local var_145_0 = {
			zh = 3.066,
			ja = 5.933
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play317282037(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			local var_148_0 = 0.175

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, true)
				arg_145_1.iconController_:SetSelectedState("hero")

				arg_145_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2079")

				arg_145_1.callingController_:SetSelectedState("normal")

				arg_145_1.keyicon_.color = Color.New(1, 1, 1)
				arg_145_1.icon_.color = Color.New(1, 1, 1)

				local var_148_1 = arg_145_1:GetWordFromCfg(317282036)
				local var_148_2 = arg_145_1:FormatText(var_148_1.content)

				arg_145_1.text_.text = var_148_2

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_4 = 7 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 7)

				if (7 <= 0 and var_148_0 or var_148_0 * (utf8.len(var_148_2) / 7)) > 0 and var_148_0 < var_148_4 then
					arg_145_1.talkMaxDuration = var_148_4

					if var_148_4 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_4 + 0
					end
				end

				arg_145_1.text_.text = var_148_2
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282036", "story_v_out_317282.awb") ~= 0 then
					local var_148_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282036", "story_v_out_317282.awb") / 1000

					if var_148_5 + 0 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + 0
					end

					if var_148_1.prefab_name ~= "" and arg_145_1.actors_[var_148_1.prefab_name] ~= nil then
						local var_148_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_1.prefab_name].transform, "story_v_out_317282", "317282036", "story_v_out_317282.awb")

						arg_145_1:RecordAudio("317282036", var_148_6)
						arg_145_1:RecordAudio("317282036", var_148_6)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_317282", "317282036", "story_v_out_317282.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_317282", "317282036", "story_v_out_317282.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_7 = math.max(var_148_0, arg_145_1.talkMaxDuration)

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_7 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - 0) / var_148_7

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= 0 + var_148_7 and arg_145_1.time_ < 0 + var_148_7 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {}

		arg_145_1:InitPlayNodeList()
	end,
	Play317282037 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 317282037
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play317282038(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.725

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, false)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(317282037).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 29 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 29)

				if (29 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 29)) > 0 and var_152_0 < var_152_3 then
					arg_149_1.talkMaxDuration = var_152_3

					if var_152_3 + 0 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_3 + 0
					end
				end

				arg_149_1.text_.text = var_152_1
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)
				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_4 = math.max(var_152_0, arg_149_1.talkMaxDuration)

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_4 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - 0) / var_152_4

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= 0 + var_152_4 and arg_149_1.time_ < 0 + var_152_4 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {}

		arg_149_1:InitPlayNodeList()
	end,
	Play317282038 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 317282038
		arg_153_1.duration_ = 3.6

		local var_153_0 = {
			zh = 2.3,
			ja = 3.6
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play317282039(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos2078ui_story = arg_153_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos2078ui_story, Vector3.New(0, -1.28, -5.6), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).z)
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles = arg_153_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, -1.28, -5.6)
				arg_153_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["2078ui_story"].transform.position).z)
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["2078ui_story"].transform.localEulerAngles = arg_153_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["2078ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect2078ui_story == nil then
				arg_153_1.var_.characterEffect2078ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect2078ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect2078ui_story then
				arg_153_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_156_4 = 0
			local var_156_5 = 0.3

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:GetWordFromCfg(317282038)
				local var_156_7 = arg_153_1:FormatText(var_156_6.content)

				arg_153_1.text_.text = var_156_7

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_9 = 12 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 12)

				if (12 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_7) / 12)) > 0 and var_156_5 < var_156_9 then
					arg_153_1.talkMaxDuration = var_156_9

					if var_156_9 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_9 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_7
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282038", "story_v_out_317282.awb") ~= 0 then
					local var_156_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282038", "story_v_out_317282.awb") / 1000

					if var_156_10 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_10 + var_156_4
					end

					if var_156_6.prefab_name ~= "" and arg_153_1.actors_[var_156_6.prefab_name] ~= nil then
						local var_156_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_6.prefab_name].transform, "story_v_out_317282", "317282038", "story_v_out_317282.awb")

						arg_153_1:RecordAudio("317282038", var_156_11)
						arg_153_1:RecordAudio("317282038", var_156_11)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_317282", "317282038", "story_v_out_317282.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_317282", "317282038", "story_v_out_317282.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_12 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_12 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_12

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_12 and arg_153_1.time_ < var_156_4 + var_156_12 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_153_1:InitPlayNodeList()
	end,
	Play317282039 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 317282039
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play317282040(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(arg_157_1.actors_["2078ui_story"]) and arg_157_1.var_.characterEffect2078ui_story == nil then
				arg_157_1.var_.characterEffect2078ui_story = arg_157_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_0 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 and not isNil(arg_157_1.actors_["2078ui_story"]) then
				if arg_157_1.var_.characterEffect2078ui_story and not isNil(arg_157_1.actors_["2078ui_story"]) then
					arg_157_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_157_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_0)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 and not isNil(arg_157_1.actors_["2078ui_story"]) and arg_157_1.var_.characterEffect2078ui_story then
				arg_157_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_157_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_160_1 = 0
			local var_160_2 = 0.9

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, false)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(317282039).content)

				arg_157_1.text_.text = var_160_3

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_5 = 36 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 36)

				if (36 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_3) / 36)) > 0 and var_160_2 < var_160_5 then
					arg_157_1.talkMaxDuration = var_160_5

					if var_160_5 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_5 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_3
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_6 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_6 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_6

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_6 and arg_157_1.time_ < var_160_1 + var_160_6 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {}

		arg_157_1:InitPlayNodeList()
	end,
	Play317282040 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 317282040
		arg_161_1.duration_ = 6.5

		local var_161_0 = {
			zh = 6.1,
			ja = 6.5
		}
		local var_161_1 = manager.audio:GetLocalizationFlag()

		if var_161_0[var_161_1] ~= nil then
			arg_161_1.duration_ = var_161_0[var_161_1]
		end

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play317282041(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos2078ui_story = arg_161_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).z)
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles = arg_161_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["2078ui_story"].transform.position).z)
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["2078ui_story"].transform.localEulerAngles = arg_161_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["2078ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect2078ui_story == nil then
				arg_161_1.var_.characterEffect2078ui_story = var_164_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_2 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 and not isNil(var_164_1) then
				if arg_161_1.var_.characterEffect2078ui_story and not isNil(var_164_1) then
					arg_161_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_161_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_2)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 and not isNil(var_164_1) and arg_161_1.var_.characterEffect2078ui_story then
				arg_161_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_161_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_164_3 = arg_161_1.actors_["1015ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1015ui_story = var_164_3.localPosition
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_3.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_161_1.time_ - 0) / var_164_4)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			local var_164_5 = arg_161_1.actors_["1015ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1015ui_story == nil then
				arg_161_1.var_.characterEffect1015ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.characterEffect1015ui_story and not isNil(var_164_5) then
					arg_161_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect1015ui_story then
				arg_161_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_164_8 = 0
			local var_164_9 = 0.925

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_8 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_10 = arg_161_1:GetWordFromCfg(317282040)
				local var_164_11 = arg_161_1:FormatText(var_164_10.content)

				arg_161_1.text_.text = var_164_11

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_13 = 37 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 37)

				if (37 <= 0 and var_164_9 or var_164_9 * (utf8.len(var_164_11) / 37)) > 0 and var_164_9 < var_164_13 then
					arg_161_1.talkMaxDuration = var_164_13

					if var_164_13 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_13 + var_164_8
					end
				end

				arg_161_1.text_.text = var_164_11
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282040", "story_v_out_317282.awb") ~= 0 then
					local var_164_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282040", "story_v_out_317282.awb") / 1000

					if var_164_14 + var_164_8 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_8
					end

					if var_164_10.prefab_name ~= "" and arg_161_1.actors_[var_164_10.prefab_name] ~= nil then
						local var_164_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_161_1.actors_[var_164_10.prefab_name].transform, "story_v_out_317282", "317282040", "story_v_out_317282.awb")

						arg_161_1:RecordAudio("317282040", var_164_15)
						arg_161_1:RecordAudio("317282040", var_164_15)
					else
						arg_161_1:AudioAction("play", "voice", "story_v_out_317282", "317282040", "story_v_out_317282.awb")
					end

					arg_161_1:RecordHistoryTalkVoice("story_v_out_317282", "317282040", "story_v_out_317282.awb")
				end

				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_16 = math.max(var_164_9, arg_161_1.talkMaxDuration)

			if var_164_8 <= arg_161_1.time_ and arg_161_1.time_ < var_164_8 + var_164_16 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_8) / var_164_16

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_8 + var_164_16 and arg_161_1.time_ < var_164_8 + var_164_16 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play317282041 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 317282041
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play317282042(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1015ui_story = arg_165_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1015ui_story"].transform.position).z)
				arg_165_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1015ui_story"].transform.localEulerAngles = arg_165_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_165_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1015ui_story"].transform.position).z)
				arg_165_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1015ui_story"].transform.localEulerAngles = arg_165_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1015ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1015ui_story == nil then
				arg_165_1.var_.characterEffect1015ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1015ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_165_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_2)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1015ui_story then
				arg_165_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_165_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_168_3 = 0
			local var_168_4 = 1.025

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_3 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_5 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(317282041).content)

				arg_165_1.text_.text = var_168_5

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_7 = 41 <= 0 and var_168_4 or var_168_4 * (utf8.len(var_168_5) / 41)

				if (41 <= 0 and var_168_4 or var_168_4 * (utf8.len(var_168_5) / 41)) > 0 and var_168_4 < var_168_7 then
					arg_165_1.talkMaxDuration = var_168_7

					if var_168_7 + var_168_3 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_7 + var_168_3
					end
				end

				arg_165_1.text_.text = var_168_5
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_8 = math.max(var_168_4, arg_165_1.talkMaxDuration)

			if var_168_3 <= arg_165_1.time_ and arg_165_1.time_ < var_168_3 + var_168_8 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_3) / var_168_8

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_3 + var_168_8 and arg_165_1.time_ < var_168_3 + var_168_8 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play317282042 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 317282042
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play317282043(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_0 = 0.55

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_1 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(317282042).content)

				arg_169_1.text_.text = var_172_1

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_3 = 22 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 22)

				if (22 <= 0 and var_172_0 or var_172_0 * (utf8.len(var_172_1) / 22)) > 0 and var_172_0 < var_172_3 then
					arg_169_1.talkMaxDuration = var_172_3

					if var_172_3 + 0 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_3 + 0
					end
				end

				arg_169_1.text_.text = var_172_1
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_4 = math.max(var_172_0, arg_169_1.talkMaxDuration)

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_4 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - 0) / var_172_4

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= 0 + var_172_4 and arg_169_1.time_ < 0 + var_172_4 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {}

		arg_169_1:InitPlayNodeList()
	end,
	Play317282043 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 317282043
		arg_173_1.duration_ = 16.9

		local var_173_0 = {
			zh = 16.9,
			ja = 15.5
		}
		local var_173_1 = manager.audio:GetLocalizationFlag()

		if var_173_0[var_173_1] ~= nil then
			arg_173_1.duration_ = var_173_0[var_173_1]
		end

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play317282044(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if arg_173_1.bgs_.K11f == nil then
				local var_176_0 = Object.Instantiate(arg_173_1.paintGo_)

				var_176_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "K11f")
				var_176_0.name = "K11f"
				var_176_0.transform.parent = arg_173_1.stage_.transform
				var_176_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.bgs_.K11f = var_176_0
			end

			if 2 < arg_173_1.time_ and arg_173_1.time_ <= 2 + arg_176_0 then
				local var_176_1 = arg_173_1.bgs_.K11f

				arg_173_1.bgs_.K11f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_176_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_176_2 = var_176_1:GetComponent("SpriteRenderer")

				if var_176_2 and var_176_2.sprite then
					local var_176_3 = 2 * (var_176_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_176_1.transform.localScale = Vector3.New(var_176_3 / var_176_2.sprite.bounds.size.y < var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x and var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x or var_176_3 / var_176_2.sprite.bounds.size.y, var_176_3 / var_176_2.sprite.bounds.size.y < var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x and var_176_3 * manager.ui.mainCameraCom_.aspect / var_176_2.sprite.bounds.size.x or var_176_3 / var_176_2.sprite.bounds.size.y, 0)
				end

				for iter_176_0, iter_176_1 in pairs(arg_173_1.bgs_) do
					if iter_176_0 ~= "K11f" then
						iter_176_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_176_4 = 0

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_5 = 2

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_5 then
				local var_176_6 = Color.New(0, 0, 0)

				var_176_6.a = Mathf.Lerp(0, 1, (arg_173_1.time_ - var_176_4) / var_176_5)
				arg_173_1.mask_.color = var_176_6
			end

			if arg_173_1.time_ >= var_176_4 + var_176_5 and arg_173_1.time_ < var_176_4 + var_176_5 + arg_176_0 then
				local var_176_7 = Color.New(0, 0, 0)

				var_176_7.a = 1
				arg_173_1.mask_.color = var_176_7
			end

			local var_176_8 = 2

			if 2 < arg_173_1.time_ and arg_173_1.time_ <= var_176_8 + arg_176_0 then
				arg_173_1.mask_.enabled = true
				arg_173_1.mask_.raycastTarget = true

				arg_173_1:SetGaussion(false)
			end

			local var_176_9 = 2

			if var_176_8 <= arg_173_1.time_ and arg_173_1.time_ < var_176_8 + var_176_9 then
				local var_176_10 = Color.New(0, 0, 0)

				var_176_10.a = Mathf.Lerp(1, 0, (arg_173_1.time_ - var_176_8) / var_176_9)
				arg_173_1.mask_.color = var_176_10
			end

			if arg_173_1.time_ >= var_176_8 + var_176_9 and arg_173_1.time_ < var_176_8 + var_176_9 + arg_176_0 then
				local var_176_11 = Color.New(0, 0, 0)

				arg_173_1.mask_.enabled = false
				var_176_11.a = 0
				arg_173_1.mask_.color = var_176_11
			end

			local var_176_12 = arg_173_1.actors_["2078ui_story"].transform

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= 4 + arg_176_0 then
				arg_173_1.var_.moveOldPos2078ui_story = var_176_12.localPosition
			end

			local var_176_13 = 0.001

			if 4 <= arg_173_1.time_ and arg_173_1.time_ < 4 + var_176_13 then
				var_176_12.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_173_1.time_ - 4) / var_176_13)
				var_176_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_12.position).x, (manager.ui.mainCamera.transform.position - var_176_12.position).y, (manager.ui.mainCamera.transform.position - var_176_12.position).z)
				var_176_12.localEulerAngles.z = 0
				var_176_12.localEulerAngles.x = 0
				var_176_12.localEulerAngles = var_176_12.localEulerAngles
			end

			if arg_173_1.time_ >= 4 + var_176_13 and arg_173_1.time_ < 4 + var_176_13 + arg_176_0 then
				var_176_12.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				var_176_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_12.position).x, (manager.ui.mainCamera.transform.position - var_176_12.position).y, (manager.ui.mainCamera.transform.position - var_176_12.position).z)
				var_176_12.localEulerAngles.z = 0
				var_176_12.localEulerAngles.x = 0
				var_176_12.localEulerAngles = var_176_12.localEulerAngles
			end

			local var_176_14 = arg_173_1.actors_["2078ui_story"]

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= 4 + arg_176_0 and not isNil(var_176_14) and arg_173_1.var_.characterEffect2078ui_story == nil then
				arg_173_1.var_.characterEffect2078ui_story = var_176_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_15 = 0.200000002980232

			if 4 <= arg_173_1.time_ and arg_173_1.time_ < 4 + var_176_15 and not isNil(var_176_14) then
				if arg_173_1.var_.characterEffect2078ui_story and not isNil(var_176_14) then
					arg_173_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 4 + var_176_15 and arg_173_1.time_ < 4 + var_176_15 + arg_176_0 and not isNil(var_176_14) and arg_173_1.var_.characterEffect2078ui_story then
				arg_173_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= 4 + arg_176_0 then
				arg_173_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			local var_176_17 = arg_173_1.actors_["2079ui_story"].transform

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= 4 + arg_176_0 then
				arg_173_1.var_.moveOldPos2079ui_story = var_176_17.localPosition
			end

			local var_176_18 = 0.001

			if 4 <= arg_173_1.time_ and arg_173_1.time_ < 4 + var_176_18 then
				var_176_17.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_173_1.time_ - 4) / var_176_18)
				var_176_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_17.position).x, (manager.ui.mainCamera.transform.position - var_176_17.position).y, (manager.ui.mainCamera.transform.position - var_176_17.position).z)
				var_176_17.localEulerAngles.z = 0
				var_176_17.localEulerAngles.x = 0
				var_176_17.localEulerAngles = var_176_17.localEulerAngles
			end

			if arg_173_1.time_ >= 4 + var_176_18 and arg_173_1.time_ < 4 + var_176_18 + arg_176_0 then
				var_176_17.localPosition = Vector3.New(0.7, -1.28, -5.6)
				var_176_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_17.position).x, (manager.ui.mainCamera.transform.position - var_176_17.position).y, (manager.ui.mainCamera.transform.position - var_176_17.position).z)
				var_176_17.localEulerAngles.z = 0
				var_176_17.localEulerAngles.x = 0
				var_176_17.localEulerAngles = var_176_17.localEulerAngles
			end

			local var_176_19 = arg_173_1.actors_["2079ui_story"]

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= 4 + arg_176_0 and not isNil(var_176_19) and arg_173_1.var_.characterEffect2079ui_story == nil then
				arg_173_1.var_.characterEffect2079ui_story = var_176_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_20 = 0.200000002980232

			if 4 <= arg_173_1.time_ and arg_173_1.time_ < 4 + var_176_20 and not isNil(var_176_19) then
				if arg_173_1.var_.characterEffect2079ui_story and not isNil(var_176_19) then
					arg_173_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_173_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 4) / var_176_20)
				end
			end

			if arg_173_1.time_ >= 4 + var_176_20 and arg_173_1.time_ < 4 + var_176_20 + arg_176_0 and not isNil(var_176_19) and arg_173_1.var_.characterEffect2079ui_story then
				arg_173_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_173_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_176_21 = 4

			arg_173_1.isInRecall_ = false

			if var_176_21 < arg_173_1.time_ and arg_173_1.time_ <= var_176_21 + arg_176_0 then
				arg_173_1.screenFilterGo_:SetActive(true)

				arg_173_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_176_2, iter_176_3 in pairs(arg_173_1.actors_) do
					for iter_176_4, iter_176_5 in ipairs((iter_176_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_176_5.color = iter_176_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_176_22 = 0.0166666666666667

			if var_176_21 <= arg_173_1.time_ and arg_173_1.time_ < var_176_21 + var_176_22 then
				arg_173_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_173_1.time_ - var_176_21) / var_176_22)
			end

			if arg_173_1.time_ >= var_176_21 + var_176_22 and arg_173_1.time_ < var_176_21 + var_176_22 + arg_176_0 then
				arg_173_1.screenFilterEffect_.weight = 1
			end

			if arg_173_1.frameCnt_ <= 1 then
				arg_173_1.dialog_:SetActive(false)
			end

			local var_176_23 = 4
			local var_176_24 = 1.4

			if 4 < arg_173_1.time_ and arg_173_1.time_ <= var_176_23 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0

				arg_173_1.dialog_:SetActive(true)

				arg_173_1.dialogCg_.alpha = 0

				local var_176_25 = LeanTween.value(arg_173_1.dialog_, 0, 1, 0.3)

				var_176_25:setOnUpdate(LuaHelper.FloatAction(function(arg_177_0)
					arg_173_1.dialogCg_.alpha = arg_177_0
				end))
				var_176_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_173_1.dialog_)
					var_176_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_173_1.duration_ = arg_173_1.duration_ + 0.3

				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_26 = arg_173_1:GetWordFromCfg(317282043)
				local var_176_27 = arg_173_1:FormatText(var_176_26.content)

				arg_173_1.text_.text = var_176_27

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_29 = 55 <= 0 and var_176_24 or var_176_24 * (utf8.len(var_176_27) / 55)

				if (55 <= 0 and var_176_24 or var_176_24 * (utf8.len(var_176_27) / 55)) > 0 and var_176_24 < var_176_29 then
					arg_173_1.talkMaxDuration = var_176_29
					var_176_23 = var_176_23 + 0.3

					if var_176_29 + var_176_23 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_29 + var_176_23
					end
				end

				arg_173_1.text_.text = var_176_27
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282043", "story_v_out_317282.awb") ~= 0 then
					local var_176_30 = manager.audio:GetVoiceLength("story_v_out_317282", "317282043", "story_v_out_317282.awb") / 1000

					if var_176_30 + var_176_23 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_30 + var_176_23
					end

					if var_176_26.prefab_name ~= "" and arg_173_1.actors_[var_176_26.prefab_name] ~= nil then
						local var_176_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_26.prefab_name].transform, "story_v_out_317282", "317282043", "story_v_out_317282.awb")

						arg_173_1:RecordAudio("317282043", var_176_31)
						arg_173_1:RecordAudio("317282043", var_176_31)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_317282", "317282043", "story_v_out_317282.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_317282", "317282043", "story_v_out_317282.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_32 = var_176_23 + 0.3
			local var_176_33 = math.max(var_176_24, arg_173_1.talkMaxDuration)

			if var_176_23 + 0.3 <= arg_173_1.time_ and arg_173_1.time_ < var_176_32 + var_176_33 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_32) / var_176_33

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_32 + var_176_33 and arg_173_1.time_ < var_176_32 + var_176_33 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play317282044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 317282044
		arg_179_1.duration_ = 7.3

		local var_179_0 = {
			zh = 7.3,
			ja = 4.733
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play317282045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = 0.85

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_1 = arg_179_1:GetWordFromCfg(317282044)
				local var_182_2 = arg_179_1:FormatText(var_182_1.content)

				arg_179_1.text_.text = var_182_2

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_4 = 34 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 34)

				if (34 <= 0 and var_182_0 or var_182_0 * (utf8.len(var_182_2) / 34)) > 0 and var_182_0 < var_182_4 then
					arg_179_1.talkMaxDuration = var_182_4

					if var_182_4 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_4 + 0
					end
				end

				arg_179_1.text_.text = var_182_2
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282044", "story_v_out_317282.awb") ~= 0 then
					local var_182_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282044", "story_v_out_317282.awb") / 1000

					if var_182_5 + 0 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + 0
					end

					if var_182_1.prefab_name ~= "" and arg_179_1.actors_[var_182_1.prefab_name] ~= nil then
						local var_182_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_1.prefab_name].transform, "story_v_out_317282", "317282044", "story_v_out_317282.awb")

						arg_179_1:RecordAudio("317282044", var_182_6)
						arg_179_1:RecordAudio("317282044", var_182_6)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_317282", "317282044", "story_v_out_317282.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_317282", "317282044", "story_v_out_317282.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_7 = math.max(var_182_0, arg_179_1.talkMaxDuration)

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - 0) / var_182_7

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play317282045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 317282045
		arg_183_1.duration_ = 3.47

		local var_183_0 = {
			zh = 2,
			ja = 3.466
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play317282046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["2079ui_story"]) and arg_183_1.var_.characterEffect2079ui_story == nil then
				arg_183_1.var_.characterEffect2079ui_story = arg_183_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["2079ui_story"]) then
				if arg_183_1.var_.characterEffect2079ui_story and not isNil(arg_183_1.actors_["2079ui_story"]) then
					arg_183_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["2079ui_story"]) and arg_183_1.var_.characterEffect2079ui_story then
				arg_183_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_186_2 = arg_183_1.actors_["2078ui_story"]

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect2078ui_story == nil then
				arg_183_1.var_.characterEffect2078ui_story = var_186_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_3 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 and not isNil(var_186_2) then
				if arg_183_1.var_.characterEffect2078ui_story and not isNil(var_186_2) then
					arg_183_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_183_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_3)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 and not isNil(var_186_2) and arg_183_1.var_.characterEffect2078ui_story then
				arg_183_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_183_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_186_4 = 0
			local var_186_5 = 0.225

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(317282045)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 9 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 9)

				if (9 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 9)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282045", "story_v_out_317282.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282045", "story_v_out_317282.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_317282", "317282045", "story_v_out_317282.awb")

						arg_183_1:RecordAudio("317282045", var_186_11)
						arg_183_1:RecordAudio("317282045", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_317282", "317282045", "story_v_out_317282.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_317282", "317282045", "story_v_out_317282.awb")
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

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play317282046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 317282046
		arg_187_1.duration_ = 8.97

		local var_187_0 = {
			zh = 8.966,
			ja = 8.1
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play317282047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(arg_187_1.actors_["2078ui_story"]) and arg_187_1.var_.characterEffect2078ui_story == nil then
				arg_187_1.var_.characterEffect2078ui_story = arg_187_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_0 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 and not isNil(arg_187_1.actors_["2078ui_story"]) then
				if arg_187_1.var_.characterEffect2078ui_story and not isNil(arg_187_1.actors_["2078ui_story"]) then
					arg_187_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 and not isNil(arg_187_1.actors_["2078ui_story"]) and arg_187_1.var_.characterEffect2078ui_story then
				arg_187_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_190_2 = arg_187_1.actors_["2079ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect2079ui_story == nil then
				arg_187_1.var_.characterEffect2079ui_story = var_190_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_3 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_3 and not isNil(var_190_2) then
				if arg_187_1.var_.characterEffect2079ui_story and not isNil(var_190_2) then
					arg_187_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_187_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_3)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_3 and arg_187_1.time_ < 0 + var_190_3 + arg_190_0 and not isNil(var_190_2) and arg_187_1.var_.characterEffect2079ui_story then
				arg_187_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_187_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_190_4 = 0
			local var_190_5 = 1.075

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_4 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_6 = arg_187_1:GetWordFromCfg(317282046)
				local var_190_7 = arg_187_1:FormatText(var_190_6.content)

				arg_187_1.text_.text = var_190_7

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_9 = 43 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 43)

				if (43 <= 0 and var_190_5 or var_190_5 * (utf8.len(var_190_7) / 43)) > 0 and var_190_5 < var_190_9 then
					arg_187_1.talkMaxDuration = var_190_9

					if var_190_9 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_9 + var_190_4
					end
				end

				arg_187_1.text_.text = var_190_7
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282046", "story_v_out_317282.awb") ~= 0 then
					local var_190_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282046", "story_v_out_317282.awb") / 1000

					if var_190_10 + var_190_4 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_10 + var_190_4
					end

					if var_190_6.prefab_name ~= "" and arg_187_1.actors_[var_190_6.prefab_name] ~= nil then
						local var_190_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_6.prefab_name].transform, "story_v_out_317282", "317282046", "story_v_out_317282.awb")

						arg_187_1:RecordAudio("317282046", var_190_11)
						arg_187_1:RecordAudio("317282046", var_190_11)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_317282", "317282046", "story_v_out_317282.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_317282", "317282046", "story_v_out_317282.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_12 = math.max(var_190_5, arg_187_1.talkMaxDuration)

			if var_190_4 <= arg_187_1.time_ and arg_187_1.time_ < var_190_4 + var_190_12 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_4) / var_190_12

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_4 + var_190_12 and arg_187_1.time_ < var_190_4 + var_190_12 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play317282047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 317282047
		arg_191_1.duration_ = 13.1

		local var_191_0 = {
			zh = 13.1,
			ja = 10.833
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
				arg_191_0:Play317282048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = 1.4

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_1 = arg_191_1:GetWordFromCfg(317282047)
				local var_194_2 = arg_191_1:FormatText(var_194_1.content)

				arg_191_1.text_.text = var_194_2

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_4 = 56 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 56)

				if (56 <= 0 and var_194_0 or var_194_0 * (utf8.len(var_194_2) / 56)) > 0 and var_194_0 < var_194_4 then
					arg_191_1.talkMaxDuration = var_194_4

					if var_194_4 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_4 + 0
					end
				end

				arg_191_1.text_.text = var_194_2
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282047", "story_v_out_317282.awb") ~= 0 then
					local var_194_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282047", "story_v_out_317282.awb") / 1000

					if var_194_5 + 0 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_5 + 0
					end

					if var_194_1.prefab_name ~= "" and arg_191_1.actors_[var_194_1.prefab_name] ~= nil then
						local var_194_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_1.prefab_name].transform, "story_v_out_317282", "317282047", "story_v_out_317282.awb")

						arg_191_1:RecordAudio("317282047", var_194_6)
						arg_191_1:RecordAudio("317282047", var_194_6)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_317282", "317282047", "story_v_out_317282.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_317282", "317282047", "story_v_out_317282.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_7 = math.max(var_194_0, arg_191_1.talkMaxDuration)

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_7 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - 0) / var_194_7

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= 0 + var_194_7 and arg_191_1.time_ < 0 + var_194_7 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play317282048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 317282048
		arg_195_1.duration_ = 4.73

		local var_195_0 = {
			zh = 4.333,
			ja = 4.733
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play317282049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["2079ui_story"]) and arg_195_1.var_.characterEffect2079ui_story == nil then
				arg_195_1.var_.characterEffect2079ui_story = arg_195_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["2079ui_story"]) then
				if arg_195_1.var_.characterEffect2079ui_story and not isNil(arg_195_1.actors_["2079ui_story"]) then
					arg_195_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["2079ui_story"]) and arg_195_1.var_.characterEffect2079ui_story then
				arg_195_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_198_2 = arg_195_1.actors_["2078ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.characterEffect2078ui_story == nil then
				arg_195_1.var_.characterEffect2078ui_story = var_198_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_3 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.characterEffect2078ui_story and not isNil(var_198_2) then
					arg_195_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_195_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_3)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.characterEffect2078ui_story then
				arg_195_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_195_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_198_4 = 0
			local var_198_5 = 0.375

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(317282048)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 15 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 15)

				if (15 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 15)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282048", "story_v_out_317282.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282048", "story_v_out_317282.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_out_317282", "317282048", "story_v_out_317282.awb")

						arg_195_1:RecordAudio("317282048", var_198_11)
						arg_195_1:RecordAudio("317282048", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_317282", "317282048", "story_v_out_317282.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_317282", "317282048", "story_v_out_317282.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play317282049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 317282049
		arg_199_1.duration_ = 13.77

		local var_199_0 = {
			zh = 13.766,
			ja = 9.433
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
				arg_199_0:Play317282050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos2078ui_story = arg_199_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["2078ui_story"].transform.position).z)
				arg_199_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["2078ui_story"].transform.localEulerAngles = arg_199_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_199_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["2078ui_story"].transform.position).z)
				arg_199_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["2078ui_story"].transform.localEulerAngles = arg_199_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["2078ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect2078ui_story == nil then
				arg_199_1.var_.characterEffect2078ui_story = var_202_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 and not isNil(var_202_1) then
				if arg_199_1.var_.characterEffect2078ui_story and not isNil(var_202_1) then
					arg_199_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 and not isNil(var_202_1) and arg_199_1.var_.characterEffect2078ui_story then
				arg_199_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_202_4 = arg_199_1.actors_["2079ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect2079ui_story == nil then
				arg_199_1.var_.characterEffect2079ui_story = var_202_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_5 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_5 and not isNil(var_202_4) then
				if arg_199_1.var_.characterEffect2079ui_story and not isNil(var_202_4) then
					arg_199_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_199_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_5)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_5 and arg_199_1.time_ < 0 + var_202_5 + arg_202_0 and not isNil(var_202_4) and arg_199_1.var_.characterEffect2079ui_story then
				arg_199_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_199_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_202_6 = 0
			local var_202_7 = 1.475

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_6 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_8 = arg_199_1:GetWordFromCfg(317282049)
				local var_202_9 = arg_199_1:FormatText(var_202_8.content)

				arg_199_1.text_.text = var_202_9

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_11 = 59 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_9) / 59)

				if (59 <= 0 and var_202_7 or var_202_7 * (utf8.len(var_202_9) / 59)) > 0 and var_202_7 < var_202_11 then
					arg_199_1.talkMaxDuration = var_202_11

					if var_202_11 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_11 + var_202_6
					end
				end

				arg_199_1.text_.text = var_202_9
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282049", "story_v_out_317282.awb") ~= 0 then
					local var_202_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282049", "story_v_out_317282.awb") / 1000

					if var_202_12 + var_202_6 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_12 + var_202_6
					end

					if var_202_8.prefab_name ~= "" and arg_199_1.actors_[var_202_8.prefab_name] ~= nil then
						local var_202_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_8.prefab_name].transform, "story_v_out_317282", "317282049", "story_v_out_317282.awb")

						arg_199_1:RecordAudio("317282049", var_202_13)
						arg_199_1:RecordAudio("317282049", var_202_13)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_317282", "317282049", "story_v_out_317282.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_317282", "317282049", "story_v_out_317282.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_14 = math.max(var_202_7, arg_199_1.talkMaxDuration)

			if var_202_6 <= arg_199_1.time_ and arg_199_1.time_ < var_202_6 + var_202_14 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_6) / var_202_14

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_6 + var_202_14 and arg_199_1.time_ < var_202_6 + var_202_14 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play317282050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 317282050
		arg_203_1.duration_ = 8.07

		local var_203_0 = {
			zh = 5.133,
			ja = 8.066
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
				arg_203_0:Play317282051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos2079ui_story = arg_203_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["2079ui_story"].transform.position).z)
				arg_203_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["2079ui_story"].transform.localEulerAngles = arg_203_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_203_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["2079ui_story"].transform.position).z)
				arg_203_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["2079ui_story"].transform.localEulerAngles = arg_203_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["2079ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect2079ui_story == nil then
				arg_203_1.var_.characterEffect2079ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect2079ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect2079ui_story then
				arg_203_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_206_4 = arg_203_1.actors_["2078ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect2078ui_story == nil then
				arg_203_1.var_.characterEffect2078ui_story = var_206_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_5 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 and not isNil(var_206_4) then
				if arg_203_1.var_.characterEffect2078ui_story and not isNil(var_206_4) then
					arg_203_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_203_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_5)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 and not isNil(var_206_4) and arg_203_1.var_.characterEffect2078ui_story then
				arg_203_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_203_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_206_6 = 0
			local var_206_7 = 0.65

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_6 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_8 = arg_203_1:GetWordFromCfg(317282050)
				local var_206_9 = arg_203_1:FormatText(var_206_8.content)

				arg_203_1.text_.text = var_206_9

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_11 = 26 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 26)

				if (26 <= 0 and var_206_7 or var_206_7 * (utf8.len(var_206_9) / 26)) > 0 and var_206_7 < var_206_11 then
					arg_203_1.talkMaxDuration = var_206_11

					if var_206_11 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_11 + var_206_6
					end
				end

				arg_203_1.text_.text = var_206_9
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282050", "story_v_out_317282.awb") ~= 0 then
					local var_206_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282050", "story_v_out_317282.awb") / 1000

					if var_206_12 + var_206_6 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_12 + var_206_6
					end

					if var_206_8.prefab_name ~= "" and arg_203_1.actors_[var_206_8.prefab_name] ~= nil then
						local var_206_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_8.prefab_name].transform, "story_v_out_317282", "317282050", "story_v_out_317282.awb")

						arg_203_1:RecordAudio("317282050", var_206_13)
						arg_203_1:RecordAudio("317282050", var_206_13)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_317282", "317282050", "story_v_out_317282.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_317282", "317282050", "story_v_out_317282.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_14 = math.max(var_206_7, arg_203_1.talkMaxDuration)

			if var_206_6 <= arg_203_1.time_ and arg_203_1.time_ < var_206_6 + var_206_14 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_6) / var_206_14

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_6 + var_206_14 and arg_203_1.time_ < var_206_6 + var_206_14 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_203_1:InitPlayNodeList()
	end,
	Play317282051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 317282051
		arg_207_1.duration_ = 3.8

		local var_207_0 = {
			zh = 3.8,
			ja = 3.7
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
				arg_207_0:Play317282052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos2078ui_story = arg_207_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["2078ui_story"].transform.position).z)
				arg_207_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["2078ui_story"].transform.localEulerAngles = arg_207_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_207_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["2078ui_story"].transform.position).z)
				arg_207_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["2078ui_story"].transform.localEulerAngles = arg_207_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["2078ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect2078ui_story == nil then
				arg_207_1.var_.characterEffect2078ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect2078ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect2078ui_story then
				arg_207_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_210_4 = arg_207_1.actors_["2079ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect2079ui_story == nil then
				arg_207_1.var_.characterEffect2079ui_story = var_210_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_5 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_5 and not isNil(var_210_4) then
				if arg_207_1.var_.characterEffect2079ui_story and not isNil(var_210_4) then
					arg_207_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_207_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_5)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_5 and arg_207_1.time_ < 0 + var_210_5 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect2079ui_story then
				arg_207_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_207_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_210_6 = 0
			local var_210_7 = 0.375

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_8 = arg_207_1:GetWordFromCfg(317282051)
				local var_210_9 = arg_207_1:FormatText(var_210_8.content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 14 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 14)

				if (14 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 14)) > 0 and var_210_7 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11

					if var_210_11 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282051", "story_v_out_317282.awb") ~= 0 then
					local var_210_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282051", "story_v_out_317282.awb") / 1000

					if var_210_12 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_6
					end

					if var_210_8.prefab_name ~= "" and arg_207_1.actors_[var_210_8.prefab_name] ~= nil then
						local var_210_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_8.prefab_name].transform, "story_v_out_317282", "317282051", "story_v_out_317282.awb")

						arg_207_1:RecordAudio("317282051", var_210_13)
						arg_207_1:RecordAudio("317282051", var_210_13)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_317282", "317282051", "story_v_out_317282.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_317282", "317282051", "story_v_out_317282.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_207_1:InitPlayNodeList()
	end,
	Play317282052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 317282052
		arg_211_1.duration_ = 1.5

		local var_211_0 = {
			zh = 1.433,
			ja = 1.5
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
				arg_211_0:Play317282053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos2079ui_story = arg_211_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["2079ui_story"].transform.position).z)
				arg_211_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["2079ui_story"].transform.localEulerAngles = arg_211_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_211_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["2079ui_story"].transform.position).z)
				arg_211_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["2079ui_story"].transform.localEulerAngles = arg_211_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["2079ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect2079ui_story == nil then
				arg_211_1.var_.characterEffect2079ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect2079ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect2079ui_story then
				arg_211_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_214_4 = arg_211_1.actors_["2078ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect2078ui_story == nil then
				arg_211_1.var_.characterEffect2078ui_story = var_214_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_5 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_5 and not isNil(var_214_4) then
				if arg_211_1.var_.characterEffect2078ui_story and not isNil(var_214_4) then
					arg_211_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_211_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_5)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_5 and arg_211_1.time_ < 0 + var_214_5 + arg_214_0 and not isNil(var_214_4) and arg_211_1.var_.characterEffect2078ui_story then
				arg_211_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_211_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_214_6 = 0
			local var_214_7 = 0.15

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_6 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_8 = arg_211_1:GetWordFromCfg(317282052)
				local var_214_9 = arg_211_1:FormatText(var_214_8.content)

				arg_211_1.text_.text = var_214_9

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_11 = 6 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_9) / 6)

				if (6 <= 0 and var_214_7 or var_214_7 * (utf8.len(var_214_9) / 6)) > 0 and var_214_7 < var_214_11 then
					arg_211_1.talkMaxDuration = var_214_11

					if var_214_11 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_11 + var_214_6
					end
				end

				arg_211_1.text_.text = var_214_9
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282052", "story_v_out_317282.awb") ~= 0 then
					local var_214_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282052", "story_v_out_317282.awb") / 1000

					if var_214_12 + var_214_6 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_12 + var_214_6
					end

					if var_214_8.prefab_name ~= "" and arg_211_1.actors_[var_214_8.prefab_name] ~= nil then
						local var_214_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_8.prefab_name].transform, "story_v_out_317282", "317282052", "story_v_out_317282.awb")

						arg_211_1:RecordAudio("317282052", var_214_13)
						arg_211_1:RecordAudio("317282052", var_214_13)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_317282", "317282052", "story_v_out_317282.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_317282", "317282052", "story_v_out_317282.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_14 = math.max(var_214_7, arg_211_1.talkMaxDuration)

			if var_214_6 <= arg_211_1.time_ and arg_211_1.time_ < var_214_6 + var_214_14 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_6) / var_214_14

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_6 + var_214_14 and arg_211_1.time_ < var_214_6 + var_214_14 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	Play317282053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 317282053
		arg_215_1.duration_ = 6.5

		local var_215_0 = {
			zh = 6.5,
			ja = 6.433
		}
		local var_215_1 = manager.audio:GetLocalizationFlag()

		if var_215_0[var_215_1] ~= nil then
			arg_215_1.duration_ = var_215_0[var_215_1]
		end

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play317282054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos2078ui_story = arg_215_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_218_0 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 then
				arg_215_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_215_1.time_ - 0) / var_218_0)
				arg_215_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["2078ui_story"].transform.position).z)
				arg_215_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["2078ui_story"].transform.localEulerAngles = arg_215_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 then
				arg_215_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_215_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_215_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_215_1.actors_["2078ui_story"].transform.position).z)
				arg_215_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_215_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_215_1.actors_["2078ui_story"].transform.localEulerAngles = arg_215_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_218_1 = arg_215_1.actors_["2078ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect2078ui_story == nil then
				arg_215_1.var_.characterEffect2078ui_story = var_218_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_2 and not isNil(var_218_1) then
				if arg_215_1.var_.characterEffect2078ui_story and not isNil(var_218_1) then
					arg_215_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_2 and arg_215_1.time_ < 0 + var_218_2 + arg_218_0 and not isNil(var_218_1) and arg_215_1.var_.characterEffect2078ui_story then
				arg_215_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_218_4 = arg_215_1.actors_["2079ui_story"]

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect2079ui_story == nil then
				arg_215_1.var_.characterEffect2079ui_story = var_218_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_5 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_5 and not isNil(var_218_4) then
				if arg_215_1.var_.characterEffect2079ui_story and not isNil(var_218_4) then
					arg_215_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_215_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_5)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_5 and arg_215_1.time_ < 0 + var_218_5 + arg_218_0 and not isNil(var_218_4) and arg_215_1.var_.characterEffect2079ui_story then
				arg_215_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_215_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_218_6 = 0
			local var_218_7 = 0.65

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_8 = arg_215_1:GetWordFromCfg(317282053)
				local var_218_9 = arg_215_1:FormatText(var_218_8.content)

				arg_215_1.text_.text = var_218_9

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_11 = 26 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_9) / 26)

				if (26 <= 0 and var_218_7 or var_218_7 * (utf8.len(var_218_9) / 26)) > 0 and var_218_7 < var_218_11 then
					arg_215_1.talkMaxDuration = var_218_11

					if var_218_11 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_9
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282053", "story_v_out_317282.awb") ~= 0 then
					local var_218_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282053", "story_v_out_317282.awb") / 1000

					if var_218_12 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_12 + var_218_6
					end

					if var_218_8.prefab_name ~= "" and arg_215_1.actors_[var_218_8.prefab_name] ~= nil then
						local var_218_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_8.prefab_name].transform, "story_v_out_317282", "317282053", "story_v_out_317282.awb")

						arg_215_1:RecordAudio("317282053", var_218_13)
						arg_215_1:RecordAudio("317282053", var_218_13)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_317282", "317282053", "story_v_out_317282.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_317282", "317282053", "story_v_out_317282.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_14 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_14 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_14

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_14 and arg_215_1.time_ < var_218_6 + var_218_14 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_215_1:InitPlayNodeList()
	end,
	Play317282054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 317282054
		arg_219_1.duration_ = 4.6

		local var_219_0 = {
			zh = 3.366,
			ja = 4.6
		}
		local var_219_1 = manager.audio:GetLocalizationFlag()

		if var_219_0[var_219_1] ~= nil then
			arg_219_1.duration_ = var_219_0[var_219_1]
		end

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play317282055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.var_.moveOldPos2079ui_story = arg_219_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_222_0 = 0.001

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 then
				arg_219_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_219_1.time_ - 0) / var_222_0)
				arg_219_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["2079ui_story"].transform.position).z)
				arg_219_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["2079ui_story"].transform.localEulerAngles = arg_219_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 then
				arg_219_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_219_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_219_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_219_1.actors_["2079ui_story"].transform.position).z)
				arg_219_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_219_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_219_1.actors_["2079ui_story"].transform.localEulerAngles = arg_219_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_222_1 = arg_219_1.actors_["2079ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect2079ui_story == nil then
				arg_219_1.var_.characterEffect2079ui_story = var_222_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_2 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_2 and not isNil(var_222_1) then
				if arg_219_1.var_.characterEffect2079ui_story and not isNil(var_222_1) then
					arg_219_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_2 and arg_219_1.time_ < 0 + var_222_2 + arg_222_0 and not isNil(var_222_1) and arg_219_1.var_.characterEffect2079ui_story then
				arg_219_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_222_4 = arg_219_1.actors_["2078ui_story"]

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect2078ui_story == nil then
				arg_219_1.var_.characterEffect2078ui_story = var_222_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_5 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_5 and not isNil(var_222_4) then
				if arg_219_1.var_.characterEffect2078ui_story and not isNil(var_222_4) then
					arg_219_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_219_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_5)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_5 and arg_219_1.time_ < 0 + var_222_5 + arg_222_0 and not isNil(var_222_4) and arg_219_1.var_.characterEffect2078ui_story then
				arg_219_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_219_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_222_6 = 0
			local var_222_7 = 0.15

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_8 = arg_219_1:GetWordFromCfg(317282054)
				local var_222_9 = arg_219_1:FormatText(var_222_8.content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 6 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 6)

				if (6 <= 0 and var_222_7 or var_222_7 * (utf8.len(var_222_9) / 6)) > 0 and var_222_7 < var_222_11 then
					arg_219_1.talkMaxDuration = var_222_11

					if var_222_11 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_11 + var_222_6
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282054", "story_v_out_317282.awb") ~= 0 then
					local var_222_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282054", "story_v_out_317282.awb") / 1000

					if var_222_12 + var_222_6 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_12 + var_222_6
					end

					if var_222_8.prefab_name ~= "" and arg_219_1.actors_[var_222_8.prefab_name] ~= nil then
						local var_222_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_8.prefab_name].transform, "story_v_out_317282", "317282054", "story_v_out_317282.awb")

						arg_219_1:RecordAudio("317282054", var_222_13)
						arg_219_1:RecordAudio("317282054", var_222_13)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_317282", "317282054", "story_v_out_317282.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_317282", "317282054", "story_v_out_317282.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_14 = math.max(var_222_7, arg_219_1.talkMaxDuration)

			if var_222_6 <= arg_219_1.time_ and arg_219_1.time_ < var_222_6 + var_222_14 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_6) / var_222_14

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_6 + var_222_14 and arg_219_1.time_ < var_222_6 + var_222_14 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_219_1:InitPlayNodeList()
	end,
	Play317282055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 317282055
		arg_223_1.duration_ = 11.23

		local var_223_0 = {
			zh = 11.233,
			ja = 8.666
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play317282056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos2078ui_story = arg_223_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_226_0 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 then
				arg_223_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_223_1.time_ - 0) / var_226_0)
				arg_223_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["2078ui_story"].transform.position).z)
				arg_223_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["2078ui_story"].transform.localEulerAngles = arg_223_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 then
				arg_223_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_223_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_223_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_223_1.actors_["2078ui_story"].transform.position).z)
				arg_223_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_223_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_223_1.actors_["2078ui_story"].transform.localEulerAngles = arg_223_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_226_1 = arg_223_1.actors_["2078ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect2078ui_story == nil then
				arg_223_1.var_.characterEffect2078ui_story = var_226_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_2 and not isNil(var_226_1) then
				if arg_223_1.var_.characterEffect2078ui_story and not isNil(var_226_1) then
					arg_223_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= 0 + var_226_2 and arg_223_1.time_ < 0 + var_226_2 + arg_226_0 and not isNil(var_226_1) and arg_223_1.var_.characterEffect2078ui_story then
				arg_223_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_226_4 = arg_223_1.actors_["2079ui_story"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect2079ui_story == nil then
				arg_223_1.var_.characterEffect2079ui_story = var_226_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_5 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_5 and not isNil(var_226_4) then
				if arg_223_1.var_.characterEffect2079ui_story and not isNil(var_226_4) then
					arg_223_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_223_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_5)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_5 and arg_223_1.time_ < 0 + var_226_5 + arg_226_0 and not isNil(var_226_4) and arg_223_1.var_.characterEffect2079ui_story then
				arg_223_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_223_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_226_6 = 0
			local var_226_7 = 1.225

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_6 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_8 = arg_223_1:GetWordFromCfg(317282055)
				local var_226_9 = arg_223_1:FormatText(var_226_8.content)

				arg_223_1.text_.text = var_226_9

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_11 = 49 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 49)

				if (49 <= 0 and var_226_7 or var_226_7 * (utf8.len(var_226_9) / 49)) > 0 and var_226_7 < var_226_11 then
					arg_223_1.talkMaxDuration = var_226_11

					if var_226_11 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_11 + var_226_6
					end
				end

				arg_223_1.text_.text = var_226_9
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282055", "story_v_out_317282.awb") ~= 0 then
					local var_226_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282055", "story_v_out_317282.awb") / 1000

					if var_226_12 + var_226_6 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_12 + var_226_6
					end

					if var_226_8.prefab_name ~= "" and arg_223_1.actors_[var_226_8.prefab_name] ~= nil then
						local var_226_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_8.prefab_name].transform, "story_v_out_317282", "317282055", "story_v_out_317282.awb")

						arg_223_1:RecordAudio("317282055", var_226_13)
						arg_223_1:RecordAudio("317282055", var_226_13)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_317282", "317282055", "story_v_out_317282.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_317282", "317282055", "story_v_out_317282.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = math.max(var_226_7, arg_223_1.talkMaxDuration)

			if var_226_6 <= arg_223_1.time_ and arg_223_1.time_ < var_226_6 + var_226_14 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_6) / var_226_14

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_6 + var_226_14 and arg_223_1.time_ < var_226_6 + var_226_14 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_223_1:InitPlayNodeList()
	end,
	Play317282056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 317282056
		arg_227_1.duration_ = 8.8

		local var_227_0 = {
			zh = 8.466,
			ja = 8.8
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play317282057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.95

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_1 = arg_227_1:GetWordFromCfg(317282056)
				local var_230_2 = arg_227_1:FormatText(var_230_1.content)

				arg_227_1.text_.text = var_230_2

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_4 = 38 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 38)

				if (38 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_2) / 38)) > 0 and var_230_0 < var_230_4 then
					arg_227_1.talkMaxDuration = var_230_4

					if var_230_4 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_4 + 0
					end
				end

				arg_227_1.text_.text = var_230_2
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282056", "story_v_out_317282.awb") ~= 0 then
					local var_230_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282056", "story_v_out_317282.awb") / 1000

					if var_230_5 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_5 + 0
					end

					if var_230_1.prefab_name ~= "" and arg_227_1.actors_[var_230_1.prefab_name] ~= nil then
						local var_230_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_1.prefab_name].transform, "story_v_out_317282", "317282056", "story_v_out_317282.awb")

						arg_227_1:RecordAudio("317282056", var_230_6)
						arg_227_1:RecordAudio("317282056", var_230_6)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_317282", "317282056", "story_v_out_317282.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_317282", "317282056", "story_v_out_317282.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_7 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_7

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play317282057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 317282057
		arg_231_1.duration_ = 2.77

		local var_231_0 = {
			zh = 2.266,
			ja = 2.766
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play317282058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos2079ui_story = arg_231_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_234_0 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 then
				arg_231_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_231_1.time_ - 0) / var_234_0)
				arg_231_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["2079ui_story"].transform.position).z)
				arg_231_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["2079ui_story"].transform.localEulerAngles = arg_231_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 then
				arg_231_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_231_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_231_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_231_1.actors_["2079ui_story"].transform.position).z)
				arg_231_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_231_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_231_1.actors_["2079ui_story"].transform.localEulerAngles = arg_231_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_234_1 = arg_231_1.actors_["2079ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect2079ui_story == nil then
				arg_231_1.var_.characterEffect2079ui_story = var_234_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_2 and not isNil(var_234_1) then
				if arg_231_1.var_.characterEffect2079ui_story and not isNil(var_234_1) then
					arg_231_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_2 and arg_231_1.time_ < 0 + var_234_2 + arg_234_0 and not isNil(var_234_1) and arg_231_1.var_.characterEffect2079ui_story then
				arg_231_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_234_4 = arg_231_1.actors_["2078ui_story"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect2078ui_story == nil then
				arg_231_1.var_.characterEffect2078ui_story = var_234_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_5 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_5 and not isNil(var_234_4) then
				if arg_231_1.var_.characterEffect2078ui_story and not isNil(var_234_4) then
					arg_231_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_231_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_5)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_5 and arg_231_1.time_ < 0 + var_234_5 + arg_234_0 and not isNil(var_234_4) and arg_231_1.var_.characterEffect2078ui_story then
				arg_231_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_231_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_234_6 = 0
			local var_234_7 = 0.25

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_8 = arg_231_1:GetWordFromCfg(317282057)
				local var_234_9 = arg_231_1:FormatText(var_234_8.content)

				arg_231_1.text_.text = var_234_9

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_11 = 10 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_9) / 10)

				if (10 <= 0 and var_234_7 or var_234_7 * (utf8.len(var_234_9) / 10)) > 0 and var_234_7 < var_234_11 then
					arg_231_1.talkMaxDuration = var_234_11

					if var_234_11 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_11 + var_234_6
					end
				end

				arg_231_1.text_.text = var_234_9
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282057", "story_v_out_317282.awb") ~= 0 then
					local var_234_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282057", "story_v_out_317282.awb") / 1000

					if var_234_12 + var_234_6 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_12 + var_234_6
					end

					if var_234_8.prefab_name ~= "" and arg_231_1.actors_[var_234_8.prefab_name] ~= nil then
						local var_234_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_8.prefab_name].transform, "story_v_out_317282", "317282057", "story_v_out_317282.awb")

						arg_231_1:RecordAudio("317282057", var_234_13)
						arg_231_1:RecordAudio("317282057", var_234_13)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_317282", "317282057", "story_v_out_317282.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_317282", "317282057", "story_v_out_317282.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_14 = math.max(var_234_7, arg_231_1.talkMaxDuration)

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_14 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_6) / var_234_14

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_6 + var_234_14 and arg_231_1.time_ < var_234_6 + var_234_14 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_231_1:InitPlayNodeList()
	end,
	Play317282058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 317282058
		arg_235_1.duration_ = 9.13

		local var_235_0 = {
			zh = 5.133,
			ja = 9.133
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play317282059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos2078ui_story = arg_235_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["2078ui_story"].transform.position).z)
				arg_235_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["2078ui_story"].transform.localEulerAngles = arg_235_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_235_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["2078ui_story"].transform.position).z)
				arg_235_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["2078ui_story"].transform.localEulerAngles = arg_235_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["2078ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect2078ui_story == nil then
				arg_235_1.var_.characterEffect2078ui_story = var_238_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_2 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 and not isNil(var_238_1) then
				if arg_235_1.var_.characterEffect2078ui_story and not isNil(var_238_1) then
					arg_235_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 and not isNil(var_238_1) and arg_235_1.var_.characterEffect2078ui_story then
				arg_235_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_238_4 = arg_235_1.actors_["2079ui_story"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect2079ui_story == nil then
				arg_235_1.var_.characterEffect2079ui_story = var_238_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_5 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_5 and not isNil(var_238_4) then
				if arg_235_1.var_.characterEffect2079ui_story and not isNil(var_238_4) then
					arg_235_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_235_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_5)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_5 and arg_235_1.time_ < 0 + var_238_5 + arg_238_0 and not isNil(var_238_4) and arg_235_1.var_.characterEffect2079ui_story then
				arg_235_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_235_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_238_6 = 0
			local var_238_7 = 0.55

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_6 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_8 = arg_235_1:GetWordFromCfg(317282058)
				local var_238_9 = arg_235_1:FormatText(var_238_8.content)

				arg_235_1.text_.text = var_238_9

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_11 = 22 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_9) / 22)

				if (22 <= 0 and var_238_7 or var_238_7 * (utf8.len(var_238_9) / 22)) > 0 and var_238_7 < var_238_11 then
					arg_235_1.talkMaxDuration = var_238_11

					if var_238_11 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_11 + var_238_6
					end
				end

				arg_235_1.text_.text = var_238_9
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282058", "story_v_out_317282.awb") ~= 0 then
					local var_238_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282058", "story_v_out_317282.awb") / 1000

					if var_238_12 + var_238_6 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_12 + var_238_6
					end

					if var_238_8.prefab_name ~= "" and arg_235_1.actors_[var_238_8.prefab_name] ~= nil then
						local var_238_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_8.prefab_name].transform, "story_v_out_317282", "317282058", "story_v_out_317282.awb")

						arg_235_1:RecordAudio("317282058", var_238_13)
						arg_235_1:RecordAudio("317282058", var_238_13)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_317282", "317282058", "story_v_out_317282.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_317282", "317282058", "story_v_out_317282.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_14 = math.max(var_238_7, arg_235_1.talkMaxDuration)

			if var_238_6 <= arg_235_1.time_ and arg_235_1.time_ < var_238_6 + var_238_14 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_6) / var_238_14

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_6 + var_238_14 and arg_235_1.time_ < var_238_6 + var_238_14 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play317282059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 317282059
		arg_239_1.duration_ = 9.9

		local var_239_0 = {
			zh = 7.6,
			ja = 9.9
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play317282060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0.95

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_1 = arg_239_1:GetWordFromCfg(317282059)
				local var_242_2 = arg_239_1:FormatText(var_242_1.content)

				arg_239_1.text_.text = var_242_2

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_4 = 38 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 38)

				if (38 <= 0 and var_242_0 or var_242_0 * (utf8.len(var_242_2) / 38)) > 0 and var_242_0 < var_242_4 then
					arg_239_1.talkMaxDuration = var_242_4

					if var_242_4 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_4 + 0
					end
				end

				arg_239_1.text_.text = var_242_2
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282059", "story_v_out_317282.awb") ~= 0 then
					local var_242_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282059", "story_v_out_317282.awb") / 1000

					if var_242_5 + 0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_5 + 0
					end

					if var_242_1.prefab_name ~= "" and arg_239_1.actors_[var_242_1.prefab_name] ~= nil then
						local var_242_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_1.prefab_name].transform, "story_v_out_317282", "317282059", "story_v_out_317282.awb")

						arg_239_1:RecordAudio("317282059", var_242_6)
						arg_239_1:RecordAudio("317282059", var_242_6)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_317282", "317282059", "story_v_out_317282.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_317282", "317282059", "story_v_out_317282.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_0, arg_239_1.talkMaxDuration)

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - 0) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= 0 + var_242_7 and arg_239_1.time_ < 0 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play317282060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 317282060
		arg_243_1.duration_ = 16.57

		local var_243_0 = {
			zh = 16.566,
			ja = 11.8
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play317282061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos2079ui_story = arg_243_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_246_0 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 then
				arg_243_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_243_1.time_ - 0) / var_246_0)
				arg_243_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["2079ui_story"].transform.position).z)
				arg_243_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["2079ui_story"].transform.localEulerAngles = arg_243_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 then
				arg_243_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_243_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_243_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_243_1.actors_["2079ui_story"].transform.position).z)
				arg_243_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_243_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_243_1.actors_["2079ui_story"].transform.localEulerAngles = arg_243_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_246_1 = arg_243_1.actors_["2079ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect2079ui_story == nil then
				arg_243_1.var_.characterEffect2079ui_story = var_246_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_2 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_2 and not isNil(var_246_1) then
				if arg_243_1.var_.characterEffect2079ui_story and not isNil(var_246_1) then
					arg_243_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_243_1.time_ >= 0 + var_246_2 and arg_243_1.time_ < 0 + var_246_2 + arg_246_0 and not isNil(var_246_1) and arg_243_1.var_.characterEffect2079ui_story then
				arg_243_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_246_4 = arg_243_1.actors_["2078ui_story"]

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect2078ui_story == nil then
				arg_243_1.var_.characterEffect2078ui_story = var_246_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_5 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_5 and not isNil(var_246_4) then
				if arg_243_1.var_.characterEffect2078ui_story and not isNil(var_246_4) then
					arg_243_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_243_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_5)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_5 and arg_243_1.time_ < 0 + var_246_5 + arg_246_0 and not isNil(var_246_4) and arg_243_1.var_.characterEffect2078ui_story then
				arg_243_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_243_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_246_6 = 0
			local var_246_7 = 1.925

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_6 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_8 = arg_243_1:GetWordFromCfg(317282060)
				local var_246_9 = arg_243_1:FormatText(var_246_8.content)

				arg_243_1.text_.text = var_246_9

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_11 = 77 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_9) / 77)

				if (77 <= 0 and var_246_7 or var_246_7 * (utf8.len(var_246_9) / 77)) > 0 and var_246_7 < var_246_11 then
					arg_243_1.talkMaxDuration = var_246_11

					if var_246_11 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_11 + var_246_6
					end
				end

				arg_243_1.text_.text = var_246_9
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282060", "story_v_out_317282.awb") ~= 0 then
					local var_246_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282060", "story_v_out_317282.awb") / 1000

					if var_246_12 + var_246_6 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_12 + var_246_6
					end

					if var_246_8.prefab_name ~= "" and arg_243_1.actors_[var_246_8.prefab_name] ~= nil then
						local var_246_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_8.prefab_name].transform, "story_v_out_317282", "317282060", "story_v_out_317282.awb")

						arg_243_1:RecordAudio("317282060", var_246_13)
						arg_243_1:RecordAudio("317282060", var_246_13)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_317282", "317282060", "story_v_out_317282.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_317282", "317282060", "story_v_out_317282.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_14 = math.max(var_246_7, arg_243_1.talkMaxDuration)

			if var_246_6 <= arg_243_1.time_ and arg_243_1.time_ < var_246_6 + var_246_14 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_6) / var_246_14

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_6 + var_246_14 and arg_243_1.time_ < var_246_6 + var_246_14 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_243_1:InitPlayNodeList()
	end,
	Play317282061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 317282061
		arg_247_1.duration_ = 3.4

		local var_247_0 = {
			zh = 1.433,
			ja = 3.4
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play317282062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos2078ui_story = arg_247_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_250_0 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 then
				arg_247_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_247_1.time_ - 0) / var_250_0)
				arg_247_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["2078ui_story"].transform.position).z)
				arg_247_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["2078ui_story"].transform.localEulerAngles = arg_247_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 then
				arg_247_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_247_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_247_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_247_1.actors_["2078ui_story"].transform.position).z)
				arg_247_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_247_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_247_1.actors_["2078ui_story"].transform.localEulerAngles = arg_247_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_250_1 = arg_247_1.actors_["2078ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect2078ui_story == nil then
				arg_247_1.var_.characterEffect2078ui_story = var_250_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_2 and not isNil(var_250_1) then
				if arg_247_1.var_.characterEffect2078ui_story and not isNil(var_250_1) then
					arg_247_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= 0 + var_250_2 and arg_247_1.time_ < 0 + var_250_2 + arg_250_0 and not isNil(var_250_1) and arg_247_1.var_.characterEffect2078ui_story then
				arg_247_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_250_4 = arg_247_1.actors_["2079ui_story"]

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect2079ui_story == nil then
				arg_247_1.var_.characterEffect2079ui_story = var_250_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_5 = 0.200000002980232

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_5 and not isNil(var_250_4) then
				if arg_247_1.var_.characterEffect2079ui_story and not isNil(var_250_4) then
					arg_247_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_247_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_247_1.time_ - 0) / var_250_5)
				end
			end

			if arg_247_1.time_ >= 0 + var_250_5 and arg_247_1.time_ < 0 + var_250_5 + arg_250_0 and not isNil(var_250_4) and arg_247_1.var_.characterEffect2079ui_story then
				arg_247_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_247_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_250_6 = 0
			local var_250_7 = 0.125

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_6 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_8 = arg_247_1:GetWordFromCfg(317282061)
				local var_250_9 = arg_247_1:FormatText(var_250_8.content)

				arg_247_1.text_.text = var_250_9

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_11 = 5 <= 0 and var_250_7 or var_250_7 * (utf8.len(var_250_9) / 5)

				if (5 <= 0 and var_250_7 or var_250_7 * (utf8.len(var_250_9) / 5)) > 0 and var_250_7 < var_250_11 then
					arg_247_1.talkMaxDuration = var_250_11

					if var_250_11 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_6
					end
				end

				arg_247_1.text_.text = var_250_9
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282061", "story_v_out_317282.awb") ~= 0 then
					local var_250_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282061", "story_v_out_317282.awb") / 1000

					if var_250_12 + var_250_6 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_12 + var_250_6
					end

					if var_250_8.prefab_name ~= "" and arg_247_1.actors_[var_250_8.prefab_name] ~= nil then
						local var_250_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_8.prefab_name].transform, "story_v_out_317282", "317282061", "story_v_out_317282.awb")

						arg_247_1:RecordAudio("317282061", var_250_13)
						arg_247_1:RecordAudio("317282061", var_250_13)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_317282", "317282061", "story_v_out_317282.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_317282", "317282061", "story_v_out_317282.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_14 = math.max(var_250_7, arg_247_1.talkMaxDuration)

			if var_250_6 <= arg_247_1.time_ and arg_247_1.time_ < var_250_6 + var_250_14 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_6) / var_250_14

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_6 + var_250_14 and arg_247_1.time_ < var_250_6 + var_250_14 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_247_1:InitPlayNodeList()
	end,
	Play317282062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 317282062
		arg_251_1.duration_ = 3.7

		local var_251_0 = {
			zh = 3.7,
			ja = 3.666
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play317282063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos2079ui_story = arg_251_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_254_0 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_0 then
				arg_251_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_251_1.time_ - 0) / var_254_0)
				arg_251_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["2079ui_story"].transform.position).z)
				arg_251_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["2079ui_story"].transform.localEulerAngles = arg_251_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_0 and arg_251_1.time_ < 0 + var_254_0 + arg_254_0 then
				arg_251_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_251_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_251_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_251_1.actors_["2079ui_story"].transform.position).z)
				arg_251_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_251_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_251_1.actors_["2079ui_story"].transform.localEulerAngles = arg_251_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_254_1 = arg_251_1.actors_["2079ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect2079ui_story == nil then
				arg_251_1.var_.characterEffect2079ui_story = var_254_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_2 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_2 and not isNil(var_254_1) then
				if arg_251_1.var_.characterEffect2079ui_story and not isNil(var_254_1) then
					arg_251_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_251_1.time_ >= 0 + var_254_2 and arg_251_1.time_ < 0 + var_254_2 + arg_254_0 and not isNil(var_254_1) and arg_251_1.var_.characterEffect2079ui_story then
				arg_251_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_254_4 = arg_251_1.actors_["2078ui_story"]

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect2078ui_story == nil then
				arg_251_1.var_.characterEffect2078ui_story = var_254_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_254_5 = 0.200000002980232

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_5 and not isNil(var_254_4) then
				if arg_251_1.var_.characterEffect2078ui_story and not isNil(var_254_4) then
					arg_251_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_251_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_251_1.time_ - 0) / var_254_5)
				end
			end

			if arg_251_1.time_ >= 0 + var_254_5 and arg_251_1.time_ < 0 + var_254_5 + arg_254_0 and not isNil(var_254_4) and arg_251_1.var_.characterEffect2078ui_story then
				arg_251_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_251_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_254_6 = 0
			local var_254_7 = 0.4

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= var_254_6 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_8 = arg_251_1:GetWordFromCfg(317282062)
				local var_254_9 = arg_251_1:FormatText(var_254_8.content)

				arg_251_1.text_.text = var_254_9

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_11 = 16 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_9) / 16)

				if (16 <= 0 and var_254_7 or var_254_7 * (utf8.len(var_254_9) / 16)) > 0 and var_254_7 < var_254_11 then
					arg_251_1.talkMaxDuration = var_254_11

					if var_254_11 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_11 + var_254_6
					end
				end

				arg_251_1.text_.text = var_254_9
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282062", "story_v_out_317282.awb") ~= 0 then
					local var_254_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282062", "story_v_out_317282.awb") / 1000

					if var_254_12 + var_254_6 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_12 + var_254_6
					end

					if var_254_8.prefab_name ~= "" and arg_251_1.actors_[var_254_8.prefab_name] ~= nil then
						local var_254_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_8.prefab_name].transform, "story_v_out_317282", "317282062", "story_v_out_317282.awb")

						arg_251_1:RecordAudio("317282062", var_254_13)
						arg_251_1:RecordAudio("317282062", var_254_13)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_317282", "317282062", "story_v_out_317282.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_317282", "317282062", "story_v_out_317282.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_14 = math.max(var_254_7, arg_251_1.talkMaxDuration)

			if var_254_6 <= arg_251_1.time_ and arg_251_1.time_ < var_254_6 + var_254_14 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_6) / var_254_14

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_6 + var_254_14 and arg_251_1.time_ < var_254_6 + var_254_14 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end

		arg_251_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_251_1:InitPlayNodeList()
	end,
	Play317282063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 317282063
		arg_255_1.duration_ = 6.03

		local var_255_0 = {
			zh = 6.033,
			ja = 5.566
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play317282064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos2078ui_story = arg_255_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_258_0 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 then
				arg_255_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_255_1.time_ - 0) / var_258_0)
				arg_255_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["2078ui_story"].transform.position).z)
				arg_255_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["2078ui_story"].transform.localEulerAngles = arg_255_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 then
				arg_255_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_255_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_255_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_255_1.actors_["2078ui_story"].transform.position).z)
				arg_255_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_255_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_255_1.actors_["2078ui_story"].transform.localEulerAngles = arg_255_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_258_1 = arg_255_1.actors_["2078ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect2078ui_story == nil then
				arg_255_1.var_.characterEffect2078ui_story = var_258_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_2 and not isNil(var_258_1) then
				if arg_255_1.var_.characterEffect2078ui_story and not isNil(var_258_1) then
					arg_255_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 0 + var_258_2 and arg_255_1.time_ < 0 + var_258_2 + arg_258_0 and not isNil(var_258_1) and arg_255_1.var_.characterEffect2078ui_story then
				arg_255_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_258_4 = arg_255_1.actors_["2079ui_story"]

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect2079ui_story == nil then
				arg_255_1.var_.characterEffect2079ui_story = var_258_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_5 = 0.200000002980232

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_5 and not isNil(var_258_4) then
				if arg_255_1.var_.characterEffect2079ui_story and not isNil(var_258_4) then
					arg_255_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_255_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_255_1.time_ - 0) / var_258_5)
				end
			end

			if arg_255_1.time_ >= 0 + var_258_5 and arg_255_1.time_ < 0 + var_258_5 + arg_258_0 and not isNil(var_258_4) and arg_255_1.var_.characterEffect2079ui_story then
				arg_255_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_255_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_258_6 = 0
			local var_258_7 = 0.7

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_6 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_8 = arg_255_1:GetWordFromCfg(317282063)
				local var_258_9 = arg_255_1:FormatText(var_258_8.content)

				arg_255_1.text_.text = var_258_9

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_11 = 28 <= 0 and var_258_7 or var_258_7 * (utf8.len(var_258_9) / 28)

				if (28 <= 0 and var_258_7 or var_258_7 * (utf8.len(var_258_9) / 28)) > 0 and var_258_7 < var_258_11 then
					arg_255_1.talkMaxDuration = var_258_11

					if var_258_11 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_11 + var_258_6
					end
				end

				arg_255_1.text_.text = var_258_9
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282063", "story_v_out_317282.awb") ~= 0 then
					local var_258_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282063", "story_v_out_317282.awb") / 1000

					if var_258_12 + var_258_6 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_12 + var_258_6
					end

					if var_258_8.prefab_name ~= "" and arg_255_1.actors_[var_258_8.prefab_name] ~= nil then
						local var_258_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_8.prefab_name].transform, "story_v_out_317282", "317282063", "story_v_out_317282.awb")

						arg_255_1:RecordAudio("317282063", var_258_13)
						arg_255_1:RecordAudio("317282063", var_258_13)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_317282", "317282063", "story_v_out_317282.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_317282", "317282063", "story_v_out_317282.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_14 = math.max(var_258_7, arg_255_1.talkMaxDuration)

			if var_258_6 <= arg_255_1.time_ and arg_255_1.time_ < var_258_6 + var_258_14 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_6) / var_258_14

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_6 + var_258_14 and arg_255_1.time_ < var_258_6 + var_258_14 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play317282064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 317282064
		arg_259_1.duration_ = 14.03

		local var_259_0 = {
			zh = 14.033,
			ja = 11.4
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play317282065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = 1.7

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_1 = arg_259_1:GetWordFromCfg(317282064)
				local var_262_2 = arg_259_1:FormatText(var_262_1.content)

				arg_259_1.text_.text = var_262_2

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_4 = 69 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 69)

				if (69 <= 0 and var_262_0 or var_262_0 * (utf8.len(var_262_2) / 69)) > 0 and var_262_0 < var_262_4 then
					arg_259_1.talkMaxDuration = var_262_4

					if var_262_4 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_4 + 0
					end
				end

				arg_259_1.text_.text = var_262_2
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282064", "story_v_out_317282.awb") ~= 0 then
					local var_262_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282064", "story_v_out_317282.awb") / 1000

					if var_262_5 + 0 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_5 + 0
					end

					if var_262_1.prefab_name ~= "" and arg_259_1.actors_[var_262_1.prefab_name] ~= nil then
						local var_262_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_1.prefab_name].transform, "story_v_out_317282", "317282064", "story_v_out_317282.awb")

						arg_259_1:RecordAudio("317282064", var_262_6)
						arg_259_1:RecordAudio("317282064", var_262_6)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_317282", "317282064", "story_v_out_317282.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_317282", "317282064", "story_v_out_317282.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_7 = math.max(var_262_0, arg_259_1.talkMaxDuration)

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_7 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - 0) / var_262_7

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= 0 + var_262_7 and arg_259_1.time_ < 0 + var_262_7 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play317282065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 317282065
		arg_263_1.duration_ = 2.43

		local var_263_0 = {
			zh = 2,
			ja = 2.433
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play317282066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.var_.moveOldPos2079ui_story = arg_263_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_266_0 = 0.001

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_0 then
				arg_263_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_263_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_263_1.time_ - 0) / var_266_0)
				arg_263_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["2079ui_story"].transform.position).z)
				arg_263_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["2079ui_story"].transform.localEulerAngles = arg_263_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_263_1.time_ >= 0 + var_266_0 and arg_263_1.time_ < 0 + var_266_0 + arg_266_0 then
				arg_263_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_263_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_263_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_263_1.actors_["2079ui_story"].transform.position).z)
				arg_263_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_263_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_263_1.actors_["2079ui_story"].transform.localEulerAngles = arg_263_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_266_1 = arg_263_1.actors_["2079ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect2079ui_story == nil then
				arg_263_1.var_.characterEffect2079ui_story = var_266_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_2 and not isNil(var_266_1) then
				if arg_263_1.var_.characterEffect2079ui_story and not isNil(var_266_1) then
					arg_263_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= 0 + var_266_2 and arg_263_1.time_ < 0 + var_266_2 + arg_266_0 and not isNil(var_266_1) and arg_263_1.var_.characterEffect2079ui_story then
				arg_263_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_266_4 = arg_263_1.actors_["2078ui_story"]

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 and not isNil(var_266_4) and arg_263_1.var_.characterEffect2078ui_story == nil then
				arg_263_1.var_.characterEffect2078ui_story = var_266_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_5 = 0.200000002980232

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_5 and not isNil(var_266_4) then
				if arg_263_1.var_.characterEffect2078ui_story and not isNil(var_266_4) then
					arg_263_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_263_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_263_1.time_ - 0) / var_266_5)
				end
			end

			if arg_263_1.time_ >= 0 + var_266_5 and arg_263_1.time_ < 0 + var_266_5 + arg_266_0 and not isNil(var_266_4) and arg_263_1.var_.characterEffect2078ui_story then
				arg_263_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_263_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_266_6 = 0
			local var_266_7 = 0.25

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= var_266_6 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_8 = arg_263_1:GetWordFromCfg(317282065)
				local var_266_9 = arg_263_1:FormatText(var_266_8.content)

				arg_263_1.text_.text = var_266_9

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_11 = 10 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 10)

				if (10 <= 0 and var_266_7 or var_266_7 * (utf8.len(var_266_9) / 10)) > 0 and var_266_7 < var_266_11 then
					arg_263_1.talkMaxDuration = var_266_11

					if var_266_11 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_11 + var_266_6
					end
				end

				arg_263_1.text_.text = var_266_9
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282065", "story_v_out_317282.awb") ~= 0 then
					local var_266_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282065", "story_v_out_317282.awb") / 1000

					if var_266_12 + var_266_6 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_12 + var_266_6
					end

					if var_266_8.prefab_name ~= "" and arg_263_1.actors_[var_266_8.prefab_name] ~= nil then
						local var_266_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_8.prefab_name].transform, "story_v_out_317282", "317282065", "story_v_out_317282.awb")

						arg_263_1:RecordAudio("317282065", var_266_13)
						arg_263_1:RecordAudio("317282065", var_266_13)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_317282", "317282065", "story_v_out_317282.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_317282", "317282065", "story_v_out_317282.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_14 = math.max(var_266_7, arg_263_1.talkMaxDuration)

			if var_266_6 <= arg_263_1.time_ and arg_263_1.time_ < var_266_6 + var_266_14 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_6) / var_266_14

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_6 + var_266_14 and arg_263_1.time_ < var_266_6 + var_266_14 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_263_1:InitPlayNodeList()
	end,
	Play317282066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 317282066
		arg_267_1.duration_ = 6.4

		local var_267_0 = {
			zh = 6.233,
			ja = 6.4
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play317282067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos2078ui_story = arg_267_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_270_0 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 then
				arg_267_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_267_1.time_ - 0) / var_270_0)
				arg_267_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["2078ui_story"].transform.position).z)
				arg_267_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["2078ui_story"].transform.localEulerAngles = arg_267_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 then
				arg_267_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_267_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_267_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_267_1.actors_["2078ui_story"].transform.position).z)
				arg_267_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_267_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_267_1.actors_["2078ui_story"].transform.localEulerAngles = arg_267_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_270_1 = arg_267_1.actors_["2078ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect2078ui_story == nil then
				arg_267_1.var_.characterEffect2078ui_story = var_270_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_2 and not isNil(var_270_1) then
				if arg_267_1.var_.characterEffect2078ui_story and not isNil(var_270_1) then
					arg_267_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= 0 + var_270_2 and arg_267_1.time_ < 0 + var_270_2 + arg_270_0 and not isNil(var_270_1) and arg_267_1.var_.characterEffect2078ui_story then
				arg_267_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_270_4 = arg_267_1.actors_["2079ui_story"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect2079ui_story == nil then
				arg_267_1.var_.characterEffect2079ui_story = var_270_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_5 = 0.200000002980232

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_5 and not isNil(var_270_4) then
				if arg_267_1.var_.characterEffect2079ui_story and not isNil(var_270_4) then
					arg_267_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_267_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_267_1.time_ - 0) / var_270_5)
				end
			end

			if arg_267_1.time_ >= 0 + var_270_5 and arg_267_1.time_ < 0 + var_270_5 + arg_270_0 and not isNil(var_270_4) and arg_267_1.var_.characterEffect2079ui_story then
				arg_267_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_267_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_270_6 = 0
			local var_270_7 = 0.425

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_6 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_8 = arg_267_1:GetWordFromCfg(317282066)
				local var_270_9 = arg_267_1:FormatText(var_270_8.content)

				arg_267_1.text_.text = var_270_9

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_11 = 17 <= 0 and var_270_7 or var_270_7 * (utf8.len(var_270_9) / 17)

				if (17 <= 0 and var_270_7 or var_270_7 * (utf8.len(var_270_9) / 17)) > 0 and var_270_7 < var_270_11 then
					arg_267_1.talkMaxDuration = var_270_11

					if var_270_11 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_11 + var_270_6
					end
				end

				arg_267_1.text_.text = var_270_9
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282066", "story_v_out_317282.awb") ~= 0 then
					local var_270_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282066", "story_v_out_317282.awb") / 1000

					if var_270_12 + var_270_6 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_12 + var_270_6
					end

					if var_270_8.prefab_name ~= "" and arg_267_1.actors_[var_270_8.prefab_name] ~= nil then
						local var_270_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_8.prefab_name].transform, "story_v_out_317282", "317282066", "story_v_out_317282.awb")

						arg_267_1:RecordAudio("317282066", var_270_13)
						arg_267_1:RecordAudio("317282066", var_270_13)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_317282", "317282066", "story_v_out_317282.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_317282", "317282066", "story_v_out_317282.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_14 = math.max(var_270_7, arg_267_1.talkMaxDuration)

			if var_270_6 <= arg_267_1.time_ and arg_267_1.time_ < var_270_6 + var_270_14 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_6) / var_270_14

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_6 + var_270_14 and arg_267_1.time_ < var_270_6 + var_270_14 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_267_1:InitPlayNodeList()
	end,
	Play317282067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 317282067
		arg_271_1.duration_ = 6.3

		local var_271_0 = {
			zh = 4.866,
			ja = 6.3
		}
		local var_271_1 = manager.audio:GetLocalizationFlag()

		if var_271_0[var_271_1] ~= nil then
			arg_271_1.duration_ = var_271_0[var_271_1]
		end

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play317282068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos2079ui_story = arg_271_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["2079ui_story"].transform.position).z)
				arg_271_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["2079ui_story"].transform.localEulerAngles = arg_271_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_271_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["2079ui_story"].transform.position).z)
				arg_271_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["2079ui_story"].transform.localEulerAngles = arg_271_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["2079ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect2079ui_story == nil then
				arg_271_1.var_.characterEffect2079ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect2079ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect2079ui_story then
				arg_271_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_274_4 = arg_271_1.actors_["2078ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect2078ui_story == nil then
				arg_271_1.var_.characterEffect2078ui_story = var_274_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_5 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_5 and not isNil(var_274_4) then
				if arg_271_1.var_.characterEffect2078ui_story and not isNil(var_274_4) then
					arg_271_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_271_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_5)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_5 and arg_271_1.time_ < 0 + var_274_5 + arg_274_0 and not isNil(var_274_4) and arg_271_1.var_.characterEffect2078ui_story then
				arg_271_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_271_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_274_6 = 0
			local var_274_7 = 0.725

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_6 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_8 = arg_271_1:GetWordFromCfg(317282067)
				local var_274_9 = arg_271_1:FormatText(var_274_8.content)

				arg_271_1.text_.text = var_274_9

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_11 = 29 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_9) / 29)

				if (29 <= 0 and var_274_7 or var_274_7 * (utf8.len(var_274_9) / 29)) > 0 and var_274_7 < var_274_11 then
					arg_271_1.talkMaxDuration = var_274_11

					if var_274_11 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_11 + var_274_6
					end
				end

				arg_271_1.text_.text = var_274_9
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282067", "story_v_out_317282.awb") ~= 0 then
					local var_274_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282067", "story_v_out_317282.awb") / 1000

					if var_274_12 + var_274_6 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_12 + var_274_6
					end

					if var_274_8.prefab_name ~= "" and arg_271_1.actors_[var_274_8.prefab_name] ~= nil then
						local var_274_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_8.prefab_name].transform, "story_v_out_317282", "317282067", "story_v_out_317282.awb")

						arg_271_1:RecordAudio("317282067", var_274_13)
						arg_271_1:RecordAudio("317282067", var_274_13)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_317282", "317282067", "story_v_out_317282.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_317282", "317282067", "story_v_out_317282.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_14 = math.max(var_274_7, arg_271_1.talkMaxDuration)

			if var_274_6 <= arg_271_1.time_ and arg_271_1.time_ < var_274_6 + var_274_14 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_6) / var_274_14

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_6 + var_274_14 and arg_271_1.time_ < var_274_6 + var_274_14 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_271_1:InitPlayNodeList()
	end,
	Play317282068 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 317282068
		arg_275_1.duration_ = 13.03

		local var_275_0 = {
			zh = 12.566,
			ja = 13.033
		}
		local var_275_1 = manager.audio:GetLocalizationFlag()

		if var_275_0[var_275_1] ~= nil then
			arg_275_1.duration_ = var_275_0[var_275_1]
		end

		SetActive(arg_275_1.tipsGo_, false)

		function arg_275_1.onSingleLineFinish_()
			arg_275_1.onSingleLineUpdate_ = nil
			arg_275_1.onSingleLineFinish_ = nil
			arg_275_1.state_ = "waiting"
		end

		function arg_275_1.playNext_(arg_277_0)
			if arg_277_0 == 1 then
				arg_275_0:Play317282069(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.var_.moveOldPos2078ui_story = arg_275_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_278_0 = 0.001

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 then
				arg_275_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_275_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_275_1.time_ - 0) / var_278_0)
				arg_275_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["2078ui_story"].transform.position).z)
				arg_275_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["2078ui_story"].transform.localEulerAngles = arg_275_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 then
				arg_275_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_275_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_275_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_275_1.actors_["2078ui_story"].transform.position).z)
				arg_275_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_275_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_275_1.actors_["2078ui_story"].transform.localEulerAngles = arg_275_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_278_1 = arg_275_1.actors_["2078ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect2078ui_story == nil then
				arg_275_1.var_.characterEffect2078ui_story = var_278_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_2 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_2 and not isNil(var_278_1) then
				if arg_275_1.var_.characterEffect2078ui_story and not isNil(var_278_1) then
					arg_275_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_275_1.time_ >= 0 + var_278_2 and arg_275_1.time_ < 0 + var_278_2 + arg_278_0 and not isNil(var_278_1) and arg_275_1.var_.characterEffect2078ui_story then
				arg_275_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_278_4 = arg_275_1.actors_["2079ui_story"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect2079ui_story == nil then
				arg_275_1.var_.characterEffect2079ui_story = var_278_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_278_5 = 0.200000002980232

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_5 and not isNil(var_278_4) then
				if arg_275_1.var_.characterEffect2079ui_story and not isNil(var_278_4) then
					arg_275_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_275_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_275_1.time_ - 0) / var_278_5)
				end
			end

			if arg_275_1.time_ >= 0 + var_278_5 and arg_275_1.time_ < 0 + var_278_5 + arg_278_0 and not isNil(var_278_4) and arg_275_1.var_.characterEffect2079ui_story then
				arg_275_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_275_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_278_6 = 0
			local var_278_7 = 1.325

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_6 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_8 = arg_275_1:GetWordFromCfg(317282068)
				local var_278_9 = arg_275_1:FormatText(var_278_8.content)

				arg_275_1.text_.text = var_278_9

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_11 = 53 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_9) / 53)

				if (53 <= 0 and var_278_7 or var_278_7 * (utf8.len(var_278_9) / 53)) > 0 and var_278_7 < var_278_11 then
					arg_275_1.talkMaxDuration = var_278_11

					if var_278_11 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_11 + var_278_6
					end
				end

				arg_275_1.text_.text = var_278_9
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282068", "story_v_out_317282.awb") ~= 0 then
					local var_278_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282068", "story_v_out_317282.awb") / 1000

					if var_278_12 + var_278_6 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_12 + var_278_6
					end

					if var_278_8.prefab_name ~= "" and arg_275_1.actors_[var_278_8.prefab_name] ~= nil then
						local var_278_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_8.prefab_name].transform, "story_v_out_317282", "317282068", "story_v_out_317282.awb")

						arg_275_1:RecordAudio("317282068", var_278_13)
						arg_275_1:RecordAudio("317282068", var_278_13)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_317282", "317282068", "story_v_out_317282.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_317282", "317282068", "story_v_out_317282.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_14 = math.max(var_278_7, arg_275_1.talkMaxDuration)

			if var_278_6 <= arg_275_1.time_ and arg_275_1.time_ < var_278_6 + var_278_14 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_6) / var_278_14

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_6 + var_278_14 and arg_275_1.time_ < var_278_6 + var_278_14 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_275_1:InitPlayNodeList()
	end,
	Play317282069 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 317282069
		arg_279_1.duration_ = 12.77

		local var_279_0 = {
			zh = 12.766,
			ja = 12.433
		}
		local var_279_1 = manager.audio:GetLocalizationFlag()

		if var_279_0[var_279_1] ~= nil then
			arg_279_1.duration_ = var_279_0[var_279_1]
		end

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play317282070(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			local var_282_0 = 1.625

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_1 = arg_279_1:GetWordFromCfg(317282069)
				local var_282_2 = arg_279_1:FormatText(var_282_1.content)

				arg_279_1.text_.text = var_282_2

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_4 = 65 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 65)

				if (65 <= 0 and var_282_0 or var_282_0 * (utf8.len(var_282_2) / 65)) > 0 and var_282_0 < var_282_4 then
					arg_279_1.talkMaxDuration = var_282_4

					if var_282_4 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_4 + 0
					end
				end

				arg_279_1.text_.text = var_282_2
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282069", "story_v_out_317282.awb") ~= 0 then
					local var_282_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282069", "story_v_out_317282.awb") / 1000

					if var_282_5 + 0 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + 0
					end

					if var_282_1.prefab_name ~= "" and arg_279_1.actors_[var_282_1.prefab_name] ~= nil then
						local var_282_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_1.prefab_name].transform, "story_v_out_317282", "317282069", "story_v_out_317282.awb")

						arg_279_1:RecordAudio("317282069", var_282_6)
						arg_279_1:RecordAudio("317282069", var_282_6)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_317282", "317282069", "story_v_out_317282.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_317282", "317282069", "story_v_out_317282.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_7 = math.max(var_282_0, arg_279_1.talkMaxDuration)

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_7 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - 0) / var_282_7

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= 0 + var_282_7 and arg_279_1.time_ < 0 + var_282_7 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play317282070 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 317282070
		arg_283_1.duration_ = 5.8

		local var_283_0 = {
			zh = 5.8,
			ja = 2.966
		}
		local var_283_1 = manager.audio:GetLocalizationFlag()

		if var_283_0[var_283_1] ~= nil then
			arg_283_1.duration_ = var_283_0[var_283_1]
		end

		SetActive(arg_283_1.tipsGo_, false)

		function arg_283_1.onSingleLineFinish_()
			arg_283_1.onSingleLineUpdate_ = nil
			arg_283_1.onSingleLineFinish_ = nil
			arg_283_1.state_ = "waiting"
		end

		function arg_283_1.playNext_(arg_285_0)
			if arg_285_0 == 1 then
				arg_283_0:Play317282071(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos2079ui_story = arg_283_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["2079ui_story"].transform.position).z)
				arg_283_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["2079ui_story"].transform.localEulerAngles = arg_283_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_283_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["2079ui_story"].transform.position).z)
				arg_283_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["2079ui_story"].transform.localEulerAngles = arg_283_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["2079ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect2079ui_story == nil then
				arg_283_1.var_.characterEffect2079ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect2079ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect2079ui_story then
				arg_283_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_286_4 = arg_283_1.actors_["2078ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect2078ui_story == nil then
				arg_283_1.var_.characterEffect2078ui_story = var_286_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_5 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_5 and not isNil(var_286_4) then
				if arg_283_1.var_.characterEffect2078ui_story and not isNil(var_286_4) then
					arg_283_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_283_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_5)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_5 and arg_283_1.time_ < 0 + var_286_5 + arg_286_0 and not isNil(var_286_4) and arg_283_1.var_.characterEffect2078ui_story then
				arg_283_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_283_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_286_6 = 0
			local var_286_7 = 0.7

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_6 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_8 = arg_283_1:GetWordFromCfg(317282070)
				local var_286_9 = arg_283_1:FormatText(var_286_8.content)

				arg_283_1.text_.text = var_286_9

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_11 = 28 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_9) / 28)

				if (28 <= 0 and var_286_7 or var_286_7 * (utf8.len(var_286_9) / 28)) > 0 and var_286_7 < var_286_11 then
					arg_283_1.talkMaxDuration = var_286_11

					if var_286_11 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_11 + var_286_6
					end
				end

				arg_283_1.text_.text = var_286_9
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282070", "story_v_out_317282.awb") ~= 0 then
					local var_286_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282070", "story_v_out_317282.awb") / 1000

					if var_286_12 + var_286_6 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_12 + var_286_6
					end

					if var_286_8.prefab_name ~= "" and arg_283_1.actors_[var_286_8.prefab_name] ~= nil then
						local var_286_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_8.prefab_name].transform, "story_v_out_317282", "317282070", "story_v_out_317282.awb")

						arg_283_1:RecordAudio("317282070", var_286_13)
						arg_283_1:RecordAudio("317282070", var_286_13)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_317282", "317282070", "story_v_out_317282.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_317282", "317282070", "story_v_out_317282.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_14 = math.max(var_286_7, arg_283_1.talkMaxDuration)

			if var_286_6 <= arg_283_1.time_ and arg_283_1.time_ < var_286_6 + var_286_14 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_6) / var_286_14

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_6 + var_286_14 and arg_283_1.time_ < var_286_6 + var_286_14 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play317282071 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 317282071
		arg_287_1.duration_ = 4.37

		local var_287_0 = {
			zh = 4.233,
			ja = 4.366
		}
		local var_287_1 = manager.audio:GetLocalizationFlag()

		if var_287_0[var_287_1] ~= nil then
			arg_287_1.duration_ = var_287_0[var_287_1]
		end

		SetActive(arg_287_1.tipsGo_, false)

		function arg_287_1.onSingleLineFinish_()
			arg_287_1.onSingleLineUpdate_ = nil
			arg_287_1.onSingleLineFinish_ = nil
			arg_287_1.state_ = "waiting"
		end

		function arg_287_1.playNext_(arg_289_0)
			if arg_289_0 == 1 then
				arg_287_0:Play317282072(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.575

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(317282071)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 23 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 23)

				if (23 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 23)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282071", "story_v_out_317282.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282071", "story_v_out_317282.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_317282", "317282071", "story_v_out_317282.awb")

						arg_287_1:RecordAudio("317282071", var_290_6)
						arg_287_1:RecordAudio("317282071", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_317282", "317282071", "story_v_out_317282.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_317282", "317282071", "story_v_out_317282.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_7 = math.max(var_290_0, arg_287_1.talkMaxDuration)

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - 0) / var_290_7

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {}

		arg_287_1:InitPlayNodeList()
	end,
	Play317282072 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 317282072
		arg_291_1.duration_ = 2.6

		local var_291_0 = {
			zh = 2.6,
			ja = 1.966
		}
		local var_291_1 = manager.audio:GetLocalizationFlag()

		if var_291_0[var_291_1] ~= nil then
			arg_291_1.duration_ = var_291_0[var_291_1]
		end

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play317282073(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos2078ui_story = arg_291_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_294_0 = 0.001

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 then
				arg_291_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_291_1.time_ - 0) / var_294_0)
				arg_291_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["2078ui_story"].transform.position).z)
				arg_291_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["2078ui_story"].transform.localEulerAngles = arg_291_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 then
				arg_291_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_291_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_291_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_291_1.actors_["2078ui_story"].transform.position).z)
				arg_291_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_291_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_291_1.actors_["2078ui_story"].transform.localEulerAngles = arg_291_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_294_1 = arg_291_1.actors_["2079ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect2079ui_story == nil then
				arg_291_1.var_.characterEffect2079ui_story = var_294_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_2 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_2 and not isNil(var_294_1) then
				if arg_291_1.var_.characterEffect2079ui_story and not isNil(var_294_1) then
					arg_291_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_291_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_2)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_2 and arg_291_1.time_ < 0 + var_294_2 + arg_294_0 and not isNil(var_294_1) and arg_291_1.var_.characterEffect2079ui_story then
				arg_291_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_291_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_294_3 = arg_291_1.actors_["2078ui_story"]

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(var_294_3) and arg_291_1.var_.characterEffect2078ui_story == nil then
				arg_291_1.var_.characterEffect2078ui_story = var_294_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_4 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_4 and not isNil(var_294_3) then
				if arg_291_1.var_.characterEffect2078ui_story and not isNil(var_294_3) then
					arg_291_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 and not isNil(var_294_3) and arg_291_1.var_.characterEffect2078ui_story then
				arg_291_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_294_6 = 0
			local var_294_7 = 0.2

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_6 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, true)

				arg_291_1.leftNameTxt_.text = arg_291_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_291_1.leftNameTxt_.transform)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1.leftNameTxt_.text)
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_8 = arg_291_1:GetWordFromCfg(317282072)
				local var_294_9 = arg_291_1:FormatText(var_294_8.content)

				arg_291_1.text_.text = var_294_9

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_11 = 8 <= 0 and var_294_7 or var_294_7 * (utf8.len(var_294_9) / 8)

				if (8 <= 0 and var_294_7 or var_294_7 * (utf8.len(var_294_9) / 8)) > 0 and var_294_7 < var_294_11 then
					arg_291_1.talkMaxDuration = var_294_11

					if var_294_11 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_11 + var_294_6
					end
				end

				arg_291_1.text_.text = var_294_9
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282072", "story_v_out_317282.awb") ~= 0 then
					local var_294_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282072", "story_v_out_317282.awb") / 1000

					if var_294_12 + var_294_6 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_12 + var_294_6
					end

					if var_294_8.prefab_name ~= "" and arg_291_1.actors_[var_294_8.prefab_name] ~= nil then
						local var_294_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_291_1.actors_[var_294_8.prefab_name].transform, "story_v_out_317282", "317282072", "story_v_out_317282.awb")

						arg_291_1:RecordAudio("317282072", var_294_13)
						arg_291_1:RecordAudio("317282072", var_294_13)
					else
						arg_291_1:AudioAction("play", "voice", "story_v_out_317282", "317282072", "story_v_out_317282.awb")
					end

					arg_291_1:RecordHistoryTalkVoice("story_v_out_317282", "317282072", "story_v_out_317282.awb")
				end

				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_14 = math.max(var_294_7, arg_291_1.talkMaxDuration)

			if var_294_6 <= arg_291_1.time_ and arg_291_1.time_ < var_294_6 + var_294_14 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_6) / var_294_14

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_6 + var_294_14 and arg_291_1.time_ < var_294_6 + var_294_14 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_291_1:InitPlayNodeList()
	end,
	Play317282073 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 317282073
		arg_295_1.duration_ = 13.47

		local var_295_0 = {
			zh = 10.6,
			ja = 13.466
		}
		local var_295_1 = manager.audio:GetLocalizationFlag()

		if var_295_0[var_295_1] ~= nil then
			arg_295_1.duration_ = var_295_0[var_295_1]
		end

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play317282074(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["2079ui_story"]) and arg_295_1.var_.characterEffect2079ui_story == nil then
				arg_295_1.var_.characterEffect2079ui_story = arg_295_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_0 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["2079ui_story"]) then
				if arg_295_1.var_.characterEffect2079ui_story and not isNil(arg_295_1.actors_["2079ui_story"]) then
					arg_295_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["2079ui_story"]) and arg_295_1.var_.characterEffect2079ui_story then
				arg_295_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_298_2 = arg_295_1.actors_["2078ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.characterEffect2078ui_story == nil then
				arg_295_1.var_.characterEffect2078ui_story = var_298_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_3 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_3 and not isNil(var_298_2) then
				if arg_295_1.var_.characterEffect2078ui_story and not isNil(var_298_2) then
					arg_295_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_295_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_3)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_3 and arg_295_1.time_ < 0 + var_298_3 + arg_298_0 and not isNil(var_298_2) and arg_295_1.var_.characterEffect2078ui_story then
				arg_295_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_295_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_298_4 = 0
			local var_298_5 = 1.45

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_4 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_6 = arg_295_1:GetWordFromCfg(317282073)
				local var_298_7 = arg_295_1:FormatText(var_298_6.content)

				arg_295_1.text_.text = var_298_7

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_9 = 58 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 58)

				if (58 <= 0 and var_298_5 or var_298_5 * (utf8.len(var_298_7) / 58)) > 0 and var_298_5 < var_298_9 then
					arg_295_1.talkMaxDuration = var_298_9

					if var_298_9 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_9 + var_298_4
					end
				end

				arg_295_1.text_.text = var_298_7
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282073", "story_v_out_317282.awb") ~= 0 then
					local var_298_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282073", "story_v_out_317282.awb") / 1000

					if var_298_10 + var_298_4 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_4
					end

					if var_298_6.prefab_name ~= "" and arg_295_1.actors_[var_298_6.prefab_name] ~= nil then
						local var_298_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_6.prefab_name].transform, "story_v_out_317282", "317282073", "story_v_out_317282.awb")

						arg_295_1:RecordAudio("317282073", var_298_11)
						arg_295_1:RecordAudio("317282073", var_298_11)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_317282", "317282073", "story_v_out_317282.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_317282", "317282073", "story_v_out_317282.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_12 = math.max(var_298_5, arg_295_1.talkMaxDuration)

			if var_298_4 <= arg_295_1.time_ and arg_295_1.time_ < var_298_4 + var_298_12 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_4) / var_298_12

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_4 + var_298_12 and arg_295_1.time_ < var_298_4 + var_298_12 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {}

		arg_295_1:InitPlayNodeList()
	end,
	Play317282074 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 317282074
		arg_299_1.duration_ = 10.83

		local var_299_0 = {
			zh = 9.366,
			ja = 10.833
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play317282075(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 1.2

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_1 = arg_299_1:GetWordFromCfg(317282074)
				local var_302_2 = arg_299_1:FormatText(var_302_1.content)

				arg_299_1.text_.text = var_302_2

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_4 = 48 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 48)

				if (48 <= 0 and var_302_0 or var_302_0 * (utf8.len(var_302_2) / 48)) > 0 and var_302_0 < var_302_4 then
					arg_299_1.talkMaxDuration = var_302_4

					if var_302_4 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_4 + 0
					end
				end

				arg_299_1.text_.text = var_302_2
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282074", "story_v_out_317282.awb") ~= 0 then
					local var_302_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282074", "story_v_out_317282.awb") / 1000

					if var_302_5 + 0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_5 + 0
					end

					if var_302_1.prefab_name ~= "" and arg_299_1.actors_[var_302_1.prefab_name] ~= nil then
						local var_302_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_1.prefab_name].transform, "story_v_out_317282", "317282074", "story_v_out_317282.awb")

						arg_299_1:RecordAudio("317282074", var_302_6)
						arg_299_1:RecordAudio("317282074", var_302_6)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_317282", "317282074", "story_v_out_317282.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_317282", "317282074", "story_v_out_317282.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_7 = math.max(var_302_0, arg_299_1.talkMaxDuration)

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - 0) / var_302_7

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {}

		arg_299_1:InitPlayNodeList()
	end,
	Play317282075 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 317282075
		arg_303_1.duration_ = 4.43

		local var_303_0 = {
			zh = 3.6,
			ja = 4.433
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play317282076(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.45

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:GetWordFromCfg(317282075)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 18 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 18)

				if (18 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 18)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282075", "story_v_out_317282.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282075", "story_v_out_317282.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_317282", "317282075", "story_v_out_317282.awb")

						arg_303_1:RecordAudio("317282075", var_306_6)
						arg_303_1:RecordAudio("317282075", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_317282", "317282075", "story_v_out_317282.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_317282", "317282075", "story_v_out_317282.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_7 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_7 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_7

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_7 and arg_303_1.time_ < 0 + var_306_7 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play317282076 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 317282076
		arg_307_1.duration_ = 8.2

		local var_307_0 = {
			zh = 8.2,
			ja = 5.6
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play317282077(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["2079ui_story"]) and arg_307_1.var_.characterEffect2079ui_story == nil then
				arg_307_1.var_.characterEffect2079ui_story = arg_307_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_0 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["2079ui_story"]) then
				if arg_307_1.var_.characterEffect2079ui_story and not isNil(arg_307_1.actors_["2079ui_story"]) then
					arg_307_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_307_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_307_1.time_ - 0) / var_310_0)
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["2079ui_story"]) and arg_307_1.var_.characterEffect2079ui_story then
				arg_307_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_307_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_310_1 = arg_307_1.actors_["2078ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect2078ui_story == nil then
				arg_307_1.var_.characterEffect2078ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect2078ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect2078ui_story then
				arg_307_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_310_4 = 0
			local var_310_5 = 1.125

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_6 = arg_307_1:GetWordFromCfg(317282076)
				local var_310_7 = arg_307_1:FormatText(var_310_6.content)

				arg_307_1.text_.text = var_310_7

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_9 = 45 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 45)

				if (45 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 45)) > 0 and var_310_5 < var_310_9 then
					arg_307_1.talkMaxDuration = var_310_9

					if var_310_9 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_9 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_7
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282076", "story_v_out_317282.awb") ~= 0 then
					local var_310_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282076", "story_v_out_317282.awb") / 1000

					if var_310_10 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_4
					end

					if var_310_6.prefab_name ~= "" and arg_307_1.actors_[var_310_6.prefab_name] ~= nil then
						local var_310_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_6.prefab_name].transform, "story_v_out_317282", "317282076", "story_v_out_317282.awb")

						arg_307_1:RecordAudio("317282076", var_310_11)
						arg_307_1:RecordAudio("317282076", var_310_11)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_317282", "317282076", "story_v_out_317282.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_317282", "317282076", "story_v_out_317282.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_12 = math.max(var_310_5, arg_307_1.talkMaxDuration)

			if var_310_4 <= arg_307_1.time_ and arg_307_1.time_ < var_310_4 + var_310_12 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_4) / var_310_12

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_4 + var_310_12 and arg_307_1.time_ < var_310_4 + var_310_12 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play317282077 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 317282077
		arg_311_1.duration_ = 7.97

		local var_311_0 = {
			zh = 3,
			ja = 7.966
		}
		local var_311_1 = manager.audio:GetLocalizationFlag()

		if var_311_0[var_311_1] ~= nil then
			arg_311_1.duration_ = var_311_0[var_311_1]
		end

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play317282078(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos2079ui_story = arg_311_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["2079ui_story"].transform.position).z)
				arg_311_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["2079ui_story"].transform.localEulerAngles = arg_311_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_311_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["2079ui_story"].transform.position).z)
				arg_311_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["2079ui_story"].transform.localEulerAngles = arg_311_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["2079ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect2079ui_story == nil then
				arg_311_1.var_.characterEffect2079ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect2079ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect2079ui_story then
				arg_311_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_314_4 = arg_311_1.actors_["2078ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_4) and arg_311_1.var_.characterEffect2078ui_story == nil then
				arg_311_1.var_.characterEffect2078ui_story = var_314_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_5 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_5 and not isNil(var_314_4) then
				if arg_311_1.var_.characterEffect2078ui_story and not isNil(var_314_4) then
					arg_311_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_311_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_5)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_5 and arg_311_1.time_ < 0 + var_314_5 + arg_314_0 and not isNil(var_314_4) and arg_311_1.var_.characterEffect2078ui_story then
				arg_311_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_311_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_314_6 = 0
			local var_314_7 = 0.3

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_6 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_8 = arg_311_1:GetWordFromCfg(317282077)
				local var_314_9 = arg_311_1:FormatText(var_314_8.content)

				arg_311_1.text_.text = var_314_9

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_11 = 12 <= 0 and var_314_7 or var_314_7 * (utf8.len(var_314_9) / 12)

				if (12 <= 0 and var_314_7 or var_314_7 * (utf8.len(var_314_9) / 12)) > 0 and var_314_7 < var_314_11 then
					arg_311_1.talkMaxDuration = var_314_11

					if var_314_11 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_6
					end
				end

				arg_311_1.text_.text = var_314_9
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282077", "story_v_out_317282.awb") ~= 0 then
					local var_314_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282077", "story_v_out_317282.awb") / 1000

					if var_314_12 + var_314_6 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_12 + var_314_6
					end

					if var_314_8.prefab_name ~= "" and arg_311_1.actors_[var_314_8.prefab_name] ~= nil then
						local var_314_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_8.prefab_name].transform, "story_v_out_317282", "317282077", "story_v_out_317282.awb")

						arg_311_1:RecordAudio("317282077", var_314_13)
						arg_311_1:RecordAudio("317282077", var_314_13)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_317282", "317282077", "story_v_out_317282.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_317282", "317282077", "story_v_out_317282.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_14 = math.max(var_314_7, arg_311_1.talkMaxDuration)

			if var_314_6 <= arg_311_1.time_ and arg_311_1.time_ < var_314_6 + var_314_14 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_6) / var_314_14

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_6 + var_314_14 and arg_311_1.time_ < var_314_6 + var_314_14 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play317282078 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 317282078
		arg_315_1.duration_ = 14.3

		local var_315_0 = {
			zh = 14.3,
			ja = 8.166
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play317282079(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["2078ui_story"]) and arg_315_1.var_.characterEffect2078ui_story == nil then
				arg_315_1.var_.characterEffect2078ui_story = arg_315_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["2078ui_story"]) then
				if arg_315_1.var_.characterEffect2078ui_story and not isNil(arg_315_1.actors_["2078ui_story"]) then
					arg_315_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["2078ui_story"]) and arg_315_1.var_.characterEffect2078ui_story then
				arg_315_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_318_2 = arg_315_1.actors_["2079ui_story"]

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.characterEffect2079ui_story == nil then
				arg_315_1.var_.characterEffect2079ui_story = var_318_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_3 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_3 and not isNil(var_318_2) then
				if arg_315_1.var_.characterEffect2079ui_story and not isNil(var_318_2) then
					arg_315_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_315_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_3)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_3 and arg_315_1.time_ < 0 + var_318_3 + arg_318_0 and not isNil(var_318_2) and arg_315_1.var_.characterEffect2079ui_story then
				arg_315_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_315_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_318_4 = 0
			local var_318_5 = 1.875

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_4 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_6 = arg_315_1:GetWordFromCfg(317282078)
				local var_318_7 = arg_315_1:FormatText(var_318_6.content)

				arg_315_1.text_.text = var_318_7

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_9 = 75 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_7) / 75)

				if (75 <= 0 and var_318_5 or var_318_5 * (utf8.len(var_318_7) / 75)) > 0 and var_318_5 < var_318_9 then
					arg_315_1.talkMaxDuration = var_318_9

					if var_318_9 + var_318_4 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_9 + var_318_4
					end
				end

				arg_315_1.text_.text = var_318_7
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282078", "story_v_out_317282.awb") ~= 0 then
					local var_318_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282078", "story_v_out_317282.awb") / 1000

					if var_318_10 + var_318_4 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_10 + var_318_4
					end

					if var_318_6.prefab_name ~= "" and arg_315_1.actors_[var_318_6.prefab_name] ~= nil then
						local var_318_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_6.prefab_name].transform, "story_v_out_317282", "317282078", "story_v_out_317282.awb")

						arg_315_1:RecordAudio("317282078", var_318_11)
						arg_315_1:RecordAudio("317282078", var_318_11)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_317282", "317282078", "story_v_out_317282.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_317282", "317282078", "story_v_out_317282.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_12 = math.max(var_318_5, arg_315_1.talkMaxDuration)

			if var_318_4 <= arg_315_1.time_ and arg_315_1.time_ < var_318_4 + var_318_12 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_4) / var_318_12

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_4 + var_318_12 and arg_315_1.time_ < var_318_4 + var_318_12 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play317282079 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 317282079
		arg_319_1.duration_ = 8.97

		local var_319_0 = {
			zh = 4.466,
			ja = 8.966
		}
		local var_319_1 = manager.audio:GetLocalizationFlag()

		if var_319_0[var_319_1] ~= nil then
			arg_319_1.duration_ = var_319_0[var_319_1]
		end

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play317282080(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(arg_319_1.actors_["2079ui_story"]) and arg_319_1.var_.characterEffect2079ui_story == nil then
				arg_319_1.var_.characterEffect2079ui_story = arg_319_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_0 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_0 and not isNil(arg_319_1.actors_["2079ui_story"]) then
				if arg_319_1.var_.characterEffect2079ui_story and not isNil(arg_319_1.actors_["2079ui_story"]) then
					arg_319_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_319_1.time_ >= 0 + var_322_0 and arg_319_1.time_ < 0 + var_322_0 + arg_322_0 and not isNil(arg_319_1.actors_["2079ui_story"]) and arg_319_1.var_.characterEffect2079ui_story then
				arg_319_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_322_2 = arg_319_1.actors_["2078ui_story"]

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.characterEffect2078ui_story == nil then
				arg_319_1.var_.characterEffect2078ui_story = var_322_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_322_3 = 0.200000002980232

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_3 and not isNil(var_322_2) then
				if arg_319_1.var_.characterEffect2078ui_story and not isNil(var_322_2) then
					arg_319_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_319_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_319_1.time_ - 0) / var_322_3)
				end
			end

			if arg_319_1.time_ >= 0 + var_322_3 and arg_319_1.time_ < 0 + var_322_3 + arg_322_0 and not isNil(var_322_2) and arg_319_1.var_.characterEffect2078ui_story then
				arg_319_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_319_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_322_4 = 0
			local var_322_5 = 0.5

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_4 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_6 = arg_319_1:GetWordFromCfg(317282079)
				local var_322_7 = arg_319_1:FormatText(var_322_6.content)

				arg_319_1.text_.text = var_322_7

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_9 = 20 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 20)

				if (20 <= 0 and var_322_5 or var_322_5 * (utf8.len(var_322_7) / 20)) > 0 and var_322_5 < var_322_9 then
					arg_319_1.talkMaxDuration = var_322_9

					if var_322_9 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_9 + var_322_4
					end
				end

				arg_319_1.text_.text = var_322_7
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282079", "story_v_out_317282.awb") ~= 0 then
					local var_322_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282079", "story_v_out_317282.awb") / 1000

					if var_322_10 + var_322_4 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_10 + var_322_4
					end

					if var_322_6.prefab_name ~= "" and arg_319_1.actors_[var_322_6.prefab_name] ~= nil then
						local var_322_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_6.prefab_name].transform, "story_v_out_317282", "317282079", "story_v_out_317282.awb")

						arg_319_1:RecordAudio("317282079", var_322_11)
						arg_319_1:RecordAudio("317282079", var_322_11)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_317282", "317282079", "story_v_out_317282.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_317282", "317282079", "story_v_out_317282.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_12 = math.max(var_322_5, arg_319_1.talkMaxDuration)

			if var_322_4 <= arg_319_1.time_ and arg_319_1.time_ < var_322_4 + var_322_12 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_4) / var_322_12

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_4 + var_322_12 and arg_319_1.time_ < var_322_4 + var_322_12 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play317282080 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 317282080
		arg_323_1.duration_ = 1.6

		local var_323_0 = {
			zh = 1.6,
			ja = 1.433
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play317282081(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["2078ui_story"]) and arg_323_1.var_.characterEffect2078ui_story == nil then
				arg_323_1.var_.characterEffect2078ui_story = arg_323_1.actors_["2078ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_0 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["2078ui_story"]) then
				if arg_323_1.var_.characterEffect2078ui_story and not isNil(arg_323_1.actors_["2078ui_story"]) then
					arg_323_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["2078ui_story"]) and arg_323_1.var_.characterEffect2078ui_story then
				arg_323_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_326_2 = arg_323_1.actors_["2079ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.characterEffect2079ui_story == nil then
				arg_323_1.var_.characterEffect2079ui_story = var_326_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_3 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.characterEffect2079ui_story and not isNil(var_326_2) then
					arg_323_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_323_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_3)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.characterEffect2079ui_story then
				arg_323_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_323_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_326_4 = 0
			local var_326_5 = 0.125

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_4 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_6 = arg_323_1:GetWordFromCfg(317282080)
				local var_326_7 = arg_323_1:FormatText(var_326_6.content)

				arg_323_1.text_.text = var_326_7

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_9 = 5 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 5)

				if (5 <= 0 and var_326_5 or var_326_5 * (utf8.len(var_326_7) / 5)) > 0 and var_326_5 < var_326_9 then
					arg_323_1.talkMaxDuration = var_326_9

					if var_326_9 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_9 + var_326_4
					end
				end

				arg_323_1.text_.text = var_326_7
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282080", "story_v_out_317282.awb") ~= 0 then
					local var_326_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282080", "story_v_out_317282.awb") / 1000

					if var_326_10 + var_326_4 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_10 + var_326_4
					end

					if var_326_6.prefab_name ~= "" and arg_323_1.actors_[var_326_6.prefab_name] ~= nil then
						local var_326_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_6.prefab_name].transform, "story_v_out_317282", "317282080", "story_v_out_317282.awb")

						arg_323_1:RecordAudio("317282080", var_326_11)
						arg_323_1:RecordAudio("317282080", var_326_11)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_317282", "317282080", "story_v_out_317282.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_317282", "317282080", "story_v_out_317282.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_12 = math.max(var_326_5, arg_323_1.talkMaxDuration)

			if var_326_4 <= arg_323_1.time_ and arg_323_1.time_ < var_326_4 + var_326_12 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_4) / var_326_12

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_4 + var_326_12 and arg_323_1.time_ < var_326_4 + var_326_12 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {}

		arg_323_1:InitPlayNodeList()
	end,
	Play317282081 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 317282081
		arg_327_1.duration_ = 11.9

		local var_327_0 = {
			zh = 11.9,
			ja = 8.5
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play317282082(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(arg_327_1.actors_["2079ui_story"]) and arg_327_1.var_.characterEffect2079ui_story == nil then
				arg_327_1.var_.characterEffect2079ui_story = arg_327_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_0 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_0 and not isNil(arg_327_1.actors_["2079ui_story"]) then
				if arg_327_1.var_.characterEffect2079ui_story and not isNil(arg_327_1.actors_["2079ui_story"]) then
					arg_327_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_0 and arg_327_1.time_ < 0 + var_330_0 + arg_330_0 and not isNil(arg_327_1.actors_["2079ui_story"]) and arg_327_1.var_.characterEffect2079ui_story then
				arg_327_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_330_2 = arg_327_1.actors_["2078ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect2078ui_story == nil then
				arg_327_1.var_.characterEffect2078ui_story = var_330_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_3 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_3 and not isNil(var_330_2) then
				if arg_327_1.var_.characterEffect2078ui_story and not isNil(var_330_2) then
					arg_327_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_327_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_3)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_3 and arg_327_1.time_ < 0 + var_330_3 + arg_330_0 and not isNil(var_330_2) and arg_327_1.var_.characterEffect2078ui_story then
				arg_327_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_327_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_330_4 = 0
			local var_330_5 = 1.4

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_4 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_6 = arg_327_1:GetWordFromCfg(317282081)
				local var_330_7 = arg_327_1:FormatText(var_330_6.content)

				arg_327_1.text_.text = var_330_7

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_9 = 56 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 56)

				if (56 <= 0 and var_330_5 or var_330_5 * (utf8.len(var_330_7) / 56)) > 0 and var_330_5 < var_330_9 then
					arg_327_1.talkMaxDuration = var_330_9

					if var_330_9 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_9 + var_330_4
					end
				end

				arg_327_1.text_.text = var_330_7
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282081", "story_v_out_317282.awb") ~= 0 then
					local var_330_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282081", "story_v_out_317282.awb") / 1000

					if var_330_10 + var_330_4 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_10 + var_330_4
					end

					if var_330_6.prefab_name ~= "" and arg_327_1.actors_[var_330_6.prefab_name] ~= nil then
						local var_330_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_6.prefab_name].transform, "story_v_out_317282", "317282081", "story_v_out_317282.awb")

						arg_327_1:RecordAudio("317282081", var_330_11)
						arg_327_1:RecordAudio("317282081", var_330_11)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_317282", "317282081", "story_v_out_317282.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_317282", "317282081", "story_v_out_317282.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_12 = math.max(var_330_5, arg_327_1.talkMaxDuration)

			if var_330_4 <= arg_327_1.time_ and arg_327_1.time_ < var_330_4 + var_330_12 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_4) / var_330_12

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_4 + var_330_12 and arg_327_1.time_ < var_330_4 + var_330_12 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {}

		arg_327_1:InitPlayNodeList()
	end,
	Play317282082 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 317282082
		arg_331_1.duration_ = 14.3

		local var_331_0 = {
			zh = 14.3,
			ja = 12.1
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play317282083(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = 1.775

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				arg_331_1.leftNameTxt_.text = arg_331_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_1 = arg_331_1:GetWordFromCfg(317282082)
				local var_334_2 = arg_331_1:FormatText(var_334_1.content)

				arg_331_1.text_.text = var_334_2

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_4 = 71 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 71)

				if (71 <= 0 and var_334_0 or var_334_0 * (utf8.len(var_334_2) / 71)) > 0 and var_334_0 < var_334_4 then
					arg_331_1.talkMaxDuration = var_334_4

					if var_334_4 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_4 + 0
					end
				end

				arg_331_1.text_.text = var_334_2
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282082", "story_v_out_317282.awb") ~= 0 then
					local var_334_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282082", "story_v_out_317282.awb") / 1000

					if var_334_5 + 0 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + 0
					end

					if var_334_1.prefab_name ~= "" and arg_331_1.actors_[var_334_1.prefab_name] ~= nil then
						local var_334_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_1.prefab_name].transform, "story_v_out_317282", "317282082", "story_v_out_317282.awb")

						arg_331_1:RecordAudio("317282082", var_334_6)
						arg_331_1:RecordAudio("317282082", var_334_6)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_317282", "317282082", "story_v_out_317282.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_317282", "317282082", "story_v_out_317282.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_7 = math.max(var_334_0, arg_331_1.talkMaxDuration)

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_7 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - 0) / var_334_7

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= 0 + var_334_7 and arg_331_1.time_ < 0 + var_334_7 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play317282083 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 317282083
		arg_335_1.duration_ = 8.77

		local var_335_0 = {
			zh = 5.7,
			ja = 8.766
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play317282084(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.8

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_1 = arg_335_1:GetWordFromCfg(317282083)
				local var_338_2 = arg_335_1:FormatText(var_338_1.content)

				arg_335_1.text_.text = var_338_2

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_4 = 32 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 32)

				if (32 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_2) / 32)) > 0 and var_338_0 < var_338_4 then
					arg_335_1.talkMaxDuration = var_338_4

					if var_338_4 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_4 + 0
					end
				end

				arg_335_1.text_.text = var_338_2
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282083", "story_v_out_317282.awb") ~= 0 then
					local var_338_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282083", "story_v_out_317282.awb") / 1000

					if var_338_5 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_5 + 0
					end

					if var_338_1.prefab_name ~= "" and arg_335_1.actors_[var_338_1.prefab_name] ~= nil then
						local var_338_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_1.prefab_name].transform, "story_v_out_317282", "317282083", "story_v_out_317282.awb")

						arg_335_1:RecordAudio("317282083", var_338_6)
						arg_335_1:RecordAudio("317282083", var_338_6)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_317282", "317282083", "story_v_out_317282.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_317282", "317282083", "story_v_out_317282.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_7 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_7 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_7

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_7 and arg_335_1.time_ < 0 + var_338_7 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play317282084 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 317282084
		arg_339_1.duration_ = 7.7

		local var_339_0 = {
			zh = 7.7,
			ja = 7.433
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play317282085(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["2079ui_story"]) and arg_339_1.var_.characterEffect2079ui_story == nil then
				arg_339_1.var_.characterEffect2079ui_story = arg_339_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_0 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["2079ui_story"]) then
				if arg_339_1.var_.characterEffect2079ui_story and not isNil(arg_339_1.actors_["2079ui_story"]) then
					arg_339_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_339_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_0)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["2079ui_story"]) and arg_339_1.var_.characterEffect2079ui_story then
				arg_339_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_339_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_342_1 = arg_339_1.actors_["2078ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect2078ui_story == nil then
				arg_339_1.var_.characterEffect2078ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect2078ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect2078ui_story then
				arg_339_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_342_4 = 0
			local var_342_5 = 0.85

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_6 = arg_339_1:GetWordFromCfg(317282084)
				local var_342_7 = arg_339_1:FormatText(var_342_6.content)

				arg_339_1.text_.text = var_342_7

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 34 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 34)

				if (34 <= 0 and var_342_5 or var_342_5 * (utf8.len(var_342_7) / 34)) > 0 and var_342_5 < var_342_9 then
					arg_339_1.talkMaxDuration = var_342_9

					if var_342_9 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_9 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_7
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282084", "story_v_out_317282.awb") ~= 0 then
					local var_342_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282084", "story_v_out_317282.awb") / 1000

					if var_342_10 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_4
					end

					if var_342_6.prefab_name ~= "" and arg_339_1.actors_[var_342_6.prefab_name] ~= nil then
						local var_342_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_6.prefab_name].transform, "story_v_out_317282", "317282084", "story_v_out_317282.awb")

						arg_339_1:RecordAudio("317282084", var_342_11)
						arg_339_1:RecordAudio("317282084", var_342_11)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_317282", "317282084", "story_v_out_317282.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_317282", "317282084", "story_v_out_317282.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_12 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_12 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_12

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_12 and arg_339_1.time_ < var_342_4 + var_342_12 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {}

		arg_339_1:InitPlayNodeList()
	end,
	Play317282085 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 317282085
		arg_343_1.duration_ = 12.57

		local var_343_0 = {
			zh = 12.566,
			ja = 9.266
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play317282086(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 1.475

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:GetWordFromCfg(317282085)
				local var_346_2 = arg_343_1:FormatText(var_346_1.content)

				arg_343_1.text_.text = var_346_2

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_4 = 60 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 60)

				if (60 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_2) / 60)) > 0 and var_346_0 < var_346_4 then
					arg_343_1.talkMaxDuration = var_346_4

					if var_346_4 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_4 + 0
					end
				end

				arg_343_1.text_.text = var_346_2
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282085", "story_v_out_317282.awb") ~= 0 then
					local var_346_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282085", "story_v_out_317282.awb") / 1000

					if var_346_5 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_5 + 0
					end

					if var_346_1.prefab_name ~= "" and arg_343_1.actors_[var_346_1.prefab_name] ~= nil then
						local var_346_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_1.prefab_name].transform, "story_v_out_317282", "317282085", "story_v_out_317282.awb")

						arg_343_1:RecordAudio("317282085", var_346_6)
						arg_343_1:RecordAudio("317282085", var_346_6)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_317282", "317282085", "story_v_out_317282.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_317282", "317282085", "story_v_out_317282.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_7 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_7 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_7

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_7 and arg_343_1.time_ < 0 + var_346_7 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play317282086 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 317282086
		arg_347_1.duration_ = 5.83

		local var_347_0 = {
			zh = 3.9,
			ja = 5.833
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play317282087(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(arg_347_1.actors_["2079ui_story"]) and arg_347_1.var_.characterEffect2079ui_story == nil then
				arg_347_1.var_.characterEffect2079ui_story = arg_347_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_0 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 and not isNil(arg_347_1.actors_["2079ui_story"]) then
				if arg_347_1.var_.characterEffect2079ui_story and not isNil(arg_347_1.actors_["2079ui_story"]) then
					arg_347_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 and not isNil(arg_347_1.actors_["2079ui_story"]) and arg_347_1.var_.characterEffect2079ui_story then
				arg_347_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_350_2 = arg_347_1.actors_["2078ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.characterEffect2078ui_story == nil then
				arg_347_1.var_.characterEffect2078ui_story = var_350_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_3 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_3 and not isNil(var_350_2) then
				if arg_347_1.var_.characterEffect2078ui_story and not isNil(var_350_2) then
					arg_347_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_347_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_3)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_3 and arg_347_1.time_ < 0 + var_350_3 + arg_350_0 and not isNil(var_350_2) and arg_347_1.var_.characterEffect2078ui_story then
				arg_347_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_347_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_350_4 = 0
			local var_350_5 = 0.375

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_4 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_6 = arg_347_1:GetWordFromCfg(317282086)
				local var_350_7 = arg_347_1:FormatText(var_350_6.content)

				arg_347_1.text_.text = var_350_7

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_9 = 15 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 15)

				if (15 <= 0 and var_350_5 or var_350_5 * (utf8.len(var_350_7) / 15)) > 0 and var_350_5 < var_350_9 then
					arg_347_1.talkMaxDuration = var_350_9

					if var_350_9 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_9 + var_350_4
					end
				end

				arg_347_1.text_.text = var_350_7
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282086", "story_v_out_317282.awb") ~= 0 then
					local var_350_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282086", "story_v_out_317282.awb") / 1000

					if var_350_10 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_10 + var_350_4
					end

					if var_350_6.prefab_name ~= "" and arg_347_1.actors_[var_350_6.prefab_name] ~= nil then
						local var_350_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_6.prefab_name].transform, "story_v_out_317282", "317282086", "story_v_out_317282.awb")

						arg_347_1:RecordAudio("317282086", var_350_11)
						arg_347_1:RecordAudio("317282086", var_350_11)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_317282", "317282086", "story_v_out_317282.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_317282", "317282086", "story_v_out_317282.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_12 = math.max(var_350_5, arg_347_1.talkMaxDuration)

			if var_350_4 <= arg_347_1.time_ and arg_347_1.time_ < var_350_4 + var_350_12 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_4) / var_350_12

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_4 + var_350_12 and arg_347_1.time_ < var_350_4 + var_350_12 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {}

		arg_347_1:InitPlayNodeList()
	end,
	Play317282087 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 317282087
		arg_351_1.duration_ = 10.53

		local var_351_0 = {
			zh = 10.533,
			ja = 7.633
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play317282088(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 1.25

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_1 = arg_351_1:GetWordFromCfg(317282087)
				local var_354_2 = arg_351_1:FormatText(var_354_1.content)

				arg_351_1.text_.text = var_354_2

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_4 = 50 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 50)

				if (50 <= 0 and var_354_0 or var_354_0 * (utf8.len(var_354_2) / 50)) > 0 and var_354_0 < var_354_4 then
					arg_351_1.talkMaxDuration = var_354_4

					if var_354_4 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_4 + 0
					end
				end

				arg_351_1.text_.text = var_354_2
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282087", "story_v_out_317282.awb") ~= 0 then
					local var_354_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282087", "story_v_out_317282.awb") / 1000

					if var_354_5 + 0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_5 + 0
					end

					if var_354_1.prefab_name ~= "" and arg_351_1.actors_[var_354_1.prefab_name] ~= nil then
						local var_354_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_1.prefab_name].transform, "story_v_out_317282", "317282087", "story_v_out_317282.awb")

						arg_351_1:RecordAudio("317282087", var_354_6)
						arg_351_1:RecordAudio("317282087", var_354_6)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_317282", "317282087", "story_v_out_317282.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_317282", "317282087", "story_v_out_317282.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_7 = math.max(var_354_0, arg_351_1.talkMaxDuration)

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_7 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - 0) / var_354_7

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= 0 + var_354_7 and arg_351_1.time_ < 0 + var_354_7 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play317282088 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 317282088
		arg_355_1.duration_ = 1.63

		local var_355_0 = {
			zh = 1.566,
			ja = 1.633
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play317282089(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["2079ui_story"]) and arg_355_1.var_.characterEffect2079ui_story == nil then
				arg_355_1.var_.characterEffect2079ui_story = arg_355_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["2079ui_story"]) then
				if arg_355_1.var_.characterEffect2079ui_story and not isNil(arg_355_1.actors_["2079ui_story"]) then
					arg_355_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_355_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["2079ui_story"]) and arg_355_1.var_.characterEffect2079ui_story then
				arg_355_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_355_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_358_1 = arg_355_1.actors_["2078ui_story"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect2078ui_story == nil then
				arg_355_1.var_.characterEffect2078ui_story = var_358_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_2 and not isNil(var_358_1) then
				if arg_355_1.var_.characterEffect2078ui_story and not isNil(var_358_1) then
					arg_355_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_355_1.time_ >= 0 + var_358_2 and arg_355_1.time_ < 0 + var_358_2 + arg_358_0 and not isNil(var_358_1) and arg_355_1.var_.characterEffect2078ui_story then
				arg_355_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_358_4 = 0
			local var_358_5 = 0.1

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_4 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_6 = arg_355_1:GetWordFromCfg(317282088)
				local var_358_7 = arg_355_1:FormatText(var_358_6.content)

				arg_355_1.text_.text = var_358_7

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_9 = 4 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 4)

				if (4 <= 0 and var_358_5 or var_358_5 * (utf8.len(var_358_7) / 4)) > 0 and var_358_5 < var_358_9 then
					arg_355_1.talkMaxDuration = var_358_9

					if var_358_9 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_9 + var_358_4
					end
				end

				arg_355_1.text_.text = var_358_7
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282088", "story_v_out_317282.awb") ~= 0 then
					local var_358_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282088", "story_v_out_317282.awb") / 1000

					if var_358_10 + var_358_4 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_10 + var_358_4
					end

					if var_358_6.prefab_name ~= "" and arg_355_1.actors_[var_358_6.prefab_name] ~= nil then
						local var_358_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_6.prefab_name].transform, "story_v_out_317282", "317282088", "story_v_out_317282.awb")

						arg_355_1:RecordAudio("317282088", var_358_11)
						arg_355_1:RecordAudio("317282088", var_358_11)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_317282", "317282088", "story_v_out_317282.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_317282", "317282088", "story_v_out_317282.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_12 = math.max(var_358_5, arg_355_1.talkMaxDuration)

			if var_358_4 <= arg_355_1.time_ and arg_355_1.time_ < var_358_4 + var_358_12 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_4) / var_358_12

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_4 + var_358_12 and arg_355_1.time_ < var_358_4 + var_358_12 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play317282089 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 317282089
		arg_359_1.duration_ = 12.23

		local var_359_0 = {
			zh = 11.133,
			ja = 12.233
		}
		local var_359_1 = manager.audio:GetLocalizationFlag()

		if var_359_0[var_359_1] ~= nil then
			arg_359_1.duration_ = var_359_0[var_359_1]
		end

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play317282090(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(arg_359_1.actors_["2079ui_story"]) and arg_359_1.var_.characterEffect2079ui_story == nil then
				arg_359_1.var_.characterEffect2079ui_story = arg_359_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_0 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_0 and not isNil(arg_359_1.actors_["2079ui_story"]) then
				if arg_359_1.var_.characterEffect2079ui_story and not isNil(arg_359_1.actors_["2079ui_story"]) then
					arg_359_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_359_1.time_ >= 0 + var_362_0 and arg_359_1.time_ < 0 + var_362_0 + arg_362_0 and not isNil(arg_359_1.actors_["2079ui_story"]) and arg_359_1.var_.characterEffect2079ui_story then
				arg_359_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_362_2 = arg_359_1.actors_["2078ui_story"]

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.characterEffect2078ui_story == nil then
				arg_359_1.var_.characterEffect2078ui_story = var_362_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_3 = 0.200000002980232

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_3 and not isNil(var_362_2) then
				if arg_359_1.var_.characterEffect2078ui_story and not isNil(var_362_2) then
					arg_359_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_359_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_359_1.time_ - 0) / var_362_3)
				end
			end

			if arg_359_1.time_ >= 0 + var_362_3 and arg_359_1.time_ < 0 + var_362_3 + arg_362_0 and not isNil(var_362_2) and arg_359_1.var_.characterEffect2078ui_story then
				arg_359_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_359_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_362_4 = 0
			local var_362_5 = 1.175

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= var_362_4 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_6 = arg_359_1:GetWordFromCfg(317282089)
				local var_362_7 = arg_359_1:FormatText(var_362_6.content)

				arg_359_1.text_.text = var_362_7

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_9 = 47 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 47)

				if (47 <= 0 and var_362_5 or var_362_5 * (utf8.len(var_362_7) / 47)) > 0 and var_362_5 < var_362_9 then
					arg_359_1.talkMaxDuration = var_362_9

					if var_362_9 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_9 + var_362_4
					end
				end

				arg_359_1.text_.text = var_362_7
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282089", "story_v_out_317282.awb") ~= 0 then
					local var_362_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282089", "story_v_out_317282.awb") / 1000

					if var_362_10 + var_362_4 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_10 + var_362_4
					end

					if var_362_6.prefab_name ~= "" and arg_359_1.actors_[var_362_6.prefab_name] ~= nil then
						local var_362_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_6.prefab_name].transform, "story_v_out_317282", "317282089", "story_v_out_317282.awb")

						arg_359_1:RecordAudio("317282089", var_362_11)
						arg_359_1:RecordAudio("317282089", var_362_11)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_317282", "317282089", "story_v_out_317282.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_317282", "317282089", "story_v_out_317282.awb")
				end

				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_12 = math.max(var_362_5, arg_359_1.talkMaxDuration)

			if var_362_4 <= arg_359_1.time_ and arg_359_1.time_ < var_362_4 + var_362_12 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_4) / var_362_12

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_4 + var_362_12 and arg_359_1.time_ < var_362_4 + var_362_12 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	Play317282090 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 317282090
		arg_363_1.duration_ = 6.43

		local var_363_0 = {
			zh = 6.433,
			ja = 5.033
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play317282091(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0.65

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_1 = arg_363_1:GetWordFromCfg(317282090)
				local var_366_2 = arg_363_1:FormatText(var_366_1.content)

				arg_363_1.text_.text = var_366_2

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_4 = 26 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 26)

				if (26 <= 0 and var_366_0 or var_366_0 * (utf8.len(var_366_2) / 26)) > 0 and var_366_0 < var_366_4 then
					arg_363_1.talkMaxDuration = var_366_4

					if var_366_4 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_4 + 0
					end
				end

				arg_363_1.text_.text = var_366_2
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282090", "story_v_out_317282.awb") ~= 0 then
					local var_366_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282090", "story_v_out_317282.awb") / 1000

					if var_366_5 + 0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_5 + 0
					end

					if var_366_1.prefab_name ~= "" and arg_363_1.actors_[var_366_1.prefab_name] ~= nil then
						local var_366_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_1.prefab_name].transform, "story_v_out_317282", "317282090", "story_v_out_317282.awb")

						arg_363_1:RecordAudio("317282090", var_366_6)
						arg_363_1:RecordAudio("317282090", var_366_6)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_317282", "317282090", "story_v_out_317282.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_317282", "317282090", "story_v_out_317282.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_7 = math.max(var_366_0, arg_363_1.talkMaxDuration)

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_7 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - 0) / var_366_7

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= 0 + var_366_7 and arg_363_1.time_ < 0 + var_366_7 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play317282091 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 317282091
		arg_367_1.duration_ = 5.67

		local var_367_0 = {
			zh = 5.666,
			ja = 5.633
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play317282092(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = 0.65

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_1 = arg_367_1:GetWordFromCfg(317282091)
				local var_370_2 = arg_367_1:FormatText(var_370_1.content)

				arg_367_1.text_.text = var_370_2

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_4 = 26 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 26)

				if (26 <= 0 and var_370_0 or var_370_0 * (utf8.len(var_370_2) / 26)) > 0 and var_370_0 < var_370_4 then
					arg_367_1.talkMaxDuration = var_370_4

					if var_370_4 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_4 + 0
					end
				end

				arg_367_1.text_.text = var_370_2
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282091", "story_v_out_317282.awb") ~= 0 then
					local var_370_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282091", "story_v_out_317282.awb") / 1000

					if var_370_5 + 0 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_5 + 0
					end

					if var_370_1.prefab_name ~= "" and arg_367_1.actors_[var_370_1.prefab_name] ~= nil then
						local var_370_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_1.prefab_name].transform, "story_v_out_317282", "317282091", "story_v_out_317282.awb")

						arg_367_1:RecordAudio("317282091", var_370_6)
						arg_367_1:RecordAudio("317282091", var_370_6)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_317282", "317282091", "story_v_out_317282.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_317282", "317282091", "story_v_out_317282.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_7 = math.max(var_370_0, arg_367_1.talkMaxDuration)

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_7 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - 0) / var_370_7

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= 0 + var_370_7 and arg_367_1.time_ < 0 + var_370_7 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play317282092 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 317282092
		arg_371_1.duration_ = 3.7

		local var_371_0 = {
			zh = 3.7,
			ja = 3.133
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play317282093(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(arg_371_1.actors_["2079ui_story"]) and arg_371_1.var_.characterEffect2079ui_story == nil then
				arg_371_1.var_.characterEffect2079ui_story = arg_371_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_0 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_0 and not isNil(arg_371_1.actors_["2079ui_story"]) then
				if arg_371_1.var_.characterEffect2079ui_story and not isNil(arg_371_1.actors_["2079ui_story"]) then
					arg_371_1.var_.characterEffect2079ui_story.fillFlat = true
					arg_371_1.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_371_1.time_ - 0) / var_374_0)
				end
			end

			if arg_371_1.time_ >= 0 + var_374_0 and arg_371_1.time_ < 0 + var_374_0 + arg_374_0 and not isNil(arg_371_1.actors_["2079ui_story"]) and arg_371_1.var_.characterEffect2079ui_story then
				arg_371_1.var_.characterEffect2079ui_story.fillFlat = true
				arg_371_1.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			local var_374_1 = arg_371_1.actors_["2078ui_story"]

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect2078ui_story == nil then
				arg_371_1.var_.characterEffect2078ui_story = var_374_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_2 and not isNil(var_374_1) then
				if arg_371_1.var_.characterEffect2078ui_story and not isNil(var_374_1) then
					arg_371_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_371_1.time_ >= 0 + var_374_2 and arg_371_1.time_ < 0 + var_374_2 + arg_374_0 and not isNil(var_374_1) and arg_371_1.var_.characterEffect2078ui_story then
				arg_371_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			local var_374_4 = 0
			local var_374_5 = 0.275

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_6 = arg_371_1:GetWordFromCfg(317282092)
				local var_374_7 = arg_371_1:FormatText(var_374_6.content)

				arg_371_1.text_.text = var_374_7

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_9 = 11 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 11)

				if (11 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_7) / 11)) > 0 and var_374_5 < var_374_9 then
					arg_371_1.talkMaxDuration = var_374_9

					if var_374_9 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_9 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_7
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282092", "story_v_out_317282.awb") ~= 0 then
					local var_374_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282092", "story_v_out_317282.awb") / 1000

					if var_374_10 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_4
					end

					if var_374_6.prefab_name ~= "" and arg_371_1.actors_[var_374_6.prefab_name] ~= nil then
						local var_374_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_6.prefab_name].transform, "story_v_out_317282", "317282092", "story_v_out_317282.awb")

						arg_371_1:RecordAudio("317282092", var_374_11)
						arg_371_1:RecordAudio("317282092", var_374_11)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_317282", "317282092", "story_v_out_317282.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_317282", "317282092", "story_v_out_317282.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_12 = math.max(var_374_5, arg_371_1.talkMaxDuration)

			if var_374_4 <= arg_371_1.time_ and arg_371_1.time_ < var_374_4 + var_374_12 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_4) / var_374_12

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_4 + var_374_12 and arg_371_1.time_ < var_374_4 + var_374_12 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {}

		arg_371_1:InitPlayNodeList()
	end,
	Play317282093 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 317282093
		arg_375_1.duration_ = 4.37

		local var_375_0 = {
			zh = 3.766,
			ja = 4.366
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play317282094(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(arg_375_1.actors_["2079ui_story"]) and arg_375_1.var_.characterEffect2079ui_story == nil then
				arg_375_1.var_.characterEffect2079ui_story = arg_375_1.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_0 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_0 and not isNil(arg_375_1.actors_["2079ui_story"]) then
				if arg_375_1.var_.characterEffect2079ui_story and not isNil(arg_375_1.actors_["2079ui_story"]) then
					arg_375_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= 0 + var_378_0 and arg_375_1.time_ < 0 + var_378_0 + arg_378_0 and not isNil(arg_375_1.actors_["2079ui_story"]) and arg_375_1.var_.characterEffect2079ui_story then
				arg_375_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_378_2 = arg_375_1.actors_["2078ui_story"]

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= 0 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.characterEffect2078ui_story == nil then
				arg_375_1.var_.characterEffect2078ui_story = var_378_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_3 = 0.200000002980232

			if 0 <= arg_375_1.time_ and arg_375_1.time_ < 0 + var_378_3 and not isNil(var_378_2) then
				if arg_375_1.var_.characterEffect2078ui_story and not isNil(var_378_2) then
					arg_375_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_375_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_375_1.time_ - 0) / var_378_3)
				end
			end

			if arg_375_1.time_ >= 0 + var_378_3 and arg_375_1.time_ < 0 + var_378_3 + arg_378_0 and not isNil(var_378_2) and arg_375_1.var_.characterEffect2078ui_story then
				arg_375_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_375_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_378_4 = 0
			local var_378_5 = 0.275

			if 0 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				arg_375_1.leftNameTxt_.text = arg_375_1:FormatText(StoryNameCfg[571].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_6 = arg_375_1:GetWordFromCfg(317282093)
				local var_378_7 = arg_375_1:FormatText(var_378_6.content)

				arg_375_1.text_.text = var_378_7

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_9 = 11 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 11)

				if (11 <= 0 and var_378_5 or var_378_5 * (utf8.len(var_378_7) / 11)) > 0 and var_378_5 < var_378_9 then
					arg_375_1.talkMaxDuration = var_378_9

					if var_378_9 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_9 + var_378_4
					end
				end

				arg_375_1.text_.text = var_378_7
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282093", "story_v_out_317282.awb") ~= 0 then
					local var_378_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282093", "story_v_out_317282.awb") / 1000

					if var_378_10 + var_378_4 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_10 + var_378_4
					end

					if var_378_6.prefab_name ~= "" and arg_375_1.actors_[var_378_6.prefab_name] ~= nil then
						local var_378_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_6.prefab_name].transform, "story_v_out_317282", "317282093", "story_v_out_317282.awb")

						arg_375_1:RecordAudio("317282093", var_378_11)
						arg_375_1:RecordAudio("317282093", var_378_11)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_317282", "317282093", "story_v_out_317282.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_317282", "317282093", "story_v_out_317282.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_12 = math.max(var_378_5, arg_375_1.talkMaxDuration)

			if var_378_4 <= arg_375_1.time_ and arg_375_1.time_ < var_378_4 + var_378_12 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_4) / var_378_12

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_4 + var_378_12 and arg_375_1.time_ < var_378_4 + var_378_12 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end

		arg_375_1.nodeConfigList_ = {}

		arg_375_1:InitPlayNodeList()
	end,
	Play317282094 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 317282094
		arg_379_1.duration_ = 9

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play317282095(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			if 2 < arg_379_1.time_ and arg_379_1.time_ <= 2 + arg_382_0 then
				local var_382_0 = arg_379_1.bgs_.K10f

				arg_379_1.bgs_.K10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_382_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_382_1 = var_382_0:GetComponent("SpriteRenderer")

				if var_382_1 and var_382_1.sprite then
					local var_382_2 = 2 * (var_382_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_382_0.transform.localScale = Vector3.New(var_382_2 / var_382_1.sprite.bounds.size.y < var_382_2 * manager.ui.mainCameraCom_.aspect / var_382_1.sprite.bounds.size.x and var_382_2 * manager.ui.mainCameraCom_.aspect / var_382_1.sprite.bounds.size.x or var_382_2 / var_382_1.sprite.bounds.size.y, var_382_2 / var_382_1.sprite.bounds.size.y < var_382_2 * manager.ui.mainCameraCom_.aspect / var_382_1.sprite.bounds.size.x and var_382_2 * manager.ui.mainCameraCom_.aspect / var_382_1.sprite.bounds.size.x or var_382_2 / var_382_1.sprite.bounds.size.y, 0)
				end

				for iter_382_0, iter_382_1 in pairs(arg_379_1.bgs_) do
					if iter_382_0 ~= "K10f" then
						iter_382_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_382_3 = 0

			if 0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_3 + arg_382_0 then
				arg_379_1.mask_.enabled = true
				arg_379_1.mask_.raycastTarget = true

				arg_379_1:SetGaussion(false)
			end

			local var_382_4 = 2

			if var_382_3 <= arg_379_1.time_ and arg_379_1.time_ < var_382_3 + var_382_4 then
				local var_382_5 = Color.New(0, 0, 0)

				var_382_5.a = Mathf.Lerp(0, 1, (arg_379_1.time_ - var_382_3) / var_382_4)
				arg_379_1.mask_.color = var_382_5
			end

			if arg_379_1.time_ >= var_382_3 + var_382_4 and arg_379_1.time_ < var_382_3 + var_382_4 + arg_382_0 then
				local var_382_6 = Color.New(0, 0, 0)

				var_382_6.a = 1
				arg_379_1.mask_.color = var_382_6
			end

			local var_382_7 = 2

			if 2 < arg_379_1.time_ and arg_379_1.time_ <= var_382_7 + arg_382_0 then
				arg_379_1.mask_.enabled = true
				arg_379_1.mask_.raycastTarget = true

				arg_379_1:SetGaussion(false)
			end

			local var_382_8 = 2

			if var_382_7 <= arg_379_1.time_ and arg_379_1.time_ < var_382_7 + var_382_8 then
				local var_382_9 = Color.New(0, 0, 0)

				var_382_9.a = Mathf.Lerp(1, 0, (arg_379_1.time_ - var_382_7) / var_382_8)
				arg_379_1.mask_.color = var_382_9
			end

			if arg_379_1.time_ >= var_382_7 + var_382_8 and arg_379_1.time_ < var_382_7 + var_382_8 + arg_382_0 then
				local var_382_10 = Color.New(0, 0, 0)

				arg_379_1.mask_.enabled = false
				var_382_10.a = 0
				arg_379_1.mask_.color = var_382_10
			end

			local var_382_11 = arg_379_1.actors_["2079ui_story"].transform

			if 2 < arg_379_1.time_ and arg_379_1.time_ <= 2 + arg_382_0 then
				arg_379_1.var_.moveOldPos2079ui_story = var_382_11.localPosition
			end

			local var_382_12 = 0.001

			if 2 <= arg_379_1.time_ and arg_379_1.time_ < 2 + var_382_12 then
				var_382_11.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_379_1.time_ - 2) / var_382_12)
				var_382_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_11.position).x, (manager.ui.mainCamera.transform.position - var_382_11.position).y, (manager.ui.mainCamera.transform.position - var_382_11.position).z)
				var_382_11.localEulerAngles.z = 0
				var_382_11.localEulerAngles.x = 0
				var_382_11.localEulerAngles = var_382_11.localEulerAngles
			end

			if arg_379_1.time_ >= 2 + var_382_12 and arg_379_1.time_ < 2 + var_382_12 + arg_382_0 then
				var_382_11.localPosition = Vector3.New(0, 100, 0)
				var_382_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_11.position).x, (manager.ui.mainCamera.transform.position - var_382_11.position).y, (manager.ui.mainCamera.transform.position - var_382_11.position).z)
				var_382_11.localEulerAngles.z = 0
				var_382_11.localEulerAngles.x = 0
				var_382_11.localEulerAngles = var_382_11.localEulerAngles
			end

			local var_382_13 = arg_379_1.actors_["2079ui_story"]

			if 4 < arg_379_1.time_ and arg_379_1.time_ <= 4 + arg_382_0 and not isNil(var_382_13) and arg_379_1.var_.characterEffect2079ui_story == nil then
				arg_379_1.var_.characterEffect2079ui_story = var_382_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_382_14 = 0.200000002980232

			if 4 <= arg_379_1.time_ and arg_379_1.time_ < 4 + var_382_14 and not isNil(var_382_13) then
				if arg_379_1.var_.characterEffect2079ui_story and not isNil(var_382_13) then
					arg_379_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_379_1.time_ >= 4 + var_382_14 and arg_379_1.time_ < 4 + var_382_14 + arg_382_0 and not isNil(var_382_13) and arg_379_1.var_.characterEffect2079ui_story then
				arg_379_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_382_16 = arg_379_1.actors_["2078ui_story"].transform

			if 2 < arg_379_1.time_ and arg_379_1.time_ <= 2 + arg_382_0 then
				arg_379_1.var_.moveOldPos2078ui_story = var_382_16.localPosition
			end

			local var_382_17 = 0.001

			if 2 <= arg_379_1.time_ and arg_379_1.time_ < 2 + var_382_17 then
				var_382_16.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_379_1.time_ - 2) / var_382_17)
				var_382_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_16.position).x, (manager.ui.mainCamera.transform.position - var_382_16.position).y, (manager.ui.mainCamera.transform.position - var_382_16.position).z)
				var_382_16.localEulerAngles.z = 0
				var_382_16.localEulerAngles.x = 0
				var_382_16.localEulerAngles = var_382_16.localEulerAngles
			end

			if arg_379_1.time_ >= 2 + var_382_17 and arg_379_1.time_ < 2 + var_382_17 + arg_382_0 then
				var_382_16.localPosition = Vector3.New(0, 100, 0)
				var_382_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_16.position).x, (manager.ui.mainCamera.transform.position - var_382_16.position).y, (manager.ui.mainCamera.transform.position - var_382_16.position).z)
				var_382_16.localEulerAngles.z = 0
				var_382_16.localEulerAngles.x = 0
				var_382_16.localEulerAngles = var_382_16.localEulerAngles
			end

			local var_382_18 = 2

			arg_379_1.isInRecall_ = false

			if var_382_18 < arg_379_1.time_ and arg_379_1.time_ <= var_382_18 + arg_382_0 then
				arg_379_1.screenFilterGo_:SetActive(false)

				for iter_382_2, iter_382_3 in pairs(arg_379_1.actors_) do
					for iter_382_4, iter_382_5 in ipairs((iter_382_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_382_5.color = iter_382_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_382_19 = 0.0166666666666667

			if var_382_18 <= arg_379_1.time_ and arg_379_1.time_ < var_382_18 + var_382_19 then
				arg_379_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_379_1.time_ - var_382_18) / var_382_19)
			end

			if arg_379_1.time_ >= var_382_18 + var_382_19 and arg_379_1.time_ < var_382_18 + var_382_19 + arg_382_0 then
				arg_379_1.screenFilterEffect_.weight = 0
			end

			local var_382_20 = arg_379_1.actors_["2079ui_story"].transform

			if 4 < arg_379_1.time_ and arg_379_1.time_ <= 4 + arg_382_0 then
				arg_379_1.var_.moveOldPos2079ui_story = var_382_20.localPosition
			end

			local var_382_21 = 0.001

			if 4 <= arg_379_1.time_ and arg_379_1.time_ < 4 + var_382_21 then
				var_382_20.localPosition = Vector3.Lerp(arg_379_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_379_1.time_ - 4) / var_382_21)
				var_382_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_20.position).x, (manager.ui.mainCamera.transform.position - var_382_20.position).y, (manager.ui.mainCamera.transform.position - var_382_20.position).z)
				var_382_20.localEulerAngles.z = 0
				var_382_20.localEulerAngles.x = 0
				var_382_20.localEulerAngles = var_382_20.localEulerAngles
			end

			if arg_379_1.time_ >= 4 + var_382_21 and arg_379_1.time_ < 4 + var_382_21 + arg_382_0 then
				var_382_20.localPosition = Vector3.New(0, -1.28, -5.6)
				var_382_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_382_20.position).x, (manager.ui.mainCamera.transform.position - var_382_20.position).y, (manager.ui.mainCamera.transform.position - var_382_20.position).z)
				var_382_20.localEulerAngles.z = 0
				var_382_20.localEulerAngles.x = 0
				var_382_20.localEulerAngles = var_382_20.localEulerAngles
			end

			if arg_379_1.frameCnt_ <= 1 then
				arg_379_1.dialog_:SetActive(false)
			end

			local var_382_22 = 4
			local var_382_23 = 0.95

			if 4 < arg_379_1.time_ and arg_379_1.time_ <= var_382_22 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0

				arg_379_1.dialog_:SetActive(true)

				arg_379_1.dialogCg_.alpha = 0

				local var_382_24 = LeanTween.value(arg_379_1.dialog_, 0, 1, 0.3)

				var_382_24:setOnUpdate(LuaHelper.FloatAction(function(arg_383_0)
					arg_379_1.dialogCg_.alpha = arg_383_0
				end))
				var_382_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_379_1.dialog_)
					var_382_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_379_1.duration_ = arg_379_1.duration_ + 0.3

				SetActive(arg_379_1.leftNameGo_, false)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_25 = arg_379_1:FormatText(arg_379_1:GetWordFromCfg(317282094).content)

				arg_379_1.text_.text = var_382_25

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_27 = 38 <= 0 and var_382_23 or var_382_23 * (utf8.len(var_382_25) / 38)

				if (38 <= 0 and var_382_23 or var_382_23 * (utf8.len(var_382_25) / 38)) > 0 and var_382_23 < var_382_27 then
					arg_379_1.talkMaxDuration = var_382_27
					var_382_22 = var_382_22 + 0.3

					if var_382_27 + var_382_22 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_27 + var_382_22
					end
				end

				arg_379_1.text_.text = var_382_25
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)
				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_28 = var_382_22 + 0.3
			local var_382_29 = math.max(var_382_23, arg_379_1.talkMaxDuration)

			if var_382_22 + 0.3 <= arg_379_1.time_ and arg_379_1.time_ < var_382_28 + var_382_29 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_28) / var_382_29

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_28 + var_382_29 and arg_379_1.time_ < var_382_28 + var_382_29 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end

		arg_379_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_379_1:InitPlayNodeList()
	end,
	Play317282095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 317282095
		arg_385_1.duration_ = 6.2

		local var_385_0 = {
			zh = 6.2,
			ja = 5.9
		}
		local var_385_1 = manager.audio:GetLocalizationFlag()

		if var_385_0[var_385_1] ~= nil then
			arg_385_1.duration_ = var_385_0[var_385_1]
		end

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play317282096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if arg_385_1.actors_["1199ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1199ui_story"))) then
				local var_388_0 = Object.Instantiate(Asset.Load("Char/" .. "1199ui_story"), arg_385_1.stage_.transform)

				var_388_0.name = "1199ui_story"
				var_388_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_385_1.actors_["1199ui_story"] = var_388_0

				local var_388_1 = var_388_0:GetComponentInChildren(typeof(CharacterEffect))

				var_388_1.enabled = true

				local var_388_2 = GameObjectTools.GetOrAddComponent(var_388_0, typeof(DynamicBoneHelper))

				if var_388_2 then
					var_388_2:EnableDynamicBone(false)
				end

				arg_385_1:ShowWeapon(var_388_1.transform, false)

				arg_385_1.var_["1199ui_story" .. "Animator"] = var_388_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_385_1.var_["1199ui_story" .. "Animator"].applyRootMotion = true
				arg_385_1.var_["1199ui_story" .. "LipSync"] = var_388_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_388_3 = arg_385_1.actors_["1199ui_story"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos1199ui_story = var_388_3.localPosition
			end

			local var_388_4 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_4 then
				var_388_3.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_385_1.time_ - 0) / var_388_4)
				var_388_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_3.position).x, (manager.ui.mainCamera.transform.position - var_388_3.position).y, (manager.ui.mainCamera.transform.position - var_388_3.position).z)
				var_388_3.localEulerAngles.z = 0
				var_388_3.localEulerAngles.x = 0
				var_388_3.localEulerAngles = var_388_3.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_4 and arg_385_1.time_ < 0 + var_388_4 + arg_388_0 then
				var_388_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_388_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_3.position).x, (manager.ui.mainCamera.transform.position - var_388_3.position).y, (manager.ui.mainCamera.transform.position - var_388_3.position).z)
				var_388_3.localEulerAngles.z = 0
				var_388_3.localEulerAngles.x = 0
				var_388_3.localEulerAngles = var_388_3.localEulerAngles
			end

			local var_388_5 = arg_385_1.actors_["1199ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_5) and arg_385_1.var_.characterEffect1199ui_story == nil then
				arg_385_1.var_.characterEffect1199ui_story = var_388_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_6 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_6 and not isNil(var_388_5) then
				if arg_385_1.var_.characterEffect1199ui_story and not isNil(var_388_5) then
					arg_385_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_6 and arg_385_1.time_ < 0 + var_388_6 + arg_388_0 and not isNil(var_388_5) and arg_385_1.var_.characterEffect1199ui_story then
				arg_385_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_1")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_388_8 = arg_385_1.actors_["2079ui_story"].transform

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.var_.moveOldPos2079ui_story = var_388_8.localPosition
			end

			local var_388_9 = 0.001

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_9 then
				var_388_8.localPosition = Vector3.Lerp(arg_385_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_385_1.time_ - 0) / var_388_9)
				var_388_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_8.position).x, (manager.ui.mainCamera.transform.position - var_388_8.position).y, (manager.ui.mainCamera.transform.position - var_388_8.position).z)
				var_388_8.localEulerAngles.z = 0
				var_388_8.localEulerAngles.x = 0
				var_388_8.localEulerAngles = var_388_8.localEulerAngles
			end

			if arg_385_1.time_ >= 0 + var_388_9 and arg_385_1.time_ < 0 + var_388_9 + arg_388_0 then
				var_388_8.localPosition = Vector3.New(0, 100, 0)
				var_388_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_388_8.position).x, (manager.ui.mainCamera.transform.position - var_388_8.position).y, (manager.ui.mainCamera.transform.position - var_388_8.position).z)
				var_388_8.localEulerAngles.z = 0
				var_388_8.localEulerAngles.x = 0
				var_388_8.localEulerAngles = var_388_8.localEulerAngles
			end

			local var_388_10 = 0
			local var_388_11 = 0.7

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_10 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_12 = arg_385_1:GetWordFromCfg(317282095)
				local var_388_13 = arg_385_1:FormatText(var_388_12.content)

				arg_385_1.text_.text = var_388_13

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_15 = 28 <= 0 and var_388_11 or var_388_11 * (utf8.len(var_388_13) / 28)

				if (28 <= 0 and var_388_11 or var_388_11 * (utf8.len(var_388_13) / 28)) > 0 and var_388_11 < var_388_15 then
					arg_385_1.talkMaxDuration = var_388_15

					if var_388_15 + var_388_10 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_15 + var_388_10
					end
				end

				arg_385_1.text_.text = var_388_13
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282095", "story_v_out_317282.awb") ~= 0 then
					local var_388_16 = manager.audio:GetVoiceLength("story_v_out_317282", "317282095", "story_v_out_317282.awb") / 1000

					if var_388_16 + var_388_10 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_16 + var_388_10
					end

					if var_388_12.prefab_name ~= "" and arg_385_1.actors_[var_388_12.prefab_name] ~= nil then
						local var_388_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_12.prefab_name].transform, "story_v_out_317282", "317282095", "story_v_out_317282.awb")

						arg_385_1:RecordAudio("317282095", var_388_17)
						arg_385_1:RecordAudio("317282095", var_388_17)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_317282", "317282095", "story_v_out_317282.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_317282", "317282095", "story_v_out_317282.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_18 = math.max(var_388_11, arg_385_1.talkMaxDuration)

			if var_388_10 <= arg_385_1.time_ and arg_385_1.time_ < var_388_10 + var_388_18 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_10) / var_388_18

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_10 + var_388_18 and arg_385_1.time_ < var_388_10 + var_388_18 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_385_1:InitPlayNodeList()
	end,
	Play317282096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 317282096
		arg_389_1.duration_ = 3.2

		local var_389_0 = {
			zh = 3.2,
			ja = 1.6
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play317282097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			local var_392_0 = 0.175

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_1 = arg_389_1:GetWordFromCfg(317282096)
				local var_392_2 = arg_389_1:FormatText(var_392_1.content)

				arg_389_1.text_.text = var_392_2

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_4 = 7 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 7)

				if (7 <= 0 and var_392_0 or var_392_0 * (utf8.len(var_392_2) / 7)) > 0 and var_392_0 < var_392_4 then
					arg_389_1.talkMaxDuration = var_392_4

					if var_392_4 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_4 + 0
					end
				end

				arg_389_1.text_.text = var_392_2
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282096", "story_v_out_317282.awb") ~= 0 then
					local var_392_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282096", "story_v_out_317282.awb") / 1000

					if var_392_5 + 0 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_5 + 0
					end

					if var_392_1.prefab_name ~= "" and arg_389_1.actors_[var_392_1.prefab_name] ~= nil then
						local var_392_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_1.prefab_name].transform, "story_v_out_317282", "317282096", "story_v_out_317282.awb")

						arg_389_1:RecordAudio("317282096", var_392_6)
						arg_389_1:RecordAudio("317282096", var_392_6)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_317282", "317282096", "story_v_out_317282.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_317282", "317282096", "story_v_out_317282.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_7 = math.max(var_392_0, arg_389_1.talkMaxDuration)

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_7 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - 0) / var_392_7

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= 0 + var_392_7 and arg_389_1.time_ < 0 + var_392_7 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play317282097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 317282097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play317282098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1199ui_story"]) and arg_393_1.var_.characterEffect1199ui_story == nil then
				arg_393_1.var_.characterEffect1199ui_story = arg_393_1.actors_["1199ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1199ui_story"]) then
				if arg_393_1.var_.characterEffect1199ui_story and not isNil(arg_393_1.actors_["1199ui_story"]) then
					arg_393_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_0)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1199ui_story"]) and arg_393_1.var_.characterEffect1199ui_story then
				arg_393_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_396_1 = 0
			local var_396_2 = 0.6

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_3 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(317282097).content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 24 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 24)

				if (24 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 24)) > 0 and var_396_2 < var_396_5 then
					arg_393_1.talkMaxDuration = var_396_5

					if var_396_5 + var_396_1 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + var_396_1
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_6 = math.max(var_396_2, arg_393_1.talkMaxDuration)

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_6 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_1) / var_396_6

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_1 + var_396_6 and arg_393_1.time_ < var_396_1 + var_396_6 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play317282098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 317282098
		arg_397_1.duration_ = 9.17

		local var_397_0 = {
			zh = 8.6,
			ja = 9.166
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play317282099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos1199ui_story = arg_397_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_400_0 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 then
				arg_397_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_397_1.time_ - 0) / var_400_0)
				arg_397_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1199ui_story"].transform.position).z)
				arg_397_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["1199ui_story"].transform.localEulerAngles = arg_397_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 then
				arg_397_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_397_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_397_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_397_1.actors_["1199ui_story"].transform.position).z)
				arg_397_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_397_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_397_1.actors_["1199ui_story"].transform.localEulerAngles = arg_397_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_400_1 = arg_397_1.actors_["1199ui_story"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1199ui_story == nil then
				arg_397_1.var_.characterEffect1199ui_story = var_400_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_2 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_2 and not isNil(var_400_1) then
				if arg_397_1.var_.characterEffect1199ui_story and not isNil(var_400_1) then
					arg_397_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_397_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_397_1.time_ - 0) / var_400_2)
				end
			end

			if arg_397_1.time_ >= 0 + var_400_2 and arg_397_1.time_ < 0 + var_400_2 + arg_400_0 and not isNil(var_400_1) and arg_397_1.var_.characterEffect1199ui_story then
				arg_397_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_397_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_400_3 = arg_397_1.actors_["1015ui_story"].transform

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPos1015ui_story = var_400_3.localPosition
			end

			local var_400_4 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_4 then
				var_400_3.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_397_1.time_ - 0) / var_400_4)
				var_400_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_3.position).x, (manager.ui.mainCamera.transform.position - var_400_3.position).y, (manager.ui.mainCamera.transform.position - var_400_3.position).z)
				var_400_3.localEulerAngles.z = 0
				var_400_3.localEulerAngles.x = 0
				var_400_3.localEulerAngles = var_400_3.localEulerAngles
			end

			if arg_397_1.time_ >= 0 + var_400_4 and arg_397_1.time_ < 0 + var_400_4 + arg_400_0 then
				var_400_3.localPosition = Vector3.New(0, -1.15, -6.2)
				var_400_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_400_3.position).x, (manager.ui.mainCamera.transform.position - var_400_3.position).y, (manager.ui.mainCamera.transform.position - var_400_3.position).z)
				var_400_3.localEulerAngles.z = 0
				var_400_3.localEulerAngles.x = 0
				var_400_3.localEulerAngles = var_400_3.localEulerAngles
			end

			local var_400_5 = arg_397_1.actors_["1015ui_story"]

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(var_400_5) and arg_397_1.var_.characterEffect1015ui_story == nil then
				arg_397_1.var_.characterEffect1015ui_story = var_400_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_6 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_6 and not isNil(var_400_5) then
				if arg_397_1.var_.characterEffect1015ui_story and not isNil(var_400_5) then
					arg_397_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_6 and arg_397_1.time_ < 0 + var_400_6 + arg_400_0 and not isNil(var_400_5) and arg_397_1.var_.characterEffect1015ui_story then
				arg_397_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_400_8 = 0
			local var_400_9 = 1.1

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_8 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_10 = arg_397_1:GetWordFromCfg(317282098)
				local var_400_11 = arg_397_1:FormatText(var_400_10.content)

				arg_397_1.text_.text = var_400_11

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_13 = 44 <= 0 and var_400_9 or var_400_9 * (utf8.len(var_400_11) / 44)

				if (44 <= 0 and var_400_9 or var_400_9 * (utf8.len(var_400_11) / 44)) > 0 and var_400_9 < var_400_13 then
					arg_397_1.talkMaxDuration = var_400_13

					if var_400_13 + var_400_8 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_13 + var_400_8
					end
				end

				arg_397_1.text_.text = var_400_11
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282098", "story_v_out_317282.awb") ~= 0 then
					local var_400_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282098", "story_v_out_317282.awb") / 1000

					if var_400_14 + var_400_8 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_14 + var_400_8
					end

					if var_400_10.prefab_name ~= "" and arg_397_1.actors_[var_400_10.prefab_name] ~= nil then
						local var_400_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_10.prefab_name].transform, "story_v_out_317282", "317282098", "story_v_out_317282.awb")

						arg_397_1:RecordAudio("317282098", var_400_15)
						arg_397_1:RecordAudio("317282098", var_400_15)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_317282", "317282098", "story_v_out_317282.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_317282", "317282098", "story_v_out_317282.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_16 = math.max(var_400_9, arg_397_1.talkMaxDuration)

			if var_400_8 <= arg_397_1.time_ and arg_397_1.time_ < var_400_8 + var_400_16 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_8) / var_400_16

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_8 + var_400_16 and arg_397_1.time_ < var_400_8 + var_400_16 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play317282099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 317282099
		arg_401_1.duration_ = 16.63

		local var_401_0 = {
			zh = 16.633,
			ja = 14.333
		}
		local var_401_1 = manager.audio:GetLocalizationFlag()

		if var_401_0[var_401_1] ~= nil then
			arg_401_1.duration_ = var_401_0[var_401_1]
		end

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play317282100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			local var_404_0 = 2.025

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_1 = arg_401_1:GetWordFromCfg(317282099)
				local var_404_2 = arg_401_1:FormatText(var_404_1.content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 80 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 80)

				if (80 <= 0 and var_404_0 or var_404_0 * (utf8.len(var_404_2) / 80)) > 0 and var_404_0 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + 0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282099", "story_v_out_317282.awb") ~= 0 then
					local var_404_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282099", "story_v_out_317282.awb") / 1000

					if var_404_5 + 0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_5 + 0
					end

					if var_404_1.prefab_name ~= "" and arg_401_1.actors_[var_404_1.prefab_name] ~= nil then
						local var_404_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_401_1.actors_[var_404_1.prefab_name].transform, "story_v_out_317282", "317282099", "story_v_out_317282.awb")

						arg_401_1:RecordAudio("317282099", var_404_6)
						arg_401_1:RecordAudio("317282099", var_404_6)
					else
						arg_401_1:AudioAction("play", "voice", "story_v_out_317282", "317282099", "story_v_out_317282.awb")
					end

					arg_401_1:RecordHistoryTalkVoice("story_v_out_317282", "317282099", "story_v_out_317282.awb")
				end

				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_7 = math.max(var_404_0, arg_401_1.talkMaxDuration)

			if 0 <= arg_401_1.time_ and arg_401_1.time_ < 0 + var_404_7 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - 0) / var_404_7

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= 0 + var_404_7 and arg_401_1.time_ < 0 + var_404_7 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play317282100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 317282100
		arg_405_1.duration_ = 16

		local var_405_0 = {
			zh = 12.633,
			ja = 16
		}
		local var_405_1 = manager.audio:GetLocalizationFlag()

		if var_405_0[var_405_1] ~= nil then
			arg_405_1.duration_ = var_405_0[var_405_1]
		end

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play317282101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			local var_408_0 = 1.575

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_1 = arg_405_1:GetWordFromCfg(317282100)
				local var_408_2 = arg_405_1:FormatText(var_408_1.content)

				arg_405_1.text_.text = var_408_2

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 63 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 63)

				if (63 <= 0 and var_408_0 or var_408_0 * (utf8.len(var_408_2) / 63)) > 0 and var_408_0 < var_408_4 then
					arg_405_1.talkMaxDuration = var_408_4

					if var_408_4 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_4 + 0
					end
				end

				arg_405_1.text_.text = var_408_2
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282100", "story_v_out_317282.awb") ~= 0 then
					local var_408_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282100", "story_v_out_317282.awb") / 1000

					if var_408_5 + 0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_5 + 0
					end

					if var_408_1.prefab_name ~= "" and arg_405_1.actors_[var_408_1.prefab_name] ~= nil then
						local var_408_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_405_1.actors_[var_408_1.prefab_name].transform, "story_v_out_317282", "317282100", "story_v_out_317282.awb")

						arg_405_1:RecordAudio("317282100", var_408_6)
						arg_405_1:RecordAudio("317282100", var_408_6)
					else
						arg_405_1:AudioAction("play", "voice", "story_v_out_317282", "317282100", "story_v_out_317282.awb")
					end

					arg_405_1:RecordHistoryTalkVoice("story_v_out_317282", "317282100", "story_v_out_317282.awb")
				end

				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_7 = math.max(var_408_0, arg_405_1.talkMaxDuration)

			if 0 <= arg_405_1.time_ and arg_405_1.time_ < 0 + var_408_7 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - 0) / var_408_7

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= 0 + var_408_7 and arg_405_1.time_ < 0 + var_408_7 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play317282101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 317282101
		arg_409_1.duration_ = 9.07

		local var_409_0 = {
			zh = 7.2,
			ja = 9.066
		}
		local var_409_1 = manager.audio:GetLocalizationFlag()

		if var_409_0[var_409_1] ~= nil then
			arg_409_1.duration_ = var_409_0[var_409_1]
		end

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play317282102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			local var_412_0 = 0.9

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_1 = arg_409_1:GetWordFromCfg(317282101)
				local var_412_2 = arg_409_1:FormatText(var_412_1.content)

				arg_409_1.text_.text = var_412_2

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_4 = 36 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 36)

				if (36 <= 0 and var_412_0 or var_412_0 * (utf8.len(var_412_2) / 36)) > 0 and var_412_0 < var_412_4 then
					arg_409_1.talkMaxDuration = var_412_4

					if var_412_4 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_4 + 0
					end
				end

				arg_409_1.text_.text = var_412_2
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282101", "story_v_out_317282.awb") ~= 0 then
					local var_412_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282101", "story_v_out_317282.awb") / 1000

					if var_412_5 + 0 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_5 + 0
					end

					if var_412_1.prefab_name ~= "" and arg_409_1.actors_[var_412_1.prefab_name] ~= nil then
						local var_412_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_409_1.actors_[var_412_1.prefab_name].transform, "story_v_out_317282", "317282101", "story_v_out_317282.awb")

						arg_409_1:RecordAudio("317282101", var_412_6)
						arg_409_1:RecordAudio("317282101", var_412_6)
					else
						arg_409_1:AudioAction("play", "voice", "story_v_out_317282", "317282101", "story_v_out_317282.awb")
					end

					arg_409_1:RecordHistoryTalkVoice("story_v_out_317282", "317282101", "story_v_out_317282.awb")
				end

				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_7 = math.max(var_412_0, arg_409_1.talkMaxDuration)

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_7 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - 0) / var_412_7

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= 0 + var_412_7 and arg_409_1.time_ < 0 + var_412_7 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play317282102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 317282102
		arg_413_1.duration_ = 4.87

		local var_413_0 = {
			zh = 4.233,
			ja = 4.866
		}
		local var_413_1 = manager.audio:GetLocalizationFlag()

		if var_413_0[var_413_1] ~= nil then
			arg_413_1.duration_ = var_413_0[var_413_1]
		end

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play317282103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1015ui_story = arg_413_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_416_0 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 then
				arg_413_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_413_1.time_ - 0) / var_416_0)
				arg_413_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1015ui_story"].transform.position).z)
				arg_413_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1015ui_story"].transform.localEulerAngles = arg_413_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 then
				arg_413_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_413_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_413_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_413_1.actors_["1015ui_story"].transform.position).z)
				arg_413_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_413_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_413_1.actors_["1015ui_story"].transform.localEulerAngles = arg_413_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_416_1 = arg_413_1.actors_["1015ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1015ui_story == nil then
				arg_413_1.var_.characterEffect1015ui_story = var_416_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_2 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_2 and not isNil(var_416_1) then
				if arg_413_1.var_.characterEffect1015ui_story and not isNil(var_416_1) then
					arg_413_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_413_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_2)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_2 and arg_413_1.time_ < 0 + var_416_2 + arg_416_0 and not isNil(var_416_1) and arg_413_1.var_.characterEffect1015ui_story then
				arg_413_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_413_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_416_3 = arg_413_1.actors_["1199ui_story"].transform

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1.var_.moveOldPos1199ui_story = var_416_3.localPosition
			end

			local var_416_4 = 0.001

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_4 then
				var_416_3.localPosition = Vector3.Lerp(arg_413_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_413_1.time_ - 0) / var_416_4)
				var_416_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_416_3.position).x, (manager.ui.mainCamera.transform.position - var_416_3.position).y, (manager.ui.mainCamera.transform.position - var_416_3.position).z)
				var_416_3.localEulerAngles.z = 0
				var_416_3.localEulerAngles.x = 0
				var_416_3.localEulerAngles = var_416_3.localEulerAngles
			end

			if arg_413_1.time_ >= 0 + var_416_4 and arg_413_1.time_ < 0 + var_416_4 + arg_416_0 then
				var_416_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_416_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_416_3.position).x, (manager.ui.mainCamera.transform.position - var_416_3.position).y, (manager.ui.mainCamera.transform.position - var_416_3.position).z)
				var_416_3.localEulerAngles.z = 0
				var_416_3.localEulerAngles.x = 0
				var_416_3.localEulerAngles = var_416_3.localEulerAngles
			end

			local var_416_5 = arg_413_1.actors_["1199ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_5) and arg_413_1.var_.characterEffect1199ui_story == nil then
				arg_413_1.var_.characterEffect1199ui_story = var_416_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_6 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_6 and not isNil(var_416_5) then
				if arg_413_1.var_.characterEffect1199ui_story and not isNil(var_416_5) then
					arg_413_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_6 and arg_413_1.time_ < 0 + var_416_6 + arg_416_0 and not isNil(var_416_5) and arg_413_1.var_.characterEffect1199ui_story then
				arg_413_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action3_2")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_416_8 = 0
			local var_416_9 = 0.575

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_8 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_10 = arg_413_1:GetWordFromCfg(317282102)
				local var_416_11 = arg_413_1:FormatText(var_416_10.content)

				arg_413_1.text_.text = var_416_11

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_13 = 23 <= 0 and var_416_9 or var_416_9 * (utf8.len(var_416_11) / 23)

				if (23 <= 0 and var_416_9 or var_416_9 * (utf8.len(var_416_11) / 23)) > 0 and var_416_9 < var_416_13 then
					arg_413_1.talkMaxDuration = var_416_13

					if var_416_13 + var_416_8 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_13 + var_416_8
					end
				end

				arg_413_1.text_.text = var_416_11
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282102", "story_v_out_317282.awb") ~= 0 then
					local var_416_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282102", "story_v_out_317282.awb") / 1000

					if var_416_14 + var_416_8 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_14 + var_416_8
					end

					if var_416_10.prefab_name ~= "" and arg_413_1.actors_[var_416_10.prefab_name] ~= nil then
						local var_416_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_413_1.actors_[var_416_10.prefab_name].transform, "story_v_out_317282", "317282102", "story_v_out_317282.awb")

						arg_413_1:RecordAudio("317282102", var_416_15)
						arg_413_1:RecordAudio("317282102", var_416_15)
					else
						arg_413_1:AudioAction("play", "voice", "story_v_out_317282", "317282102", "story_v_out_317282.awb")
					end

					arg_413_1:RecordHistoryTalkVoice("story_v_out_317282", "317282102", "story_v_out_317282.awb")
				end

				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_16 = math.max(var_416_9, arg_413_1.talkMaxDuration)

			if var_416_8 <= arg_413_1.time_ and arg_413_1.time_ < var_416_8 + var_416_16 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_8) / var_416_16

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_8 + var_416_16 and arg_413_1.time_ < var_416_8 + var_416_16 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_413_1:InitPlayNodeList()
	end,
	Play317282103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 317282103
		arg_417_1.duration_ = 14.8

		local var_417_0 = {
			zh = 14.8,
			ja = 12.233
		}
		local var_417_1 = manager.audio:GetLocalizationFlag()

		if var_417_0[var_417_1] ~= nil then
			arg_417_1.duration_ = var_417_0[var_417_1]
		end

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play317282104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1015ui_story = arg_417_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1015ui_story"].transform.position).z)
				arg_417_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1015ui_story"].transform.localEulerAngles = arg_417_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_417_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["1015ui_story"].transform.position).z)
				arg_417_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["1015ui_story"].transform.localEulerAngles = arg_417_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["1015ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1015ui_story == nil then
				arg_417_1.var_.characterEffect1015ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect1015ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect1015ui_story then
				arg_417_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_420_4 = arg_417_1.actors_["1199ui_story"].transform

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos1199ui_story = var_420_4.localPosition
			end

			local var_420_5 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_5 then
				var_420_4.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_417_1.time_ - 0) / var_420_5)
				var_420_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_420_4.position).x, (manager.ui.mainCamera.transform.position - var_420_4.position).y, (manager.ui.mainCamera.transform.position - var_420_4.position).z)
				var_420_4.localEulerAngles.z = 0
				var_420_4.localEulerAngles.x = 0
				var_420_4.localEulerAngles = var_420_4.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_5 and arg_417_1.time_ < 0 + var_420_5 + arg_420_0 then
				var_420_4.localPosition = Vector3.New(0, 100, 0)
				var_420_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_420_4.position).x, (manager.ui.mainCamera.transform.position - var_420_4.position).y, (manager.ui.mainCamera.transform.position - var_420_4.position).z)
				var_420_4.localEulerAngles.z = 0
				var_420_4.localEulerAngles.x = 0
				var_420_4.localEulerAngles = var_420_4.localEulerAngles
			end

			local var_420_6 = arg_417_1.actors_["1199ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_6) and arg_417_1.var_.characterEffect1199ui_story == nil then
				arg_417_1.var_.characterEffect1199ui_story = var_420_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_7 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_7 and not isNil(var_420_6) then
				if arg_417_1.var_.characterEffect1199ui_story and not isNil(var_420_6) then
					arg_417_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_7)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_7 and arg_417_1.time_ < 0 + var_420_7 + arg_420_0 and not isNil(var_420_6) and arg_417_1.var_.characterEffect1199ui_story then
				arg_417_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_420_8 = 0
			local var_420_9 = 1.825

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_8 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, false)
				arg_417_1.callingController_:SetSelectedState("normal")

				local var_420_10 = arg_417_1:GetWordFromCfg(317282103)
				local var_420_11 = arg_417_1:FormatText(var_420_10.content)

				arg_417_1.text_.text = var_420_11

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_13 = 73 <= 0 and var_420_9 or var_420_9 * (utf8.len(var_420_11) / 73)

				if (73 <= 0 and var_420_9 or var_420_9 * (utf8.len(var_420_11) / 73)) > 0 and var_420_9 < var_420_13 then
					arg_417_1.talkMaxDuration = var_420_13

					if var_420_13 + var_420_8 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_13 + var_420_8
					end
				end

				arg_417_1.text_.text = var_420_11
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282103", "story_v_out_317282.awb") ~= 0 then
					local var_420_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282103", "story_v_out_317282.awb") / 1000

					if var_420_14 + var_420_8 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_14 + var_420_8
					end

					if var_420_10.prefab_name ~= "" and arg_417_1.actors_[var_420_10.prefab_name] ~= nil then
						local var_420_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_417_1.actors_[var_420_10.prefab_name].transform, "story_v_out_317282", "317282103", "story_v_out_317282.awb")

						arg_417_1:RecordAudio("317282103", var_420_15)
						arg_417_1:RecordAudio("317282103", var_420_15)
					else
						arg_417_1:AudioAction("play", "voice", "story_v_out_317282", "317282103", "story_v_out_317282.awb")
					end

					arg_417_1:RecordHistoryTalkVoice("story_v_out_317282", "317282103", "story_v_out_317282.awb")
				end

				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_16 = math.max(var_420_9, arg_417_1.talkMaxDuration)

			if var_420_8 <= arg_417_1.time_ and arg_417_1.time_ < var_420_8 + var_420_16 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_8) / var_420_16

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_8 + var_420_16 and arg_417_1.time_ < var_420_8 + var_420_16 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play317282104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 317282104
		arg_421_1.duration_ = 13.7

		local var_421_0 = {
			zh = 8.766,
			ja = 13.7
		}
		local var_421_1 = manager.audio:GetLocalizationFlag()

		if var_421_0[var_421_1] ~= nil then
			arg_421_1.duration_ = var_421_0[var_421_1]
		end

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play317282105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			local var_424_0 = 1

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, false)
				arg_421_1.callingController_:SetSelectedState("normal")

				local var_424_1 = arg_421_1:GetWordFromCfg(317282104)
				local var_424_2 = arg_421_1:FormatText(var_424_1.content)

				arg_421_1.text_.text = var_424_2

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_4 = 40 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 40)

				if (40 <= 0 and var_424_0 or var_424_0 * (utf8.len(var_424_2) / 40)) > 0 and var_424_0 < var_424_4 then
					arg_421_1.talkMaxDuration = var_424_4

					if var_424_4 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_4 + 0
					end
				end

				arg_421_1.text_.text = var_424_2
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282104", "story_v_out_317282.awb") ~= 0 then
					local var_424_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282104", "story_v_out_317282.awb") / 1000

					if var_424_5 + 0 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_5 + 0
					end

					if var_424_1.prefab_name ~= "" and arg_421_1.actors_[var_424_1.prefab_name] ~= nil then
						local var_424_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_421_1.actors_[var_424_1.prefab_name].transform, "story_v_out_317282", "317282104", "story_v_out_317282.awb")

						arg_421_1:RecordAudio("317282104", var_424_6)
						arg_421_1:RecordAudio("317282104", var_424_6)
					else
						arg_421_1:AudioAction("play", "voice", "story_v_out_317282", "317282104", "story_v_out_317282.awb")
					end

					arg_421_1:RecordHistoryTalkVoice("story_v_out_317282", "317282104", "story_v_out_317282.awb")
				end

				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_7 = math.max(var_424_0, arg_421_1.talkMaxDuration)

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_7 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - 0) / var_424_7

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= 0 + var_424_7 and arg_421_1.time_ < 0 + var_424_7 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {}

		arg_421_1:InitPlayNodeList()
	end,
	Play317282105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 317282105
		arg_425_1.duration_ = 15.53

		local var_425_0 = {
			zh = 15.533,
			ja = 9.666
		}
		local var_425_1 = manager.audio:GetLocalizationFlag()

		if var_425_0[var_425_1] ~= nil then
			arg_425_1.duration_ = var_425_0[var_425_1]
		end

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
		end

		function arg_425_1.playNext_(arg_427_0)
			if arg_427_0 == 1 then
				arg_425_0:Play317282106(arg_425_1)
			end
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 1.725

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, false)
				arg_425_1.callingController_:SetSelectedState("normal")

				local var_428_1 = arg_425_1:GetWordFromCfg(317282105)
				local var_428_2 = arg_425_1:FormatText(var_428_1.content)

				arg_425_1.text_.text = var_428_2

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_4 = 69 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 69)

				if (69 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_2) / 69)) > 0 and var_428_0 < var_428_4 then
					arg_425_1.talkMaxDuration = var_428_4

					if var_428_4 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_4 + 0
					end
				end

				arg_425_1.text_.text = var_428_2
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282105", "story_v_out_317282.awb") ~= 0 then
					local var_428_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282105", "story_v_out_317282.awb") / 1000

					if var_428_5 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_5 + 0
					end

					if var_428_1.prefab_name ~= "" and arg_425_1.actors_[var_428_1.prefab_name] ~= nil then
						local var_428_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_425_1.actors_[var_428_1.prefab_name].transform, "story_v_out_317282", "317282105", "story_v_out_317282.awb")

						arg_425_1:RecordAudio("317282105", var_428_6)
						arg_425_1:RecordAudio("317282105", var_428_6)
					else
						arg_425_1:AudioAction("play", "voice", "story_v_out_317282", "317282105", "story_v_out_317282.awb")
					end

					arg_425_1:RecordHistoryTalkVoice("story_v_out_317282", "317282105", "story_v_out_317282.awb")
				end

				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_7 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_7 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_7

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_7 and arg_425_1.time_ < 0 + var_428_7 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	Play317282106 = function(arg_429_0, arg_429_1)
		arg_429_1.time_ = 0
		arg_429_1.frameCnt_ = 0
		arg_429_1.state_ = "playing"
		arg_429_1.curTalkId_ = 317282106
		arg_429_1.duration_ = 6.63

		local var_429_0 = {
			zh = 5.7,
			ja = 6.633
		}
		local var_429_1 = manager.audio:GetLocalizationFlag()

		if var_429_0[var_429_1] ~= nil then
			arg_429_1.duration_ = var_429_0[var_429_1]
		end

		SetActive(arg_429_1.tipsGo_, false)

		function arg_429_1.onSingleLineFinish_()
			arg_429_1.onSingleLineUpdate_ = nil
			arg_429_1.onSingleLineFinish_ = nil
			arg_429_1.state_ = "waiting"
		end

		function arg_429_1.playNext_(arg_431_0)
			if arg_431_0 == 1 then
				arg_429_0:Play317282107(arg_429_1)
			end
		end

		function arg_429_1.onSingleLineUpdate_(arg_432_0)
			local var_432_0 = 0.75

			if 0 < arg_429_1.time_ and arg_429_1.time_ <= 0 + arg_432_0 then
				arg_429_1.talkMaxDuration = 0
				arg_429_1.dialogCg_.alpha = 1

				arg_429_1.dialog_:SetActive(true)
				SetActive(arg_429_1.leftNameGo_, true)

				arg_429_1.leftNameTxt_.text = arg_429_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_429_1.leftNameTxt_.transform)

				arg_429_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_429_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_429_1:RecordName(arg_429_1.leftNameTxt_.text)
				SetActive(arg_429_1.iconTrs_.gameObject, false)
				arg_429_1.callingController_:SetSelectedState("normal")

				local var_432_1 = arg_429_1:GetWordFromCfg(317282106)
				local var_432_2 = arg_429_1:FormatText(var_432_1.content)

				arg_429_1.text_.text = var_432_2

				LuaForUtil.ClearLinePrefixSymbol(arg_429_1.text_)

				local var_432_4 = 30 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 30)

				if (30 <= 0 and var_432_0 or var_432_0 * (utf8.len(var_432_2) / 30)) > 0 and var_432_0 < var_432_4 then
					arg_429_1.talkMaxDuration = var_432_4

					if var_432_4 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_4 + 0
					end
				end

				arg_429_1.text_.text = var_432_2
				arg_429_1.typewritter.percent = 0

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282106", "story_v_out_317282.awb") ~= 0 then
					local var_432_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282106", "story_v_out_317282.awb") / 1000

					if var_432_5 + 0 > arg_429_1.duration_ then
						arg_429_1.duration_ = var_432_5 + 0
					end

					if var_432_1.prefab_name ~= "" and arg_429_1.actors_[var_432_1.prefab_name] ~= nil then
						local var_432_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_429_1.actors_[var_432_1.prefab_name].transform, "story_v_out_317282", "317282106", "story_v_out_317282.awb")

						arg_429_1:RecordAudio("317282106", var_432_6)
						arg_429_1:RecordAudio("317282106", var_432_6)
					else
						arg_429_1:AudioAction("play", "voice", "story_v_out_317282", "317282106", "story_v_out_317282.awb")
					end

					arg_429_1:RecordHistoryTalkVoice("story_v_out_317282", "317282106", "story_v_out_317282.awb")
				end

				arg_429_1:RecordContent(arg_429_1.text_.text)
			end

			local var_432_7 = math.max(var_432_0, arg_429_1.talkMaxDuration)

			if 0 <= arg_429_1.time_ and arg_429_1.time_ < 0 + var_432_7 then
				arg_429_1.typewritter.percent = (arg_429_1.time_ - 0) / var_432_7

				arg_429_1.typewritter:SetDirty()
			end

			if arg_429_1.time_ >= 0 + var_432_7 and arg_429_1.time_ < 0 + var_432_7 + arg_432_0 then
				arg_429_1.typewritter.percent = 1

				arg_429_1.typewritter:SetDirty()
				arg_429_1:ShowNextGo(true)
			end
		end

		arg_429_1.nodeConfigList_ = {}

		arg_429_1:InitPlayNodeList()
	end,
	Play317282107 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 317282107
		arg_433_1.duration_ = 2.93

		local var_433_0 = {
			zh = 1.9,
			ja = 2.933
		}
		local var_433_1 = manager.audio:GetLocalizationFlag()

		if var_433_0[var_433_1] ~= nil then
			arg_433_1.duration_ = var_433_0[var_433_1]
		end

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play317282108(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1015ui_story = arg_433_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_436_0 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_0 then
				arg_433_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_433_1.time_ - 0) / var_436_0)
				arg_433_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1015ui_story"].transform.position).z)
				arg_433_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1015ui_story"].transform.localEulerAngles = arg_433_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_0 and arg_433_1.time_ < 0 + var_436_0 + arg_436_0 then
				arg_433_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_433_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_433_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_433_1.actors_["1015ui_story"].transform.position).z)
				arg_433_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_433_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_433_1.actors_["1015ui_story"].transform.localEulerAngles = arg_433_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_436_1 = arg_433_1.actors_["1015ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1015ui_story == nil then
				arg_433_1.var_.characterEffect1015ui_story = var_436_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_2 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_2 and not isNil(var_436_1) then
				if arg_433_1.var_.characterEffect1015ui_story and not isNil(var_436_1) then
					arg_433_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_433_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_433_1.time_ - 0) / var_436_2)
				end
			end

			if arg_433_1.time_ >= 0 + var_436_2 and arg_433_1.time_ < 0 + var_436_2 + arg_436_0 and not isNil(var_436_1) and arg_433_1.var_.characterEffect1015ui_story then
				arg_433_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_433_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_436_3 = arg_433_1.actors_["1199ui_story"].transform

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1.var_.moveOldPos1199ui_story = var_436_3.localPosition
			end

			local var_436_4 = 0.001

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_4 then
				var_436_3.localPosition = Vector3.Lerp(arg_433_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_433_1.time_ - 0) / var_436_4)
				var_436_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_436_3.position).x, (manager.ui.mainCamera.transform.position - var_436_3.position).y, (manager.ui.mainCamera.transform.position - var_436_3.position).z)
				var_436_3.localEulerAngles.z = 0
				var_436_3.localEulerAngles.x = 0
				var_436_3.localEulerAngles = var_436_3.localEulerAngles
			end

			if arg_433_1.time_ >= 0 + var_436_4 and arg_433_1.time_ < 0 + var_436_4 + arg_436_0 then
				var_436_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_436_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_436_3.position).x, (manager.ui.mainCamera.transform.position - var_436_3.position).y, (manager.ui.mainCamera.transform.position - var_436_3.position).z)
				var_436_3.localEulerAngles.z = 0
				var_436_3.localEulerAngles.x = 0
				var_436_3.localEulerAngles = var_436_3.localEulerAngles
			end

			local var_436_5 = arg_433_1.actors_["1199ui_story"]

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 and not isNil(var_436_5) and arg_433_1.var_.characterEffect1199ui_story == nil then
				arg_433_1.var_.characterEffect1199ui_story = var_436_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_436_6 = 0.200000002980232

			if 0 <= arg_433_1.time_ and arg_433_1.time_ < 0 + var_436_6 and not isNil(var_436_5) then
				if arg_433_1.var_.characterEffect1199ui_story and not isNil(var_436_5) then
					arg_433_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_433_1.time_ >= 0 + var_436_6 and arg_433_1.time_ < 0 + var_436_6 + arg_436_0 and not isNil(var_436_5) and arg_433_1.var_.characterEffect1199ui_story then
				arg_433_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action1_1")
			end

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= 0 + arg_436_0 then
				arg_433_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_436_8 = 0
			local var_436_9 = 0.25

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_8 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, true)

				arg_433_1.leftNameTxt_.text = arg_433_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_433_1.leftNameTxt_.transform)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1.leftNameTxt_.text)
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_10 = arg_433_1:GetWordFromCfg(317282107)
				local var_436_11 = arg_433_1:FormatText(var_436_10.content)

				arg_433_1.text_.text = var_436_11

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_13 = 10 <= 0 and var_436_9 or var_436_9 * (utf8.len(var_436_11) / 10)

				if (10 <= 0 and var_436_9 or var_436_9 * (utf8.len(var_436_11) / 10)) > 0 and var_436_9 < var_436_13 then
					arg_433_1.talkMaxDuration = var_436_13

					if var_436_13 + var_436_8 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_13 + var_436_8
					end
				end

				arg_433_1.text_.text = var_436_11
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282107", "story_v_out_317282.awb") ~= 0 then
					local var_436_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282107", "story_v_out_317282.awb") / 1000

					if var_436_14 + var_436_8 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_14 + var_436_8
					end

					if var_436_10.prefab_name ~= "" and arg_433_1.actors_[var_436_10.prefab_name] ~= nil then
						local var_436_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_433_1.actors_[var_436_10.prefab_name].transform, "story_v_out_317282", "317282107", "story_v_out_317282.awb")

						arg_433_1:RecordAudio("317282107", var_436_15)
						arg_433_1:RecordAudio("317282107", var_436_15)
					else
						arg_433_1:AudioAction("play", "voice", "story_v_out_317282", "317282107", "story_v_out_317282.awb")
					end

					arg_433_1:RecordHistoryTalkVoice("story_v_out_317282", "317282107", "story_v_out_317282.awb")
				end

				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_16 = math.max(var_436_9, arg_433_1.talkMaxDuration)

			if var_436_8 <= arg_433_1.time_ and arg_433_1.time_ < var_436_8 + var_436_16 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_8) / var_436_16

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_8 + var_436_16 and arg_433_1.time_ < var_436_8 + var_436_16 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_433_1:InitPlayNodeList()
	end,
	Play317282108 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 317282108
		arg_437_1.duration_ = 8.6

		local var_437_0 = {
			zh = 5.5,
			ja = 8.6
		}
		local var_437_1 = manager.audio:GetLocalizationFlag()

		if var_437_0[var_437_1] ~= nil then
			arg_437_1.duration_ = var_437_0[var_437_1]
		end

		SetActive(arg_437_1.tipsGo_, false)

		function arg_437_1.onSingleLineFinish_()
			arg_437_1.onSingleLineUpdate_ = nil
			arg_437_1.onSingleLineFinish_ = nil
			arg_437_1.state_ = "waiting"
		end

		function arg_437_1.playNext_(arg_439_0)
			if arg_439_0 == 1 then
				arg_437_0:Play317282109(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1015ui_story = arg_437_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_440_0 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 then
				arg_437_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_437_1.time_ - 0) / var_440_0)
				arg_437_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1015ui_story"].transform.position).z)
				arg_437_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1015ui_story"].transform.localEulerAngles = arg_437_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 then
				arg_437_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_437_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_437_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_437_1.actors_["1015ui_story"].transform.position).z)
				arg_437_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_437_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_437_1.actors_["1015ui_story"].transform.localEulerAngles = arg_437_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_440_1 = arg_437_1.actors_["1015ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1015ui_story == nil then
				arg_437_1.var_.characterEffect1015ui_story = var_440_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_2 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_2 and not isNil(var_440_1) then
				if arg_437_1.var_.characterEffect1015ui_story and not isNil(var_440_1) then
					arg_437_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_437_1.time_ >= 0 + var_440_2 and arg_437_1.time_ < 0 + var_440_2 + arg_440_0 and not isNil(var_440_1) and arg_437_1.var_.characterEffect1015ui_story then
				arg_437_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_440_4 = arg_437_1.actors_["1199ui_story"].transform

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos1199ui_story = var_440_4.localPosition
			end

			local var_440_5 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_5 then
				var_440_4.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_437_1.time_ - 0) / var_440_5)
				var_440_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_440_4.position).x, (manager.ui.mainCamera.transform.position - var_440_4.position).y, (manager.ui.mainCamera.transform.position - var_440_4.position).z)
				var_440_4.localEulerAngles.z = 0
				var_440_4.localEulerAngles.x = 0
				var_440_4.localEulerAngles = var_440_4.localEulerAngles
			end

			if arg_437_1.time_ >= 0 + var_440_5 and arg_437_1.time_ < 0 + var_440_5 + arg_440_0 then
				var_440_4.localPosition = Vector3.New(0, 100, 0)
				var_440_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_440_4.position).x, (manager.ui.mainCamera.transform.position - var_440_4.position).y, (manager.ui.mainCamera.transform.position - var_440_4.position).z)
				var_440_4.localEulerAngles.z = 0
				var_440_4.localEulerAngles.x = 0
				var_440_4.localEulerAngles = var_440_4.localEulerAngles
			end

			local var_440_6 = arg_437_1.actors_["1199ui_story"]

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(var_440_6) and arg_437_1.var_.characterEffect1199ui_story == nil then
				arg_437_1.var_.characterEffect1199ui_story = var_440_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_440_7 = 0.200000002980232

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_7 and not isNil(var_440_6) then
				if arg_437_1.var_.characterEffect1199ui_story and not isNil(var_440_6) then
					arg_437_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_437_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_437_1.time_ - 0) / var_440_7)
				end
			end

			if arg_437_1.time_ >= 0 + var_440_7 and arg_437_1.time_ < 0 + var_440_7 + arg_440_0 and not isNil(var_440_6) and arg_437_1.var_.characterEffect1199ui_story then
				arg_437_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_437_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_440_8 = 0
			local var_440_9 = 0.65

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_8 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_10 = arg_437_1:GetWordFromCfg(317282108)
				local var_440_11 = arg_437_1:FormatText(var_440_10.content)

				arg_437_1.text_.text = var_440_11

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_13 = 26 <= 0 and var_440_9 or var_440_9 * (utf8.len(var_440_11) / 26)

				if (26 <= 0 and var_440_9 or var_440_9 * (utf8.len(var_440_11) / 26)) > 0 and var_440_9 < var_440_13 then
					arg_437_1.talkMaxDuration = var_440_13

					if var_440_13 + var_440_8 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_13 + var_440_8
					end
				end

				arg_437_1.text_.text = var_440_11
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282108", "story_v_out_317282.awb") ~= 0 then
					local var_440_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282108", "story_v_out_317282.awb") / 1000

					if var_440_14 + var_440_8 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_14 + var_440_8
					end

					if var_440_10.prefab_name ~= "" and arg_437_1.actors_[var_440_10.prefab_name] ~= nil then
						local var_440_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_10.prefab_name].transform, "story_v_out_317282", "317282108", "story_v_out_317282.awb")

						arg_437_1:RecordAudio("317282108", var_440_15)
						arg_437_1:RecordAudio("317282108", var_440_15)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_317282", "317282108", "story_v_out_317282.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_317282", "317282108", "story_v_out_317282.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_16 = math.max(var_440_9, arg_437_1.talkMaxDuration)

			if var_440_8 <= arg_437_1.time_ and arg_437_1.time_ < var_440_8 + var_440_16 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_8) / var_440_16

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_8 + var_440_16 and arg_437_1.time_ < var_440_8 + var_440_16 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_437_1:InitPlayNodeList()
	end,
	Play317282109 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 317282109
		arg_441_1.duration_ = 9.2

		local var_441_0 = {
			zh = 9.2,
			ja = 4.833
		}
		local var_441_1 = manager.audio:GetLocalizationFlag()

		if var_441_0[var_441_1] ~= nil then
			arg_441_1.duration_ = var_441_0[var_441_1]
		end

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play317282110(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			local var_444_0 = 1.125

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, false)
				arg_441_1.callingController_:SetSelectedState("normal")

				local var_444_1 = arg_441_1:GetWordFromCfg(317282109)
				local var_444_2 = arg_441_1:FormatText(var_444_1.content)

				arg_441_1.text_.text = var_444_2

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_4 = 45 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 45)

				if (45 <= 0 and var_444_0 or var_444_0 * (utf8.len(var_444_2) / 45)) > 0 and var_444_0 < var_444_4 then
					arg_441_1.talkMaxDuration = var_444_4

					if var_444_4 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_4 + 0
					end
				end

				arg_441_1.text_.text = var_444_2
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282109", "story_v_out_317282.awb") ~= 0 then
					local var_444_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282109", "story_v_out_317282.awb") / 1000

					if var_444_5 + 0 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_5 + 0
					end

					if var_444_1.prefab_name ~= "" and arg_441_1.actors_[var_444_1.prefab_name] ~= nil then
						local var_444_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_441_1.actors_[var_444_1.prefab_name].transform, "story_v_out_317282", "317282109", "story_v_out_317282.awb")

						arg_441_1:RecordAudio("317282109", var_444_6)
						arg_441_1:RecordAudio("317282109", var_444_6)
					else
						arg_441_1:AudioAction("play", "voice", "story_v_out_317282", "317282109", "story_v_out_317282.awb")
					end

					arg_441_1:RecordHistoryTalkVoice("story_v_out_317282", "317282109", "story_v_out_317282.awb")
				end

				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_0, arg_441_1.talkMaxDuration)

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - 0) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= 0 + var_444_7 and arg_441_1.time_ < 0 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play317282110 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 317282110
		arg_445_1.duration_ = 8.07

		local var_445_0 = {
			zh = 8.066,
			ja = 6.866
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play317282111(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			local var_448_0 = 1.075

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_1 = arg_445_1:GetWordFromCfg(317282110)
				local var_448_2 = arg_445_1:FormatText(var_448_1.content)

				arg_445_1.text_.text = var_448_2

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_4 = 43 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 43)

				if (43 <= 0 and var_448_0 or var_448_0 * (utf8.len(var_448_2) / 43)) > 0 and var_448_0 < var_448_4 then
					arg_445_1.talkMaxDuration = var_448_4

					if var_448_4 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_4 + 0
					end
				end

				arg_445_1.text_.text = var_448_2
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282110", "story_v_out_317282.awb") ~= 0 then
					local var_448_5 = manager.audio:GetVoiceLength("story_v_out_317282", "317282110", "story_v_out_317282.awb") / 1000

					if var_448_5 + 0 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_5 + 0
					end

					if var_448_1.prefab_name ~= "" and arg_445_1.actors_[var_448_1.prefab_name] ~= nil then
						local var_448_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_1.prefab_name].transform, "story_v_out_317282", "317282110", "story_v_out_317282.awb")

						arg_445_1:RecordAudio("317282110", var_448_6)
						arg_445_1:RecordAudio("317282110", var_448_6)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_317282", "317282110", "story_v_out_317282.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_317282", "317282110", "story_v_out_317282.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_7 = math.max(var_448_0, arg_445_1.talkMaxDuration)

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_7 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - 0) / var_448_7

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= 0 + var_448_7 and arg_445_1.time_ < 0 + var_448_7 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play317282111 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 317282111
		arg_449_1.duration_ = 7.23

		local var_449_0 = {
			zh = 4.7,
			ja = 7.233
		}
		local var_449_1 = manager.audio:GetLocalizationFlag()

		if var_449_0[var_449_1] ~= nil then
			arg_449_1.duration_ = var_449_0[var_449_1]
		end

		SetActive(arg_449_1.tipsGo_, false)

		function arg_449_1.onSingleLineFinish_()
			arg_449_1.onSingleLineUpdate_ = nil
			arg_449_1.onSingleLineFinish_ = nil
			arg_449_1.state_ = "waiting"
		end

		function arg_449_1.playNext_(arg_451_0)
			if arg_451_0 == 1 then
				arg_449_0:Play317282112(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1015ui_story = arg_449_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_452_0 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_0 then
				arg_449_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_449_1.time_ - 0) / var_452_0)
				arg_449_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1015ui_story"].transform.position).z)
				arg_449_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1015ui_story"].transform.localEulerAngles = arg_449_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_0 and arg_449_1.time_ < 0 + var_452_0 + arg_452_0 then
				arg_449_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_449_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_449_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_449_1.actors_["1015ui_story"].transform.position).z)
				arg_449_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_449_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_449_1.actors_["1015ui_story"].transform.localEulerAngles = arg_449_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_452_1 = arg_449_1.actors_["1015ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1015ui_story == nil then
				arg_449_1.var_.characterEffect1015ui_story = var_452_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_2 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_2 and not isNil(var_452_1) then
				if arg_449_1.var_.characterEffect1015ui_story and not isNil(var_452_1) then
					arg_449_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_449_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_449_1.time_ - 0) / var_452_2)
				end
			end

			if arg_449_1.time_ >= 0 + var_452_2 and arg_449_1.time_ < 0 + var_452_2 + arg_452_0 and not isNil(var_452_1) and arg_449_1.var_.characterEffect1015ui_story then
				arg_449_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_449_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_452_3 = arg_449_1.actors_["1199ui_story"].transform

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.var_.moveOldPos1199ui_story = var_452_3.localPosition
			end

			local var_452_4 = 0.001

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_4 then
				var_452_3.localPosition = Vector3.Lerp(arg_449_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_449_1.time_ - 0) / var_452_4)
				var_452_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_3.position).x, (manager.ui.mainCamera.transform.position - var_452_3.position).y, (manager.ui.mainCamera.transform.position - var_452_3.position).z)
				var_452_3.localEulerAngles.z = 0
				var_452_3.localEulerAngles.x = 0
				var_452_3.localEulerAngles = var_452_3.localEulerAngles
			end

			if arg_449_1.time_ >= 0 + var_452_4 and arg_449_1.time_ < 0 + var_452_4 + arg_452_0 then
				var_452_3.localPosition = Vector3.New(0, -1.08, -5.9)
				var_452_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_452_3.position).x, (manager.ui.mainCamera.transform.position - var_452_3.position).y, (manager.ui.mainCamera.transform.position - var_452_3.position).z)
				var_452_3.localEulerAngles.z = 0
				var_452_3.localEulerAngles.x = 0
				var_452_3.localEulerAngles = var_452_3.localEulerAngles
			end

			local var_452_5 = arg_449_1.actors_["1199ui_story"]

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 and not isNil(var_452_5) and arg_449_1.var_.characterEffect1199ui_story == nil then
				arg_449_1.var_.characterEffect1199ui_story = var_452_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_452_6 = 0.200000002980232

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_6 and not isNil(var_452_5) then
				if arg_449_1.var_.characterEffect1199ui_story and not isNil(var_452_5) then
					arg_449_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_449_1.time_ >= 0 + var_452_6 and arg_449_1.time_ < 0 + var_452_6 + arg_452_0 and not isNil(var_452_5) and arg_449_1.var_.characterEffect1199ui_story then
				arg_449_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action4_1")
			end

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_452_8 = 0
			local var_452_9 = 0.65

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= var_452_8 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_10 = arg_449_1:GetWordFromCfg(317282111)
				local var_452_11 = arg_449_1:FormatText(var_452_10.content)

				arg_449_1.text_.text = var_452_11

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_13 = 26 <= 0 and var_452_9 or var_452_9 * (utf8.len(var_452_11) / 26)

				if (26 <= 0 and var_452_9 or var_452_9 * (utf8.len(var_452_11) / 26)) > 0 and var_452_9 < var_452_13 then
					arg_449_1.talkMaxDuration = var_452_13

					if var_452_13 + var_452_8 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_13 + var_452_8
					end
				end

				arg_449_1.text_.text = var_452_11
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282111", "story_v_out_317282.awb") ~= 0 then
					local var_452_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282111", "story_v_out_317282.awb") / 1000

					if var_452_14 + var_452_8 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_14 + var_452_8
					end

					if var_452_10.prefab_name ~= "" and arg_449_1.actors_[var_452_10.prefab_name] ~= nil then
						local var_452_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_10.prefab_name].transform, "story_v_out_317282", "317282111", "story_v_out_317282.awb")

						arg_449_1:RecordAudio("317282111", var_452_15)
						arg_449_1:RecordAudio("317282111", var_452_15)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_317282", "317282111", "story_v_out_317282.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_317282", "317282111", "story_v_out_317282.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_16 = math.max(var_452_9, arg_449_1.talkMaxDuration)

			if var_452_8 <= arg_449_1.time_ and arg_449_1.time_ < var_452_8 + var_452_16 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - var_452_8) / var_452_16

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= var_452_8 + var_452_16 and arg_449_1.time_ < var_452_8 + var_452_16 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_449_1:InitPlayNodeList()
	end,
	Play317282112 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 317282112
		arg_453_1.duration_ = 8.8

		local var_453_0 = {
			zh = 5.3,
			ja = 8.8
		}
		local var_453_1 = manager.audio:GetLocalizationFlag()

		if var_453_0[var_453_1] ~= nil then
			arg_453_1.duration_ = var_453_0[var_453_1]
		end

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play317282113(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1015ui_story = arg_453_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_456_0 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 then
				arg_453_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_453_1.time_ - 0) / var_456_0)
				arg_453_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1015ui_story"].transform.position).z)
				arg_453_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1015ui_story"].transform.localEulerAngles = arg_453_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 then
				arg_453_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_453_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_453_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_453_1.actors_["1015ui_story"].transform.position).z)
				arg_453_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_453_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_453_1.actors_["1015ui_story"].transform.localEulerAngles = arg_453_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_456_1 = arg_453_1.actors_["1015ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1015ui_story == nil then
				arg_453_1.var_.characterEffect1015ui_story = var_456_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_2 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_2 and not isNil(var_456_1) then
				if arg_453_1.var_.characterEffect1015ui_story and not isNil(var_456_1) then
					arg_453_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_453_1.time_ >= 0 + var_456_2 and arg_453_1.time_ < 0 + var_456_2 + arg_456_0 and not isNil(var_456_1) and arg_453_1.var_.characterEffect1015ui_story then
				arg_453_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_456_4 = arg_453_1.actors_["1199ui_story"].transform

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 then
				arg_453_1.var_.moveOldPos1199ui_story = var_456_4.localPosition
			end

			local var_456_5 = 0.001

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_5 then
				var_456_4.localPosition = Vector3.Lerp(arg_453_1.var_.moveOldPos1199ui_story, Vector3.New(0, 100, 0), (arg_453_1.time_ - 0) / var_456_5)
				var_456_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_456_4.position).x, (manager.ui.mainCamera.transform.position - var_456_4.position).y, (manager.ui.mainCamera.transform.position - var_456_4.position).z)
				var_456_4.localEulerAngles.z = 0
				var_456_4.localEulerAngles.x = 0
				var_456_4.localEulerAngles = var_456_4.localEulerAngles
			end

			if arg_453_1.time_ >= 0 + var_456_5 and arg_453_1.time_ < 0 + var_456_5 + arg_456_0 then
				var_456_4.localPosition = Vector3.New(0, 100, 0)
				var_456_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_456_4.position).x, (manager.ui.mainCamera.transform.position - var_456_4.position).y, (manager.ui.mainCamera.transform.position - var_456_4.position).z)
				var_456_4.localEulerAngles.z = 0
				var_456_4.localEulerAngles.x = 0
				var_456_4.localEulerAngles = var_456_4.localEulerAngles
			end

			local var_456_6 = arg_453_1.actors_["1199ui_story"]

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(var_456_6) and arg_453_1.var_.characterEffect1199ui_story == nil then
				arg_453_1.var_.characterEffect1199ui_story = var_456_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_456_7 = 0.200000002980232

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_7 and not isNil(var_456_6) then
				if arg_453_1.var_.characterEffect1199ui_story and not isNil(var_456_6) then
					arg_453_1.var_.characterEffect1199ui_story.fillFlat = true
					arg_453_1.var_.characterEffect1199ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_453_1.time_ - 0) / var_456_7)
				end
			end

			if arg_453_1.time_ >= 0 + var_456_7 and arg_453_1.time_ < 0 + var_456_7 + arg_456_0 and not isNil(var_456_6) and arg_453_1.var_.characterEffect1199ui_story then
				arg_453_1.var_.characterEffect1199ui_story.fillFlat = true
				arg_453_1.var_.characterEffect1199ui_story.fillRatio = 0.5
			end

			local var_456_8 = 0
			local var_456_9 = 0.7

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_8 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, false)
				arg_453_1.callingController_:SetSelectedState("normal")

				local var_456_10 = arg_453_1:GetWordFromCfg(317282112)
				local var_456_11 = arg_453_1:FormatText(var_456_10.content)

				arg_453_1.text_.text = var_456_11

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_13 = 28 <= 0 and var_456_9 or var_456_9 * (utf8.len(var_456_11) / 28)

				if (28 <= 0 and var_456_9 or var_456_9 * (utf8.len(var_456_11) / 28)) > 0 and var_456_9 < var_456_13 then
					arg_453_1.talkMaxDuration = var_456_13

					if var_456_13 + var_456_8 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_13 + var_456_8
					end
				end

				arg_453_1.text_.text = var_456_11
				arg_453_1.typewritter.percent = 0

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282112", "story_v_out_317282.awb") ~= 0 then
					local var_456_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282112", "story_v_out_317282.awb") / 1000

					if var_456_14 + var_456_8 > arg_453_1.duration_ then
						arg_453_1.duration_ = var_456_14 + var_456_8
					end

					if var_456_10.prefab_name ~= "" and arg_453_1.actors_[var_456_10.prefab_name] ~= nil then
						local var_456_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_453_1.actors_[var_456_10.prefab_name].transform, "story_v_out_317282", "317282112", "story_v_out_317282.awb")

						arg_453_1:RecordAudio("317282112", var_456_15)
						arg_453_1:RecordAudio("317282112", var_456_15)
					else
						arg_453_1:AudioAction("play", "voice", "story_v_out_317282", "317282112", "story_v_out_317282.awb")
					end

					arg_453_1:RecordHistoryTalkVoice("story_v_out_317282", "317282112", "story_v_out_317282.awb")
				end

				arg_453_1:RecordContent(arg_453_1.text_.text)
			end

			local var_456_16 = math.max(var_456_9, arg_453_1.talkMaxDuration)

			if var_456_8 <= arg_453_1.time_ and arg_453_1.time_ < var_456_8 + var_456_16 then
				arg_453_1.typewritter.percent = (arg_453_1.time_ - var_456_8) / var_456_16

				arg_453_1.typewritter:SetDirty()
			end

			if arg_453_1.time_ >= var_456_8 + var_456_16 and arg_453_1.time_ < var_456_8 + var_456_16 + arg_456_0 then
				arg_453_1.typewritter.percent = 1

				arg_453_1.typewritter:SetDirty()
				arg_453_1:ShowNextGo(true)
			end
		end

		arg_453_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_453_1:InitPlayNodeList()
	end,
	Play317282113 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 317282113
		arg_457_1.duration_ = 5

		SetActive(arg_457_1.tipsGo_, false)

		function arg_457_1.onSingleLineFinish_()
			arg_457_1.onSingleLineUpdate_ = nil
			arg_457_1.onSingleLineFinish_ = nil
			arg_457_1.state_ = "waiting"
		end

		function arg_457_1.playNext_(arg_459_0)
			if arg_459_0 == 1 then
				arg_457_0:Play317282114(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["1015ui_story"]) and arg_457_1.var_.characterEffect1015ui_story == nil then
				arg_457_1.var_.characterEffect1015ui_story = arg_457_1.actors_["1015ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_460_0 = 0.200000002980232

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["1015ui_story"]) then
				if arg_457_1.var_.characterEffect1015ui_story and not isNil(arg_457_1.actors_["1015ui_story"]) then
					arg_457_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_457_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_457_1.time_ - 0) / var_460_0)
				end
			end

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["1015ui_story"]) and arg_457_1.var_.characterEffect1015ui_story then
				arg_457_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_457_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			local var_460_1 = 0
			local var_460_2 = 0.65

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_1 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, true)
				arg_457_1.iconController_:SetSelectedState("hero")

				arg_457_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_457_1.callingController_:SetSelectedState("normal")

				arg_457_1.keyicon_.color = Color.New(1, 1, 1)
				arg_457_1.icon_.color = Color.New(1, 1, 1)

				local var_460_3 = arg_457_1:FormatText(arg_457_1:GetWordFromCfg(317282113).content)

				arg_457_1.text_.text = var_460_3

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_5 = 26 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 26)

				if (26 <= 0 and var_460_2 or var_460_2 * (utf8.len(var_460_3) / 26)) > 0 and var_460_2 < var_460_5 then
					arg_457_1.talkMaxDuration = var_460_5

					if var_460_5 + var_460_1 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_5 + var_460_1
					end
				end

				arg_457_1.text_.text = var_460_3
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)
				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_6 = math.max(var_460_2, arg_457_1.talkMaxDuration)

			if var_460_1 <= arg_457_1.time_ and arg_457_1.time_ < var_460_1 + var_460_6 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_1) / var_460_6

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_1 + var_460_6 and arg_457_1.time_ < var_460_1 + var_460_6 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {}

		arg_457_1:InitPlayNodeList()
	end,
	Play317282114 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 317282114
		arg_461_1.duration_ = 7.1

		local var_461_0 = {
			zh = 7.1,
			ja = 5.166
		}
		local var_461_1 = manager.audio:GetLocalizationFlag()

		if var_461_0[var_461_1] ~= nil then
			arg_461_1.duration_ = var_461_0[var_461_1]
		end

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play317282115(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos1015ui_story = arg_461_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_464_0 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 then
				arg_461_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_461_1.time_ - 0) / var_464_0)
				arg_461_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1015ui_story"].transform.position).z)
				arg_461_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1015ui_story"].transform.localEulerAngles = arg_461_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 then
				arg_461_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_461_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_461_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_461_1.actors_["1015ui_story"].transform.position).z)
				arg_461_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_461_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_461_1.actors_["1015ui_story"].transform.localEulerAngles = arg_461_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_464_1 = arg_461_1.actors_["1015ui_story"]

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1015ui_story == nil then
				arg_461_1.var_.characterEffect1015ui_story = var_464_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_464_2 = 0.200000002980232

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_2 and not isNil(var_464_1) then
				if arg_461_1.var_.characterEffect1015ui_story and not isNil(var_464_1) then
					arg_461_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_461_1.time_ >= 0 + var_464_2 and arg_461_1.time_ < 0 + var_464_2 + arg_464_0 and not isNil(var_464_1) and arg_461_1.var_.characterEffect1015ui_story then
				arg_461_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_464_4 = 0
			local var_464_5 = 0.925

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_4 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, true)

				arg_461_1.leftNameTxt_.text = arg_461_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_461_1.leftNameTxt_.transform)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1.leftNameTxt_.text)
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_6 = arg_461_1:GetWordFromCfg(317282114)
				local var_464_7 = arg_461_1:FormatText(var_464_6.content)

				arg_461_1.text_.text = var_464_7

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_9 = 37 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 37)

				if (37 <= 0 and var_464_5 or var_464_5 * (utf8.len(var_464_7) / 37)) > 0 and var_464_5 < var_464_9 then
					arg_461_1.talkMaxDuration = var_464_9

					if var_464_9 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_9 + var_464_4
					end
				end

				arg_461_1.text_.text = var_464_7
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282114", "story_v_out_317282.awb") ~= 0 then
					local var_464_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282114", "story_v_out_317282.awb") / 1000

					if var_464_10 + var_464_4 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_10 + var_464_4
					end

					if var_464_6.prefab_name ~= "" and arg_461_1.actors_[var_464_6.prefab_name] ~= nil then
						local var_464_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_461_1.actors_[var_464_6.prefab_name].transform, "story_v_out_317282", "317282114", "story_v_out_317282.awb")

						arg_461_1:RecordAudio("317282114", var_464_11)
						arg_461_1:RecordAudio("317282114", var_464_11)
					else
						arg_461_1:AudioAction("play", "voice", "story_v_out_317282", "317282114", "story_v_out_317282.awb")
					end

					arg_461_1:RecordHistoryTalkVoice("story_v_out_317282", "317282114", "story_v_out_317282.awb")
				end

				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_12 = math.max(var_464_5, arg_461_1.talkMaxDuration)

			if var_464_4 <= arg_461_1.time_ and arg_461_1.time_ < var_464_4 + var_464_12 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_4) / var_464_12

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_4 + var_464_12 and arg_461_1.time_ < var_464_4 + var_464_12 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_461_1:InitPlayNodeList()
	end,
	Play317282115 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 317282115
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play317282116(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1.var_.moveOldPos1015ui_story = arg_465_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_468_0 = 0.001

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_0 then
				arg_465_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_465_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_465_1.time_ - 0) / var_468_0)
				arg_465_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1015ui_story"].transform.position).z)
				arg_465_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1015ui_story"].transform.localEulerAngles = arg_465_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_465_1.time_ >= 0 + var_468_0 and arg_465_1.time_ < 0 + var_468_0 + arg_468_0 then
				arg_465_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_465_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_465_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_465_1.actors_["1015ui_story"].transform.position).z)
				arg_465_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_465_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_465_1.actors_["1015ui_story"].transform.localEulerAngles = arg_465_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_468_1 = arg_465_1.actors_["1015ui_story"]

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1015ui_story == nil then
				arg_465_1.var_.characterEffect1015ui_story = var_468_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_468_2 = 0.200000002980232

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_2 and not isNil(var_468_1) then
				if arg_465_1.var_.characterEffect1015ui_story and not isNil(var_468_1) then
					arg_465_1.var_.characterEffect1015ui_story.fillFlat = true
					arg_465_1.var_.characterEffect1015ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_465_1.time_ - 0) / var_468_2)
				end
			end

			if arg_465_1.time_ >= 0 + var_468_2 and arg_465_1.time_ < 0 + var_468_2 + arg_468_0 and not isNil(var_468_1) and arg_465_1.var_.characterEffect1015ui_story then
				arg_465_1.var_.characterEffect1015ui_story.fillFlat = true
				arg_465_1.var_.characterEffect1015ui_story.fillRatio = 0.5
			end

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
				arg_465_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_468_4 = 0
			local var_468_5 = 0.725

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= var_468_4 + arg_468_0 then
				arg_465_1.talkMaxDuration = 0
				arg_465_1.dialogCg_.alpha = 1

				arg_465_1.dialog_:SetActive(true)
				SetActive(arg_465_1.leftNameGo_, false)

				arg_465_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_465_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_465_1:RecordName(arg_465_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_465_1.iconTrs_.gameObject, false)
				arg_465_1.callingController_:SetSelectedState("normal")

				local var_468_6 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(317282115).content)

				arg_465_1.text_.text = var_468_6

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_8 = 29 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_6) / 29)

				if (29 <= 0 and var_468_5 or var_468_5 * (utf8.len(var_468_6) / 29)) > 0 and var_468_5 < var_468_8 then
					arg_465_1.talkMaxDuration = var_468_8

					if var_468_8 + var_468_4 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_8 + var_468_4
					end
				end

				arg_465_1.text_.text = var_468_6
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_9 = math.max(var_468_5, arg_465_1.talkMaxDuration)

			if var_468_4 <= arg_465_1.time_ and arg_465_1.time_ < var_468_4 + var_468_9 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - var_468_4) / var_468_9

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= var_468_4 + var_468_9 and arg_465_1.time_ < var_468_4 + var_468_9 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_465_1:InitPlayNodeList()
	end,
	Play317282116 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 317282116
		arg_469_1.duration_ = 1.93

		local var_469_0 = {
			zh = 1.9,
			ja = 1.933
		}
		local var_469_1 = manager.audio:GetLocalizationFlag()

		if var_469_0[var_469_1] ~= nil then
			arg_469_1.duration_ = var_469_0[var_469_1]
		end

		SetActive(arg_469_1.tipsGo_, false)

		function arg_469_1.onSingleLineFinish_()
			arg_469_1.onSingleLineUpdate_ = nil
			arg_469_1.onSingleLineFinish_ = nil
			arg_469_1.state_ = "waiting"
		end

		function arg_469_1.playNext_(arg_471_0)
			if arg_471_0 == 1 then
				arg_469_0:Play317282117(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos2078ui_story = arg_469_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_472_0 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 then
				arg_469_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos2078ui_story, Vector3.New(-0.7, -1.28, -5.6), (arg_469_1.time_ - 0) / var_472_0)
				arg_469_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["2078ui_story"].transform.position).z)
				arg_469_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["2078ui_story"].transform.localEulerAngles = arg_469_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 then
				arg_469_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				arg_469_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_469_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_469_1.actors_["2078ui_story"].transform.position).z)
				arg_469_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_469_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_469_1.actors_["2078ui_story"].transform.localEulerAngles = arg_469_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			local var_472_1 = arg_469_1.actors_["2078ui_story"]

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect2078ui_story == nil then
				arg_469_1.var_.characterEffect2078ui_story = var_472_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_472_2 = 0.200000002980232

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_2 and not isNil(var_472_1) then
				if arg_469_1.var_.characterEffect2078ui_story and not isNil(var_472_1) then
					arg_469_1.var_.characterEffect2078ui_story.fillFlat = false
				end
			end

			if arg_469_1.time_ >= 0 + var_472_2 and arg_469_1.time_ < 0 + var_472_2 + arg_472_0 and not isNil(var_472_1) and arg_469_1.var_.characterEffect2078ui_story then
				arg_469_1.var_.characterEffect2078ui_story.fillFlat = false
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/story2078/story2078ction/2078action1_1")
			end

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1:PlayTimeline("2078ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_472_4 = 0
			local var_472_5 = 0.25

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_4 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[528].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_6 = arg_469_1:GetWordFromCfg(317282116)
				local var_472_7 = arg_469_1:FormatText(var_472_6.content)

				arg_469_1.text_.text = var_472_7

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_9 = 10 <= 0 and var_472_5 or var_472_5 * (utf8.len(var_472_7) / 10)

				if (10 <= 0 and var_472_5 or var_472_5 * (utf8.len(var_472_7) / 10)) > 0 and var_472_5 < var_472_9 then
					arg_469_1.talkMaxDuration = var_472_9

					if var_472_9 + var_472_4 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_9 + var_472_4
					end
				end

				arg_469_1.text_.text = var_472_7
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282116", "story_v_out_317282.awb") ~= 0 then
					local var_472_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282116", "story_v_out_317282.awb") / 1000

					if var_472_10 + var_472_4 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_10 + var_472_4
					end

					if var_472_6.prefab_name ~= "" and arg_469_1.actors_[var_472_6.prefab_name] ~= nil then
						local var_472_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_6.prefab_name].transform, "story_v_out_317282", "317282116", "story_v_out_317282.awb")

						arg_469_1:RecordAudio("317282116", var_472_11)
						arg_469_1:RecordAudio("317282116", var_472_11)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_317282", "317282116", "story_v_out_317282.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_317282", "317282116", "story_v_out_317282.awb")
				end

				arg_469_1:RecordContent(arg_469_1.text_.text)
			end

			local var_472_12 = math.max(var_472_5, arg_469_1.talkMaxDuration)

			if var_472_4 <= arg_469_1.time_ and arg_469_1.time_ < var_472_4 + var_472_12 then
				arg_469_1.typewritter.percent = (arg_469_1.time_ - var_472_4) / var_472_12

				arg_469_1.typewritter:SetDirty()
			end

			if arg_469_1.time_ >= var_472_4 + var_472_12 and arg_469_1.time_ < var_472_4 + var_472_12 + arg_472_0 then
				arg_469_1.typewritter.percent = 1

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(true)
			end
		end

		arg_469_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_469_1:InitPlayNodeList()
	end,
	Play317282117 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 317282117
		arg_473_1.duration_ = 5.5

		SetActive(arg_473_1.tipsGo_, false)

		function arg_473_1.onSingleLineFinish_()
			arg_473_1.onSingleLineUpdate_ = nil
			arg_473_1.onSingleLineFinish_ = nil
			arg_473_1.state_ = "waiting"
		end

		function arg_473_1.playNext_(arg_475_0)
			if arg_475_0 == 1 then
				arg_473_0:Play317282118(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.var_.moveOldPos2079ui_story = arg_473_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_476_0 = 0.001

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_0 then
				arg_473_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_473_1.var_.moveOldPos2079ui_story, Vector3.New(0.7, -1.28, -5.6), (arg_473_1.time_ - 0) / var_476_0)
				arg_473_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["2079ui_story"].transform.position).z)
				arg_473_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["2079ui_story"].transform.localEulerAngles = arg_473_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_473_1.time_ >= 0 + var_476_0 and arg_473_1.time_ < 0 + var_476_0 + arg_476_0 then
				arg_473_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0.7, -1.28, -5.6)
				arg_473_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_473_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_473_1.actors_["2079ui_story"].transform.position).z)
				arg_473_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_473_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_473_1.actors_["2079ui_story"].transform.localEulerAngles = arg_473_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_476_1 = arg_473_1.actors_["2079ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect2079ui_story == nil then
				arg_473_1.var_.characterEffect2079ui_story = var_476_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_2 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_2 and not isNil(var_476_1) then
				if arg_473_1.var_.characterEffect2079ui_story and not isNil(var_476_1) then
					arg_473_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_473_1.time_ >= 0 + var_476_2 and arg_473_1.time_ < 0 + var_476_2 + arg_476_0 and not isNil(var_476_1) and arg_473_1.var_.characterEffect2079ui_story then
				arg_473_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_476_4 = arg_473_1.actors_["2078ui_story"]

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 and not isNil(var_476_4) and arg_473_1.var_.characterEffect2078ui_story == nil then
				arg_473_1.var_.characterEffect2078ui_story = var_476_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_476_5 = 0.200000002980232

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_5 and not isNil(var_476_4) then
				if arg_473_1.var_.characterEffect2078ui_story and not isNil(var_476_4) then
					arg_473_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_473_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_473_1.time_ - 0) / var_476_5)
				end
			end

			if arg_473_1.time_ >= 0 + var_476_5 and arg_473_1.time_ < 0 + var_476_5 + arg_476_0 and not isNil(var_476_4) and arg_473_1.var_.characterEffect2078ui_story then
				arg_473_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_473_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_476_6 = 0
			local var_476_7 = 0.35

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= var_476_6 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[529].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_8 = arg_473_1:GetWordFromCfg(317282117)
				local var_476_9 = arg_473_1:FormatText(var_476_8.content)

				arg_473_1.text_.text = var_476_9

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_11 = 14 <= 0 and var_476_7 or var_476_7 * (utf8.len(var_476_9) / 14)

				if (14 <= 0 and var_476_7 or var_476_7 * (utf8.len(var_476_9) / 14)) > 0 and var_476_7 < var_476_11 then
					arg_473_1.talkMaxDuration = var_476_11

					if var_476_11 + var_476_6 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_11 + var_476_6
					end
				end

				arg_473_1.text_.text = var_476_9
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282117", "story_v_out_317282.awb") ~= 0 then
					local var_476_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282117", "story_v_out_317282.awb") / 1000

					if var_476_12 + var_476_6 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_12 + var_476_6
					end

					if var_476_8.prefab_name ~= "" and arg_473_1.actors_[var_476_8.prefab_name] ~= nil then
						local var_476_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_8.prefab_name].transform, "story_v_out_317282", "317282117", "story_v_out_317282.awb")

						arg_473_1:RecordAudio("317282117", var_476_13)
						arg_473_1:RecordAudio("317282117", var_476_13)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_317282", "317282117", "story_v_out_317282.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_317282", "317282117", "story_v_out_317282.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_14 = math.max(var_476_7, arg_473_1.talkMaxDuration)

			if var_476_6 <= arg_473_1.time_ and arg_473_1.time_ < var_476_6 + var_476_14 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - var_476_6) / var_476_14

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= var_476_6 + var_476_14 and arg_473_1.time_ < var_476_6 + var_476_14 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_473_1:InitPlayNodeList()
	end,
	Play317282118 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 317282118
		arg_477_1.duration_ = 5.1

		local var_477_0 = {
			zh = 2.233,
			ja = 5.1
		}
		local var_477_1 = manager.audio:GetLocalizationFlag()

		if var_477_0[var_477_1] ~= nil then
			arg_477_1.duration_ = var_477_0[var_477_1]
		end

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play317282119(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos2078ui_story = arg_477_1.actors_["2078ui_story"].transform.localPosition
			end

			local var_480_0 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 then
				arg_477_1.actors_["2078ui_story"].transform.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos2078ui_story, Vector3.New(0, 100, 0), (arg_477_1.time_ - 0) / var_480_0)
				arg_477_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["2078ui_story"].transform.position).z)
				arg_477_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["2078ui_story"].transform.localEulerAngles = arg_477_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 then
				arg_477_1.actors_["2078ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_477_1.actors_["2078ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_477_1.actors_["2078ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["2078ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_477_1.actors_["2078ui_story"].transform.position).z)
				arg_477_1.actors_["2078ui_story"].transform.localEulerAngles.z = 0
				arg_477_1.actors_["2078ui_story"].transform.localEulerAngles.x = 0
				arg_477_1.actors_["2078ui_story"].transform.localEulerAngles = arg_477_1.actors_["2078ui_story"].transform.localEulerAngles
			end

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_480_1 = arg_477_1.actors_["2079ui_story"].transform

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 then
				arg_477_1.var_.moveOldPos2079ui_story = var_480_1.localPosition
			end

			local var_480_2 = 0.001

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_2 then
				var_480_1.localPosition = Vector3.Lerp(arg_477_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_477_1.time_ - 0) / var_480_2)
				var_480_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_1.position).x, (manager.ui.mainCamera.transform.position - var_480_1.position).y, (manager.ui.mainCamera.transform.position - var_480_1.position).z)
				var_480_1.localEulerAngles.z = 0
				var_480_1.localEulerAngles.x = 0
				var_480_1.localEulerAngles = var_480_1.localEulerAngles
			end

			if arg_477_1.time_ >= 0 + var_480_2 and arg_477_1.time_ < 0 + var_480_2 + arg_480_0 then
				var_480_1.localPosition = Vector3.New(0, -1.28, -5.6)
				var_480_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_480_1.position).x, (manager.ui.mainCamera.transform.position - var_480_1.position).y, (manager.ui.mainCamera.transform.position - var_480_1.position).z)
				var_480_1.localEulerAngles.z = 0
				var_480_1.localEulerAngles.x = 0
				var_480_1.localEulerAngles = var_480_1.localEulerAngles
			end

			local var_480_3 = arg_477_1.actors_["2079ui_story"]

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(var_480_3) and arg_477_1.var_.characterEffect2079ui_story == nil then
				arg_477_1.var_.characterEffect2079ui_story = var_480_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_480_4 = 0.200000002980232

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_4 and not isNil(var_480_3) then
				if arg_477_1.var_.characterEffect2079ui_story and not isNil(var_480_3) then
					arg_477_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_477_1.time_ >= 0 + var_480_4 and arg_477_1.time_ < 0 + var_480_4 + arg_480_0 and not isNil(var_480_3) and arg_477_1.var_.characterEffect2079ui_story then
				arg_477_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_480_6 = 0
			local var_480_7 = 0.15

			if 0 < arg_477_1.time_ and arg_477_1.time_ <= var_480_6 + arg_480_0 then
				arg_477_1.talkMaxDuration = 0
				arg_477_1.dialogCg_.alpha = 1

				arg_477_1.dialog_:SetActive(true)
				SetActive(arg_477_1.leftNameGo_, true)

				arg_477_1.leftNameTxt_.text = arg_477_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_477_1.leftNameTxt_.transform)

				arg_477_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_477_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_477_1:RecordName(arg_477_1.leftNameTxt_.text)
				SetActive(arg_477_1.iconTrs_.gameObject, false)
				arg_477_1.callingController_:SetSelectedState("normal")

				local var_480_8 = arg_477_1:GetWordFromCfg(317282118)
				local var_480_9 = arg_477_1:FormatText(var_480_8.content)

				arg_477_1.text_.text = var_480_9

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_11 = 6 <= 0 and var_480_7 or var_480_7 * (utf8.len(var_480_9) / 6)

				if (6 <= 0 and var_480_7 or var_480_7 * (utf8.len(var_480_9) / 6)) > 0 and var_480_7 < var_480_11 then
					arg_477_1.talkMaxDuration = var_480_11

					if var_480_11 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_11 + var_480_6
					end
				end

				arg_477_1.text_.text = var_480_9
				arg_477_1.typewritter.percent = 0

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282118", "story_v_out_317282.awb") ~= 0 then
					local var_480_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282118", "story_v_out_317282.awb") / 1000

					if var_480_12 + var_480_6 > arg_477_1.duration_ then
						arg_477_1.duration_ = var_480_12 + var_480_6
					end

					if var_480_8.prefab_name ~= "" and arg_477_1.actors_[var_480_8.prefab_name] ~= nil then
						local var_480_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_477_1.actors_[var_480_8.prefab_name].transform, "story_v_out_317282", "317282118", "story_v_out_317282.awb")

						arg_477_1:RecordAudio("317282118", var_480_13)
						arg_477_1:RecordAudio("317282118", var_480_13)
					else
						arg_477_1:AudioAction("play", "voice", "story_v_out_317282", "317282118", "story_v_out_317282.awb")
					end

					arg_477_1:RecordHistoryTalkVoice("story_v_out_317282", "317282118", "story_v_out_317282.awb")
				end

				arg_477_1:RecordContent(arg_477_1.text_.text)
			end

			local var_480_14 = math.max(var_480_7, arg_477_1.talkMaxDuration)

			if var_480_6 <= arg_477_1.time_ and arg_477_1.time_ < var_480_6 + var_480_14 then
				arg_477_1.typewritter.percent = (arg_477_1.time_ - var_480_6) / var_480_14

				arg_477_1.typewritter:SetDirty()
			end

			if arg_477_1.time_ >= var_480_6 + var_480_14 and arg_477_1.time_ < var_480_6 + var_480_14 + arg_480_0 then
				arg_477_1.typewritter.percent = 1

				arg_477_1.typewritter:SetDirty()
				arg_477_1:ShowNextGo(true)
			end
		end

		arg_477_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2078ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_477_1:InitPlayNodeList()
	end,
	Play317282119 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 317282119
		arg_481_1.duration_ = 3.6

		local var_481_0 = {
			zh = 2.566,
			ja = 3.6
		}
		local var_481_1 = manager.audio:GetLocalizationFlag()

		if var_481_0[var_481_1] ~= nil then
			arg_481_1.duration_ = var_481_0[var_481_1]
		end

		SetActive(arg_481_1.tipsGo_, false)

		function arg_481_1.onSingleLineFinish_()
			arg_481_1.onSingleLineUpdate_ = nil
			arg_481_1.onSingleLineFinish_ = nil
			arg_481_1.state_ = "waiting"
		end

		function arg_481_1.playNext_(arg_483_0)
			if arg_483_0 == 1 then
				arg_481_0:Play317282120(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos1015ui_story = arg_481_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_484_0 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 then
				arg_481_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos1015ui_story, Vector3.New(0, -1.15, -6.2), (arg_481_1.time_ - 0) / var_484_0)
				arg_481_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1015ui_story"].transform.position).z)
				arg_481_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1015ui_story"].transform.localEulerAngles = arg_481_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 then
				arg_481_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, -1.15, -6.2)
				arg_481_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_481_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_481_1.actors_["1015ui_story"].transform.position).z)
				arg_481_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_481_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_481_1.actors_["1015ui_story"].transform.localEulerAngles = arg_481_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			local var_484_1 = arg_481_1.actors_["1015ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1015ui_story == nil then
				arg_481_1.var_.characterEffect1015ui_story = var_484_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_2 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_2 and not isNil(var_484_1) then
				if arg_481_1.var_.characterEffect1015ui_story and not isNil(var_484_1) then
					arg_481_1.var_.characterEffect1015ui_story.fillFlat = false
				end
			end

			if arg_481_1.time_ >= 0 + var_484_2 and arg_481_1.time_ < 0 + var_484_2 + arg_484_0 and not isNil(var_484_1) and arg_481_1.var_.characterEffect1015ui_story then
				arg_481_1.var_.characterEffect1015ui_story.fillFlat = false
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/story1015/story1015action/1015action1_1")
			end

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1:PlayTimeline("1015ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_484_4 = arg_481_1.actors_["2079ui_story"].transform

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos2079ui_story = var_484_4.localPosition
			end

			local var_484_5 = 0.001

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_5 then
				var_484_4.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_481_1.time_ - 0) / var_484_5)
				var_484_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_4.position).x, (manager.ui.mainCamera.transform.position - var_484_4.position).y, (manager.ui.mainCamera.transform.position - var_484_4.position).z)
				var_484_4.localEulerAngles.z = 0
				var_484_4.localEulerAngles.x = 0
				var_484_4.localEulerAngles = var_484_4.localEulerAngles
			end

			if arg_481_1.time_ >= 0 + var_484_5 and arg_481_1.time_ < 0 + var_484_5 + arg_484_0 then
				var_484_4.localPosition = Vector3.New(0, 100, 0)
				var_484_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_484_4.position).x, (manager.ui.mainCamera.transform.position - var_484_4.position).y, (manager.ui.mainCamera.transform.position - var_484_4.position).z)
				var_484_4.localEulerAngles.z = 0
				var_484_4.localEulerAngles.x = 0
				var_484_4.localEulerAngles = var_484_4.localEulerAngles
			end

			local var_484_6 = arg_481_1.actors_["2078ui_story"]

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(var_484_6) and arg_481_1.var_.characterEffect2078ui_story == nil then
				arg_481_1.var_.characterEffect2078ui_story = var_484_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_484_7 = 0.200000002980232

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_7 and not isNil(var_484_6) then
				if arg_481_1.var_.characterEffect2078ui_story and not isNil(var_484_6) then
					arg_481_1.var_.characterEffect2078ui_story.fillFlat = true
					arg_481_1.var_.characterEffect2078ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_481_1.time_ - 0) / var_484_7)
				end
			end

			if arg_481_1.time_ >= 0 + var_484_7 and arg_481_1.time_ < 0 + var_484_7 + arg_484_0 and not isNil(var_484_6) and arg_481_1.var_.characterEffect2078ui_story then
				arg_481_1.var_.characterEffect2078ui_story.fillFlat = true
				arg_481_1.var_.characterEffect2078ui_story.fillRatio = 0.5
			end

			local var_484_8 = 0
			local var_484_9 = 0.35

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_8 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[479].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_10 = arg_481_1:GetWordFromCfg(317282119)
				local var_484_11 = arg_481_1:FormatText(var_484_10.content)

				arg_481_1.text_.text = var_484_11

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_13 = 14 <= 0 and var_484_9 or var_484_9 * (utf8.len(var_484_11) / 14)

				if (14 <= 0 and var_484_9 or var_484_9 * (utf8.len(var_484_11) / 14)) > 0 and var_484_9 < var_484_13 then
					arg_481_1.talkMaxDuration = var_484_13

					if var_484_13 + var_484_8 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_13 + var_484_8
					end
				end

				arg_481_1.text_.text = var_484_11
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282119", "story_v_out_317282.awb") ~= 0 then
					local var_484_14 = manager.audio:GetVoiceLength("story_v_out_317282", "317282119", "story_v_out_317282.awb") / 1000

					if var_484_14 + var_484_8 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_14 + var_484_8
					end

					if var_484_10.prefab_name ~= "" and arg_481_1.actors_[var_484_10.prefab_name] ~= nil then
						local var_484_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_10.prefab_name].transform, "story_v_out_317282", "317282119", "story_v_out_317282.awb")

						arg_481_1:RecordAudio("317282119", var_484_15)
						arg_481_1:RecordAudio("317282119", var_484_15)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_317282", "317282119", "story_v_out_317282.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_317282", "317282119", "story_v_out_317282.awb")
				end

				arg_481_1:RecordContent(arg_481_1.text_.text)
			end

			local var_484_16 = math.max(var_484_9, arg_481_1.talkMaxDuration)

			if var_484_8 <= arg_481_1.time_ and arg_481_1.time_ < var_484_8 + var_484_16 then
				arg_481_1.typewritter.percent = (arg_481_1.time_ - var_484_8) / var_484_16

				arg_481_1.typewritter:SetDirty()
			end

			if arg_481_1.time_ >= var_484_8 + var_484_16 and arg_481_1.time_ < var_484_8 + var_484_16 + arg_484_0 then
				arg_481_1.typewritter.percent = 1

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(true)
			end
		end

		arg_481_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_481_1:InitPlayNodeList()
	end,
	Play317282120 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 317282120
		arg_485_1.duration_ = 7.73

		local var_485_0 = {
			zh = 7.733,
			ja = 7.066
		}
		local var_485_1 = manager.audio:GetLocalizationFlag()

		if var_485_0[var_485_1] ~= nil then
			arg_485_1.duration_ = var_485_0[var_485_1]
		end

		SetActive(arg_485_1.tipsGo_, false)

		function arg_485_1.onSingleLineFinish_()
			arg_485_1.onSingleLineUpdate_ = nil
			arg_485_1.onSingleLineFinish_ = nil
			arg_485_1.state_ = "waiting"
		end

		function arg_485_1.playNext_(arg_487_0)
			if arg_487_0 == 1 then
				arg_485_0:Play317282121(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos1015ui_story = arg_485_1.actors_["1015ui_story"].transform.localPosition
			end

			local var_488_0 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_0 then
				arg_485_1.actors_["1015ui_story"].transform.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos1015ui_story, Vector3.New(0, 100, 0), (arg_485_1.time_ - 0) / var_488_0)
				arg_485_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1015ui_story"].transform.position).z)
				arg_485_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1015ui_story"].transform.localEulerAngles = arg_485_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_0 and arg_485_1.time_ < 0 + var_488_0 + arg_488_0 then
				arg_485_1.actors_["1015ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_485_1.actors_["1015ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_485_1.actors_["1015ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1015ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_485_1.actors_["1015ui_story"].transform.position).z)
				arg_485_1.actors_["1015ui_story"].transform.localEulerAngles.z = 0
				arg_485_1.actors_["1015ui_story"].transform.localEulerAngles.x = 0
				arg_485_1.actors_["1015ui_story"].transform.localEulerAngles = arg_485_1.actors_["1015ui_story"].transform.localEulerAngles
			end

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			local var_488_1 = arg_485_1.actors_["2079ui_story"].transform

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.var_.moveOldPos2079ui_story = var_488_1.localPosition
			end

			local var_488_2 = 0.001

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_2 then
				var_488_1.localPosition = Vector3.Lerp(arg_485_1.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (arg_485_1.time_ - 0) / var_488_2)
				var_488_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_1.position).x, (manager.ui.mainCamera.transform.position - var_488_1.position).y, (manager.ui.mainCamera.transform.position - var_488_1.position).z)
				var_488_1.localEulerAngles.z = 0
				var_488_1.localEulerAngles.x = 0
				var_488_1.localEulerAngles = var_488_1.localEulerAngles
			end

			if arg_485_1.time_ >= 0 + var_488_2 and arg_485_1.time_ < 0 + var_488_2 + arg_488_0 then
				var_488_1.localPosition = Vector3.New(0, -1.28, -5.6)
				var_488_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_488_1.position).x, (manager.ui.mainCamera.transform.position - var_488_1.position).y, (manager.ui.mainCamera.transform.position - var_488_1.position).z)
				var_488_1.localEulerAngles.z = 0
				var_488_1.localEulerAngles.x = 0
				var_488_1.localEulerAngles = var_488_1.localEulerAngles
			end

			local var_488_3 = arg_485_1.actors_["2079ui_story"]

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 and not isNil(var_488_3) and arg_485_1.var_.characterEffect2079ui_story == nil then
				arg_485_1.var_.characterEffect2079ui_story = var_488_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_488_4 = 0.200000002980232

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_4 and not isNil(var_488_3) then
				if arg_485_1.var_.characterEffect2079ui_story and not isNil(var_488_3) then
					arg_485_1.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if arg_485_1.time_ >= 0 + var_488_4 and arg_485_1.time_ < 0 + var_488_4 + arg_488_0 and not isNil(var_488_3) and arg_485_1.var_.characterEffect2079ui_story then
				arg_485_1.var_.characterEffect2079ui_story.fillFlat = false
			end

			local var_488_6 = 0
			local var_488_7 = 0.6

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= var_488_6 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[530].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_8 = arg_485_1:GetWordFromCfg(317282120)
				local var_488_9 = arg_485_1:FormatText(var_488_8.content)

				arg_485_1.text_.text = var_488_9

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_11 = 24 <= 0 and var_488_7 or var_488_7 * (utf8.len(var_488_9) / 24)

				if (24 <= 0 and var_488_7 or var_488_7 * (utf8.len(var_488_9) / 24)) > 0 and var_488_7 < var_488_11 then
					arg_485_1.talkMaxDuration = var_488_11

					if var_488_11 + var_488_6 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_11 + var_488_6
					end
				end

				arg_485_1.text_.text = var_488_9
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282120", "story_v_out_317282.awb") ~= 0 then
					local var_488_12 = manager.audio:GetVoiceLength("story_v_out_317282", "317282120", "story_v_out_317282.awb") / 1000

					if var_488_12 + var_488_6 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_12 + var_488_6
					end

					if var_488_8.prefab_name ~= "" and arg_485_1.actors_[var_488_8.prefab_name] ~= nil then
						local var_488_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_8.prefab_name].transform, "story_v_out_317282", "317282120", "story_v_out_317282.awb")

						arg_485_1:RecordAudio("317282120", var_488_13)
						arg_485_1:RecordAudio("317282120", var_488_13)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_317282", "317282120", "story_v_out_317282.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_317282", "317282120", "story_v_out_317282.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_14 = math.max(var_488_7, arg_485_1.talkMaxDuration)

			if var_488_6 <= arg_485_1.time_ and arg_485_1.time_ < var_488_6 + var_488_14 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - var_488_6) / var_488_14

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= var_488_6 + var_488_14 and arg_485_1.time_ < var_488_6 + var_488_14 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1015ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_485_1:InitPlayNodeList()
	end,
	Play317282121 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 317282121
		arg_489_1.duration_ = 5

		SetActive(arg_489_1.tipsGo_, false)

		function arg_489_1.onSingleLineFinish_()
			arg_489_1.onSingleLineUpdate_ = nil
			arg_489_1.onSingleLineFinish_ = nil
			arg_489_1.state_ = "waiting"
		end

		function arg_489_1.playNext_(arg_491_0)
			if arg_491_0 == 1 then
				arg_489_0:Play317282122(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.var_.moveOldPos2079ui_story = arg_489_1.actors_["2079ui_story"].transform.localPosition
			end

			local var_492_0 = 0.001

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_0 then
				arg_489_1.actors_["2079ui_story"].transform.localPosition = Vector3.Lerp(arg_489_1.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (arg_489_1.time_ - 0) / var_492_0)
				arg_489_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_489_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["2079ui_story"].transform.position).z)
				arg_489_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_489_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_489_1.actors_["2079ui_story"].transform.localEulerAngles = arg_489_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			if arg_489_1.time_ >= 0 + var_492_0 and arg_489_1.time_ < 0 + var_492_0 + arg_492_0 then
				arg_489_1.actors_["2079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_489_1.actors_["2079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_489_1.actors_["2079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["2079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_489_1.actors_["2079ui_story"].transform.position).z)
				arg_489_1.actors_["2079ui_story"].transform.localEulerAngles.z = 0
				arg_489_1.actors_["2079ui_story"].transform.localEulerAngles.x = 0
				arg_489_1.actors_["2079ui_story"].transform.localEulerAngles = arg_489_1.actors_["2079ui_story"].transform.localEulerAngles
			end

			local var_492_1 = 0
			local var_492_2 = 1.15

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= var_492_1 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, false)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_3 = arg_489_1:FormatText(arg_489_1:GetWordFromCfg(317282121).content)

				arg_489_1.text_.text = var_492_3

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_5 = 46 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 46)

				if (46 <= 0 and var_492_2 or var_492_2 * (utf8.len(var_492_3) / 46)) > 0 and var_492_2 < var_492_5 then
					arg_489_1.talkMaxDuration = var_492_5

					if var_492_5 + var_492_1 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + var_492_1
					end
				end

				arg_489_1.text_.text = var_492_3
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)
				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_6 = math.max(var_492_2, arg_489_1.talkMaxDuration)

			if var_492_1 <= arg_489_1.time_ and arg_489_1.time_ < var_492_1 + var_492_6 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - var_492_1) / var_492_6

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= var_492_1 + var_492_6 and arg_489_1.time_ < var_492_1 + var_492_6 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_489_1:InitPlayNodeList()
	end,
	Play317282122 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 317282122
		arg_493_1.duration_ = 2.8

		local var_493_0 = {
			zh = 2.1,
			ja = 2.8
		}
		local var_493_1 = manager.audio:GetLocalizationFlag()

		if var_493_0[var_493_1] ~= nil then
			arg_493_1.duration_ = var_493_0[var_493_1]
		end

		SetActive(arg_493_1.tipsGo_, false)

		function arg_493_1.onSingleLineFinish_()
			arg_493_1.onSingleLineUpdate_ = nil
			arg_493_1.onSingleLineFinish_ = nil
			arg_493_1.state_ = "waiting"
		end

		function arg_493_1.playNext_(arg_495_0)
			if arg_495_0 == 1 then
				arg_493_0:Play317282123(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos1093ui_story = arg_493_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_496_0 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_0 then
				arg_493_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos1093ui_story, Vector3.New(0, -1.11, -5.88), (arg_493_1.time_ - 0) / var_496_0)
				arg_493_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1093ui_story"].transform.position).z)
				arg_493_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1093ui_story"].transform.localEulerAngles = arg_493_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_493_1.time_ >= 0 + var_496_0 and arg_493_1.time_ < 0 + var_496_0 + arg_496_0 then
				arg_493_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.88)
				arg_493_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_493_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_493_1.actors_["1093ui_story"].transform.position).z)
				arg_493_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_493_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_493_1.actors_["1093ui_story"].transform.localEulerAngles = arg_493_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_496_1 = arg_493_1.actors_["1093ui_story"]

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1093ui_story == nil then
				arg_493_1.var_.characterEffect1093ui_story = var_496_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_496_2 = 0.200000002980232

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_2 and not isNil(var_496_1) then
				if arg_493_1.var_.characterEffect1093ui_story and not isNil(var_496_1) then
					arg_493_1.var_.characterEffect1093ui_story.fillFlat = false
				end
			end

			if arg_493_1.time_ >= 0 + var_496_2 and arg_493_1.time_ < 0 + var_496_2 + arg_496_0 and not isNil(var_496_1) and arg_493_1.var_.characterEffect1093ui_story then
				arg_493_1.var_.characterEffect1093ui_story.fillFlat = false
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/story1093/story1093action/1093action4_1")
			end

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1:PlayTimeline("1093ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_496_4 = 0
			local var_496_5 = 0.125

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_4 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[73].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_6 = arg_493_1:GetWordFromCfg(317282122)
				local var_496_7 = arg_493_1:FormatText(var_496_6.content)

				arg_493_1.text_.text = var_496_7

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_9 = 5 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 5)

				if (5 <= 0 and var_496_5 or var_496_5 * (utf8.len(var_496_7) / 5)) > 0 and var_496_5 < var_496_9 then
					arg_493_1.talkMaxDuration = var_496_9

					if var_496_9 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_9 + var_496_4
					end
				end

				arg_493_1.text_.text = var_496_7
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282122", "story_v_out_317282.awb") ~= 0 then
					local var_496_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282122", "story_v_out_317282.awb") / 1000

					if var_496_10 + var_496_4 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_10 + var_496_4
					end

					if var_496_6.prefab_name ~= "" and arg_493_1.actors_[var_496_6.prefab_name] ~= nil then
						local var_496_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_6.prefab_name].transform, "story_v_out_317282", "317282122", "story_v_out_317282.awb")

						arg_493_1:RecordAudio("317282122", var_496_11)
						arg_493_1:RecordAudio("317282122", var_496_11)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_317282", "317282122", "story_v_out_317282.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_317282", "317282122", "story_v_out_317282.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_12 = math.max(var_496_5, arg_493_1.talkMaxDuration)

			if var_496_4 <= arg_493_1.time_ and arg_493_1.time_ < var_496_4 + var_496_12 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_4) / var_496_12

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_4 + var_496_12 and arg_493_1.time_ < var_496_4 + var_496_12 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_493_1:InitPlayNodeList()
	end,
	Play317282123 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 317282123
		arg_497_1.duration_ = 5

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play317282124(arg_497_1)
			end
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 then
				arg_497_1.var_.moveOldPos1093ui_story = arg_497_1.actors_["1093ui_story"].transform.localPosition
			end

			local var_500_0 = 0.001

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 then
				arg_497_1.actors_["1093ui_story"].transform.localPosition = Vector3.Lerp(arg_497_1.var_.moveOldPos1093ui_story, Vector3.New(0, 100, 0), (arg_497_1.time_ - 0) / var_500_0)
				arg_497_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1093ui_story"].transform.position).z)
				arg_497_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1093ui_story"].transform.localEulerAngles = arg_497_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 then
				arg_497_1.actors_["1093ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_497_1.actors_["1093ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_497_1.actors_["1093ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1093ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_497_1.actors_["1093ui_story"].transform.position).z)
				arg_497_1.actors_["1093ui_story"].transform.localEulerAngles.z = 0
				arg_497_1.actors_["1093ui_story"].transform.localEulerAngles.x = 0
				arg_497_1.actors_["1093ui_story"].transform.localEulerAngles = arg_497_1.actors_["1093ui_story"].transform.localEulerAngles
			end

			local var_500_1 = arg_497_1.actors_["1093ui_story"]

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(var_500_1) and arg_497_1.var_.characterEffect1093ui_story == nil then
				arg_497_1.var_.characterEffect1093ui_story = var_500_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_500_2 = 0.200000002980232

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_2 and not isNil(var_500_1) then
				if arg_497_1.var_.characterEffect1093ui_story and not isNil(var_500_1) then
					arg_497_1.var_.characterEffect1093ui_story.fillFlat = true
					arg_497_1.var_.characterEffect1093ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_497_1.time_ - 0) / var_500_2)
				end
			end

			if arg_497_1.time_ >= 0 + var_500_2 and arg_497_1.time_ < 0 + var_500_2 + arg_500_0 and not isNil(var_500_1) and arg_497_1.var_.characterEffect1093ui_story then
				arg_497_1.var_.characterEffect1093ui_story.fillFlat = true
				arg_497_1.var_.characterEffect1093ui_story.fillRatio = 0.5
			end

			local var_500_3 = 0
			local var_500_4 = 0.875

			if 0 < arg_497_1.time_ and arg_497_1.time_ <= var_500_3 + arg_500_0 then
				arg_497_1.talkMaxDuration = 0
				arg_497_1.dialogCg_.alpha = 1

				arg_497_1.dialog_:SetActive(true)
				SetActive(arg_497_1.leftNameGo_, false)

				arg_497_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_497_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_497_1:RecordName(arg_497_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_497_1.iconTrs_.gameObject, false)
				arg_497_1.callingController_:SetSelectedState("normal")

				local var_500_5 = arg_497_1:FormatText(arg_497_1:GetWordFromCfg(317282123).content)

				arg_497_1.text_.text = var_500_5

				LuaForUtil.ClearLinePrefixSymbol(arg_497_1.text_)

				local var_500_7 = 35 <= 0 and var_500_4 or var_500_4 * (utf8.len(var_500_5) / 35)

				if (35 <= 0 and var_500_4 or var_500_4 * (utf8.len(var_500_5) / 35)) > 0 and var_500_4 < var_500_7 then
					arg_497_1.talkMaxDuration = var_500_7

					if var_500_7 + var_500_3 > arg_497_1.duration_ then
						arg_497_1.duration_ = var_500_7 + var_500_3
					end
				end

				arg_497_1.text_.text = var_500_5
				arg_497_1.typewritter.percent = 0

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(false)
				arg_497_1:RecordContent(arg_497_1.text_.text)
			end

			local var_500_8 = math.max(var_500_4, arg_497_1.talkMaxDuration)

			if var_500_3 <= arg_497_1.time_ and arg_497_1.time_ < var_500_3 + var_500_8 then
				arg_497_1.typewritter.percent = (arg_497_1.time_ - var_500_3) / var_500_8

				arg_497_1.typewritter:SetDirty()
			end

			if arg_497_1.time_ >= var_500_3 + var_500_8 and arg_497_1.time_ < var_500_3 + var_500_8 + arg_500_0 then
				arg_497_1.typewritter.percent = 1

				arg_497_1.typewritter:SetDirty()
				arg_497_1:ShowNextGo(true)
			end
		end

		arg_497_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1093ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_497_1:InitPlayNodeList()
	end,
	Play317282124 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 317282124
		arg_501_1.duration_ = 7.1

		local var_501_0 = {
			zh = 5.333,
			ja = 7.1
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
			arg_501_1.auto_ = false
		end

		function arg_501_1.playNext_(arg_503_0)
			arg_501_1.onStoryFinished_()
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos1199ui_story = arg_501_1.actors_["1199ui_story"].transform.localPosition
			end

			local var_504_0 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 then
				arg_501_1.actors_["1199ui_story"].transform.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos1199ui_story, Vector3.New(0, -1.08, -5.9), (arg_501_1.time_ - 0) / var_504_0)
				arg_501_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1199ui_story"].transform.position).z)
				arg_501_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1199ui_story"].transform.localEulerAngles = arg_501_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 then
				arg_501_1.actors_["1199ui_story"].transform.localPosition = Vector3.New(0, -1.08, -5.9)
				arg_501_1.actors_["1199ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_501_1.actors_["1199ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1199ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_501_1.actors_["1199ui_story"].transform.position).z)
				arg_501_1.actors_["1199ui_story"].transform.localEulerAngles.z = 0
				arg_501_1.actors_["1199ui_story"].transform.localEulerAngles.x = 0
				arg_501_1.actors_["1199ui_story"].transform.localEulerAngles = arg_501_1.actors_["1199ui_story"].transform.localEulerAngles
			end

			local var_504_1 = arg_501_1.actors_["1199ui_story"]

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1199ui_story == nil then
				arg_501_1.var_.characterEffect1199ui_story = var_504_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_504_2 = 0.200000002980232

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_2 and not isNil(var_504_1) then
				if arg_501_1.var_.characterEffect1199ui_story and not isNil(var_504_1) then
					arg_501_1.var_.characterEffect1199ui_story.fillFlat = false
				end
			end

			if arg_501_1.time_ >= 0 + var_504_2 and arg_501_1.time_ < 0 + var_504_2 + arg_504_0 and not isNil(var_504_1) and arg_501_1.var_.characterEffect1199ui_story then
				arg_501_1.var_.characterEffect1199ui_story.fillFlat = false
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/story1099/story1099action/1099action6_1")
			end

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1:PlayTimeline("1199ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_504_4 = 0
			local var_504_5 = 0.775

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_4 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_6 = arg_501_1:GetWordFromCfg(317282124)
				local var_504_7 = arg_501_1:FormatText(var_504_6.content)

				arg_501_1.text_.text = var_504_7

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_9 = 31 <= 0 and var_504_5 or var_504_5 * (utf8.len(var_504_7) / 31)

				if (31 <= 0 and var_504_5 or var_504_5 * (utf8.len(var_504_7) / 31)) > 0 and var_504_5 < var_504_9 then
					arg_501_1.talkMaxDuration = var_504_9

					if var_504_9 + var_504_4 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_9 + var_504_4
					end
				end

				arg_501_1.text_.text = var_504_7
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_317282", "317282124", "story_v_out_317282.awb") ~= 0 then
					local var_504_10 = manager.audio:GetVoiceLength("story_v_out_317282", "317282124", "story_v_out_317282.awb") / 1000

					if var_504_10 + var_504_4 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_10 + var_504_4
					end

					if var_504_6.prefab_name ~= "" and arg_501_1.actors_[var_504_6.prefab_name] ~= nil then
						local var_504_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_6.prefab_name].transform, "story_v_out_317282", "317282124", "story_v_out_317282.awb")

						arg_501_1:RecordAudio("317282124", var_504_11)
						arg_501_1:RecordAudio("317282124", var_504_11)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_317282", "317282124", "story_v_out_317282.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_317282", "317282124", "story_v_out_317282.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_12 = math.max(var_504_5, arg_501_1.talkMaxDuration)

			if var_504_4 <= arg_501_1.time_ and arg_501_1.time_ < var_504_4 + var_504_12 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_4) / var_504_12

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_4 + var_504_12 and arg_501_1.time_ < var_504_4 + var_504_12 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1199ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_501_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/K10f",
		"TextureConfig/Background/K11f"
	},
	voices = {
		"story_v_out_317282.awb"
	}
}
