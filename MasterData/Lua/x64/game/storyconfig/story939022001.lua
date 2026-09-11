return {
	Play939022001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939022001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939022002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST15a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST15a")
				var_4_0.name = "ST15a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST15a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST15a

				arg_1_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST15a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 1.999999999999

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1211ui_story"

			if arg_1_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["1211ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1211ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_1_1.time_ - 1.8) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_14 and arg_1_1.time_ < 1.8 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1211ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1211ui_story == nil then
				arg_1_1.var_.characterEffect1211ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1211ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_16 and arg_1_1.time_ < 1.8 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1211ui_story then
				arg_1_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "ui_battle.awb")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_side_daily03", "bgm_side_daily03", "bgm_side_daily03.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_side_daily03", "bgm_side_daily03")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 1.999999999999
			local var_4_25 = 0.2

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(939022001).content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 8 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_27) / 8)

				if (8 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_27) / 8)) > 0 and var_4_25 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_24 = var_4_24 + 0.3

					if var_4_29 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_24 + 0.3
			local var_4_31 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play939022002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 939022002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play939022003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1054ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1054ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1054ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1054ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1054ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1054ui_story = var_12_3.localPosition

				local var_12_4 = GameObjectTools.GetOrAddComponent(var_12_3.gameObject, typeof(DynamicBoneHelper))

				if var_12_4 then
					var_12_4:EnableDynamicBone(false)
				end
			end

			local var_12_5 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_5 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_9_1.time_ - 0) / var_12_5)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_5 and arg_9_1.time_ < 0 + var_12_5 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles

				local var_12_6 = GameObjectTools.GetOrAddComponent(var_12_3.gameObject, typeof(DynamicBoneHelper))

				if var_12_6 then
					var_12_6:EnableDynamicBone(true)
				end
			end

			local var_12_7 = arg_9_1.actors_["1054ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect1054ui_story == nil then
				arg_9_1.var_.characterEffect1054ui_story = var_12_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_8 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_8 and not isNil(var_12_7) then
				if arg_9_1.var_.characterEffect1054ui_story and not isNil(var_12_7) then
					arg_9_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_8 and arg_9_1.time_ < 0 + var_12_8 + arg_12_0 and not isNil(var_12_7) and arg_9_1.var_.characterEffect1054ui_story then
				arg_9_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_12_10 = arg_9_1.actors_["1211ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect1211ui_story == nil then
				arg_9_1.var_.characterEffect1211ui_story = var_12_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_11 and not isNil(var_12_10) then
				if arg_9_1.var_.characterEffect1211ui_story and not isNil(var_12_10) then
					arg_9_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_11)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_11 and arg_9_1.time_ < 0 + var_12_11 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect1211ui_story then
				arg_9_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_12_12 = 0
			local var_12_13 = 0.55

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(939022002).content)

				arg_9_1.text_.text = var_12_14

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_16 = 22 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_14) / 22)

				if (22 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_14) / 22)) > 0 and var_12_13 < var_12_16 then
					arg_9_1.talkMaxDuration = var_12_16

					if var_12_16 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_14
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_17 = math.max(var_12_13, arg_9_1.talkMaxDuration)

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_17 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_12) / var_12_17

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_12 + var_12_17 and arg_9_1.time_ < var_12_12 + var_12_17 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play939022003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 939022003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play939022004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1054ui_story"]) and arg_13_1.var_.characterEffect1054ui_story == nil then
				arg_13_1.var_.characterEffect1054ui_story = arg_13_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1054ui_story"]) then
				if arg_13_1.var_.characterEffect1054ui_story and not isNil(arg_13_1.actors_["1054ui_story"]) then
					arg_13_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1054ui_story"]) and arg_13_1.var_.characterEffect1054ui_story then
				arg_13_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_16_1 = 0
			local var_16_2 = 0.8

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_1 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, true)
				arg_13_1.iconController_:SetSelectedState("hero")

				arg_13_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_13_1.callingController_:SetSelectedState("normal")

				arg_13_1.keyicon_.color = Color.New(1, 1, 1)
				arg_13_1.icon_.color = Color.New(1, 1, 1)

				local var_16_3 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(939022003).content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 32 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 32)

				if (32 <= 0 and var_16_2 or var_16_2 * (utf8.len(var_16_3) / 32)) > 0 and var_16_2 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_1 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_1
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_6 = math.max(var_16_2, arg_13_1.talkMaxDuration)

			if var_16_1 <= arg_13_1.time_ and arg_13_1.time_ < var_16_1 + var_16_6 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_1) / var_16_6

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_1 + var_16_6 and arg_13_1.time_ < var_16_1 + var_16_6 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play939022004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 939022004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play939022005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1054ui_story = arg_17_1.actors_["1054ui_story"].transform.localPosition

				local var_20_0 = GameObjectTools.GetOrAddComponent(arg_17_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_20_0 then
					var_20_0:EnableDynamicBone(false)
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_17_1.time_ - 0) / var_20_1)
				arg_17_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).z)
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles = arg_17_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_17_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).z)
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles = arg_17_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_20_2 = GameObjectTools.GetOrAddComponent(arg_17_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(true)
				end
			end

			local var_20_3 = arg_17_1.actors_["1054ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect1054ui_story == nil then
				arg_17_1.var_.characterEffect1054ui_story = var_20_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_4 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 and not isNil(var_20_3) then
				if arg_17_1.var_.characterEffect1054ui_story and not isNil(var_20_3) then
					arg_17_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 and not isNil(var_20_3) and arg_17_1.var_.characterEffect1054ui_story then
				arg_17_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_20_6 = 0
			local var_20_7 = 0.55

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_6 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_8 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(939022004).content)

				arg_17_1.text_.text = var_20_8

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_10 = 22 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_8) / 22)

				if (22 <= 0 and var_20_7 or var_20_7 * (utf8.len(var_20_8) / 22)) > 0 and var_20_7 < var_20_10 then
					arg_17_1.talkMaxDuration = var_20_10

					if var_20_10 + var_20_6 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_6
					end
				end

				arg_17_1.text_.text = var_20_8
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_11 = math.max(var_20_7, arg_17_1.talkMaxDuration)

			if var_20_6 <= arg_17_1.time_ and arg_17_1.time_ < var_20_6 + var_20_11 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_6) / var_20_11

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_6 + var_20_11 and arg_17_1.time_ < var_20_6 + var_20_11 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play939022005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 939022005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play939022006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1211ui_story = arg_21_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1211ui_story"].transform.position).z)
				arg_21_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1211ui_story"].transform.localEulerAngles = arg_21_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_21_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1211ui_story"].transform.position).z)
				arg_21_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1211ui_story"].transform.localEulerAngles = arg_21_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1211ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1211ui_story == nil then
				arg_21_1.var_.characterEffect1211ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1211ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1211ui_story then
				arg_21_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_24_4 = arg_21_1.actors_["1054ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1054ui_story == nil then
				arg_21_1.var_.characterEffect1054ui_story = var_24_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_5 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_5 and not isNil(var_24_4) then
				if arg_21_1.var_.characterEffect1054ui_story and not isNil(var_24_4) then
					arg_21_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_5)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_5 and arg_21_1.time_ < 0 + var_24_5 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.characterEffect1054ui_story then
				arg_21_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action2_2")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_24_6 = 0
			local var_24_7 = 0.45

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_6 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_8 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(939022005).content)

				arg_21_1.text_.text = var_24_8

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_10 = 18 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_8) / 18)

				if (18 <= 0 and var_24_7 or var_24_7 * (utf8.len(var_24_8) / 18)) > 0 and var_24_7 < var_24_10 then
					arg_21_1.talkMaxDuration = var_24_10

					if var_24_10 + var_24_6 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_6
					end
				end

				arg_21_1.text_.text = var_24_8
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_11 = math.max(var_24_7, arg_21_1.talkMaxDuration)

			if var_24_6 <= arg_21_1.time_ and arg_21_1.time_ < var_24_6 + var_24_11 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_6) / var_24_11

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_6 + var_24_11 and arg_21_1.time_ < var_24_6 + var_24_11 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play939022006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 939022006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play939022007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "6148ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["6148ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["6148ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["6148ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["6148ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos6148ui_story = var_28_3.localPosition

				local var_28_4 = GameObjectTools.GetOrAddComponent(var_28_3.gameObject, typeof(DynamicBoneHelper))

				if var_28_4 then
					var_28_4:EnableDynamicBone(false)
				end
			end

			local var_28_5 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_5 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_25_1.time_ - 0) / var_28_5)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_5 and arg_25_1.time_ < 0 + var_28_5 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles

				local var_28_6 = GameObjectTools.GetOrAddComponent(var_28_3.gameObject, typeof(DynamicBoneHelper))

				if var_28_6 then
					var_28_6:EnableDynamicBone(true)
				end
			end

			local var_28_7 = arg_25_1.actors_["1054ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1054ui_story = var_28_7.localPosition

				local var_28_8 = GameObjectTools.GetOrAddComponent(var_28_7.gameObject, typeof(DynamicBoneHelper))

				if var_28_8 then
					var_28_8:EnableDynamicBone(false)
				end
			end

			local var_28_9 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_9 then
				var_28_7.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_25_1.time_ - 0) / var_28_9)
				var_28_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_7.position).x, (manager.ui.mainCamera.transform.position - var_28_7.position).y, (manager.ui.mainCamera.transform.position - var_28_7.position).z)
				var_28_7.localEulerAngles.z = 0
				var_28_7.localEulerAngles.x = 0
				var_28_7.localEulerAngles = var_28_7.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_9 and arg_25_1.time_ < 0 + var_28_9 + arg_28_0 then
				var_28_7.localPosition = Vector3.New(0, 100, 0)
				var_28_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_7.position).x, (manager.ui.mainCamera.transform.position - var_28_7.position).y, (manager.ui.mainCamera.transform.position - var_28_7.position).z)
				var_28_7.localEulerAngles.z = 0
				var_28_7.localEulerAngles.x = 0
				var_28_7.localEulerAngles = var_28_7.localEulerAngles

				local var_28_10 = GameObjectTools.GetOrAddComponent(var_28_7.gameObject, typeof(DynamicBoneHelper))

				if var_28_10 then
					var_28_10:EnableDynamicBone(true)
				end
			end

			local var_28_11 = arg_25_1.actors_["6148ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.characterEffect6148ui_story == nil then
				arg_25_1.var_.characterEffect6148ui_story = var_28_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_12 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_12 and not isNil(var_28_11) then
				if arg_25_1.var_.characterEffect6148ui_story and not isNil(var_28_11) then
					arg_25_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_12 and arg_25_1.time_ < 0 + var_28_12 + arg_28_0 and not isNil(var_28_11) and arg_25_1.var_.characterEffect6148ui_story then
				arg_25_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_28_14 = arg_25_1.actors_["1211ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1211ui_story == nil then
				arg_25_1.var_.characterEffect1211ui_story = var_28_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_15 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_15 and not isNil(var_28_14) then
				if arg_25_1.var_.characterEffect1211ui_story and not isNil(var_28_14) then
					arg_25_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_15)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_15 and arg_25_1.time_ < 0 + var_28_15 + arg_28_0 and not isNil(var_28_14) and arg_25_1.var_.characterEffect1211ui_story then
				arg_25_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_28_16 = 0
			local var_28_17 = 0.65

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_16 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_18 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(939022006).content)

				arg_25_1.text_.text = var_28_18

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_20 = 26 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_18) / 26)

				if (26 <= 0 and var_28_17 or var_28_17 * (utf8.len(var_28_18) / 26)) > 0 and var_28_17 < var_28_20 then
					arg_25_1.talkMaxDuration = var_28_20

					if var_28_20 + var_28_16 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_20 + var_28_16
					end
				end

				arg_25_1.text_.text = var_28_18
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_21 = math.max(var_28_17, arg_25_1.talkMaxDuration)

			if var_28_16 <= arg_25_1.time_ and arg_25_1.time_ < var_28_16 + var_28_21 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_16) / var_28_21

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_16 + var_28_21 and arg_25_1.time_ < var_28_16 + var_28_21 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
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
	Play939022007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 939022007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play939022008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos6148ui_story = arg_29_1.actors_["6148ui_story"].transform.localPosition

				local var_32_0 = GameObjectTools.GetOrAddComponent(arg_29_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_32_0 then
					var_32_0:EnableDynamicBone(false)
				end
			end

			local var_32_1 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_1 then
				arg_29_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_1)
				arg_29_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).z)
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles = arg_29_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_1 and arg_29_1.time_ < 0 + var_32_1 + arg_32_0 then
				arg_29_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["6148ui_story"].transform.position).z)
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["6148ui_story"].transform.localEulerAngles = arg_29_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_32_2 = GameObjectTools.GetOrAddComponent(arg_29_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_32_2 then
					var_32_2:EnableDynamicBone(true)
				end
			end

			local var_32_3 = arg_29_1.actors_["1211ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1211ui_story = var_32_3.localPosition
			end

			local var_32_4 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_4 then
				var_32_3.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_4)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_4 and arg_29_1.time_ < 0 + var_32_4 + arg_32_0 then
				var_32_3.localPosition = Vector3.New(0, 100, 0)
				var_32_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_3.position).x, (manager.ui.mainCamera.transform.position - var_32_3.position).y, (manager.ui.mainCamera.transform.position - var_32_3.position).z)
				var_32_3.localEulerAngles.z = 0
				var_32_3.localEulerAngles.x = 0
				var_32_3.localEulerAngles = var_32_3.localEulerAngles
			end

			local var_32_5 = arg_29_1.actors_["6148ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect6148ui_story == nil then
				arg_29_1.var_.characterEffect6148ui_story = var_32_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_6 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_6 and not isNil(var_32_5) then
				if arg_29_1.var_.characterEffect6148ui_story and not isNil(var_32_5) then
					arg_29_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_29_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_6)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_6 and arg_29_1.time_ < 0 + var_32_6 + arg_32_0 and not isNil(var_32_5) and arg_29_1.var_.characterEffect6148ui_story then
				arg_29_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_29_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_32_7 = 0
			local var_32_8 = 0.925

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_9 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(939022007).content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 37 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_9) / 37)

				if (37 <= 0 and var_32_8 or var_32_8 * (utf8.len(var_32_9) / 37)) > 0 and var_32_8 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_7 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_7
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_8, arg_29_1.talkMaxDuration)

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_7) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_7 + var_32_12 and arg_29_1.time_ < var_32_7 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play939022008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 939022008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play939022009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos6148ui_story = arg_33_1.actors_["6148ui_story"].transform.localPosition

				local var_36_0 = GameObjectTools.GetOrAddComponent(arg_33_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_36_0 then
					var_36_0:EnableDynamicBone(false)
				end
			end

			local var_36_1 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_1 then
				arg_33_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_33_1.time_ - 0) / var_36_1)
				arg_33_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6148ui_story"].transform.position).z)
				arg_33_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["6148ui_story"].transform.localEulerAngles = arg_33_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_1 and arg_33_1.time_ < 0 + var_36_1 + arg_36_0 then
				arg_33_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_33_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["6148ui_story"].transform.position).z)
				arg_33_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["6148ui_story"].transform.localEulerAngles = arg_33_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_36_2 = GameObjectTools.GetOrAddComponent(arg_33_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_36_2 then
					var_36_2:EnableDynamicBone(true)
				end
			end

			local var_36_3 = arg_33_1.actors_["6148ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect6148ui_story == nil then
				arg_33_1.var_.characterEffect6148ui_story = var_36_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_4 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_4 and not isNil(var_36_3) then
				if arg_33_1.var_.characterEffect6148ui_story and not isNil(var_36_3) then
					arg_33_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_4 and arg_33_1.time_ < 0 + var_36_4 + arg_36_0 and not isNil(var_36_3) and arg_33_1.var_.characterEffect6148ui_story then
				arg_33_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_2")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_36_6 = 0
			local var_36_7 = 0.475

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(939022008).content)

				arg_33_1.text_.text = var_36_8

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_10 = 19 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_8) / 19)

				if (19 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_8) / 19)) > 0 and var_36_7 < var_36_10 then
					arg_33_1.talkMaxDuration = var_36_10

					if var_36_10 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_8
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_11 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_11 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_11

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_11 and arg_33_1.time_ < var_36_6 + var_36_11 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play939022009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 939022009
		arg_37_1.duration_ = 6.5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play939022010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			local var_40_9000

			if 0.85 < arg_37_1.time_ and arg_37_1.time_ <= 0.85 + arg_40_0 then
				local var_40_0 = arg_37_1.bgs_.ST15a

				arg_37_1.bgs_.ST15a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_1 = var_40_0:GetComponent("SpriteRenderer")

				if var_40_1 and var_40_1.sprite then
					local var_40_2 = 2 * (var_40_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_0.transform.localScale = Vector3.New(var_40_2 / var_40_1.sprite.bounds.size.y < var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x and var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x or var_40_2 / var_40_1.sprite.bounds.size.y, var_40_2 / var_40_1.sprite.bounds.size.y < var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x and var_40_2 * manager.ui.mainCameraCom_.aspect / var_40_1.sprite.bounds.size.x or var_40_2 / var_40_1.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "ST15a" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_3 = 1.5

			if 1.5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_3 + arg_40_0 then
				arg_37_1.allBtn_.enabled = false
			end

			if arg_37_1.time_ >= var_40_3 + 0.3 and arg_37_1.time_ < var_40_3 + 0.3 + arg_40_0 then
				arg_37_1.allBtn_.enabled = true
			end

			local var_40_4 = arg_37_1.actors_["6148ui_story"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos6148ui_story = var_40_4.localPosition

				local var_40_5 = GameObjectTools.GetOrAddComponent(var_40_4.gameObject, typeof(DynamicBoneHelper))

				if var_40_5 then
					var_40_5:EnableDynamicBone(false)
				end
			end

			local var_40_6 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_6 then
				var_40_4.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_37_1.time_ - 0) / var_40_6)
				var_40_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_4.position).x, (manager.ui.mainCamera.transform.position - var_40_4.position).y, (manager.ui.mainCamera.transform.position - var_40_4.position).z)
				var_40_4.localEulerAngles.z = 0
				var_40_4.localEulerAngles.x = 0
				var_40_4.localEulerAngles = var_40_4.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_6 and arg_37_1.time_ < 0 + var_40_6 + arg_40_0 then
				var_40_4.localPosition = Vector3.New(0, 100, 0)
				var_40_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_40_4.position).x, (manager.ui.mainCamera.transform.position - var_40_4.position).y, (manager.ui.mainCamera.transform.position - var_40_4.position).z)
				var_40_4.localEulerAngles.z = 0
				var_40_4.localEulerAngles.x = 0
				var_40_4.localEulerAngles = var_40_4.localEulerAngles

				local var_40_7 = GameObjectTools.GetOrAddComponent(var_40_4.gameObject, typeof(DynamicBoneHelper))

				if var_40_7 then
					var_40_7:EnableDynamicBone(true)
				end
			end

			local var_40_8 = arg_37_1.actors_["6148ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.characterEffect6148ui_story == nil then
				arg_37_1.var_.characterEffect6148ui_story = var_40_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_9 = 0.034000001847744

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_9 and not isNil(var_40_8) then
				if arg_37_1.var_.characterEffect6148ui_story and not isNil(var_40_8) then
					arg_37_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_37_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_9)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_9 and arg_37_1.time_ < 0 + var_40_9 + arg_40_0 and not isNil(var_40_8) and arg_37_1.var_.characterEffect6148ui_story then
				arg_37_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_37_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_10 = arg_37_1.var_.effectzhuanchang1

				if not arg_37_1.var_.effectzhuanchang1 then
					var_40_10 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Zblack"), manager.ui.mainCamera.transform)
					var_40_10.name = "zhuanchang1"
					arg_37_1.var_.effectzhuanchang1 = var_40_10
				else
					var_40_10.transform:SetParent(var_40_9000)
				end

				var_40_10.transform.localPosition = Vector3.New(0, 0, 0)
				var_40_10.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_12 = 1.5
			local var_40_13 = 1.225

			if 1.5 < arg_37_1.time_ and arg_37_1.time_ <= var_40_12 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_14 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_14:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_15 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(939022009).content)

				arg_37_1.text_.text = var_40_15

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_17 = 49 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 49)

				if (49 <= 0 and var_40_13 or var_40_13 * (utf8.len(var_40_15) / 49)) > 0 and var_40_13 < var_40_17 then
					arg_37_1.talkMaxDuration = var_40_17
					var_40_12 = var_40_12 + 0.3

					if var_40_17 + var_40_12 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_17 + var_40_12
					end
				end

				arg_37_1.text_.text = var_40_15
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_18 = var_40_12 + 0.3
			local var_40_19 = math.max(var_40_13, arg_37_1.talkMaxDuration)

			if var_40_12 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_18 + var_40_19 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_18) / var_40_19

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_18 + var_40_19 and arg_37_1.time_ < var_40_18 + var_40_19 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
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
	Play939022010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 939022010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play939022011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1211ui_story = arg_43_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_46_0 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 then
				arg_43_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_43_1.time_ - 0) / var_46_0)
				arg_43_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1211ui_story"].transform.position).z)
				arg_43_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1211ui_story"].transform.localEulerAngles = arg_43_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 then
				arg_43_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_43_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_43_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_43_1.actors_["1211ui_story"].transform.position).z)
				arg_43_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_43_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_43_1.actors_["1211ui_story"].transform.localEulerAngles = arg_43_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_46_1 = arg_43_1.actors_["1211ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1211ui_story == nil then
				arg_43_1.var_.characterEffect1211ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1211ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1211ui_story then
				arg_43_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_46_4 = 0
			local var_46_5 = 0.4

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(939022010).content)

				arg_43_1.text_.text = var_46_6

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_8 = 16 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_6) / 16)

				if (16 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_6) / 16)) > 0 and var_46_5 < var_46_8 then
					arg_43_1.talkMaxDuration = var_46_8

					if var_46_8 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_6
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_9 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_9 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_9

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_9 and arg_43_1.time_ < var_46_4 + var_46_9 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play939022011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 939022011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play939022012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if arg_47_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_50_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_47_1.stage_.transform)

				var_50_0.name = "1284ui_story"
				var_50_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_47_1.actors_["1284ui_story"] = var_50_0

				local var_50_1 = var_50_0:GetComponentInChildren(typeof(CharacterEffect))

				var_50_1.enabled = true

				local var_50_2 = GameObjectTools.GetOrAddComponent(var_50_0, typeof(DynamicBoneHelper))

				if var_50_2 then
					var_50_2:EnableDynamicBone(false)
				end

				arg_47_1:ShowWeapon(var_50_1.transform, false)

				arg_47_1.var_["1284ui_story" .. "Animator"] = var_50_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_47_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_47_1.var_["1284ui_story" .. "LipSync"] = var_50_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_50_3 = arg_47_1.actors_["1284ui_story"].transform

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.var_.moveOldPos1284ui_story = var_50_3.localPosition
			end

			local var_50_4 = 0.001

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 then
				var_50_3.localPosition = Vector3.Lerp(arg_47_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_47_1.time_ - 0) / var_50_4)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 then
				var_50_3.localPosition = Vector3.New(0.7, -0.985, -6.22)
				var_50_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_50_3.position).x, (manager.ui.mainCamera.transform.position - var_50_3.position).y, (manager.ui.mainCamera.transform.position - var_50_3.position).z)
				var_50_3.localEulerAngles.z = 0
				var_50_3.localEulerAngles.x = 0
				var_50_3.localEulerAngles = var_50_3.localEulerAngles
			end

			local var_50_5 = arg_47_1.actors_["1284ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.characterEffect1284ui_story == nil then
				arg_47_1.var_.characterEffect1284ui_story = var_50_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_6 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_6 and not isNil(var_50_5) then
				if arg_47_1.var_.characterEffect1284ui_story and not isNil(var_50_5) then
					arg_47_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_6 and arg_47_1.time_ < 0 + var_50_6 + arg_50_0 and not isNil(var_50_5) and arg_47_1.var_.characterEffect1284ui_story then
				arg_47_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_50_8 = arg_47_1.actors_["1211ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_8) and arg_47_1.var_.characterEffect1211ui_story == nil then
				arg_47_1.var_.characterEffect1211ui_story = var_50_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_9 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_9 and not isNil(var_50_8) then
				if arg_47_1.var_.characterEffect1211ui_story and not isNil(var_50_8) then
					arg_47_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_9)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_9 and arg_47_1.time_ < 0 + var_50_9 + arg_50_0 and not isNil(var_50_8) and arg_47_1.var_.characterEffect1211ui_story then
				arg_47_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_50_10 = 0
			local var_50_11 = 0.25

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_10 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_12 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(939022011).content)

				arg_47_1.text_.text = var_50_12

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_14 = 10 <= 0 and var_50_11 or var_50_11 * (utf8.len(var_50_12) / 10)

				if (10 <= 0 and var_50_11 or var_50_11 * (utf8.len(var_50_12) / 10)) > 0 and var_50_11 < var_50_14 then
					arg_47_1.talkMaxDuration = var_50_14

					if var_50_14 + var_50_10 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_14 + var_50_10
					end
				end

				arg_47_1.text_.text = var_50_12
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_15 = math.max(var_50_11, arg_47_1.talkMaxDuration)

			if var_50_10 <= arg_47_1.time_ and arg_47_1.time_ < var_50_10 + var_50_15 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_10) / var_50_15

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_10 + var_50_15 and arg_47_1.time_ < var_50_10 + var_50_15 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play939022012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 939022012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play939022013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.var_.moveOldPos1211ui_story = arg_51_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_54_0 = 0.001

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 then
				arg_51_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_51_1.time_ - 0) / var_54_0)
				arg_51_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).z)
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles = arg_51_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 then
				arg_51_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				arg_51_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_51_1.actors_["1211ui_story"].transform.position).z)
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_51_1.actors_["1211ui_story"].transform.localEulerAngles = arg_51_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_54_1 = arg_51_1.actors_["1211ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1211ui_story == nil then
				arg_51_1.var_.characterEffect1211ui_story = var_54_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_2 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_2 and not isNil(var_54_1) then
				if arg_51_1.var_.characterEffect1211ui_story and not isNil(var_54_1) then
					arg_51_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_2 and arg_51_1.time_ < 0 + var_54_2 + arg_54_0 and not isNil(var_54_1) and arg_51_1.var_.characterEffect1211ui_story then
				arg_51_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_54_4 = arg_51_1.actors_["1284ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect1284ui_story == nil then
				arg_51_1.var_.characterEffect1284ui_story = var_54_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_5 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_5 and not isNil(var_54_4) then
				if arg_51_1.var_.characterEffect1284ui_story and not isNil(var_54_4) then
					arg_51_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_5)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_5 and arg_51_1.time_ < 0 + var_54_5 + arg_54_0 and not isNil(var_54_4) and arg_51_1.var_.characterEffect1284ui_story then
				arg_51_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211actionlink/1211action434")
			end

			local var_54_6 = 0
			local var_54_7 = 0.575

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_6 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_8 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(939022012).content)

				arg_51_1.text_.text = var_54_8

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 23 <= 0 and var_54_7 or var_54_7 * (utf8.len(var_54_8) / 23)

				if (23 <= 0 and var_54_7 or var_54_7 * (utf8.len(var_54_8) / 23)) > 0 and var_54_7 < var_54_10 then
					arg_51_1.talkMaxDuration = var_54_10

					if var_54_10 + var_54_6 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_6
					end
				end

				arg_51_1.text_.text = var_54_8
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_11 = math.max(var_54_7, arg_51_1.talkMaxDuration)

			if var_54_6 <= arg_51_1.time_ and arg_51_1.time_ < var_54_6 + var_54_11 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_6) / var_54_11

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_6 + var_54_11 and arg_51_1.time_ < var_54_6 + var_54_11 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play939022013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 939022013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play939022014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1211ui_story = arg_55_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).z)
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles = arg_55_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1211ui_story"].transform.position).z)
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1211ui_story"].transform.localEulerAngles = arg_55_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1284ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1284ui_story = var_58_1.localPosition
			end

			local var_58_2 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 then
				var_58_1.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_2)
				var_58_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_1.position).x, (manager.ui.mainCamera.transform.position - var_58_1.position).y, (manager.ui.mainCamera.transform.position - var_58_1.position).z)
				var_58_1.localEulerAngles.z = 0
				var_58_1.localEulerAngles.x = 0
				var_58_1.localEulerAngles = var_58_1.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 then
				var_58_1.localPosition = Vector3.New(0, 100, 0)
				var_58_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_1.position).x, (manager.ui.mainCamera.transform.position - var_58_1.position).y, (manager.ui.mainCamera.transform.position - var_58_1.position).z)
				var_58_1.localEulerAngles.z = 0
				var_58_1.localEulerAngles.x = 0
				var_58_1.localEulerAngles = var_58_1.localEulerAngles
			end

			local var_58_3 = arg_55_1.actors_["1211ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect1211ui_story == nil then
				arg_55_1.var_.characterEffect1211ui_story = var_58_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_4 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 and not isNil(var_58_3) then
				if arg_55_1.var_.characterEffect1211ui_story and not isNil(var_58_3) then
					arg_55_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_4)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect1211ui_story then
				arg_55_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "ui_battle.awb")

				local var_58_7 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_55_1.bgmTxt_.text ~= var_58_7 and arg_55_1.bgmTxt_.text ~= "" then
						if arg_55_1.bgmTxt2_.text ~= "" then
							arg_55_1.bgmTxt_.text = arg_55_1.bgmTxt2_.text
						end

						arg_55_1.bgmTxt2_.text = var_58_7

						arg_55_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_55_1.bgmTxt_.text = var_58_7
						arg_55_1.bgmTxt2_.text = var_58_7
					end

					if arg_55_1.bgmTimer then
						arg_55_1.bgmTimer:Stop()

						arg_55_1.bgmTimer = nil
					end

					if arg_55_1.settingData.show_music_name == 1 then
						arg_55_1.musicController:SetSelectedState("show")
						arg_55_1.musicAnimator_:Play("open", 0, 0)

						if arg_55_1.settingData.music_time ~= 0 then
							arg_55_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_55_1.settingData.music_time), function()
								if arg_55_1 == nil or isNil(arg_55_1.bgmTxt_) then
									return
								end

								arg_55_1.musicController:SetSelectedState("hide")
								arg_55_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_58_8 = 0
			local var_58_9 = 0.75

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_10 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(939022013).content)

				arg_55_1.text_.text = var_58_10

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_12 = 30 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_10) / 30)

				if (30 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_10) / 30)) > 0 and var_58_9 < var_58_12 then
					arg_55_1.talkMaxDuration = var_58_12

					if var_58_12 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_12 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_10
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_13 = math.max(var_58_9, arg_55_1.talkMaxDuration)

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_13 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_8) / var_58_13

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_8 + var_58_13 and arg_55_1.time_ < var_58_8 + var_58_13 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
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
	Play939022014 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 939022014
		arg_60_1.duration_ = 5.52

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play939022015(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_63_0 = 1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 then
				local var_63_1, var_63_2 = math.modf((arg_60_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_63_2 * 0.13, var_63_2 * 0.13, var_63_2 * 0.13) + arg_60_1.var_.shakeOldPos
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 then
				manager.ui.mainCamera.transform.localPosition = arg_60_1.var_.shakeOldPos
			end

			local var_63_3 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_3 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			if arg_60_1.time_ >= var_63_3 + 1 and arg_60_1.time_ < var_63_3 + 1 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_4 = 0.516666666666667
			local var_63_5 = 0.15

			if 0.516666666666667 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_6 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_6:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_7 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(939022014).content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 6 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 6)

				if (6 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 6)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9
					var_63_4 = var_63_4 + 0.3

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = var_63_4 + 0.3
			local var_63_11 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 + 0.3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_10) / var_63_11

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play939022015 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 939022015
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play939022016(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 0.65

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_1 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(939022015).content)

				arg_66_1.text_.text = var_69_1

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_3 = 26 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 26)

				if (26 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 26)) > 0 and var_69_0 < var_69_3 then
					arg_66_1.talkMaxDuration = var_69_3

					if var_69_3 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_3 + 0
					end
				end

				arg_66_1.text_.text = var_69_1
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_4 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_4

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play939022016 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 939022016
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play939022017(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 1.1

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, true)
				arg_70_1.iconController_:SetSelectedState("hero")

				arg_70_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_70_1.callingController_:SetSelectedState("calling")

				arg_70_1.keyicon_.color = Color.New(1, 1, 1)
				arg_70_1.icon_.color = Color.New(1, 1, 1)

				local var_73_1 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(939022016).content)

				arg_70_1.text_.text = var_73_1

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_3 = 44 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 44)

				if (44 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 44)) > 0 and var_73_0 < var_73_3 then
					arg_70_1.talkMaxDuration = var_73_3

					if var_73_3 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_3 + 0
					end
				end

				arg_70_1.text_.text = var_73_1
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_4 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_4

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play939022017 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 939022017
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play939022018(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.85

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, true)
				arg_74_1.iconController_:SetSelectedState("hero")

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_74_1.callingController_:SetSelectedState("calling")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(939022017).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 34 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 34)

				if (34 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 34)) > 0 and var_77_0 < var_77_3 then
					arg_74_1.talkMaxDuration = var_77_3

					if var_77_3 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_3 + 0
					end
				end

				arg_74_1.text_.text = var_77_1
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_4 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_4

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play939022018 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 939022018
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play939022019(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if arg_78_1.actors_["1248ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1248ui_story"))) then
				local var_81_0 = Object.Instantiate(Asset.Load("Char/" .. "1248ui_story"), arg_78_1.stage_.transform)

				var_81_0.name = "1248ui_story"
				var_81_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.actors_["1248ui_story"] = var_81_0

				local var_81_1 = var_81_0:GetComponentInChildren(typeof(CharacterEffect))

				var_81_1.enabled = true

				local var_81_2 = GameObjectTools.GetOrAddComponent(var_81_0, typeof(DynamicBoneHelper))

				if var_81_2 then
					var_81_2:EnableDynamicBone(false)
				end

				arg_78_1:ShowWeapon(var_81_1.transform, false)

				arg_78_1.var_["1248ui_story" .. "Animator"] = var_81_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_78_1.var_["1248ui_story" .. "Animator"].applyRootMotion = true
				arg_78_1.var_["1248ui_story" .. "LipSync"] = var_81_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_81_3 = arg_78_1.actors_["1248ui_story"]

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1248ui_story == nil then
				arg_78_1.var_.characterEffect1248ui_story = var_81_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_4 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_4 and not isNil(var_81_3) then
				if arg_78_1.var_.characterEffect1248ui_story and not isNil(var_81_3) then
					arg_78_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_78_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_78_1.time_ - 0) / var_81_4)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_4 and arg_78_1.time_ < 0 + var_81_4 + arg_81_0 and not isNil(var_81_3) and arg_78_1.var_.characterEffect1248ui_story then
				arg_78_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_78_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_81_5 = 0
			local var_81_6 = 0.525

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_5 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, true)
				arg_78_1.iconController_:SetSelectedState("hero")

				arg_78_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_78_1.callingController_:SetSelectedState("normal")

				arg_78_1.keyicon_.color = Color.New(1, 1, 1)
				arg_78_1.icon_.color = Color.New(1, 1, 1)

				local var_81_7 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(939022018).content)

				arg_78_1.text_.text = var_81_7

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_9 = 21 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_7) / 21)

				if (21 <= 0 and var_81_6 or var_81_6 * (utf8.len(var_81_7) / 21)) > 0 and var_81_6 < var_81_9 then
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

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play939022019 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 939022019
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play939022020(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.75

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, true)
				arg_82_1.iconController_:SetSelectedState("hero")

				arg_82_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_82_1.callingController_:SetSelectedState("calling")

				arg_82_1.keyicon_.color = Color.New(1, 1, 1)
				arg_82_1.icon_.color = Color.New(1, 1, 1)

				local var_85_1 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(939022019).content)

				arg_82_1.text_.text = var_85_1

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_3 = 30 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 30)

				if (30 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_1) / 30)) > 0 and var_85_0 < var_85_3 then
					arg_82_1.talkMaxDuration = var_85_3

					if var_85_3 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_3 + 0
					end
				end

				arg_82_1.text_.text = var_85_1
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_4 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_4

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play939022020 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 939022020
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play939022021(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.9

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_86_1.callingController_:SetSelectedState("calling")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_1 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(939022020).content)

				arg_86_1.text_.text = var_89_1

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_3 = 36 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 36)

				if (36 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 36)) > 0 and var_89_0 < var_89_3 then
					arg_86_1.talkMaxDuration = var_89_3

					if var_89_3 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_3 + 0
					end
				end

				arg_86_1.text_.text = var_89_1
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_4 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_4

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play939022021 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 939022021
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play939022022(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1248ui_story"]) and arg_90_1.var_.characterEffect1248ui_story == nil then
				arg_90_1.var_.characterEffect1248ui_story = arg_90_1.actors_["1248ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["1248ui_story"]) then
				if arg_90_1.var_.characterEffect1248ui_story and not isNil(arg_90_1.actors_["1248ui_story"]) then
					arg_90_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_90_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_0)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["1248ui_story"]) and arg_90_1.var_.characterEffect1248ui_story then
				arg_90_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_90_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_93_1 = 0
			local var_93_2 = 0.55

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, true)
				arg_90_1.iconController_:SetSelectedState("hero")

				arg_90_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_90_1.callingController_:SetSelectedState("normal")

				arg_90_1.keyicon_.color = Color.New(1, 1, 1)
				arg_90_1.icon_.color = Color.New(1, 1, 1)

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(939022021).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 22 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 22)

				if (22 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 22)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play939022022 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 939022022
		arg_94_1.duration_ = 9

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play939022023(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if arg_94_1.bgs_.H01b == nil then
				local var_97_0 = Object.Instantiate(arg_94_1.paintGo_)

				var_97_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H01b")
				var_97_0.name = "H01b"
				var_97_0.transform.parent = arg_94_1.stage_.transform
				var_97_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.bgs_.H01b = var_97_0
			end

			if 2 < arg_94_1.time_ and arg_94_1.time_ <= 2 + arg_97_0 then
				local var_97_1 = arg_94_1.bgs_.H01b

				arg_94_1.bgs_.H01b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_97_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_97_2 = var_97_1:GetComponent("SpriteRenderer")

				if var_97_2 and var_97_2.sprite then
					local var_97_3 = 2 * (var_97_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_97_1.transform.localScale = Vector3.New(var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, var_97_3 / var_97_2.sprite.bounds.size.y < var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x and var_97_3 * manager.ui.mainCameraCom_.aspect / var_97_2.sprite.bounds.size.x or var_97_3 / var_97_2.sprite.bounds.size.y, 0)
				end

				for iter_97_0, iter_97_1 in pairs(arg_94_1.bgs_) do
					if iter_97_0 ~= "H01b" then
						iter_97_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_97_4 = 3.999999999999

			if 3.999999999999 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.allBtn_.enabled = false
			end

			if arg_94_1.time_ >= var_97_4 + 0.3 and arg_94_1.time_ < var_97_4 + 0.3 + arg_97_0 then
				arg_94_1.allBtn_.enabled = true
			end

			local var_97_5 = 0

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_5 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_6 = 2

			if var_97_5 <= arg_94_1.time_ and arg_94_1.time_ < var_97_5 + var_97_6 then
				local var_97_7 = Color.New(0, 0, 0)

				var_97_7.a = Mathf.Lerp(0, 1, (arg_94_1.time_ - var_97_5) / var_97_6)
				arg_94_1.mask_.color = var_97_7
			end

			if arg_94_1.time_ >= var_97_5 + var_97_6 and arg_94_1.time_ < var_97_5 + var_97_6 + arg_97_0 then
				local var_97_8 = Color.New(0, 0, 0)

				var_97_8.a = 1
				arg_94_1.mask_.color = var_97_8
			end

			local var_97_9 = 2

			if 2 < arg_94_1.time_ and arg_94_1.time_ <= var_97_9 + arg_97_0 then
				arg_94_1.mask_.enabled = true
				arg_94_1.mask_.raycastTarget = true

				arg_94_1:SetGaussion(false)
			end

			local var_97_10 = 2

			if var_97_9 <= arg_94_1.time_ and arg_94_1.time_ < var_97_9 + var_97_10 then
				local var_97_11 = Color.New(0, 0, 0)

				var_97_11.a = Mathf.Lerp(1, 0, (arg_94_1.time_ - var_97_9) / var_97_10)
				arg_94_1.mask_.color = var_97_11
			end

			if arg_94_1.time_ >= var_97_9 + var_97_10 and arg_94_1.time_ < var_97_9 + var_97_10 + arg_97_0 then
				local var_97_12 = Color.New(0, 0, 0)

				arg_94_1.mask_.enabled = false
				var_97_12.a = 0
				arg_94_1.mask_.color = var_97_12
			end

			if arg_94_1.frameCnt_ <= 1 then
				arg_94_1.dialog_:SetActive(false)
			end

			local var_97_13 = 4
			local var_97_14 = 1.4

			if 4 < arg_94_1.time_ and arg_94_1.time_ <= var_97_13 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0

				arg_94_1.dialog_:SetActive(true)

				arg_94_1.dialogCg_.alpha = 0

				local var_97_15 = LeanTween.value(arg_94_1.dialog_, 0, 1, 0.3)

				var_97_15:setOnUpdate(LuaHelper.FloatAction(function(arg_98_0)
					arg_94_1.dialogCg_.alpha = arg_98_0
				end))
				var_97_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_94_1.dialog_)
					var_97_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_94_1.duration_ = arg_94_1.duration_ + 0.3

				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_16 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(939022022).content)

				arg_94_1.text_.text = var_97_16

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_18 = 56 <= 0 and var_97_14 or var_97_14 * (utf8.len(var_97_16) / 56)

				if (56 <= 0 and var_97_14 or var_97_14 * (utf8.len(var_97_16) / 56)) > 0 and var_97_14 < var_97_18 then
					arg_94_1.talkMaxDuration = var_97_18
					var_97_13 = var_97_13 + 0.3

					if var_97_18 + var_97_13 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_18 + var_97_13
					end
				end

				arg_94_1.text_.text = var_97_16
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_19 = var_97_13 + 0.3
			local var_97_20 = math.max(var_97_14, arg_94_1.talkMaxDuration)

			if var_97_13 + 0.3 <= arg_94_1.time_ and arg_94_1.time_ < var_97_19 + var_97_20 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_19) / var_97_20

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_19 + var_97_20 and arg_94_1.time_ < var_97_19 + var_97_20 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play939022023 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 939022023
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play939022024(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.625

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(939022023).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 25 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 25)

				if (25 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 25)) > 0 and var_103_0 < var_103_3 then
					arg_100_1.talkMaxDuration = var_103_3

					if var_103_3 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_3 + 0
					end
				end

				arg_100_1.text_.text = var_103_1
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_4 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_4

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play939022024 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 939022024
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play939022025(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.85

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(939022024).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 34 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 34)

				if (34 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 34)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play939022025 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 939022025
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play939022026(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 1.275

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(939022025).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 51 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 51)

				if (51 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 51)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play939022026 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 939022026
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play939022027(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 0.125

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, true)
				arg_112_1.iconController_:SetSelectedState("hero")

				arg_112_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_112_1.callingController_:SetSelectedState("normal")

				arg_112_1.keyicon_.color = Color.New(1, 1, 1)
				arg_112_1.icon_.color = Color.New(1, 1, 1)

				local var_115_1 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(939022026).content)

				arg_112_1.text_.text = var_115_1

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_3 = 5 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 5)

				if (5 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 5)) > 0 and var_115_0 < var_115_3 then
					arg_112_1.talkMaxDuration = var_115_3

					if var_115_3 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_3 + 0
					end
				end

				arg_112_1.text_.text = var_115_1
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_4 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_4

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play939022027 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 939022027
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play939022028(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 0.75

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(939022027).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 30 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 30)

				if (30 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 30)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play939022028 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 939022028
		arg_120_1.duration_ = 5

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play939022029(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if arg_120_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_123_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_120_1.stage_.transform)

				var_123_0.name = "1081ui_story"
				var_123_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_120_1.actors_["1081ui_story"] = var_123_0

				local var_123_1 = var_123_0:GetComponentInChildren(typeof(CharacterEffect))

				var_123_1.enabled = true

				local var_123_2 = GameObjectTools.GetOrAddComponent(var_123_0, typeof(DynamicBoneHelper))

				if var_123_2 then
					var_123_2:EnableDynamicBone(false)
				end

				arg_120_1:ShowWeapon(var_123_1.transform, false)

				arg_120_1.var_["1081ui_story" .. "Animator"] = var_123_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_120_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_120_1.var_["1081ui_story" .. "LipSync"] = var_123_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_123_3 = arg_120_1.actors_["1081ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1081ui_story = var_123_3.localPosition
			end

			local var_123_4 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_4 then
				var_123_3.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_120_1.time_ - 0) / var_123_4)
				var_123_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_3.position).x, (manager.ui.mainCamera.transform.position - var_123_3.position).y, (manager.ui.mainCamera.transform.position - var_123_3.position).z)
				var_123_3.localEulerAngles.z = 0
				var_123_3.localEulerAngles.x = 0
				var_123_3.localEulerAngles = var_123_3.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_4 and arg_120_1.time_ < 0 + var_123_4 + arg_123_0 then
				var_123_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_123_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_3.position).x, (manager.ui.mainCamera.transform.position - var_123_3.position).y, (manager.ui.mainCamera.transform.position - var_123_3.position).z)
				var_123_3.localEulerAngles.z = 0
				var_123_3.localEulerAngles.x = 0
				var_123_3.localEulerAngles = var_123_3.localEulerAngles
			end

			local var_123_5 = arg_120_1.actors_["1081ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_5) and arg_120_1.var_.characterEffect1081ui_story == nil then
				arg_120_1.var_.characterEffect1081ui_story = var_123_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_6 = 0.200000002980232

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_6 and not isNil(var_123_5) then
				if arg_120_1.var_.characterEffect1081ui_story and not isNil(var_123_5) then
					arg_120_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_6 and arg_120_1.time_ < 0 + var_123_6 + arg_123_0 and not isNil(var_123_5) and arg_120_1.var_.characterEffect1081ui_story then
				arg_120_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:AudioAction("play", "music", "bgm_side_daily02", "bgm_side_daily02", "bgm_side_daily02.awb")

				local var_123_10 = manager.audio:GetAudioName("bgm_side_daily02", "bgm_side_daily02")

				if "" ~= "" then
					if arg_120_1.bgmTxt_.text ~= var_123_10 and arg_120_1.bgmTxt_.text ~= "" then
						if arg_120_1.bgmTxt2_.text ~= "" then
							arg_120_1.bgmTxt_.text = arg_120_1.bgmTxt2_.text
						end

						arg_120_1.bgmTxt2_.text = var_123_10

						arg_120_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_120_1.bgmTxt_.text = var_123_10
						arg_120_1.bgmTxt2_.text = var_123_10
					end

					if arg_120_1.bgmTimer then
						arg_120_1.bgmTimer:Stop()

						arg_120_1.bgmTimer = nil
					end

					if arg_120_1.settingData.show_music_name == 1 then
						arg_120_1.musicController:SetSelectedState("show")
						arg_120_1.musicAnimator_:Play("open", 0, 0)

						if arg_120_1.settingData.music_time ~= 0 then
							arg_120_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_120_1.settingData.music_time), function()
								if arg_120_1 == nil or isNil(arg_120_1.bgmTxt_) then
									return
								end

								arg_120_1.musicController:SetSelectedState("hide")
								arg_120_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_123_11 = 0
			local var_123_12 = 0.725

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_11 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_13 = arg_120_1:FormatText(arg_120_1:GetWordFromCfg(939022028).content)

				arg_120_1.text_.text = var_123_13

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_15 = 29 <= 0 and var_123_12 or var_123_12 * (utf8.len(var_123_13) / 29)

				if (29 <= 0 and var_123_12 or var_123_12 * (utf8.len(var_123_13) / 29)) > 0 and var_123_12 < var_123_15 then
					arg_120_1.talkMaxDuration = var_123_15

					if var_123_15 + var_123_11 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_15 + var_123_11
					end
				end

				arg_120_1.text_.text = var_123_13
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)
				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_12, arg_120_1.talkMaxDuration)

			if var_123_11 <= arg_120_1.time_ and arg_120_1.time_ < var_123_11 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_11) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_11 + var_123_16 and arg_120_1.time_ < var_123_11 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_120_1:InitPlayNodeList()
	end,
	Play939022029 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 939022029
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play939022030(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1081ui_story"]) and arg_125_1.var_.characterEffect1081ui_story == nil then
				arg_125_1.var_.characterEffect1081ui_story = arg_125_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1081ui_story"]) then
				if arg_125_1.var_.characterEffect1081ui_story and not isNil(arg_125_1.actors_["1081ui_story"]) then
					arg_125_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1081ui_story"]) and arg_125_1.var_.characterEffect1081ui_story then
				arg_125_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 0.15

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, true)
				arg_125_1.iconController_:SetSelectedState("hero")

				arg_125_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_125_1.callingController_:SetSelectedState("normal")

				arg_125_1.keyicon_.color = Color.New(1, 1, 1)
				arg_125_1.icon_.color = Color.New(1, 1, 1)

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(939022029).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 6 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 6)

				if (6 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 6)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play939022030 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 939022030
		arg_129_1.duration_ = 5

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play939022031(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1081ui_story = arg_129_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).z)
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles = arg_129_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_129_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1081ui_story"].transform.position).z)
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1081ui_story"].transform.localEulerAngles = arg_129_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1081ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1081ui_story == nil then
				arg_129_1.var_.characterEffect1081ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1081ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1081ui_story then
				arg_129_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action5_2")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_132_4 = 0
			local var_132_5 = 0.375

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_6 = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(939022030).content)

				arg_129_1.text_.text = var_132_6

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_8 = 15 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_6) / 15)

				if (15 <= 0 and var_132_5 or var_132_5 * (utf8.len(var_132_6) / 15)) > 0 and var_132_5 < var_132_8 then
					arg_129_1.talkMaxDuration = var_132_8

					if var_132_8 + var_132_4 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_8 + var_132_4
					end
				end

				arg_129_1.text_.text = var_132_6
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)
				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_9 = math.max(var_132_5, arg_129_1.talkMaxDuration)

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_9 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_4) / var_132_9

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_4 + var_132_9 and arg_129_1.time_ < var_132_4 + var_132_9 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play939022031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 939022031
		arg_133_1.duration_ = 5

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play939022032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos1081ui_story = arg_133_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).z)
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles = arg_133_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["1081ui_story"].transform.position).z)
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["1081ui_story"].transform.localEulerAngles = arg_133_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["1081ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1081ui_story == nil then
				arg_133_1.var_.characterEffect1081ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect1081ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_2)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect1081ui_story then
				arg_133_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_136_3 = 0
			local var_136_4 = 0.575

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

				local var_136_5 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(939022031).content)

				arg_133_1.text_.text = var_136_5

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_7 = 23 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 23)

				if (23 <= 0 and var_136_4 or var_136_4 * (utf8.len(var_136_5) / 23)) > 0 and var_136_4 < var_136_7 then
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
				actorName = "1081ui_story",
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
	Play939022032 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 939022032
		arg_137_1.duration_ = 5

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play939022033(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1081ui_story = arg_137_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).z)
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles = arg_137_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, -0.92, -5.8)
				arg_137_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1081ui_story"].transform.position).z)
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1081ui_story"].transform.localEulerAngles = arg_137_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1081ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1081ui_story == nil then
				arg_137_1.var_.characterEffect1081ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1081ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1081ui_story then
				arg_137_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action3_1")
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_140_4 = 0
			local var_140_5 = 0.7

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_4 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_6 = arg_137_1:FormatText(arg_137_1:GetWordFromCfg(939022032).content)

				arg_137_1.text_.text = var_140_6

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_8 = 28 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_6) / 28)

				if (28 <= 0 and var_140_5 or var_140_5 * (utf8.len(var_140_6) / 28)) > 0 and var_140_5 < var_140_8 then
					arg_137_1.talkMaxDuration = var_140_8

					if var_140_8 + var_140_4 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_8 + var_140_4
					end
				end

				arg_137_1.text_.text = var_140_6
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)
				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_9 = math.max(var_140_5, arg_137_1.talkMaxDuration)

			if var_140_4 <= arg_137_1.time_ and arg_137_1.time_ < var_140_4 + var_140_9 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_4) / var_140_9

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_4 + var_140_9 and arg_137_1.time_ < var_140_4 + var_140_9 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play939022033 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 939022033
		arg_141_1.duration_ = 5

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play939022034(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 and not isNil(arg_141_1.actors_["1081ui_story"]) and arg_141_1.var_.characterEffect1081ui_story == nil then
				arg_141_1.var_.characterEffect1081ui_story = arg_141_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_144_0 = 0.200000002980232

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 and not isNil(arg_141_1.actors_["1081ui_story"]) then
				if arg_141_1.var_.characterEffect1081ui_story and not isNil(arg_141_1.actors_["1081ui_story"]) then
					arg_141_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_141_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_141_1.time_ - 0) / var_144_0)
				end
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 and not isNil(arg_141_1.actors_["1081ui_story"]) and arg_141_1.var_.characterEffect1081ui_story then
				arg_141_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_141_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_144_1 = 0
			local var_144_2 = 0.2

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, true)
				arg_141_1.iconController_:SetSelectedState("hero")

				arg_141_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_141_1.callingController_:SetSelectedState("normal")

				arg_141_1.keyicon_.color = Color.New(1, 1, 1)
				arg_141_1.icon_.color = Color.New(1, 1, 1)

				local var_144_3 = arg_141_1:FormatText(arg_141_1:GetWordFromCfg(939022033).content)

				arg_141_1.text_.text = var_144_3

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_5 = 8 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 8)

				if (8 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_3) / 8)) > 0 and var_144_2 < var_144_5 then
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

		arg_141_1.nodeConfigList_ = {}

		arg_141_1:InitPlayNodeList()
	end,
	Play939022034 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 939022034
		arg_145_1.duration_ = 5

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play939022035(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos1081ui_story = arg_145_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).z)
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles = arg_145_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_145_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["1081ui_story"].transform.position).z)
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["1081ui_story"].transform.localEulerAngles = arg_145_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_148_1 = 0
			local var_148_2 = 0.375

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_1 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, false)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_3 = arg_145_1:FormatText(arg_145_1:GetWordFromCfg(939022034).content)

				arg_145_1.text_.text = var_148_3

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_5 = 15 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 15)

				if (15 <= 0 and var_148_2 or var_148_2 * (utf8.len(var_148_3) / 15)) > 0 and var_148_2 < var_148_5 then
					arg_145_1.talkMaxDuration = var_148_5

					if var_148_5 + var_148_1 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_5 + var_148_1
					end
				end

				arg_145_1.text_.text = var_148_3
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)
				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_6 = math.max(var_148_2, arg_145_1.talkMaxDuration)

			if var_148_1 <= arg_145_1.time_ and arg_145_1.time_ < var_148_1 + var_148_6 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_1) / var_148_6

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_1 + var_148_6 and arg_145_1.time_ < var_148_1 + var_148_6 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play939022035 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 939022035
		arg_149_1.duration_ = 5

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play939022036(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			local var_152_0 = 0.775

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, true)
				arg_149_1.iconController_:SetSelectedState("hero")

				arg_149_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_149_1.callingController_:SetSelectedState("normal")

				arg_149_1.keyicon_.color = Color.New(1, 1, 1)
				arg_149_1.icon_.color = Color.New(1, 1, 1)

				local var_152_1 = arg_149_1:FormatText(arg_149_1:GetWordFromCfg(939022035).content)

				arg_149_1.text_.text = var_152_1

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_3 = 31 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 31)

				if (31 <= 0 and var_152_0 or var_152_0 * (utf8.len(var_152_1) / 31)) > 0 and var_152_0 < var_152_3 then
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
	Play939022036 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 939022036
		arg_153_1.duration_ = 5

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play939022037(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.var_.moveOldPos1081ui_story = arg_153_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_156_0 = 0.001

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_0 then
				arg_153_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_153_1.var_.moveOldPos1081ui_story, Vector3.New(-0.7, -0.92, -5.8), (arg_153_1.time_ - 0) / var_156_0)
				arg_153_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).z)
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles = arg_153_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_153_1.time_ >= 0 + var_156_0 and arg_153_1.time_ < 0 + var_156_0 + arg_156_0 then
				arg_153_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(-0.7, -0.92, -5.8)
				arg_153_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_153_1.actors_["1081ui_story"].transform.position).z)
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_153_1.actors_["1081ui_story"].transform.localEulerAngles = arg_153_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_156_1 = arg_153_1.actors_["1081ui_story"]

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1081ui_story == nil then
				arg_153_1.var_.characterEffect1081ui_story = var_156_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_156_2 = 0.200000002980232

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_2 and not isNil(var_156_1) then
				if arg_153_1.var_.characterEffect1081ui_story and not isNil(var_156_1) then
					arg_153_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_153_1.time_ >= 0 + var_156_2 and arg_153_1.time_ < 0 + var_156_2 + arg_156_0 and not isNil(var_156_1) and arg_153_1.var_.characterEffect1081ui_story then
				arg_153_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action435")
			end

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_156_4 = 0
			local var_156_5 = 1.25

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= var_156_4 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_6 = arg_153_1:FormatText(arg_153_1:GetWordFromCfg(939022036).content)

				arg_153_1.text_.text = var_156_6

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_8 = 50 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_6) / 50)

				if (50 <= 0 and var_156_5 or var_156_5 * (utf8.len(var_156_6) / 50)) > 0 and var_156_5 < var_156_8 then
					arg_153_1.talkMaxDuration = var_156_8

					if var_156_8 + var_156_4 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_8 + var_156_4
					end
				end

				arg_153_1.text_.text = var_156_6
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)
				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_9 = math.max(var_156_5, arg_153_1.talkMaxDuration)

			if var_156_4 <= arg_153_1.time_ and arg_153_1.time_ < var_156_4 + var_156_9 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - var_156_4) / var_156_9

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= var_156_4 + var_156_9 and arg_153_1.time_ < var_156_4 + var_156_9 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play939022037 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 939022037
		arg_157_1.duration_ = 5

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play939022038(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1211ui_story = arg_157_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1211ui_story, Vector3.New(0.7, -0.67, -6.07), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1211ui_story"].transform.position).z)
				arg_157_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1211ui_story"].transform.localEulerAngles = arg_157_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0.7, -0.67, -6.07)
				arg_157_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1211ui_story"].transform.position).z)
				arg_157_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1211ui_story"].transform.localEulerAngles = arg_157_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_160_1 = arg_157_1.actors_["1211ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1211ui_story == nil then
				arg_157_1.var_.characterEffect1211ui_story = var_160_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_2 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_2 and not isNil(var_160_1) then
				if arg_157_1.var_.characterEffect1211ui_story and not isNil(var_160_1) then
					arg_157_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_157_1.time_ >= 0 + var_160_2 and arg_157_1.time_ < 0 + var_160_2 + arg_160_0 and not isNil(var_160_1) and arg_157_1.var_.characterEffect1211ui_story then
				arg_157_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_160_4 = arg_157_1.actors_["1081ui_story"]

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1081ui_story == nil then
				arg_157_1.var_.characterEffect1081ui_story = var_160_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_160_5 = 0.200000002980232

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_5 and not isNil(var_160_4) then
				if arg_157_1.var_.characterEffect1081ui_story and not isNil(var_160_4) then
					arg_157_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_157_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_157_1.time_ - 0) / var_160_5)
				end
			end

			if arg_157_1.time_ >= 0 + var_160_5 and arg_157_1.time_ < 0 + var_160_5 + arg_160_0 and not isNil(var_160_4) and arg_157_1.var_.characterEffect1081ui_story then
				arg_157_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_157_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action4_1")
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_160_6 = 0
			local var_160_7 = 0.4

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_6 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_8 = arg_157_1:FormatText(arg_157_1:GetWordFromCfg(939022037).content)

				arg_157_1.text_.text = var_160_8

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_10 = 16 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_8) / 16)

				if (16 <= 0 and var_160_7 or var_160_7 * (utf8.len(var_160_8) / 16)) > 0 and var_160_7 < var_160_10 then
					arg_157_1.talkMaxDuration = var_160_10

					if var_160_10 + var_160_6 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_10 + var_160_6
					end
				end

				arg_157_1.text_.text = var_160_8
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)
				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_11 = math.max(var_160_7, arg_157_1.talkMaxDuration)

			if var_160_6 <= arg_157_1.time_ and arg_157_1.time_ < var_160_6 + var_160_11 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_6) / var_160_11

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_6 + var_160_11 and arg_157_1.time_ < var_160_6 + var_160_11 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_157_1:InitPlayNodeList()
	end,
	Play939022038 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 939022038
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play939022039(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos6148ui_story = arg_161_1.actors_["6148ui_story"].transform.localPosition

				local var_164_0 = GameObjectTools.GetOrAddComponent(arg_161_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_164_0 then
					var_164_0:EnableDynamicBone(false)
				end
			end

			local var_164_1 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_1 then
				arg_161_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_161_1.time_ - 0) / var_164_1)
				arg_161_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).z)
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles = arg_161_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_1 and arg_161_1.time_ < 0 + var_164_1 + arg_164_0 then
				arg_161_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_161_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["6148ui_story"].transform.position).z)
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["6148ui_story"].transform.localEulerAngles = arg_161_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_164_2 = GameObjectTools.GetOrAddComponent(arg_161_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_164_2 then
					var_164_2:EnableDynamicBone(true)
				end
			end

			local var_164_3 = arg_161_1.actors_["1211ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1211ui_story = var_164_3.localPosition
			end

			local var_164_4 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				var_164_3.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_4)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				var_164_3.localPosition = Vector3.New(0, 100, 0)
				var_164_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_3.position).x, (manager.ui.mainCamera.transform.position - var_164_3.position).y, (manager.ui.mainCamera.transform.position - var_164_3.position).z)
				var_164_3.localEulerAngles.z = 0
				var_164_3.localEulerAngles.x = 0
				var_164_3.localEulerAngles = var_164_3.localEulerAngles
			end

			local var_164_5 = arg_161_1.actors_["6148ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect6148ui_story == nil then
				arg_161_1.var_.characterEffect6148ui_story = var_164_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_6 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_6 and not isNil(var_164_5) then
				if arg_161_1.var_.characterEffect6148ui_story and not isNil(var_164_5) then
					arg_161_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_161_1.time_ >= 0 + var_164_6 and arg_161_1.time_ < 0 + var_164_6 + arg_164_0 and not isNil(var_164_5) and arg_161_1.var_.characterEffect6148ui_story then
				arg_161_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_164_8 = arg_161_1.actors_["1211ui_story"]

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.characterEffect1211ui_story == nil then
				arg_161_1.var_.characterEffect1211ui_story = var_164_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_164_9 = 0.200000002980232

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_9 and not isNil(var_164_8) then
				if arg_161_1.var_.characterEffect1211ui_story and not isNil(var_164_8) then
					arg_161_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_161_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_161_1.time_ - 0) / var_164_9)
				end
			end

			if arg_161_1.time_ >= 0 + var_164_9 and arg_161_1.time_ < 0 + var_164_9 + arg_164_0 and not isNil(var_164_8) and arg_161_1.var_.characterEffect1211ui_story then
				arg_161_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_161_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_164_10 = 0
			local var_164_11 = 0.925

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_10 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, true)

				arg_161_1.leftNameTxt_.text = arg_161_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_161_1.leftNameTxt_.transform)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1.leftNameTxt_.text)
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_12 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(939022038).content)

				arg_161_1.text_.text = var_164_12

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_14 = 37 <= 0 and var_164_11 or var_164_11 * (utf8.len(var_164_12) / 37)

				if (37 <= 0 and var_164_11 or var_164_11 * (utf8.len(var_164_12) / 37)) > 0 and var_164_11 < var_164_14 then
					arg_161_1.talkMaxDuration = var_164_14

					if var_164_14 + var_164_10 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_14 + var_164_10
					end
				end

				arg_161_1.text_.text = var_164_12
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_15 = math.max(var_164_11, arg_161_1.talkMaxDuration)

			if var_164_10 <= arg_161_1.time_ and arg_161_1.time_ < var_164_10 + var_164_15 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_10) / var_164_15

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_10 + var_164_15 and arg_161_1.time_ < var_164_10 + var_164_15 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
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
	Play939022039 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 939022039
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play939022040(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos1081ui_story = arg_165_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos1081ui_story, Vector3.New(-0.7, -0.92, -5.8), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).z)
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles = arg_165_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(-0.7, -0.92, -5.8)
				arg_165_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["1081ui_story"].transform.position).z)
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["1081ui_story"].transform.localEulerAngles = arg_165_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["1081ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1081ui_story == nil then
				arg_165_1.var_.characterEffect1081ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect1081ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect1081ui_story then
				arg_165_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_168_4 = arg_165_1.actors_["6148ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect6148ui_story == nil then
				arg_165_1.var_.characterEffect6148ui_story = var_168_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_5 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_5 and not isNil(var_168_4) then
				if arg_165_1.var_.characterEffect6148ui_story and not isNil(var_168_4) then
					arg_165_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_165_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_165_1.time_ - 0) / var_168_5)
				end
			end

			if arg_165_1.time_ >= 0 + var_168_5 and arg_165_1.time_ < 0 + var_168_5 + arg_168_0 and not isNil(var_168_4) and arg_165_1.var_.characterEffect6148ui_story then
				arg_165_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_165_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action459")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_168_6 = 0
			local var_168_7 = 1.05

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_6 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_8 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(939022039).content)

				arg_165_1.text_.text = var_168_8

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_10 = 42 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_8) / 42)

				if (42 <= 0 and var_168_7 or var_168_7 * (utf8.len(var_168_8) / 42)) > 0 and var_168_7 < var_168_10 then
					arg_165_1.talkMaxDuration = var_168_10

					if var_168_10 + var_168_6 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_6
					end
				end

				arg_165_1.text_.text = var_168_8
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_11 = math.max(var_168_7, arg_165_1.talkMaxDuration)

			if var_168_6 <= arg_165_1.time_ and arg_165_1.time_ < var_168_6 + var_168_11 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_6) / var_168_11

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_6 + var_168_11 and arg_165_1.time_ < var_168_6 + var_168_11 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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
	Play939022040 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 939022040
		arg_169_1.duration_ = 5

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play939022041(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos1081ui_story = arg_169_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos1081ui_story, Vector3.New(-0.7, -0.92, -5.8), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).z)
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles = arg_169_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(-0.7, -0.92, -5.8)
				arg_169_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["1081ui_story"].transform.position).z)
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["1081ui_story"].transform.localEulerAngles = arg_169_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action492")
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_172_1 = 0
			local var_172_2 = 0.725

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(939022040).content)

				arg_169_1.text_.text = var_172_3

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_5 = 29 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 29)

				if (29 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_3) / 29)) > 0 and var_172_2 < var_172_5 then
					arg_169_1.talkMaxDuration = var_172_5

					if var_172_5 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_5 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_3
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_6 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_6 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_6

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_6 and arg_169_1.time_ < var_172_1 + var_172_6 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play939022041 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 939022041
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play939022042(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1054ui_story = arg_173_1.actors_["1054ui_story"].transform.localPosition

				local var_176_0 = GameObjectTools.GetOrAddComponent(arg_173_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_176_0 then
					var_176_0:EnableDynamicBone(false)
				end
			end

			local var_176_1 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_1 then
				arg_173_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_173_1.time_ - 0) / var_176_1)
				arg_173_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1054ui_story"].transform.position).z)
				arg_173_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1054ui_story"].transform.localEulerAngles = arg_173_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_1 and arg_173_1.time_ < 0 + var_176_1 + arg_176_0 then
				arg_173_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_173_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1054ui_story"].transform.position).z)
				arg_173_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1054ui_story"].transform.localEulerAngles = arg_173_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_176_2 = GameObjectTools.GetOrAddComponent(arg_173_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_176_2 then
					var_176_2:EnableDynamicBone(true)
				end
			end

			local var_176_3 = arg_173_1.actors_["6148ui_story"].transform

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos6148ui_story = var_176_3.localPosition

				local var_176_4 = GameObjectTools.GetOrAddComponent(var_176_3.gameObject, typeof(DynamicBoneHelper))

				if var_176_4 then
					var_176_4:EnableDynamicBone(false)
				end
			end

			local var_176_5 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_5 then
				var_176_3.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_5)
				var_176_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_3.position).x, (manager.ui.mainCamera.transform.position - var_176_3.position).y, (manager.ui.mainCamera.transform.position - var_176_3.position).z)
				var_176_3.localEulerAngles.z = 0
				var_176_3.localEulerAngles.x = 0
				var_176_3.localEulerAngles = var_176_3.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_5 and arg_173_1.time_ < 0 + var_176_5 + arg_176_0 then
				var_176_3.localPosition = Vector3.New(0, 100, 0)
				var_176_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_176_3.position).x, (manager.ui.mainCamera.transform.position - var_176_3.position).y, (manager.ui.mainCamera.transform.position - var_176_3.position).z)
				var_176_3.localEulerAngles.z = 0
				var_176_3.localEulerAngles.x = 0
				var_176_3.localEulerAngles = var_176_3.localEulerAngles

				local var_176_6 = GameObjectTools.GetOrAddComponent(var_176_3.gameObject, typeof(DynamicBoneHelper))

				if var_176_6 then
					var_176_6:EnableDynamicBone(true)
				end
			end

			local var_176_7 = arg_173_1.actors_["1054ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.characterEffect1054ui_story == nil then
				arg_173_1.var_.characterEffect1054ui_story = var_176_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_8 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_8 and not isNil(var_176_7) then
				if arg_173_1.var_.characterEffect1054ui_story and not isNil(var_176_7) then
					arg_173_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_8 and arg_173_1.time_ < 0 + var_176_8 + arg_176_0 and not isNil(var_176_7) and arg_173_1.var_.characterEffect1054ui_story then
				arg_173_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_176_10 = arg_173_1.actors_["1081ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_10) and arg_173_1.var_.characterEffect1081ui_story == nil then
				arg_173_1.var_.characterEffect1081ui_story = var_176_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_11 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_11 and not isNil(var_176_10) then
				if arg_173_1.var_.characterEffect1081ui_story and not isNil(var_176_10) then
					arg_173_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_173_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_173_1.time_ - 0) / var_176_11)
				end
			end

			if arg_173_1.time_ >= 0 + var_176_11 and arg_173_1.time_ < 0 + var_176_11 + arg_176_0 and not isNil(var_176_10) and arg_173_1.var_.characterEffect1081ui_story then
				arg_173_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_173_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_176_12 = 0
			local var_176_13 = 0.225

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_12 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_14 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(939022041).content)

				arg_173_1.text_.text = var_176_14

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_16 = 9 <= 0 and var_176_13 or var_176_13 * (utf8.len(var_176_14) / 9)

				if (9 <= 0 and var_176_13 or var_176_13 * (utf8.len(var_176_14) / 9)) > 0 and var_176_13 < var_176_16 then
					arg_173_1.talkMaxDuration = var_176_16

					if var_176_16 + var_176_12 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_16 + var_176_12
					end
				end

				arg_173_1.text_.text = var_176_14
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_17 = math.max(var_176_13, arg_173_1.talkMaxDuration)

			if var_176_12 <= arg_173_1.time_ and arg_173_1.time_ < var_176_12 + var_176_17 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_12) / var_176_17

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_12 + var_176_17 and arg_173_1.time_ < var_176_12 + var_176_17 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play939022042 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 939022042
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play939022043(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(arg_177_1.actors_["1054ui_story"]) and arg_177_1.var_.characterEffect1054ui_story == nil then
				arg_177_1.var_.characterEffect1054ui_story = arg_177_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_0 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 and not isNil(arg_177_1.actors_["1054ui_story"]) then
				if arg_177_1.var_.characterEffect1054ui_story and not isNil(arg_177_1.actors_["1054ui_story"]) then
					arg_177_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_177_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_177_1.time_ - 0) / var_180_0)
				end
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 and not isNil(arg_177_1.actors_["1054ui_story"]) and arg_177_1.var_.characterEffect1054ui_story then
				arg_177_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_177_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_180_1 = 0
			local var_180_2 = 0.4

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_1 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, true)
				arg_177_1.iconController_:SetSelectedState("hero")

				arg_177_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_177_1.callingController_:SetSelectedState("normal")

				arg_177_1.keyicon_.color = Color.New(1, 1, 1)
				arg_177_1.icon_.color = Color.New(1, 1, 1)

				local var_180_3 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(939022042).content)

				arg_177_1.text_.text = var_180_3

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_5 = 16 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 16)

				if (16 <= 0 and var_180_2 or var_180_2 * (utf8.len(var_180_3) / 16)) > 0 and var_180_2 < var_180_5 then
					arg_177_1.talkMaxDuration = var_180_5

					if var_180_5 + var_180_1 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_5 + var_180_1
					end
				end

				arg_177_1.text_.text = var_180_3
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_6 = math.max(var_180_2, arg_177_1.talkMaxDuration)

			if var_180_1 <= arg_177_1.time_ and arg_177_1.time_ < var_180_1 + var_180_6 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_1) / var_180_6

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_1 + var_180_6 and arg_177_1.time_ < var_180_1 + var_180_6 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {}

		arg_177_1:InitPlayNodeList()
	end,
	Play939022043 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 939022043
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play939022044(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.var_.moveOldPos1081ui_story = arg_181_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_184_0 = 0.001

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 then
				arg_181_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_181_1.var_.moveOldPos1081ui_story, Vector3.New(-0.7, -0.92, -5.8), (arg_181_1.time_ - 0) / var_184_0)
				arg_181_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).z)
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles = arg_181_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 then
				arg_181_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(-0.7, -0.92, -5.8)
				arg_181_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_181_1.actors_["1081ui_story"].transform.position).z)
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_181_1.actors_["1081ui_story"].transform.localEulerAngles = arg_181_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_184_1 = arg_181_1.actors_["1081ui_story"]

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1081ui_story == nil then
				arg_181_1.var_.characterEffect1081ui_story = var_184_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_2 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_2 and not isNil(var_184_1) then
				if arg_181_1.var_.characterEffect1081ui_story and not isNil(var_184_1) then
					arg_181_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_181_1.time_ >= 0 + var_184_2 and arg_181_1.time_ < 0 + var_184_2 + arg_184_0 and not isNil(var_184_1) and arg_181_1.var_.characterEffect1081ui_story then
				arg_181_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_2")
			end

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_184_4 = 0
			local var_184_5 = 0.9

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_4 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_6 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(939022043).content)

				arg_181_1.text_.text = var_184_6

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_8 = 36 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_6) / 36)

				if (36 <= 0 and var_184_5 or var_184_5 * (utf8.len(var_184_6) / 36)) > 0 and var_184_5 < var_184_8 then
					arg_181_1.talkMaxDuration = var_184_8

					if var_184_8 + var_184_4 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_8 + var_184_4
					end
				end

				arg_181_1.text_.text = var_184_6
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_9 = math.max(var_184_5, arg_181_1.talkMaxDuration)

			if var_184_4 <= arg_181_1.time_ and arg_181_1.time_ < var_184_4 + var_184_9 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_4) / var_184_9

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_4 + var_184_9 and arg_181_1.time_ < var_184_4 + var_184_9 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_181_1:InitPlayNodeList()
	end,
	Play939022044 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 939022044
		arg_185_1.duration_ = 5

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play939022045(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			local var_188_0 = 0.85

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_1 = arg_185_1:FormatText(arg_185_1:GetWordFromCfg(939022044).content)

				arg_185_1.text_.text = var_188_1

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_3 = 34 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 34)

				if (34 <= 0 and var_188_0 or var_188_0 * (utf8.len(var_188_1) / 34)) > 0 and var_188_0 < var_188_3 then
					arg_185_1.talkMaxDuration = var_188_3

					if var_188_3 + 0 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_3 + 0
					end
				end

				arg_185_1.text_.text = var_188_1
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)
				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_4 = math.max(var_188_0, arg_185_1.talkMaxDuration)

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_4 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - 0) / var_188_4

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= 0 + var_188_4 and arg_185_1.time_ < 0 + var_188_4 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play939022045 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 939022045
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play939022046(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1081ui_story = arg_189_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).z)
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles = arg_189_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1081ui_story"].transform.position).z)
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1081ui_story"].transform.localEulerAngles = arg_189_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_192_1 = arg_189_1.actors_["1054ui_story"].transform

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1054ui_story = var_192_1.localPosition

				local var_192_2 = GameObjectTools.GetOrAddComponent(var_192_1.gameObject, typeof(DynamicBoneHelper))

				if var_192_2 then
					var_192_2:EnableDynamicBone(false)
				end
			end

			local var_192_3 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_3 then
				var_192_1.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_3)
				var_192_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_1.position).x, (manager.ui.mainCamera.transform.position - var_192_1.position).y, (manager.ui.mainCamera.transform.position - var_192_1.position).z)
				var_192_1.localEulerAngles.z = 0
				var_192_1.localEulerAngles.x = 0
				var_192_1.localEulerAngles = var_192_1.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_3 and arg_189_1.time_ < 0 + var_192_3 + arg_192_0 then
				var_192_1.localPosition = Vector3.New(0, 100, 0)
				var_192_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_192_1.position).x, (manager.ui.mainCamera.transform.position - var_192_1.position).y, (manager.ui.mainCamera.transform.position - var_192_1.position).z)
				var_192_1.localEulerAngles.z = 0
				var_192_1.localEulerAngles.x = 0
				var_192_1.localEulerAngles = var_192_1.localEulerAngles

				local var_192_4 = GameObjectTools.GetOrAddComponent(var_192_1.gameObject, typeof(DynamicBoneHelper))

				if var_192_4 then
					var_192_4:EnableDynamicBone(true)
				end
			end

			local var_192_5 = arg_189_1.actors_["1081ui_story"]

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.characterEffect1081ui_story == nil then
				arg_189_1.var_.characterEffect1081ui_story = var_192_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_6 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_6 and not isNil(var_192_5) then
				if arg_189_1.var_.characterEffect1081ui_story and not isNil(var_192_5) then
					arg_189_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_6)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_6 and arg_189_1.time_ < 0 + var_192_6 + arg_192_0 and not isNil(var_192_5) and arg_189_1.var_.characterEffect1081ui_story then
				arg_189_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_192_7 = 0
			local var_192_8 = 1.1

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_7 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_9 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(939022045).content)

				arg_189_1.text_.text = var_192_9

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_11 = 44 <= 0 and var_192_8 or var_192_8 * (utf8.len(var_192_9) / 44)

				if (44 <= 0 and var_192_8 or var_192_8 * (utf8.len(var_192_9) / 44)) > 0 and var_192_8 < var_192_11 then
					arg_189_1.talkMaxDuration = var_192_11

					if var_192_11 + var_192_7 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_11 + var_192_7
					end
				end

				arg_189_1.text_.text = var_192_9
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_12 = math.max(var_192_8, arg_189_1.talkMaxDuration)

			if var_192_7 <= arg_189_1.time_ and arg_189_1.time_ < var_192_7 + var_192_12 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_7) / var_192_12

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_7 + var_192_12 and arg_189_1.time_ < var_192_7 + var_192_12 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_189_1:InitPlayNodeList()
	end,
	Play939022046 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 939022046
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play939022047(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1284ui_story = arg_193_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1284ui_story"].transform.position).z)
				arg_193_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1284ui_story"].transform.localEulerAngles = arg_193_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				arg_193_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1284ui_story"].transform.position).z)
				arg_193_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1284ui_story"].transform.localEulerAngles = arg_193_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1284ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1284ui_story == nil then
				arg_193_1.var_.characterEffect1284ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1284ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1284ui_story then
				arg_193_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action5_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_196_4 = 0
			local var_196_5 = 0.35

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(939022046).content)

				arg_193_1.text_.text = var_196_6

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_8 = 14 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_6) / 14)

				if (14 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_6) / 14)) > 0 and var_196_5 < var_196_8 then
					arg_193_1.talkMaxDuration = var_196_8

					if var_196_8 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_8 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_6
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_9 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_9 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_9

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_9 and arg_193_1.time_ < var_196_4 + var_196_9 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_193_1:InitPlayNodeList()
	end,
	Play939022047 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 939022047
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play939022048(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos1054ui_story = arg_197_1.actors_["1054ui_story"].transform.localPosition

				local var_200_0 = GameObjectTools.GetOrAddComponent(arg_197_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_200_0 then
					var_200_0:EnableDynamicBone(false)
				end
			end

			local var_200_1 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_1 then
				arg_197_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_197_1.time_ - 0) / var_200_1)
				arg_197_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1054ui_story"].transform.position).z)
				arg_197_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1054ui_story"].transform.localEulerAngles = arg_197_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_1 and arg_197_1.time_ < 0 + var_200_1 + arg_200_0 then
				arg_197_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_197_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["1054ui_story"].transform.position).z)
				arg_197_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["1054ui_story"].transform.localEulerAngles = arg_197_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_200_2 = GameObjectTools.GetOrAddComponent(arg_197_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_200_2 then
					var_200_2:EnableDynamicBone(true)
				end
			end

			local var_200_3 = arg_197_1.actors_["1054ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_3) and arg_197_1.var_.characterEffect1054ui_story == nil then
				arg_197_1.var_.characterEffect1054ui_story = var_200_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_4 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_4 and not isNil(var_200_3) then
				if arg_197_1.var_.characterEffect1054ui_story and not isNil(var_200_3) then
					arg_197_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_4 and arg_197_1.time_ < 0 + var_200_4 + arg_200_0 and not isNil(var_200_3) and arg_197_1.var_.characterEffect1054ui_story then
				arg_197_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_200_6 = arg_197_1.actors_["1284ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect1284ui_story == nil then
				arg_197_1.var_.characterEffect1284ui_story = var_200_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_7 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_7 and not isNil(var_200_6) then
				if arg_197_1.var_.characterEffect1284ui_story and not isNil(var_200_6) then
					arg_197_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_7)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_7 and arg_197_1.time_ < 0 + var_200_7 + arg_200_0 and not isNil(var_200_6) and arg_197_1.var_.characterEffect1284ui_story then
				arg_197_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action2_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaC", "EmotionTimelineAnimator")
			end

			local var_200_8 = 0
			local var_200_9 = 1.1

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_8 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_10 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(939022047).content)

				arg_197_1.text_.text = var_200_10

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_12 = 44 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_10) / 44)

				if (44 <= 0 and var_200_9 or var_200_9 * (utf8.len(var_200_10) / 44)) > 0 and var_200_9 < var_200_12 then
					arg_197_1.talkMaxDuration = var_200_12

					if var_200_12 + var_200_8 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_8
					end
				end

				arg_197_1.text_.text = var_200_10
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_13 = math.max(var_200_9, arg_197_1.talkMaxDuration)

			if var_200_8 <= arg_197_1.time_ and arg_197_1.time_ < var_200_8 + var_200_13 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_8) / var_200_13

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_8 + var_200_13 and arg_197_1.time_ < var_200_8 + var_200_13 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play939022048 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 939022048
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play939022049(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1081ui_story = arg_201_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1081ui_story, Vector3.New(-0.7, -0.92, -5.8), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).z)
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles = arg_201_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(-0.7, -0.92, -5.8)
				arg_201_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1081ui_story"].transform.position).z)
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1081ui_story"].transform.localEulerAngles = arg_201_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["1284ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1284ui_story = var_204_1.localPosition
			end

			local var_204_2 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 then
				var_204_1.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_2)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 then
				var_204_1.localPosition = Vector3.New(0, 100, 0)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			local var_204_3 = arg_201_1.actors_["1081ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_3) and arg_201_1.var_.characterEffect1081ui_story == nil then
				arg_201_1.var_.characterEffect1081ui_story = var_204_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_4 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_4 and not isNil(var_204_3) then
				if arg_201_1.var_.characterEffect1081ui_story and not isNil(var_204_3) then
					arg_201_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_4 and arg_201_1.time_ < 0 + var_204_4 + arg_204_0 and not isNil(var_204_3) and arg_201_1.var_.characterEffect1081ui_story then
				arg_201_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_204_6 = arg_201_1.actors_["1054ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect1054ui_story == nil then
				arg_201_1.var_.characterEffect1054ui_story = var_204_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_7 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_7 and not isNil(var_204_6) then
				if arg_201_1.var_.characterEffect1054ui_story and not isNil(var_204_6) then
					arg_201_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_7)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_7 and arg_201_1.time_ < 0 + var_204_7 + arg_204_0 and not isNil(var_204_6) and arg_201_1.var_.characterEffect1054ui_story then
				arg_201_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_204_8 = 0
			local var_204_9 = 0.5

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_8 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_10 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(939022048).content)

				arg_201_1.text_.text = var_204_10

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_12 = 20 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_10) / 20)

				if (20 <= 0 and var_204_9 or var_204_9 * (utf8.len(var_204_10) / 20)) > 0 and var_204_9 < var_204_12 then
					arg_201_1.talkMaxDuration = var_204_12

					if var_204_12 + var_204_8 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_12 + var_204_8
					end
				end

				arg_201_1.text_.text = var_204_10
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_13 = math.max(var_204_9, arg_201_1.talkMaxDuration)

			if var_204_8 <= arg_201_1.time_ and arg_201_1.time_ < var_204_8 + var_204_13 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_8) / var_204_13

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_8 + var_204_13 and arg_201_1.time_ < var_204_8 + var_204_13 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play939022049 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 939022049
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play939022050(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos6148ui_story = arg_205_1.actors_["6148ui_story"].transform.localPosition

				local var_208_0 = GameObjectTools.GetOrAddComponent(arg_205_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_208_0 then
					var_208_0:EnableDynamicBone(false)
				end
			end

			local var_208_1 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_1 then
				arg_205_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_205_1.time_ - 0) / var_208_1)
				arg_205_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["6148ui_story"].transform.position).z)
				arg_205_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["6148ui_story"].transform.localEulerAngles = arg_205_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_1 and arg_205_1.time_ < 0 + var_208_1 + arg_208_0 then
				arg_205_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_205_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["6148ui_story"].transform.position).z)
				arg_205_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["6148ui_story"].transform.localEulerAngles = arg_205_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_208_2 = GameObjectTools.GetOrAddComponent(arg_205_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_208_2 then
					var_208_2:EnableDynamicBone(true)
				end
			end

			local var_208_3 = arg_205_1.actors_["6148ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect6148ui_story == nil then
				arg_205_1.var_.characterEffect6148ui_story = var_208_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_4 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_4 and not isNil(var_208_3) then
				if arg_205_1.var_.characterEffect6148ui_story and not isNil(var_208_3) then
					arg_205_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_4 and arg_205_1.time_ < 0 + var_208_4 + arg_208_0 and not isNil(var_208_3) and arg_205_1.var_.characterEffect6148ui_story then
				arg_205_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_208_6 = arg_205_1.actors_["1081ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect1081ui_story == nil then
				arg_205_1.var_.characterEffect1081ui_story = var_208_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_7 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_7 and not isNil(var_208_6) then
				if arg_205_1.var_.characterEffect1081ui_story and not isNil(var_208_6) then
					arg_205_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_205_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_7)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_7 and arg_205_1.time_ < 0 + var_208_7 + arg_208_0 and not isNil(var_208_6) and arg_205_1.var_.characterEffect1081ui_story then
				arg_205_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_205_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_208_8 = arg_205_1.actors_["1054ui_story"].transform

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1054ui_story = var_208_8.localPosition

				local var_208_9 = GameObjectTools.GetOrAddComponent(var_208_8.gameObject, typeof(DynamicBoneHelper))

				if var_208_9 then
					var_208_9:EnableDynamicBone(false)
				end
			end

			local var_208_10 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_10 then
				var_208_8.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_205_1.time_ - 0) / var_208_10)
				var_208_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_8.position).x, (manager.ui.mainCamera.transform.position - var_208_8.position).y, (manager.ui.mainCamera.transform.position - var_208_8.position).z)
				var_208_8.localEulerAngles.z = 0
				var_208_8.localEulerAngles.x = 0
				var_208_8.localEulerAngles = var_208_8.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_10 and arg_205_1.time_ < 0 + var_208_10 + arg_208_0 then
				var_208_8.localPosition = Vector3.New(0, 100, 0)
				var_208_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_208_8.position).x, (manager.ui.mainCamera.transform.position - var_208_8.position).y, (manager.ui.mainCamera.transform.position - var_208_8.position).z)
				var_208_8.localEulerAngles.z = 0
				var_208_8.localEulerAngles.x = 0
				var_208_8.localEulerAngles = var_208_8.localEulerAngles

				local var_208_11 = GameObjectTools.GetOrAddComponent(var_208_8.gameObject, typeof(DynamicBoneHelper))

				if var_208_11 then
					var_208_11:EnableDynamicBone(true)
				end
			end

			local var_208_12 = 0
			local var_208_13 = 1.025

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_12 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_14 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(939022049).content)

				arg_205_1.text_.text = var_208_14

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_16 = 41 <= 0 and var_208_13 or var_208_13 * (utf8.len(var_208_14) / 41)

				if (41 <= 0 and var_208_13 or var_208_13 * (utf8.len(var_208_14) / 41)) > 0 and var_208_13 < var_208_16 then
					arg_205_1.talkMaxDuration = var_208_16

					if var_208_16 + var_208_12 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_16 + var_208_12
					end
				end

				arg_205_1.text_.text = var_208_14
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_17 = math.max(var_208_13, arg_205_1.talkMaxDuration)

			if var_208_12 <= arg_205_1.time_ and arg_205_1.time_ < var_208_12 + var_208_17 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_12) / var_208_17

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_12 + var_208_17 and arg_205_1.time_ < var_208_12 + var_208_17 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_205_1:InitPlayNodeList()
	end,
	Play939022050 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 939022050
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play939022051(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1.var_.moveOldPos1081ui_story = arg_209_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_212_0 = 0.001

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 then
				arg_209_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_209_1.var_.moveOldPos1081ui_story, Vector3.New(-0.7, -0.92, -5.8), (arg_209_1.time_ - 0) / var_212_0)
				arg_209_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).z)
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles = arg_209_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 then
				arg_209_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(-0.7, -0.92, -5.8)
				arg_209_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_209_1.actors_["1081ui_story"].transform.position).z)
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_209_1.actors_["1081ui_story"].transform.localEulerAngles = arg_209_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_212_1 = arg_209_1.actors_["1081ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1081ui_story == nil then
				arg_209_1.var_.characterEffect1081ui_story = var_212_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_2 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_2 and not isNil(var_212_1) then
				if arg_209_1.var_.characterEffect1081ui_story and not isNil(var_212_1) then
					arg_209_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_209_1.time_ >= 0 + var_212_2 and arg_209_1.time_ < 0 + var_212_2 + arg_212_0 and not isNil(var_212_1) and arg_209_1.var_.characterEffect1081ui_story then
				arg_209_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_212_4 = arg_209_1.actors_["6148ui_story"]

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect6148ui_story == nil then
				arg_209_1.var_.characterEffect6148ui_story = var_212_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_5 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_5 and not isNil(var_212_4) then
				if arg_209_1.var_.characterEffect6148ui_story and not isNil(var_212_4) then
					arg_209_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_209_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_5)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_5 and arg_209_1.time_ < 0 + var_212_5 + arg_212_0 and not isNil(var_212_4) and arg_209_1.var_.characterEffect6148ui_story then
				arg_209_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_209_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 then
				arg_209_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_212_6 = 0
			local var_212_7 = 0.3

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_6 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_8 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(939022050).content)

				arg_209_1.text_.text = var_212_8

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_10 = 12 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_8) / 12)

				if (12 <= 0 and var_212_7 or var_212_7 * (utf8.len(var_212_8) / 12)) > 0 and var_212_7 < var_212_10 then
					arg_209_1.talkMaxDuration = var_212_10

					if var_212_10 + var_212_6 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_10 + var_212_6
					end
				end

				arg_209_1.text_.text = var_212_8
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_11 = math.max(var_212_7, arg_209_1.talkMaxDuration)

			if var_212_6 <= arg_209_1.time_ and arg_209_1.time_ < var_212_6 + var_212_11 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_6) / var_212_11

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_6 + var_212_11 and arg_209_1.time_ < var_212_6 + var_212_11 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_209_1:InitPlayNodeList()
	end,
	Play939022051 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 939022051
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play939022052(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos6148ui_story = arg_213_1.actors_["6148ui_story"].transform.localPosition

				local var_216_0 = GameObjectTools.GetOrAddComponent(arg_213_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_216_0 then
					var_216_0:EnableDynamicBone(false)
				end
			end

			local var_216_1 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_1 then
				arg_213_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_213_1.time_ - 0) / var_216_1)
				arg_213_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["6148ui_story"].transform.position).z)
				arg_213_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["6148ui_story"].transform.localEulerAngles = arg_213_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_1 and arg_213_1.time_ < 0 + var_216_1 + arg_216_0 then
				arg_213_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_213_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["6148ui_story"].transform.position).z)
				arg_213_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["6148ui_story"].transform.localEulerAngles = arg_213_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_216_2 = GameObjectTools.GetOrAddComponent(arg_213_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_216_2 then
					var_216_2:EnableDynamicBone(true)
				end
			end

			local var_216_3 = arg_213_1.actors_["6148ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect6148ui_story == nil then
				arg_213_1.var_.characterEffect6148ui_story = var_216_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_4 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_4 and not isNil(var_216_3) then
				if arg_213_1.var_.characterEffect6148ui_story and not isNil(var_216_3) then
					arg_213_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_4 and arg_213_1.time_ < 0 + var_216_4 + arg_216_0 and not isNil(var_216_3) and arg_213_1.var_.characterEffect6148ui_story then
				arg_213_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_216_6 = arg_213_1.actors_["1081ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1081ui_story == nil then
				arg_213_1.var_.characterEffect1081ui_story = var_216_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_7 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_7 and not isNil(var_216_6) then
				if arg_213_1.var_.characterEffect1081ui_story and not isNil(var_216_6) then
					arg_213_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_213_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_213_1.time_ - 0) / var_216_7)
				end
			end

			if arg_213_1.time_ >= 0 + var_216_7 and arg_213_1.time_ < 0 + var_216_7 + arg_216_0 and not isNil(var_216_6) and arg_213_1.var_.characterEffect1081ui_story then
				arg_213_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_213_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action3_1")
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_216_8 = 0
			local var_216_9 = 1.475

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_8 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_10 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(939022051).content)

				arg_213_1.text_.text = var_216_10

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_12 = 59 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_10) / 59)

				if (59 <= 0 and var_216_9 or var_216_9 * (utf8.len(var_216_10) / 59)) > 0 and var_216_9 < var_216_12 then
					arg_213_1.talkMaxDuration = var_216_12

					if var_216_12 + var_216_8 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_12 + var_216_8
					end
				end

				arg_213_1.text_.text = var_216_10
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_13 = math.max(var_216_9, arg_213_1.talkMaxDuration)

			if var_216_8 <= arg_213_1.time_ and arg_213_1.time_ < var_216_8 + var_216_13 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_8) / var_216_13

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_8 + var_216_13 and arg_213_1.time_ < var_216_8 + var_216_13 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_213_1:InitPlayNodeList()
	end,
	Play939022052 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 939022052
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play939022053(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos1054ui_story = arg_217_1.actors_["1054ui_story"].transform.localPosition

				local var_220_0 = GameObjectTools.GetOrAddComponent(arg_217_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_220_0 then
					var_220_0:EnableDynamicBone(false)
				end
			end

			local var_220_1 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_1 then
				arg_217_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_217_1.time_ - 0) / var_220_1)
				arg_217_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1054ui_story"].transform.position).z)
				arg_217_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1054ui_story"].transform.localEulerAngles = arg_217_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_1 and arg_217_1.time_ < 0 + var_220_1 + arg_220_0 then
				arg_217_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_217_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_217_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_217_1.actors_["1054ui_story"].transform.position).z)
				arg_217_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_217_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_217_1.actors_["1054ui_story"].transform.localEulerAngles = arg_217_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_220_2 = GameObjectTools.GetOrAddComponent(arg_217_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_220_2 then
					var_220_2:EnableDynamicBone(true)
				end
			end

			local var_220_3 = arg_217_1.actors_["6148ui_story"].transform

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.var_.moveOldPos6148ui_story = var_220_3.localPosition

				local var_220_4 = GameObjectTools.GetOrAddComponent(var_220_3.gameObject, typeof(DynamicBoneHelper))

				if var_220_4 then
					var_220_4:EnableDynamicBone(false)
				end
			end

			local var_220_5 = 0.001

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_5 then
				var_220_3.localPosition = Vector3.Lerp(arg_217_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_217_1.time_ - 0) / var_220_5)
				var_220_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_3.position).x, (manager.ui.mainCamera.transform.position - var_220_3.position).y, (manager.ui.mainCamera.transform.position - var_220_3.position).z)
				var_220_3.localEulerAngles.z = 0
				var_220_3.localEulerAngles.x = 0
				var_220_3.localEulerAngles = var_220_3.localEulerAngles
			end

			if arg_217_1.time_ >= 0 + var_220_5 and arg_217_1.time_ < 0 + var_220_5 + arg_220_0 then
				var_220_3.localPosition = Vector3.New(0, 100, 0)
				var_220_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_220_3.position).x, (manager.ui.mainCamera.transform.position - var_220_3.position).y, (manager.ui.mainCamera.transform.position - var_220_3.position).z)
				var_220_3.localEulerAngles.z = 0
				var_220_3.localEulerAngles.x = 0
				var_220_3.localEulerAngles = var_220_3.localEulerAngles

				local var_220_6 = GameObjectTools.GetOrAddComponent(var_220_3.gameObject, typeof(DynamicBoneHelper))

				if var_220_6 then
					var_220_6:EnableDynamicBone(true)
				end
			end

			local var_220_7 = arg_217_1.actors_["1054ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.characterEffect1054ui_story == nil then
				arg_217_1.var_.characterEffect1054ui_story = var_220_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_8 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_8 and not isNil(var_220_7) then
				if arg_217_1.var_.characterEffect1054ui_story and not isNil(var_220_7) then
					arg_217_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_217_1.time_ >= 0 + var_220_8 and arg_217_1.time_ < 0 + var_220_8 + arg_220_0 and not isNil(var_220_7) and arg_217_1.var_.characterEffect1054ui_story then
				arg_217_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_220_10 = arg_217_1.actors_["6148ui_story"]

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(var_220_10) and arg_217_1.var_.characterEffect6148ui_story == nil then
				arg_217_1.var_.characterEffect6148ui_story = var_220_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_11 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_11 and not isNil(var_220_10) then
				if arg_217_1.var_.characterEffect6148ui_story and not isNil(var_220_10) then
					arg_217_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_217_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_11)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_11 and arg_217_1.time_ < 0 + var_220_11 + arg_220_0 and not isNil(var_220_10) and arg_217_1.var_.characterEffect6148ui_story then
				arg_217_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_217_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action4_1")
			end

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_220_12 = 0
			local var_220_13 = 1.525

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_12 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_14 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(939022052).content)

				arg_217_1.text_.text = var_220_14

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_16 = 61 <= 0 and var_220_13 or var_220_13 * (utf8.len(var_220_14) / 61)

				if (61 <= 0 and var_220_13 or var_220_13 * (utf8.len(var_220_14) / 61)) > 0 and var_220_13 < var_220_16 then
					arg_217_1.talkMaxDuration = var_220_16

					if var_220_16 + var_220_12 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_16 + var_220_12
					end
				end

				arg_217_1.text_.text = var_220_14
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_17 = math.max(var_220_13, arg_217_1.talkMaxDuration)

			if var_220_12 <= arg_217_1.time_ and arg_217_1.time_ < var_220_12 + var_220_17 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_12) / var_220_17

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_12 + var_220_17 and arg_217_1.time_ < var_220_12 + var_220_17 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_217_1:InitPlayNodeList()
	end,
	Play939022053 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 939022053
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play939022054(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1054ui_story"]) and arg_221_1.var_.characterEffect1054ui_story == nil then
				arg_221_1.var_.characterEffect1054ui_story = arg_221_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1054ui_story"]) then
				if arg_221_1.var_.characterEffect1054ui_story and not isNil(arg_221_1.actors_["1054ui_story"]) then
					arg_221_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_0)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1054ui_story"]) and arg_221_1.var_.characterEffect1054ui_story then
				arg_221_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_224_1 = 0
			local var_224_2 = 0.5

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_3 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(939022053).content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 20 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 20)

				if (20 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 20)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_6 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_6 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_6

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_6 and arg_221_1.time_ < var_224_1 + var_224_6 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play939022054 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 939022054
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play939022055(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1081ui_story = arg_225_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1081ui_story, Vector3.New(-0.7, -0.92, -5.8), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1081ui_story"].transform.position).z)
				arg_225_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1081ui_story"].transform.localEulerAngles = arg_225_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(-0.7, -0.92, -5.8)
				arg_225_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1081ui_story"].transform.position).z)
				arg_225_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1081ui_story"].transform.localEulerAngles = arg_225_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_228_1 = arg_225_1.actors_["1081ui_story"]

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1081ui_story == nil then
				arg_225_1.var_.characterEffect1081ui_story = var_228_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_2 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_2 and not isNil(var_228_1) then
				if arg_225_1.var_.characterEffect1081ui_story and not isNil(var_228_1) then
					arg_225_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_2 and arg_225_1.time_ < 0 + var_228_2 + arg_228_0 and not isNil(var_228_1) and arg_225_1.var_.characterEffect1081ui_story then
				arg_225_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081actionlink/1081action474")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_228_4 = 0
			local var_228_5 = 0.8

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_4 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_6 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(939022054).content)

				arg_225_1.text_.text = var_228_6

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_8 = 32 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_6) / 32)

				if (32 <= 0 and var_228_5 or var_228_5 * (utf8.len(var_228_6) / 32)) > 0 and var_228_5 < var_228_8 then
					arg_225_1.talkMaxDuration = var_228_8

					if var_228_8 + var_228_4 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_8 + var_228_4
					end
				end

				arg_225_1.text_.text = var_228_6
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_9 = math.max(var_228_5, arg_225_1.talkMaxDuration)

			if var_228_4 <= arg_225_1.time_ and arg_225_1.time_ < var_228_4 + var_228_9 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_4) / var_228_9

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_4 + var_228_9 and arg_225_1.time_ < var_228_4 + var_228_9 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_225_1:InitPlayNodeList()
	end,
	Play939022055 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 939022055
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play939022056(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["1081ui_story"]) and arg_229_1.var_.characterEffect1081ui_story == nil then
				arg_229_1.var_.characterEffect1081ui_story = arg_229_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["1081ui_story"]) then
				if arg_229_1.var_.characterEffect1081ui_story and not isNil(arg_229_1.actors_["1081ui_story"]) then
					arg_229_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_0)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["1081ui_story"]) and arg_229_1.var_.characterEffect1081ui_story then
				arg_229_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_232_1 = arg_229_1.actors_["1081ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1081ui_story = var_232_1.localPosition
			end

			local var_232_2 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 then
				var_232_1.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_2)
				var_232_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_1.position).x, (manager.ui.mainCamera.transform.position - var_232_1.position).y, (manager.ui.mainCamera.transform.position - var_232_1.position).z)
				var_232_1.localEulerAngles.z = 0
				var_232_1.localEulerAngles.x = 0
				var_232_1.localEulerAngles = var_232_1.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 then
				var_232_1.localPosition = Vector3.New(0, 100, 0)
				var_232_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_1.position).x, (manager.ui.mainCamera.transform.position - var_232_1.position).y, (manager.ui.mainCamera.transform.position - var_232_1.position).z)
				var_232_1.localEulerAngles.z = 0
				var_232_1.localEulerAngles.x = 0
				var_232_1.localEulerAngles = var_232_1.localEulerAngles
			end

			local var_232_3 = arg_229_1.actors_["1054ui_story"].transform

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1054ui_story = var_232_3.localPosition

				local var_232_4 = GameObjectTools.GetOrAddComponent(var_232_3.gameObject, typeof(DynamicBoneHelper))

				if var_232_4 then
					var_232_4:EnableDynamicBone(false)
				end
			end

			local var_232_5 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_5 then
				var_232_3.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_229_1.time_ - 0) / var_232_5)
				var_232_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_3.position).x, (manager.ui.mainCamera.transform.position - var_232_3.position).y, (manager.ui.mainCamera.transform.position - var_232_3.position).z)
				var_232_3.localEulerAngles.z = 0
				var_232_3.localEulerAngles.x = 0
				var_232_3.localEulerAngles = var_232_3.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_5 and arg_229_1.time_ < 0 + var_232_5 + arg_232_0 then
				var_232_3.localPosition = Vector3.New(0, 100, 0)
				var_232_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_232_3.position).x, (manager.ui.mainCamera.transform.position - var_232_3.position).y, (manager.ui.mainCamera.transform.position - var_232_3.position).z)
				var_232_3.localEulerAngles.z = 0
				var_232_3.localEulerAngles.x = 0
				var_232_3.localEulerAngles = var_232_3.localEulerAngles

				local var_232_6 = GameObjectTools.GetOrAddComponent(var_232_3.gameObject, typeof(DynamicBoneHelper))

				if var_232_6 then
					var_232_6:EnableDynamicBone(true)
				end
			end

			local var_232_7 = 0
			local var_232_8 = 0.9

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_7 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, false)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_9 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(939022055).content)

				arg_229_1.text_.text = var_232_9

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_11 = 36 <= 0 and var_232_8 or var_232_8 * (utf8.len(var_232_9) / 36)

				if (36 <= 0 and var_232_8 or var_232_8 * (utf8.len(var_232_9) / 36)) > 0 and var_232_8 < var_232_11 then
					arg_229_1.talkMaxDuration = var_232_11

					if var_232_11 + var_232_7 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_11 + var_232_7
					end
				end

				arg_229_1.text_.text = var_232_9
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_8, arg_229_1.talkMaxDuration)

			if var_232_7 <= arg_229_1.time_ and arg_229_1.time_ < var_232_7 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_7) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_7 + var_232_12 and arg_229_1.time_ < var_232_7 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_229_1:InitPlayNodeList()
	end,
	Play939022056 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 939022056
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
			arg_233_1.auto_ = false
		end

		function arg_233_1.playNext_(arg_235_0)
			arg_233_1.onStoryFinished_()
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 then
				arg_233_1.marker = "luntantiezi9999"
				arg_233_1.actionList["1"] = arg_233_1.actionList["1"] or StoryInteractionRogueCardForumGame.New(arg_233_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")

				arg_233_1.actionList["1"]:SetData({
					hideOnEndGame = true,
					type = 2,
					postId = 202,
					enterClipName = "",
					completeShowStoryUI = true,
					isNeedInteraction = true,
					uiBtnName = "postBtn_",
					enterHideStoryUI = true,
					completeClipName = "",
					enterController = {},
					completeController = {}
				})
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST15a",
		"TextureConfig/Background/H01b"
	},
	voices = {},
	skipMarkers = {
		939022056
	}
}
